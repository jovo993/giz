package ba.giz

import ba.giz.dto.IzvjestajExcelDTO
import grails.converters.JSON
import grails.transaction.Transactional
import grails.util.Holders
import pl.touk.excel.export.WebXlsxExporter

import static org.springframework.http.HttpStatus.NOT_FOUND
import static org.springframework.http.HttpStatus.NO_CONTENT
import static pl.touk.excel.export.abilities.RowManipulationAbility.fillHeader

@Transactional(readOnly = true)
class IzvjestajController {

  def show(Long id) {
    resolveViewAndRedirect(Izvjestaj.findById(id))
  }

  def index(Integer max) {
    params.max = Math.min(max ?: 10, 100)
    respond Izvjestaj.list(params), model: [izvjestajCount: Izvjestaj.count()]
  }

  def resolveViewAndRedirect(Izvjestaj izvjestaj) {
    Preduzece preduzece = Preduzece.findById(izvjestaj.preduzece.id)
    if (preduzece.sektor == Sektor.ELEKTRICNA_ENERGIJA) {
      render view: "/izvjestaj/ee/edit", model: [izvjestaj: izvjestaj, id: izvjestaj.id]
    }

    if (preduzece.sektor == Sektor.GAS) {
      render view: "/izvjestaj/gas/edit", model: [izvjestaj: izvjestaj, id: izvjestaj.id]
    }

    if (preduzece.sektor == Sektor.TOPLOTNA_ENERGIJA) {
      render view: "/izvjestaj/te/edit", model: [izvjestaj: izvjestaj, id: izvjestaj.id]
    }
  }

  def create() {
    Preduzece preduzece = Preduzece.findById(Holders.applicationContext.getBean("springSecurityService").currentUser?.preduzece?.id)

    if (preduzece.sektor == Sektor.ELEKTRICNA_ENERGIJA) {
      render view: "/izvjestaj/ee/create", model: [preduzece: preduzece]
    }

    if (preduzece.sektor == Sektor.GAS) {
      render view: "/izvjestaj/gas/create", model: [preduzece: preduzece]
    }

    if (preduzece.sektor == Sektor.TOPLOTNA_ENERGIJA) {
      render view: "/izvjestaj/te/create", model: [preduzece: preduzece]
    }
  }

  def excelExport() {
    respond new IzvjestajExcelDTO()
  }

  @Transactional
  def save(params) {
    try {
      Izvjestaj izvjestaj = new Izvjestaj()
      izvjestaj.status = IzvjestajStatus.KREIRAN
      izvjestaj.datumKreiranja = Calendar.getInstance().getTime()

      CreateIzvjestajUtils.generateBasicData(params, izvjestaj)
      CreateIzvjestajUtils.generateTypeDependentData(params, izvjestaj)

      izvjestaj.save flush: true, failOnError: true

      response.status = 200
      render([id: izvjestaj.id, title: 'Izvještaj', message: 'Izvještaj je uspješno kreiran.'] as JSON)
    }
    catch (Exception e) {
      response.status = 500
      render([title: 'Izvještaj', message: 'Došlo je do greške prilikom kreiranja izvještaja.', error: e.getLocalizedMessage()] as JSON)
    }


  }

  @Transactional
  def update(params) {
    try {
      Izvjestaj izvjestaj = Izvjestaj.findById(params.izvjestaj.id)
      CreateIzvjestajUtils.generateBasicData(params, izvjestaj)
      CreateIzvjestajUtils.generateTypeDependentData(params, izvjestaj)
      izvjestaj.save flush: true, failOnError: true

      response.status = 200
      render([id: izvjestaj.id, title: 'Izvještaj', message: 'Izvještaj je uspješno ažuriran.'] as JSON)
    }
    catch (Exception e) {
      response.status = 500
      render([title: 'Izvještaj', message: 'Došlo je do greške prilikom ažuriranja izvještaja.', error: e.getLocalizedMessage()] as JSON)
    }
  }

