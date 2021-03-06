package ba.giz

import ba.giz.dto.IzvjestajExcelDTO
import grails.converters.JSON
import grails.transaction.Transactional
import grails.util.Holders
import net.sf.jasperreports.engine.DefaultJasperReportsContext
import net.sf.jasperreports.engine.JREmptyDataSource
import net.sf.jasperreports.engine.JasperCompileManager
import net.sf.jasperreports.engine.JasperExportManager
import net.sf.jasperreports.engine.JasperFillManager
import net.sf.jasperreports.engine.JasperPrint
import net.sf.jasperreports.engine.JasperReport
import pl.touk.excel.export.WebXlsxExporter
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.NOT_FOUND
import static org.springframework.http.HttpStatus.NO_CONTENT
import static pl.touk.excel.export.abilities.RowManipulationAbility.fillHeader

import grails.util.Holders
import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder as LCU

// import pl.touk.excel.export.getters.MessageFromPropertyGetter 
import ba.giz.MsgFromPropertyGetter

@Transactional(readOnly = true)
class IzvjestajController {

  def show(Long id) {
    resolveViewAndRedirect(Izvjestaj.findById(id))
  }

  def index(Integer max, Integer offset) {
    params.max = (max ?: 10)
    params.offset = (offset ?: 0)

    respond Izvjestaj.list(params), model: [izvjestajCount: Izvjestaj.count()]
  }

  def resolveViewAndRedirect(Izvjestaj izvjestaj) {
    Preduzece preduzece = Preduzece.findById(izvjestaj.preduzece.id)
    Boolean isUserAdmin = UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser)

    if (!isUserAdmin &&
      preduzece.id != Holders.applicationContext.getBean("springSecurityService").currentUser?.preduzece?.id) {
      redirect(controller: "homepage", action: "homepage")
      return
    }
    
    if (preduzece.sektor == Sektor.ELEKTRICNA_ENERGIJA) {
      render view: "/izvjestaj/ee/edit", model: [izvjestaj: izvjestaj, id: izvjestaj.id, isUserAdmin: isUserAdmin]
    }

    if (preduzece.sektor == Sektor.GAS) {
      render view: "/izvjestaj/gas/edit", model: [izvjestaj: izvjestaj, id: izvjestaj.id, isUserAdmin: isUserAdmin]
    }

