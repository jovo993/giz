package ba.giz

import ba.giz.dto.IzvjestajExcelDTO
import grails.transaction.Transactional
import grails.util.Holders
import net.sf.jasperreports.engine.DefaultJasperReportsContext
import net.sf.jasperreports.engine.JREmptyDataSource
import net.sf.jasperreports.engine.JasperCompileManager
import net.sf.jasperreports.engine.JasperExportManager
import net.sf.jasperreports.engine.JasperFillManager
import net.sf.jasperreports.engine.JasperPrint
import net.sf.jasperreports.engine.JasperReport
import org.apache.commons.io.FileUtils
import pl.touk.excel.export.WebXlsxExporter
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource

import static org.springframework.http.HttpStatus.*
import static pl.touk.excel.export.abilities.RowManipulationAbility.fillHeader

@Transactional(readOnly = true)
class IzvjestajController {

  def index(Integer max) {
    params.max = Math.min(max ?: 10, 100)
    respond Izvjestaj.list(params), model: [izvjestajCount: Izvjestaj.count()]
  }

  def resolveViewAndRedirect(Izvjestaj izvjestaj) {
    Preduzece preduzece = Preduzece.findById(izvjestaj.preduzece.id)
    if (preduzece.sektor == Sektor.ELEKTRICNA_ENERGIJA && (izvjestaj.status == IzvjestajStatus.KREIRAN || izvjestaj.status == IzvjestajStatus.DORADA)) {
      render view: "/izvjestaj/ee/edit", model: [izvjestaj: izvjestaj, id: izvjestaj.id]
    }

    if (preduzece.sektor == Sektor.GAS && (izvjestaj.status == IzvjestajStatus.KREIRAN || izvjestaj.status == IzvjestajStatus.DORADA)) {
      render view: "/izvjestaj/gas/edit", model: [izvjestaj: izvjestaj, id: izvjestaj.id]
    }

    if (preduzece.sektor == Sektor.TOPLOTNA_ENERGIJA && (izvjestaj.status == IzvjestajStatus.KREIRAN || izvjestaj.status == IzvjestajStatus.DORADA)) {
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

    Izvjestaj izvjestaj = new Izvjestaj()

    CreateIzvjestajUtils.generateBasicData(params, izvjestaj)
    CreateIzvjestajUtils.generateTypeDependentData(params, izvjestaj)

    izvjestaj.save flush: true, failOnError: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: "default.created.message", args: [message(code: "izvjestaj.novi.title", default: "Izvjestaj"), izvjestaj.id]) as Object
        redirect izvjestaj
      }
      "*" { respond izvjestaj, [created: OK] }
    }

  }

  @Transactional
  def update(params) {
    Izvjestaj izvjestaj = Izvjestaj.findById(params.izvjestaj.id)
    CreateIzvjestajUtils.generateBasicData(params, izvjestaj)
    CreateIzvjestajUtils.generateTypeDependentData(params, izvjestaj)
    izvjestaj.save flush: true, failOnError: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: "default.updated.message", args: [message(code: "izvjestaj.novi.title", default: "Izvjestaj"), izvjestaj.id]) as Object
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
      "Za godinu", "Status", "Izvje\u0161taj sastavio", "Datum podno\u0161enja", "Naziv preduze\u0107a", "Sektor", "Uloge", "Adresa"
    ]
    def withProperties = [
      "podaciPodnosenjeIzvjestaja.godina", "status", "podaciPodnosenjeIzvjestaja.prezimeImePozicija", "datumSlanja", "preduzece.naziv", "preduzece.sektor", "preduzece.uloga", "preduzece.adresa"
    ]

    new WebXlsxExporter().with {
      setResponseHeaders(response)
      fillHeader(headers)
      add(results, withProperties)
      workbook.write(response.outputStream)
      response.outputStream.flush()
      finalize()
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

    if (dto.uloga.operater || dto.uloga.distributer || dto.uloga.snabdjevac) {
      results = results.findAll { dto.uloga.toString().split(", ").collect().containsAll(it.preduzece.uloga.toString().split(", ").collect()) }
    }

    results
  }

  @Transactional
  def send(params) {
    Izvjestaj izvjestaj = Izvjestaj.findById(params.izvjestaj.id)
    if(izvjestaj.status)
    izvjestaj.datumSlanja = new Date().clearTime()
    izvjestaj.status = IzvjestajStatus.POSLAN
    izvjestaj.save flush: true, failOnError: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: "default.updated.message", args: [message(code: "izvjestaj.novi.title", default: "Izvjestaj"), izvjestaj.id]) as Object
        redirect izvjestaj
      }
      "*" { respond izvjestaj, [status: OK] }
    }
  }

  def vratiNaDoradu(Izvjestaj izvjestaj) {
    if(izvjestaj.status == IzvjestajStatus.POSLAN) {
      if(UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser)) {
        izvjestaj.status = IzvjestajStatus.DORADA

        izvjestaj.save flush: true, failOnError: true

        request.withFormat {
          form multipartForm {
            flash.message = message(code: "default.updated.message", args: [message(code: "izvjestaj.dorada.title"), izvjestaj.id]) as Object
            redirect izvjestaj
          }
          "*" { respond izvjestaj, [status: OK] }
        }
      }
    }
  }

  def verifikuj(Izvjestaj izvjestaj) {
    if(izvjestaj.status == IzvjestajStatus.POSLAN) {
      if(UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser)) {
        izvjestaj.status = IzvjestajStatus.VERIFIKOVAN

        izvjestaj.save flush: true, failOnError: true

        request.withFormat {
          form multipartForm {
            flash.message = message(code: "default.updated.message", args: [message(code: "izvjestaj.dorada.title"), izvjestaj.id]) as Object
            redirect izvjestaj
          }
          "*" { respond izvjestaj, [status: OK] }
        }
      }
    }
  }

  @Transactional
  def printPdf(params) {
    DefaultJasperReportsContext.getInstance().setProperty("net.sf.jasperreports.default.font.name", "SansSerif")
    DefaultJasperReportsContext.getInstance().setProperty("net.sf.jasperreports.default.pdf.encoding", "Cp1250")

    String report = "grails-app/resources/jasper/izvjestaj_ee.jrxml"
    JasperReport jreport = JasperCompileManager.compileReport(report)

    Izvjestaj izvjestaj = Izvjestaj.findById(params.izvjestaj.id)
    JRBeanCollectionDataSource preuzetaIsporucenaEEDataSource = new JRBeanCollectionDataSource(izvjestaj.preuzetaIsporucenaEEList)
    JRBeanCollectionDataSource procjenaStanjaEnergetskeEfikasnostiDataSource = new JRBeanCollectionDataSource(izvjestaj.procjenaStanjaEnergetskeEfikasnostiList)

    def bean = []
    bean = [
      preduzeceNaziv: izvjestaj.preduzece.naziv,
      preduzeceAdresa: izvjestaj.preduzece.adresa,
      preduzeceMaticniBroj: izvjestaj.preduzece.maticniBrojJedinstvenogRegistra,
      preduzeceJib: izvjestaj.preduzece.jib,
      preduzecePib: izvjestaj.preduzece.pib,
      preduzeceTelefon: izvjestaj.preduzece.telefon,
      preduzeceFax: izvjestaj.preduzece.fax,
      preduzeceMail: izvjestaj.preduzece.email,
      preduzeceBrojZaposlenih: izvjestaj.preduzece.brojZaposlenih,
      preduzeceGodisnjiPromet: izvjestaj.preduzece.ukupanGodisnjiPromet,
      distribucijaRegistarskiBroj: izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj,
      distribucijaKomisija: izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija,
      distribucijaDatumPocetkaVazenje: izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje,
      distribucijaPeriodVazenja: izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja,
      snabdijevanjeRegistarskiBroj: izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj,
      snabdijevanjeKomisija: izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija,
      snabdijevanjeDatumPocetkaVazenje: izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje,
      snabdijevanjePeriodVazenja: izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja,
      godina: izvjestaj.podaciPodnosenjeIzvjestaja.godina,
      prezimeImePozicija: izvjestaj.podaciPodnosenjeIzvjestaja.prezimeImePozicija,
      telefon: izvjestaj.podaciPodnosenjeIzvjestaja.telefon,
      email: izvjestaj.podaciPodnosenjeIzvjestaja.email,
      preuzetaIsporucenaEEDataSource: preuzetaIsporucenaEEDataSource,
      procjenaStanjaEnergetskeEfikasnostiDataSource: procjenaStanjaEnergetskeEfikasnostiDataSource,
      domacinstvoBrojMjerenjePotrosnje: izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoBrojMjerenjePotrosnje,
      domacinstvoUkupanBroj: izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoUkupanBroj,
      domacinstvoBrojDaljinskoOcitavanje: izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoBrojDaljinskoOcitavanje,
      industrijaBrojMjerenjePotrosnje: izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaBrojMjerenjePotrosnje,
      industrijaUkupanBroj: izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaUkupanBroj,
      industrijaBrojDaljinskoOcitavanje: izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaBrojDaljinskoOcitavanje,
      ostaloBrojMjerenjePotrosnje: izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloBrojMjerenjePotrosnje,
      ostaloUkupanBroj: izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloUkupanBroj,
      ostaloBrojDaljinskoOcitavanje: izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloBrojDaljinskoOcitavanje,
      ukupnoBrojMjerenjePotrosnje: izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojMjerenjePotrosnje,
      ukupnoBrojKrajnjihKupaca: izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojKrajnjihKupaca,
      ukupnoBrojDaljinskoOcitavanje: izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojDaljinskoOcitavanje,
      podaciPonudeEnergetskihUsluga: izvjestaj.podaciPonudeEnergetskihUsluga,
      podaciPonudeUgradnjaIndividualnihUredjaja: izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja,
      podaciOstaloEnergetskaEfikasnost: izvjestaj.podaciOstaloEnergetskaEfikasnost
    ]

    bean.collect { it ?: "" }

    JasperPrint jprint = JasperFillManager.fillReport(jreport, bean, new JREmptyDataSource())

    byte[] byteArray = JasperExportManager.exportReportToPdf(jprint)
    //TODO: return file to front-end, this is for development purposes only
    FileUtils.writeByteArrayToFile(new File("C:\\Users\\OSD-jsajlovic\\Desktop\\izvjestaj.pdf"), byteArray)
  }
}
