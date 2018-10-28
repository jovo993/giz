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
import org.apache.commons.io.FileUtils
import pl.touk.excel.export.WebXlsxExporter
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource

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
  def generateQuantitativeExcel(IzvjestajExcelDTO dto) {
    if (dto.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond dto.errors, view: "excelExport"
      return
    }

    List<Izvjestaj> results = searchForExcel(dto)

    def headers = ["Za godinu", "Naziv preduze\u0107a", "Sektor"]

    def withProperties = ["podaciPodnosenjeIzvjestaja.godina", "preduzece.naziv", "preduzece.sektor"]

    if (!dto.sektori || dto.sektori.isEmpty() || dto.sektori.contains(Sektor.ELEKTRICNA_ENERGIJA)) {
      //TODO: maybe add transient fields on "ee" Izvjestaj which correlate to numeric values in the "UKUPNO" row on "PREUZETA I ISPORUCENA EE, GUBICI" table
    }

    if (!dto.sektori || dto.sektori.isEmpty() || dto.sektori.contains(Sektor.GAS)) {
      headers += [
        "Preuzete koli\u010Dine gasa (Sm3)", "Isporu\u010Dene koli\u010Dine gasa u Sm3 (industrijski potro\u0161a\u010Di)", "Isporu\u010Dene koli\u010Dine gasa u Sm3 (sistemi daljinskog grijanja)",
        "Isporu\u010Dene koli\u010Dine gasa u Sm3 (komercijalni krajnji kupci)", "Isporu\u010Dene koli\u010Dine gasa u Sm3 (doma\u0107instva)",
        "Ukupno isporu\u010Deno", "Gubici"
      ]

      withProperties += [
        "preuzetIsporucenGas.preuzetaKolicina", "preuzetIsporucenGas.industrijskiPotrosaci", "preuzetIsporucenGas.sistemiDaljinskoGrijanja",
        "preuzetIsporucenGas.komercijalniKrajnjiKupci", "preuzetIsporucenGas.domacinstva",
        "preuzetIsporucenGas.ukupnoIsporuceno", "preuzetIsporucenGas.gubici"
      ]
    }

    if (!dto.sektori || dto.sektori.isEmpty() || dto.sektori.contains(Sektor.TOPLOTNA_ENERGIJA)) {
      headers += [
        "Isporu\u010Dene koli\u010Dine TE u MWh (poslovni potro\u0161a\u010Di)", "Isporu\u010Dene koli\u010Dine TE u MWh (stambeni potro\u0161a\u010Di)",
        "Isporu\u010Dene koli\u010Dine TE po m2 (stambeni potro\u0161a\u010Di)", "Ukupno isporu\u010Deno", "Gubici"
      ]

      withProperties += [
        "isporucenaToplotnaEnergija.poslovniPotrosaciMwh", "isporucenaToplotnaEnergija.stambeniPotrosaciMwh",
        "isporucenaToplotnaEnergija.stambeniPotrosaciM2", "isporucenaToplotnaEnergija.ukupnoIsporuceno", "isporucenaToplotnaEnergija.gubici"
      ]
    }

    headers << "Ukupno isporu\u010Dena energija krajnjim kupcima u TJ"

    withProperties << "ukupnoIsporucenaEnergija"

    headers += [
      "Broj kupaca (doma\u0107instva- mjerenje potro\u0161nje)", "Broj kupaca (industrija- mjerenje potro\u0161nje)",
      "Broj kupaca (ostali sektori- mjerenje potro\u0161nje)", "Broj kupaca (ukupno- mjerenje potro\u0161nje)",
      "Ukupan broj kupaca (doma\u0107instva)", "Ukupan broj kupaca (industrija)", "Ukupan broj kupaca (ostali sektori)", "Ukupan broj kupaca (sveukupno)"
    ]

    withProperties += [
      "stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoBrojMjerenjePotrosnje", "stepenMjerenjeEnergijeStrukturaKupaca.industrijaBrojMjerenjePotrosnje",
      "stepenMjerenjeEnergijeStrukturaKupaca.ostaloBrojMjerenjePotrosnje", "stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojMjerenjePotrosnje",
      "stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoUkupanBroj", "stepenMjerenjeEnergijeStrukturaKupaca.industrijaUkupanBroj", "stepenMjerenjeEnergijeStrukturaKupaca.ostaloUkupanBroj", "stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojKrajnjihKupaca"
    ]

    if (!dto.sektori || dto.sektori.isEmpty() || dto.sektori.contains(Sektor.ELEKTRICNA_ENERGIJA)) {
      headers += [
        "Broj korisnika sa sistemom dalj. o\u010Ditavanja (doma\u0107instva)", "Broj korisnika sa sistemom dalj. o\u010Ditavanja (industrija)",
        "Broj korisnika sa sistemom dalj. o\u010Ditavanja (ostali sektori)", "Broj korisnika sa sistemom dalj. o\u010Ditavanja (ukupno)"
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


  @Transactional
  def printPdf(params) {
    try {
      DefaultJasperReportsContext.getInstance().setProperty("net.sf.jasperreports.default.font.name", "SansSerif")
      DefaultJasperReportsContext.getInstance().setProperty("net.sf.jasperreports.default.pdf.encoding", "Cp1250")

      String report = ""

      Izvjestaj izvjestaj = Izvjestaj.findById(params.id)
      JRBeanCollectionDataSource preuzetaIsporucenaEEDataSource = new JRBeanCollectionDataSource(izvjestaj.preuzetaIsporucenaEEList)
      JRBeanCollectionDataSource procjenaStanjaEnergetskeEfikasnostiDataSource = new JRBeanCollectionDataSource(izvjestaj.procjenaStanjaEnergetskeEfikasnostiList)
      JRBeanCollectionDataSource podaciEnergentiDataSource = new JRBeanCollectionDataSource(izvjestaj.podaciEnergenti)

      def bean = []
      bean = [
        preduzeceNaziv                  : izvjestaj.preduzece.naziv,
        preduzeceAdresa                 : izvjestaj.preduzece.adresa,
        preduzeceMaticniBroj            : izvjestaj.preduzece.maticniBrojJedinstvenogRegistra,
        preduzeceJib                    : izvjestaj.preduzece.jib,
        preduzecePib                    : izvjestaj.preduzece.pib,
        preduzeceTelefon                : izvjestaj.preduzece.telefon,
        preduzeceFax                    : izvjestaj.preduzece.fax,
        preduzeceMail                   : izvjestaj.preduzece.email,
        preduzeceBrojZaposlenih         : izvjestaj.preduzece.brojZaposlenih,
        preduzeceGodisnjiPromet         : izvjestaj.preduzece.ukupanGodisnjiPromet,
        distribucijaRegistarskiBroj     : izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj,
        distribucijaKomisija            : izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija,
        distribucijaDatumPocetkaVazenje : izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje,
        distribucijaPeriodVazenja       : izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja,
        snabdijevanjeRegistarskiBroj    : izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj,
        snabdijevanjeKomisija           : izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija,
        snabdijevanjeDatumPocetkaVazenje: izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje,
        snabdijevanjePeriodVazenja      : izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja,
        godina                          : izvjestaj.podaciPodnosenjeIzvjestaja.godina,
        prezimeImePozicija              : izvjestaj.podaciPodnosenjeIzvjestaja.prezimeImePozicija,
        telefon                         : izvjestaj.podaciPodnosenjeIzvjestaja.telefon,
        email                           : izvjestaj.podaciPodnosenjeIzvjestaja.email
      ]

      if (izvjestaj.tip == IzvjestajTip.EE_DS) {
        report = "grails-app/resources/jasper/izvjestaj_ee.jrxml"

        bean += [
          preuzetaIsporucenaEEDataSource               : preuzetaIsporucenaEEDataSource,
          procjenaStanjaEnergetskeEfikasnostiDataSource: procjenaStanjaEnergetskeEfikasnostiDataSource,
          domacinstvoBrojMjerenjePotrosnje             : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoBrojMjerenjePotrosnje,
          domacinstvoUkupanBroj                        : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoUkupanBroj,
          domacinstvoBrojDaljinskoOcitavanje           : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoBrojDaljinskoOcitavanje,
          industrijaBrojMjerenjePotrosnje              : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaBrojMjerenjePotrosnje,
          industrijaUkupanBroj                         : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaUkupanBroj,
          industrijaBrojDaljinskoOcitavanje            : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaBrojDaljinskoOcitavanje,
          ostaloBrojMjerenjePotrosnje                  : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloBrojMjerenjePotrosnje,
          ostaloUkupanBroj                             : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloUkupanBroj,
          ostaloBrojDaljinskoOcitavanje                : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloBrojDaljinskoOcitavanje,
          ukupnoBrojMjerenjePotrosnje                  : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojMjerenjePotrosnje,
          ukupnoBrojKrajnjihKupaca                     : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojKrajnjihKupaca,
          ukupnoBrojDaljinskoOcitavanje                : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojDaljinskoOcitavanje,
          podaciPonudeEnergetskihUsluga                : izvjestaj.podaciPonudeEnergetskihUsluga,
          podaciPonudeUgradnjaIndividualnihUredjaja    : izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja,
          podaciOstaloEnergetskaEfikasnost             : izvjestaj.podaciOstaloEnergetskaEfikasnost
        ]
      }

      if (izvjestaj.tip == IzvjestajTip.T_DS) {
        report = "grails-app/resources/jasper/izvjestaj_te.jrxml"

        bean += [
          poslovniPotrosaciMwh                         : izvjestaj.isporucenaToplotnaEnergija?.poslovniPotrosaciMwh,
          stambeniPotrosaciMwh                         : izvjestaj.isporucenaToplotnaEnergija?.stambeniPotrosaciMwh,
          stambeniPotrosaciM2                          : izvjestaj.isporucenaToplotnaEnergija?.stambeniPotrosaciM2,
          ukupnoIsporuceno                             : izvjestaj.isporucenaToplotnaEnergija?.ukupnoIsporuceno,
          gubici                                       : izvjestaj.isporucenaToplotnaEnergija?.gubici,
          podaciEnergentiDataSource                    : podaciEnergentiDataSource,
          procjenaStanjaEnergetskeEfikasnostiDataSource: procjenaStanjaEnergetskeEfikasnostiDataSource,
          ukupnoIsporucenaEnergija                     : izvjestaj.ukupnoIsporucenaEnergija,
          podaciPonudeEnergetskihUsluga                : izvjestaj.podaciPonudeEnergetskihUsluga,
          podaciPonudeUgradnjaIndividualnihUredjaja    : izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja,
          podaciOstaloEnergetskaEfikasnost             : izvjestaj.podaciOstaloEnergetskaEfikasnost,
          domacinstvoBrojMjerenjePotrosnje             : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoBrojMjerenjePotrosnje.toInteger(),
          domacinstvoUkupanBroj                        : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoUkupanBroj.toInteger(),
          industrijaBrojMjerenjePotrosnje              : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaBrojMjerenjePotrosnje.toInteger(),
          industrijaUkupanBroj                         : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaUkupanBroj.toInteger(),
          ostaloBrojMjerenjePotrosnje                  : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloBrojMjerenjePotrosnje.toInteger(),
          ostaloUkupanBroj                             : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloUkupanBroj.toInteger(),
          ukupnoBrojMjerenjePotrosnje                  : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojMjerenjePotrosnje.toInteger(),
          ukupnoBrojKrajnjihKupaca                     : izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojKrajnjihKupaca.toInteger()
        ]
      }

      bean.collect { it ?: "" }

      JasperReport jreport = JasperCompileManager.compileReport(report)

      JasperPrint jprint = JasperFillManager.fillReport(jreport, bean, new JREmptyDataSource())

      byte[] byteArray = JasperExportManager.exportReportToPdf(jprint)
      String encoded = Base64.getEncoder().encodeToString(byteArray);
      response.status = 200
      render([pdfByteArray: encoded] as JSON)
    } catch (Exception e) {
      response.status = 500
      render([title: 'Izvještaj', message: 'Došlo je do greške prilikom generisanja izvještaja.', error: e.getLocalizedMessage()] as JSON)
    }
  }
}
