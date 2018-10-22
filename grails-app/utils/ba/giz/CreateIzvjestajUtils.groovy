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
    podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje = parseDate(pdod.distribucijaDatumPocetkaVazenje.toString())
    podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja = pdod.distribucijaPeriodVazenja.isInteger() ? pdod.distribucijaPeriodVazenja.toInteger() : null

    podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj = pdod.snabdijevanjeRegistarskiBroj
    podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija = pdod.snabdijevanjeKomisija
    podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje = parseDate(pdod.snabdijevanjeDatumPocetkaVazenje.toString())
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


    izvjestaj.ukupnoIsporucenaEnergija = convertStringToDouble(params.izvjestaj.ukupnoIsporucenaEnergija.toString())
    izvjestaj.podaciPonudeEnergetskihUsluga = params.izvjestaj.podaciPonudeEnergetskihUsluga
    izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja = params.izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja
    izvjestaj.podaciOstaloEnergetskaEfikasnost = params.izvjestaj.podaciOstaloEnergetskaEfikasnost
  }

  // TODO: if its a update copy on top of already existing objects (copyData(new, old))
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
        izvjestaj.preuzetIsporucenGas = parseJsonArrayToPreuzetIsporucenGas(data.preuzetIsporucenGas)

        izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca = generateStepenMjerenjaEnergije(data.stepenMjerenjeEnergijeStrukturaKupaca, false)

        break
      case Sektor.TOPLOTNA_ENERGIJA:
        izvjestaj.tip = IzvjestajTip.T_DS
        izvjestaj.isporucenaToplotnaEnergija = parseJsonArrayToIsporucenaToplotnaEnergija(data.isporucenaToplotnaEnergija)
        izvjestaj.isporucenaToplotnaEnergija.save()
        izvjestaj.podaciEnergenti = parseJsonArrayToListPodaciEnergenti(data.podaciEnergenti)

        izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca = generateStepenMjerenjaEnergije(data.stepenMjerenjeEnergijeStrukturaKupaca, false)

        break
    }
  }

  static StepenMjerenjeEnergijeStrukturaKupaca generateStepenMjerenjaEnergije(data, ee_sektor) {
    StepenMjerenjeEnergijeStrukturaKupaca stepenMjerenja = new StepenMjerenjeEnergijeStrukturaKupaca()

    stepenMjerenja.domacinstvoBrojMjerenjePotrosnje = convertStringToLong(data.domacinstvoBrojMjerenjePotrosnje.toString())
    stepenMjerenja.domacinstvoUkupanBroj = convertStringToLong(data.domacinstvoUkupanBroj.toString())

    stepenMjerenja.industrijaUkupanBroj = convertStringToLong(data.industrijaUkupanBroj.toString())
    stepenMjerenja.industrijaBrojMjerenjePotrosnje = convertStringToLong(data.industrijaBrojMjerenjePotrosnje.toString())

    stepenMjerenja.ostaloBrojMjerenjePotrosnje = convertStringToLong(data.ostaloBrojMjerenjePotrosnje.toString())
    stepenMjerenja.ostaloUkupanBroj = convertStringToLong(data.ostaloUkupanBroj.toString())

    stepenMjerenja.ukupnoBrojMjerenjePotrosnje = convertStringToLong(data.ukupnoBrojMjerenjePotrosnje.toString())
    stepenMjerenja.ukupnoBrojKrajnjihKupaca = convertStringToLong(data.ukupnoBrojKrajnjihKupaca.toString())

    if (ee_sektor) {
      stepenMjerenja.industrijaBrojDaljinskoOcitavanje = convertStringToLong(data.industrijaBrojDaljinskoOcitavanje.toString())
      stepenMjerenja.domacinstvoBrojDaljinskoOcitavanje = convertStringToLong(data.domacinstvoBrojDaljinskoOcitavanje.toString())
      stepenMjerenja.ostaloBrojDaljinskoOcitavanje = convertStringToLong(data.ostaloBrojDaljinskoOcitavanje.toString())
      stepenMjerenja.ukupnoBrojDaljinskoOcitavanje = convertStringToLong(data.ukupnoBrojDaljinskoOcitavanje.toString())
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

  private static PreuzetIsporucenGas parseJsonArrayToPreuzetIsporucenGas(text) {
    String value = text.toString()
    Type type = new TypeToken<PreuzetIsporucenGas>() {}.getType()
    Gson gson = new GsonBuilder().registerTypeAdapter(Double.class, new DoubleTypeAdapter()).create()
    return gson.fromJson(value.substring(1, value.length() - 1), type)
  }

  private static IsporucenaToplotnaEnergija parseJsonArrayToIsporucenaToplotnaEnergija(text) {
    String value = text.toString()
    Type type = new TypeToken<IsporucenaToplotnaEnergija>() {}.getType()
    Gson gson = new GsonBuilder().registerTypeAdapter(Double.class, new DoubleTypeAdapter()).create()
    return gson.fromJson(value.substring(1, value.length() - 1), type)
  }

  private static List<PodaciEnergenti> parseJsonArrayToListPodaciEnergenti(text) {
    Type listType = new TypeToken<List<PodaciEnergenti>>() {}.getType()
    Gson gson = new GsonBuilder().registerTypeAdapter(Double.class, new DoubleTypeAdapter()).create()
    return gson.fromJson(text.toString(), listType)
  }

  private static convertStringToLong(String value) {
    return value == "" ? 0 : value == "null" ? 0 : Long.valueOf(value)
  }

  private static convertStringToDouble(String value) {
    return value == ""  ? 0 : value == "null" ? 0 : Double.valueOf(value)
  }

  private static parseDate(String date) {
      return date == "" ? null : new Date().parse("yyyy-mm-dd", date)
  }

}