  @Transactional
  def delete(Izvjestaj izvjestaj) {

    if (izvjestaj == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    izvjestaj.delete flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: "default.deleted.message", args: [message(code: "izvjestaj.novi.title", default: "Izvjestaj"), izvjestaj.id])
        redirect action: "index", method: "GET"
      }
      "*" { render status: NO_CONTENT }
    }
  }

  protected void notFound() {
    request.withFormat {
      form multipartForm {
        flash.message = message(code: "default.not.found.message", args: [message(code: "izvjestaj.novi.title", default: "Izvjestaj"), params.id])
        redirect action: "index", method: "GET"
      }
      "*" { render status: NOT_FOUND }
    }
  }

  @Transactional
  def generateBasicExcel(IzvjestajExcelDTO dto) {
    if (dto.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond dto.errors, view: "excelExport"
      return
    }

    List<Izvjestaj> results = searchForExcel(dto)

    def headers = [
      "Za godinu", "Status", "Izvje\u0160taj sastavio", "Datum podno\u0160enja", "Naziv preduze\u0107a", "Sektor", "Uloge", "Adresa"
    ]
    def withProperties = [
      "podaciPodnosenjeIzvjestaja.godina", "status", "podaciPodnosenjeIzvjestaja.displayName", "datumSlanja", "preduzece.naziv", "preduzece.sektor", "preduzece.uloga", "preduzece.adresa"
    ]

    new WebXlsxExporter().with {
      setResponseHeaders(response)
      fillHeader(headers)
      add(results, withProperties)
      save(response.outputStream)
    }
  }

  @Transactional
  def generateQuantitativeExcel(IzvjestajExcelDTO izvjestajExcelDTO) {
    //TODO: add this when the whole Izvjestaj process is implemented, ie when all the numeric values are present
    null
  }

  // TODO: Think of a better way to do this search
  // MongoDB does not support join queries, so we can't use projections onto properties inside GORM closures
  // Workaround is to use criteria for flat filter properties on Izvjestaj, and then just filter the list of
  // Izvjestaj objects using plain groovy code for the other (nested) properties...
  List<Izvjestaj> searchForExcel(IzvjestajExcelDTO dto) {
    List<Izvjestaj> results = Izvjestaj.createCriteria().list {
      or {
        if (dto.kreiran) {
          eq("status", IzvjestajStatus.KREIRAN)
        }
        if (dto.poslan) {
          eq("status", IzvjestajStatus.POSLAN)
        }
        if (dto.dorada) {
          eq("status", IzvjestajStatus.DORADA)
        }
        if (dto.verifikovan) {
          eq("status", IzvjestajStatus.VERIFIKOVAN)
        }
        if (dto.zavrsen) {
          eq("status", IzvjestajStatus.ZAVRSEN)
        }
      }
      order("datumSlanja", "desc")
    }

    if (dto.godina) {
      results = results.findAll { it.podaciPodnosenjeIzvjestaja.godina == dto.godina }
    }

    if (dto.sektori) {
      results = results.findAll { dto.sektori.contains(it.preduzece.sektor) }
    }

    if (dto.uloga.operator || dto.uloga.distributer || dto.uloga.snabdjevac) {
      results = results.findAll { dto.uloga.toString().split(", ").collect().containsAll(it.preduzece.uloga.toString().split(", ").collect()) }
    }

    results
  }

  @Transactional
  def posalji(params) {
    try {
      Izvjestaj izvjestaj = Izvjestaj.findById(params.izvjestaj.id)
      CreateIzvjestajUtils.generateBasicData(params, izvjestaj)
      CreateIzvjestajUtils.generateTypeDependentData(params, izvjestaj)

      izvjestaj.datumSlanja = new Date().clearTime()
      izvjestaj.status = IzvjestajStatus.POSLAN

      izvjestaj.save flush: true, failOnError: true

      response.status = 200
      render([id: izvjestaj.id, title: 'Izvještaj', message: 'Izvještaj je uspješno poslan.'] as JSON)
    }
    catch (Exception e) {
      response.status = 500
      render([title: 'Izvještaj', message: 'Došlo je do greške prilikom slanja izvještaja.', error: e.getLocalizedMessage()] as JSON)
    }
  }

  @Transactional
  def vratiNaDoradu(params) {
    Izvjestaj izvjestaj = Izvjestaj.findById(params.id)
    if (izvjestaj.status == IzvjestajStatus.POSLAN) {
      if (UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser)) {
        izvjestaj.status = IzvjestajStatus.DORADA

        izvjestaj.save flush: true, failOnError: true

        response.status = 200
        render([id: izvjestaj.id, title: 'Izvještaj', message: 'Izvještaj je vraćen na doradu.'] as JSON)
      } else {
        response.status = 500
        render([id: izvjestaj.id, title: 'Izvještaj', message: 'Nemate potrebne privilegije.'] as JSON)
      }
    } else {
      response.status = 500
      render([id: izvjestaj.id, title: 'Izvještaj', message: 'Izvještaj nije u potrebnom statusu.'] as JSON)
    }
  }

  @Transactional
  def verifikuj(params) {
    Izvjestaj izvjestaj = Izvjestaj.findById(params.id)
    if (izvjestaj.status == IzvjestajStatus.POSLAN) {
      if (UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser)) {
        izvjestaj.status = IzvjestajStatus.VERIFIKOVAN

        izvjestaj.save flush: true, failOnError: true

        response.status = 200
        render([id: izvjestaj.id, title: 'Izvještaj', message: 'Izvještaj je vraćen na doradu.'] as JSON)
      } else {
        response.status = 500
        render([id: izvjestaj.id, title: 'Izvještaj', message: 'Nemate potrebne privilegije.'] as JSON)
      }
    } else {
      response.status = 500
      render([id: izvjestaj.id, title: 'Izvještaj', message: 'Izvještaj nije u potrebnom statusu.'] as JSON)
    }
  }

  @Transactional
  def potvrdi(params) {
    Izvjestaj izvjestaj = Izvjestaj.findById(params.id)
    if (izvjestaj.status == IzvjestajStatus.ZAVRSEN) {
      if (UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser)) {
        izvjestaj.status = IzvjestajStatus.VERIFIKOVAN

        izvjestaj.save flush: true, failOnError: true

        response.status = 200
        render([id: izvjestaj.id, title: 'Izvještaj', message: 'Izvještaj je završen.'] as JSON)
      } else {
        response.status = 500
        render([id: izvjestaj.id, title: 'Izvještaj', message: 'Nemate potrebne privilegije.'] as JSON)
      }
    } else {
      response.status = 500
      render([id: izvjestaj.id, title: 'Izvještaj', message: 'Izvještaj nije u potrebnom statusu.'] as JSON)
    }
  }

}
