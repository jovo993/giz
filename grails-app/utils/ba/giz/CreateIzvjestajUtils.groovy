package ba.giz

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken

import java.lang.reflect.Type

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


    izvjestaj.podaciPonudeEnergetskihUsluga = params.izvjestaj.podaciPonudeEnergetskihUsluga
    izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja = params.izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja
    izvjestaj.podaciOstaloEnergetskaEfikasnost = params.izvjestaj.podaciOstaloEnergetskaEfikasnost
  }

  static void generateTableData(params, Izvjestaj izvjestaj) {
    def data = params.izvjestaj

    switch (izvjestaj.preduzece.sektor) {
      case Sektor.ELEKTRICNA_ENERGIJA:

        izvjestaj.preuzetaIsporucenaEEList = null
        List<PreuzetaIsporucenaEE> preuzetaIsporucenaEE = parseJsonArrayToListPreuzetaIsporucenaEE(data.preuzetaIsporucenaEEList)
        if (preuzetaIsporucenaEE.size() > 1) {
          izvjestaj.preuzetaIsporucenaEEList = preuzetaIsporucenaEE
        }

        izvjestaj.procjenaStanjaEnergetskeEfikasnostiList = null
        List<ProcjenaStanjaEnergetskeEfikasnosti> efikasnostList = parseJsonArrayToListProcjenaStanja(data.procjenaStanjaEnergetskeEfikasnostiList)
        if (efikasnostList.size() > 0) {
          izvjestaj.procjenaStanjaEnergetskeEfikasnostiList = efikasnostList
        }

        izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca = generateStepenMjerenjaEnergije(data.stepenMjerenjeEnergijeStrukturaKupaca, true)

        break
      case Sektor.GAS:
        break
      case Sektor.TOPLOTNA_ENERGIJA:
        break
    }
  }

  static StepenMjerenjeEnergijeStrukturaKupaca generateStepenMjerenjaEnergije(data, ee_sektor) {
    StepenMjerenjeEnergijeStrukturaKupaca stepenMjerenja = new StepenMjerenjeEnergijeStrukturaKupaca()

    stepenMjerenja.domacinstvoBrojMjerenjePotrosnje = convertStringToLong(data.domacinstvoBrojMjerenjePotrosnje)
    stepenMjerenja.domacinstvoUkupanBroj = convertStringToLong(data.domacinstvoUkupanBroj)

    stepenMjerenja.industrijaUkupanBroj = convertStringToLong(data.industrijaUkupanBroj)
    stepenMjerenja.industrijaBrojMjerenjePotrosnje = convertStringToLong(data.industrijaBrojMjerenjePotrosnje)

    stepenMjerenja.ostaloBrojMjerenjePotrosnje = convertStringToLong(data.ostaloBrojMjerenjePotrosnje)
    stepenMjerenja.ostaloUkupanBroj = convertStringToLong(data.ostaloUkupanBroj)

    stepenMjerenja.ukupnoBrojMjerenjePotrosnje = convertStringToLong(data.ukupnoBrojMjerenjePotrosnje)
    stepenMjerenja.ukupnoBrojKrajnjihKupaca = convertStringToLong(data.ukupnoBrojKrajnjihKupaca)

    if (ee_sektor) {
      stepenMjerenja.industrijaBrojDaljinskoOcitavanje = convertStringToLong(data.industrijaBrojDaljinskoOcitavanje)
      stepenMjerenja.domacinstvoBrojDaljinskoOcitavanje = convertStringToLong(data.domacinstvoBrojDaljinskoOcitavanje)
      stepenMjerenja.ostaloBrojDaljinskoOcitavanje = convertStringToLong(data.ostaloBrojDaljinskoOcitavanje)
      stepenMjerenja.ukupnoBrojDaljinskoOcitavanje = convertStringToLong(data.ukupnoBrojDaljinskoOcitavanje)
    }

    return stepenMjerenja
  }

  private static List<PreuzetaIsporucenaEE> parseJsonArrayToListPreuzetaIsporucenaEE(text) {
    Type listType = new TypeToken<List<PreuzetaIsporucenaEE>>() {}.getType()
    Gson gson = new GsonBuilder().registerTypeAdapter(Double.class, new DoubleTypeAdapter()).create()
    return gson.fromJson(text.toString(), listType)
  }

  private static List<ProcjenaStanjaEnergetskeEfikasnosti> parseJsonArrayToListProcjenaStanja(text) {
    Type listType = new TypeToken<List<ProcjenaStanjaEnergetskeEfikasnosti>>() {}.getType()
    return new Gson().fromJson(text.toString(), listType)
  }

  private static convertStringToLong(value) {
    return Long.valueOf(value.toString())
  }

}
