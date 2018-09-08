package ba.giz

import ba.giz.dto.IzvjestajExcelDTO
import grails.transaction.Transactional
import pl.touk.excel.export.WebXlsxExporter

import static org.springframework.http.HttpStatus.CREATED
import static org.springframework.http.HttpStatus.NOT_FOUND
import static org.springframework.http.HttpStatus.NO_CONTENT
import static org.springframework.http.HttpStatus.OK
import static pl.touk.excel.export.abilities.RowManipulationAbility.fillHeader

@Transactional(readOnly = true)
class IzvjestajController {

  def index(Integer max) {
    params.max = Math.min(max ?: 10, 100)
    respond Izvjestaj.list(params), model: [izvjestajCount: Izvjestaj.count()]
  }

  def show(Izvjestaj izvjestaj) {
    respond izvjestaj
  }

  def create() {
    Preduzece preduzece = Preduzece.findBySektor(Sektor.ELEKTRICNA_ENERGIJA)

    if(preduzece.sektor == Sektor.ELEKTRICNA_ENERGIJA) {
      render view: "/izvjestaj/ee/create", model: [preduzece: preduzece]
    }

    if(preduzece.sektor == Sektor.GAS) {
      render view: "/izvjestaj/g/create", model: [preduzece: preduzece]
    }

    if(preduzece.sektor == Sektor.TOPLOTNA_ENERGIJA) {
      render view: "/izvjestaj/te/create", model: [preduzece: preduzece]
    }
  }

  def excelExport() {
    respond new IzvjestajExcelDTO()
  }

  @Transactional
  def save(Izvjestaj izvjestaj) {

    izvjestaj.preduzece = Preduzece.findBySektor(Sektor.ELEKTRICNA_ENERGIJA)

    if (izvjestaj == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    if (izvjestaj.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond izvjestaj.errors, view: "create"
      return
    }

    izvjestaj.save flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: "default.created.message", args: [message(code: "izvjestaj.create.title", default: "Izvjestaj"), izvjestaj.id])
        redirect izvjestaj
      }
      "*" { respond izvjestaj, [status: CREATED] }
    }
  }

  @Transactional
  def update(Izvjestaj izvjestaj) {
    if (izvjestaj == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    if (izvjestaj.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond izvjestaj.errors, view: "edit"
      return
    }

    izvjestaj.save flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: "default.updated.message", args: [message(code: "izvjestaj.create.title", default: "Izvjestaj"), izvjestaj.id])
        redirect izvjestaj
      }
      "*" { respond izvjestaj, [status: OK] }
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
        flash.message = message(code: "default.deleted.message", args: [message(code: "izvjestaj.create.title", default: "Izvjestaj"), izvjestaj.id])
        redirect action: "index", method: "GET"
      }
      "*" { render status: NO_CONTENT }
    }
  }

  protected void notFound() {
    request.withFormat {
      form multipartForm {
        flash.message = message(code: "default.not.found.message", args: [message(code: "izvjestaj.create.title", default: "Izvjestaj"), params.id])
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
      "Za godinu", "Status", "Izvje\u0160taj sastavio", "Datum podno\u0160enja","Naziv preduze\u0107a", "Sektor", "Uloge", "Adresa"
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
}