    if (preduzece.sektor == Sektor.TOPLOTNA_ENERGIJA) {
      render view: "/izvjestaj/te/edit", model: [izvjestaj: izvjestaj, id: izvjestaj.id, isUserAdmin: isUserAdmin]
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
    if (!UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser)) {
	   redirect(controller: "homepage", action: "homepage")
	   return
	}
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
      render([id: izvjestaj.id, title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.kreiran"), theme: 'success'] as JSON)
    }
    catch (Exception e) {
      response.status = 500
      render([title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.greskakreiranje"), theme: 'error', error: e.getStackTrace()] as JSON)
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
      render([id: izvjestaj.id, title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.azuriran"), theme: 'success'] as JSON)
    }
    catch (Exception e) {
      response.status = 500
      render([title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.greskaazuriranje"), theme: 'error', error: e.getStackTrace()] as JSON)
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

    // def headers = [
    //   "Za godinu", "Status", "Izvje\u0161taj sastavio", "Datum podno\u0161enja", "Naziv preduze\u0107a", "Sektor", "Uloge", "Adresa"
    // ]

    def headers = [
      message(code: "excel1.godina"), message(code: "excel1.status"), message(code: "excel1.izvjestajsastavio"), message(code: "excel1.datumpodnosenja"), message(code: "excel1.nazivpreduzeca"), message(code: "excel1.sektor"), message(code: "excel1.uloge"), message(code: "excel1.adresa")
    ]

/*
    def withProperties = [
      "podaciPodnosenjeIzvjestaja.godina", "status", "podaciPodnosenjeIzvjestaja.prezimeImePozicija", "datumSlanja",
      "preduzece.naziv", "preduzece.sektor", "preduzece.uloga", "preduzece.adresa"
    ]
*/

    // BB: umjesto prethodnog zakomentarisanog bloka "def withProperties = ..."
    // neophodno zbog konvertovanja statusa i sektora u cirilicu
    MessageSource ms = Holders.applicationContext.getBean("messageSource")

    def withProperties = [
      "podaciPodnosenjeIzvjestaja.godina",
      new MsgFromPropertyGetter(ms, 'ba.giz.IzvjestajStatus.', 'status', LCU.getLocale()),
      "podaciPodnosenjeIzvjestaja.prezimeImePozicija",
      "datumSlanja", "preduzece.naziv",
      new MsgFromPropertyGetter(ms, 'ba.giz.Sektor.', 'preduzece', 'sektor', LCU.getLocale()),
      "preduzece.uloga", "preduzece.adresa"
    ]
    // BB: umjesto prethodnog zakomentarisanog bloka "def withProperties = ..."

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
  def generateQuantitativeExcel(IzvjestajExcelDTO dto) {
    if (dto.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond dto.errors, view: "excelExport"
      return
    }

    List<Izvjestaj> results = searchForExcel(dto)

    // def headers = ["Za godinu", "Naziv preduze\u0107a", "Sektor"]
    def headers = [message(code: "excel1.godina"), message(code: "excel1.nazivpreduzeca"), message(code: "excel1.sektor")]

    // def withProperties = ["podaciPodnosenjeIzvjestaja.godina", "preduzece.naziv", "preduzece.sektor"]

    MessageSource ms = Holders.applicationContext.getBean("messageSource")
    def withProperties = ["podaciPodnosenjeIzvjestaja.godina", "preduzece.naziv",
    new MsgFromPropertyGetter(ms, 'ba.giz.Sektor.', 'preduzece', 'sektor', LCU.getLocale()) ]

    if (!dto.sektori || dto.sektori.isEmpty() || dto.sektori.contains(Sektor.ELEKTRICNA_ENERGIJA)) {
      //TODO: maybe add transient fields on "ee" Izvjestaj which correlate to numeric values in the "UKUPNO" row on "PREUZETA I ISPORUCENA EE, GUBICI" table
    }

    if (!dto.sektori || dto.sektori.isEmpty() || dto.sektori.contains(Sektor.GAS)) {
      /*
      headers += [
        "Preuzete koli\u010Dine gasa (Sm3)", "Isporu\u010Dene koli\u010Dine gasa u Sm3 (industrijski potro\u0161a\u010Di)", "Isporu\u010Dene koli\u010Dine gasa u Sm3 (sistemi daljinskog grijanja)",
        "Isporu\u010Dene koli\u010Dine gasa u Sm3 (komercijalni krajnji kupci)", "Isporu\u010Dene koli\u010Dine gasa u Sm3 (doma\u0107instva)",
        "Ukupno isporu\u010Deno", "Gubici"
      ]
      */

      headers += [
        message(code: "excel2.g01"),
        message(code: "excel2.g02"),
        message(code: "excel2.g03"),
        message(code: "excel2.g04"),
        message(code: "excel2.g05"),
        message(code: "excel2.g06"),
        message(code: "excel2.g07")
      ]

      withProperties += [
        "preuzetIsporucenGas.preuzetaKolicina", "preuzetIsporucenGas.industrijskiPotrosaci", "preuzetIsporucenGas.sistemiDaljinskoGrijanja",
        "preuzetIsporucenGas.komercijalniKrajnjiKupci", "preuzetIsporucenGas.domacinstva",
        "preuzetIsporucenGas.ukupnoIsporuceno", "preuzetIsporucenGas.gubici"
      ]
    }

    if (!dto.sektori || dto.sektori.isEmpty() || dto.sektori.contains(Sektor.TOPLOTNA_ENERGIJA)) {
      /*
      headers += [
        "Isporu\u010Dene koli\u010Dine TE u MWh (poslovni potro\u0161a\u010Di)", "Isporu\u010Dene koli\u010Dine TE u MWh (stambeni potro\u0161a\u010Di)",
        "Isporu\u010Dene koli\u010Dine TE po m2 (stambeni potro\u0161a\u010Di)", "Ukupno isporu\u010Deno", "Gubici"
      ]
      */

      headers += [
        message(code: "excel2.t01"),
        message(code: "excel2.t02"),
        message(code: "excel2.t03"),
        message(code: "excel2.t04"),
        message(code: "excel2.t05")
      ]

      withProperties += [
        "isporucenaToplotnaEnergija.poslovniPotrosaciMwh", "isporucenaToplotnaEnergija.stambeniPotrosaciMwh",
        "isporucenaToplotnaEnergija.stambeniPotrosaciM2", "isporucenaToplotnaEnergija.ukupnoIsporuceno", "isporucenaToplotnaEnergija.gubici"
      ]
    }

    headers << message(code: "excel2.x00")

    withProperties << "ukupnoIsporucenaEnergija"

    /*
    headers += [
      "Broj kupaca (doma\u0107instva- mjerenje potro\u0161nje)", "Broj kupaca (industrija- mjerenje potro\u0161nje)",
      "Broj kupaca (ostali sektori- mjerenje potro\u0161nje)", "Broj kupaca (ukupno- mjerenje potro\u0161nje)",
      "Ukupan broj kupaca (doma\u0107instva)", "Ukupan broj kupaca (industrija)", "Ukupan broj kupaca (ostali sektori)", "Ukupan broj kupaca (sveukupno)"
    ]
      */

    headers += [
      message(code: "excel2.x01"),
      message(code: "excel2.x02"),
      message(code: "excel2.x03"),
      message(code: "excel2.x04"),
      message(code: "excel2.x05"),
      message(code: "excel2.x06"),
      message(code: "excel2.x07"),
      message(code: "excel2.x08")
    ]

    withProperties += [
      "stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoBrojMjerenjePotrosnje", "stepenMjerenjeEnergijeStrukturaKupaca.industrijaBrojMjerenjePotrosnje",
      "stepenMjerenjeEnergijeStrukturaKupaca.ostaloBrojMjerenjePotrosnje", "stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojMjerenjePotrosnje",
      "stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoUkupanBroj", "stepenMjerenjeEnergijeStrukturaKupaca.industrijaUkupanBroj", "stepenMjerenjeEnergijeStrukturaKupaca.ostaloUkupanBroj", "stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojKrajnjihKupaca"
    ]

    if (!dto.sektori || dto.sektori.isEmpty() || dto.sektori.contains(Sektor.ELEKTRICNA_ENERGIJA)) {

      /*
      headers += [
        "Broj korisnika sa sistemom dalj. o\u010Ditavanja (doma\u0107instva)", "Broj korisnika sa sistemom dalj. o\u010Ditavanja (industrija)",
        "Broj korisnika sa sistemom dalj. o\u010Ditavanja (ostali sektori)", "Broj korisnika sa sistemom dalj. o\u010Ditavanja (ukupno)"
      ]
      */

    headers += [
      message(code: "excel2.x09"),
      message(code: "excel2.x10"),
      message(code: "excel2.x11"),
      message(code: "excel2.x12")
    ]

      withProperties += [
        "stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoBrojDaljinskoOcitavanje", "stepenMjerenjeEnergijeStrukturaKupaca.industrijaBrojDaljinskoOcitavanje",
        "stepenMjerenjeEnergijeStrukturaKupaca.ostaloBrojDaljinskoOcitavanje", "stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojDaljinskoOcitavanje"
      ]
    }

    new WebXlsxExporter().with {
      setResponseHeaders(response)
      fillHeader(headers)
      add(results, withProperties)
      workbook.write(response.outputStream)
      response.outputStream.flush()
      finalize()
    }
  }

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
      results = results.findAll { it.podaciPodnosenjeIzvjestaja.godina == dto.godina.toString() }
    }

    if (dto.sektori) {
      results = results.findAll { dto.sektori.contains(it.preduzece.sektor) }
    }

    if (dto.uloga.operater || dto.uloga.distributer || dto.uloga.snabdjevac) {
      results = results.findAll {
        dto.uloga.toString().split(", ").collect().containsAll(it.preduzece.uloga.toString().split(", ").collect())
      }
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
      render([id: izvjestaj.id, title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.poslan"), theme: 'success'] as JSON)
    }
    catch (Exception e) {
      response.status = 500
      render([title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.greskaslanje"), theme: 'error', error: e.getStackTrace()] as JSON)
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
        render([id: izvjestaj.id, title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.vracen"), theme: 'success'] as JSON)
      } else {
        response.status = 500
        render([id: izvjestaj.id, title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.nemateprivilegije"), theme: 'warning'] as JSON)
      }
    } else {
      response.status = 500
      render([id: izvjestaj.id, title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.nijeustatusu"), theme: 'warning'] as JSON)
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
        render([id: izvjestaj.id, title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.verifikovan"), theme: 'success'] as JSON)
      } else {
        response.status = 500
        render([id: izvjestaj.id, title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.nemateprivilegije"), theme: 'warning'] as JSON)
      }
    } else {
      response.status = 500
      render([id: izvjestaj.id, title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.nijeustatusu"), theme: 'warning'] as JSON)
    }
  }

  @Transactional
  def potvrdi(params) {
    Izvjestaj izvjestaj = Izvjestaj.findById(params.id)
    if (izvjestaj.status == IzvjestajStatus.VERIFIKOVAN) {
      if (UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser)) {
        izvjestaj.status = IzvjestajStatus.ZAVRSEN

        izvjestaj.save flush: true, failOnError: true

        response.status = 200
        render([id: izvjestaj.id, title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.zavrsen"), theme: 'success'] as JSON)
      } else {
        response.status = 500
        render([id: izvjestaj.id, title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.nemateprivilegije"), theme: 'warning'] as JSON)
      }
    } else {
      response.status = 500
      render([id: izvjestaj.id, title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.nijeustatusu"), theme: 'warning'] as JSON)
    }
  }

  @Transactional
  def invalidate(params) {
    Izvjestaj izvjestaj = Izvjestaj.findById(params.id)
    if (izvjestaj.status == IzvjestajStatus.KREIRAN || izvjestaj.status == IzvjestajStatus.DORADA) {
      izvjestaj.status = IzvjestajStatus.STORNIRAN

      izvjestaj.save flush: true, failOnError: true

      response.status = 200
      render([id: izvjestaj.id, title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.storniran"), theme: 'success'] as JSON)

    } else {
      response.status = 500
      render([id: izvjestaj.id, title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.nijeustatusu"), theme: 'warning'] as JSON)
    }
  }


  @Transactional
  def printPdf(params) {
    try {
      

      def sc = session.getServletContext()
      def reportsPath = sc.getRealPath("/")
      String report = ""

      Izvjestaj izvjestaj = Izvjestaj.findById(params.id)

      JRBeanCollectionDataSource procjenaStanjaEnergetskeEfikasnostiDataSource = new JRBeanCollectionDataSource(izvjestaj.procjenaStanjaEnergetskeEfikasnostiList)

      def bean = [
        preduzeceNaziv                               : izvjestaj.preduzece.naziv,
        preduzeceAdresa                              : izvjestaj.preduzece.adresa,
        preduzeceMaticniBroj                         : izvjestaj.preduzece.maticniBrojJedinstvenogRegistra,
        preduzeceJib                                 : izvjestaj.preduzece.jib,
        preduzecePib                                 : izvjestaj.preduzece.pib,
        preduzeceTelefon                             : izvjestaj.preduzece.telefon,
        preduzeceFax                                 : izvjestaj.preduzece.fax,
        preduzeceMail                                : izvjestaj.preduzece.email,
        preduzeceBrojZaposlenih                      : izvjestaj.preduzece.brojZaposlenih,
        preduzeceGodisnjiPromet                      : izvjestaj.preduzece.ukupanGodisnjiPromet,
        distribucijaRegistarskiBroj                  : izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj,
        distribucijaKomisija                         : izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija,
        distribucijaDatumPocetkaVazenje              : ( izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje != null ? new SimpleDateFormat("dd.mm.yyyy.").format(izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje) : ""),
        distribucijaPeriodVazenja                    : izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja,
        snabdijevanjeRegistarskiBroj                 : izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj,
        snabdijevanjeKomisija                        : izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija,
        snabdijevanjeDatumPocetkaVazenje             : ( izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje != null ? new SimpleDateFormat("dd.mm.yyyy.").format(izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje) : ""),
        snabdijevanjePeriodVazenja                   : izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja,
        godina                                       : izvjestaj.podaciPodnosenjeIzvjestaja.godina,
        prezimeImePozicija                           : izvjestaj.podaciPodnosenjeIzvjestaja.prezimeImePozicija,
        telefon                                      : izvjestaj.podaciPodnosenjeIzvjestaja.telefon,
        email                                        : izvjestaj.podaciPodnosenjeIzvjestaja.email,
        ukupnoIsporucenaEnergija                     : izvjestaj.ukupnoIsporucenaEnergija,
        procjenaStanjaEnergetskeEfikasnostiDataSource: procjenaStanjaEnergetskeEfikasnostiDataSource,
        domacinstvoBrojMjerenjePotrosnje             : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoBrojMjerenjePotrosnje,
        domacinstvoUkupanBroj                        : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoUkupanBroj,
        industrijaBrojMjerenjePotrosnje              : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaBrojMjerenjePotrosnje,
        industrijaUkupanBroj                         : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaUkupanBroj,
        ostaloBrojMjerenjePotrosnje                  : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloBrojMjerenjePotrosnje,
        ostaloUkupanBroj                             : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloUkupanBroj,
        ukupnoBrojMjerenjePotrosnje                  : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojMjerenjePotrosnje,
        ukupnoBrojKrajnjihKupaca                     : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojKrajnjihKupaca,
        podaciPonudeEnergetskihUsluga                : izvjestaj.podaciPonudeEnergetskihUsluga,
        podaciPonudeUgradnjaIndividualnihUredjaja    : izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja,
        podaciOstaloEnergetskaEfikasnost             : izvjestaj.podaciOstaloEnergetskaEfikasnost,
        datumKreiranja                               : new SimpleDateFormat("dd.MM.yyyy.").format(izvjestaj.datumKreiranja)
      ]

      if (izvjestaj.tip == IzvjestajTip.EE_DS) {
        report = reportsPath + "jasper/izvjestaj_ee.jrxml"
        // report = reportsPath + "jasper/test.jrxml"

        // String ukupno_i18n = message(code: "izvjestaj.ee.t1.ukupno")
        // println ukupno_i18n

        List<PreuzetaIsporucenaEE> preuzetaIsporucenaEEList = izvjestaj.preuzetaIsporucenaEEList
        preuzetaIsporucenaEEList.add(
          new PreuzetaIsporucenaEE(
            radnaJedinica: "= = =", preuzetaElektricnaEnergija: preuzetaIsporucenaEEList.preuzetaElektricnaEnergija.sum(),
            potrosnjaNa110kV: preuzetaIsporucenaEEList.potrosnjaNa110kV.sum(), potrosnjaNa35kV: preuzetaIsporucenaEEList.potrosnjaNa35kV.sum(),
            potrosnjaNa1Do35kV: preuzetaIsporucenaEEList.potrosnjaNa1Do35kV.sum(), potrosnjaOstala: preuzetaIsporucenaEEList.potrosnjaOstala.sum(),
            potrosnjaDomacinstva: preuzetaIsporucenaEEList.potrosnjaDomacinstva.sum(), potrosnjaJavnaRasvjeta: preuzetaIsporucenaEEList.potrosnjaJavnaRasvjeta.sum(),
            ukupnoIsporuceno: preuzetaIsporucenaEEList.ukupnoIsporuceno.sum(), gubici: preuzetaIsporucenaEEList.gubici.sum()
          )
        )
        JRBeanCollectionDataSource preuzetaIsporucenaEEDataSource = new JRBeanCollectionDataSource(preuzetaIsporucenaEEList)

        bean += [
          preuzetaIsporucenaEEDataSource    : preuzetaIsporucenaEEDataSource,
          domacinstvoBrojDaljinskoOcitavanje: izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoBrojDaljinskoOcitavanje,
          industrijaBrojDaljinskoOcitavanje : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaBrojDaljinskoOcitavanje,
          ostaloBrojDaljinskoOcitavanje     : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloBrojDaljinskoOcitavanje,
          ukupnoBrojDaljinskoOcitavanje     : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojDaljinskoOcitavanje
        ]
      }

      if (izvjestaj.tip == IzvjestajTip.T_DS) {
        report = reportsPath + "jasper/izvjestaj_te.jrxml"

        JRBeanCollectionDataSource podaciEnergentiDataSource = new JRBeanCollectionDataSource(izvjestaj.podaciEnergenti)

        bean += [
          poslovniPotrosaciMwh     : izvjestaj.isporucenaToplotnaEnergija?.poslovniPotrosaciMwh,
          stambeniPotrosaciMwh     : izvjestaj.isporucenaToplotnaEnergija?.stambeniPotrosaciMwh,
          stambeniPotrosaciM2      : izvjestaj.isporucenaToplotnaEnergija?.stambeniPotrosaciM2,
          ukupnoIsporuceno         : izvjestaj.isporucenaToplotnaEnergija?.ukupnoIsporuceno,
          gubici                   : izvjestaj.isporucenaToplotnaEnergija?.gubici,
          podaciEnergentiDataSource: podaciEnergentiDataSource
        ]
      }

      if (izvjestaj.tip == IzvjestajTip.G_DS) {
        report = reportsPath + "jasper/izvjestaj_g.jrxml"

        bean += [
          preuzetaKolicina        : izvjestaj.preuzetIsporucenGas?.preuzetaKolicina,
          industrijskiPotrosaci   : izvjestaj.preuzetIsporucenGas?.industrijskiPotrosaci,
          sistemiDaljinskoGrijanja: izvjestaj.preuzetIsporucenGas?.sistemiDaljinskoGrijanja,
          komercijalniKrajnjiKupci: izvjestaj.preuzetIsporucenGas?.komercijalniKrajnjiKupci,
          domacinstva             : izvjestaj.preuzetIsporucenGas?.domacinstva,
          ukupnoIsporuceno        : izvjestaj.preuzetIsporucenGas?.ukupnoIsporuceno,
          gubici                  : izvjestaj.preuzetIsporucenGas?.gubici
        ]
      }

      bean.collect { it ?: "" }

      JasperReport jreport = JasperCompileManager.compileReport(report)

      JasperPrint jprint = JasperFillManager.fillReport(jreport, bean, new JREmptyDataSource())

      byte[] byteArray = JasperExportManager.exportReportToPdf(jprint)
      String encoded = Base64.getEncoder().encodeToString(byteArray)
      response.status = 200
      render([pdfByteArray: encoded] as JSON)
    } catch (Exception e) {
      response.status = 500
      render([title: message(code: "nfc.izvjestaj"), message: message(code: "nfc.greskagenerisanje"), theme: 'error', error: e.getStackTrace()] as JSON)
    }
  }
}
