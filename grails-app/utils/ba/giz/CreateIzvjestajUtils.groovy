package ba.giz

import groovy.json.JsonSlurper

class CreateIzvjestajUtils {

  static void generateBasicData(params, Izvjestaj izvjestaj) {
    PodaciDozvolaObavljanjeDjelatnosti podaciDozvolaObavljanjeDjelatnosti = new PodaciDozvolaObavljanjeDjelatnosti()

    def pdod = params.izvjestaj.podaciDozvolaObavljanjeDjelatnosti
    podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj = pdod.distribucijaRegistarskiBroj
    podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija = pdod.distribucijaKomisija
    String datumDistribucija = pdod.distribucijaDatumPocetkaVazenje_day + "." + pdod.distribucijaDatumPocetkaVazenje_month + "." + pdod.distribucijaDatumPocetkaVazenje_year
    podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje = new Date().parse("dd.mm.yyyy", datumDistribucija)
    podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja = pdod.distribucijaPeriodVazenja.isInteger() ? pdod.distribucijaPeriodVazenja.toInteger() : null

    podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj = pdod.snabdijevanjeRegistarskiBroj
    podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija = pdod.snabdijevanjeKomisija
    String datumSnabdijevanje = pdod.snabdijevanjeDatumPocetkaVazenje_day + "." + pdod.snabdijevanjeDatumPocetkaVazenje_month + "." + pdod.snabdijevanjeDatumPocetkaVazenje_year
    podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje = new Date().parse("dd.mm.yyyy", datumSnabdijevanje)
    podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja = pdod.snabdijevanjePeriodVazenja.isInteger() ? pdod.snabdijevanjePeriodVazenja.toInteger() : null

    izvjestaj.podaciDozvolaObavljanjeDjelatnosti = podaciDozvolaObavljanjeDjelatnosti


    PodaciPodnosenjeIzvjestaja podaciPodnosenjeIzvjestaja = new PodaciPodnosenjeIzvjestaja()

    def ppi = params.izvjestaj.podaciPodnosenjeIzvjestaja
    podaciPodnosenjeIzvjestaja.godina = ppi.godina
    podaciPodnosenjeIzvjestaja.prezimeImePozicija = ppi.prezimeImePozicija
    podaciPodnosenjeIzvjestaja.telefon = ppi.telefon
    podaciPodnosenjeIzvjestaja.email = ppi.email

    izvjestaj.podaciPodnosenjeIzvjestaja = podaciPodnosenjeIzvjestaja
  }

  static void generateAdditionaData(params, Izvjestaj izvjestaj) {
    switch (izvjestaj.preduzece.sektor) {
      case Sektor.ELEKTRICNA_ENERGIJA:
        List<PreuzetaIsporucenaEE> preuzetaIsporucenaEE = JsonSlurper.newInstance().parseText(params.izvjestaj.preuzetaIsporucenaEEList) as List<PreuzetaIsporucenaEE>
        izvjestaj.preuzetaIsporucenaEEList = preuzetaIsporucenaEE
        break
      case Sektor.GAS:
        break
      case Sektor.TOPLOTNA_ENERGIJA:
        break
    }
  }

}
