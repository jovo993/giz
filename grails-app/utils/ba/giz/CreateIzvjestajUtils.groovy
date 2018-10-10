package ba.giz

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import grails.util.Holders

import java.lang.reflect.Type

class CreateIzvjestajUtils {

  static void generateBasicData(params, Izvjestaj izvjestaj) {

    izvjestaj.datumKreiranja = Calendar.getInstance().getTime()
    izvjestaj.status = IzvjestajStatus.KREIRAN
    izvjestaj.preduzece = Preduzece.findById(Holders.applicationContext.getBean("springSecurityService").currentUser?.preduzece?.id)

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

    podaciDozvolaObavljanjeDjelatnosti.save()
    izvjestaj.podaciDozvolaObavljanjeDjelatnosti = podaciDozvolaObavljanjeDjelatnosti


    PodaciPodnosenjeIzvjestaja podaciPodnosenjeIzvjestaja = new PodaciPodnosenjeIzvjestaja()
    def ppi = params.izvjestaj.podaciPodnosenjeIzvjestaja
    podaciPodnosenjeIzvjestaja.godina = ppi.godina_year
    podaciPodnosenjeIzvjestaja.prezimeImePozicija = ppi.prezimeImePozicija
    podaciPodnosenjeIzvjestaja.telefon = ppi.telefon
    podaciPodnosenjeIzvjestaja.email = ppi.email

    podaciPodnosenjeIzvjestaja.save()
    izvjestaj.podaciPodnosenjeIzvjestaja = podaciPodnosenjeIzvjestaja


    izvjestaj.podaciPonudeEnergetskihUsluga = params.izvjestaj.podaciPonudeEnergetskihUsluga
    izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja = params.izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja
    izvjestaj.podaciOstaloEnergetskaEfikasnost = params.izvjestaj.podaciOstaloEnergetskaEfikasnost
  }

  static void generateTypeDependentData(params, Izvjestaj izvjestaj) {
    def data = params.izvjestaj

    izvjestaj.procjenaStanjaEnergetskeEfikasnostiList = null
    List<ProcjenaStanjaEnergetskeEfikasnosti> efikasnostList = parseJsonArrayToListProcjenaStanja(data.procjenaStanjaEnergetskeEfikasnostiList)
    izvjestaj.procjenaStanjaEnergetskeEfikasnostiList = efikasnostList

    switch (izvjestaj.preduzece.sektor) {
      case Sektor.ELEKTRICNA_ENERGIJA:
        izvjestaj.tip = IzvjestajTip.EE_DS

        izvjestaj.preuzetaIsporucenaEEList = null
        List<PreuzetaIsporucenaEE> preuzetaIsporucenaEE = parseJsonArrayToListPreuzetaIsporucenaEE(data.preuzetaIsporucenaEEList)
        izvjestaj.preuzetaIsporucenaEEList = preuzetaIsporucenaEE

        izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca = generateStepenMjerenjaEnergije(data.stepenMjerenjeEnergijeStrukturaKupaca, true)

        break
      case Sektor.GAS:
        izvjestaj.tip = IzvjestajTip.G_DS
        izvjestaj.preuzetIsporucenGasList = parseJsonArrayToListPreuzetIsporucenGas(data.preuzetIsporucenGasList)

        izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca = generateStepenMjerenjaEnergije(data.stepenMjerenjeEnergijeStrukturaKupaca, false)

        break
      case Sektor.TOPLOTNA_ENERGIJA:
        izvjestaj.tip = IzvjestajTip.T_DS
        izvjestaj.isporucenaToplotnaEnergijaList = parseJsonArrayToListIsporucenaToplotnaEnergija(data.isporucenaToplotnaEnergijaList)

        izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca = generateStepenMjerenjaEnergije(data.stepenMjerenjeEnergijeStrukturaKupaca, false)

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

    stepenMjerenja.save()
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

  private static List<PreuzetIsporucenGas> parseJsonArrayToListPreuzetIsporucenGas(text) {
    Type listType = new TypeToken<List<PreuzetIsporucenGas>>() {}.getType()
    Gson gson = new GsonBuilder().registerTypeAdapter(Double.class, new DoubleTypeAdapter()).create()
    return gson.fromJson(text.toString(), listType)
  }

  private static List<IsporucenaToplotnaEnergija> parseJsonArrayToListIsporucenaToplotnaEnergija(text) {
    Type listType = new TypeToken<List<IsporucenaToplotnaEnergija>>() {}.getType()
    Gson gson = new GsonBuilder().registerTypeAdapter(Double.class, new DoubleTypeAdapter()).create()
    return gson.fromJson(text.toString(), listType)
  }

  private static convertStringToLong(String value) {
    return value == "" ? 0 : Long.valueOf(value)
  }

}
