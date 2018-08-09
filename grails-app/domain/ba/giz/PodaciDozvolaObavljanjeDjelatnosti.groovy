package ba.giz

class PodaciDozvolaObavljanjeDjelatnosti {

  String distribucijaRegistarskiBroj
  String distribucijaKomisija
  Date distribucijaDatumPocetkaVazenje
  Integer distribucijaPeriodVazenja

  String snabdijevanjeRegistarskiBroj
  String snabdijevanjeKomisija
  Date snabdijevanjeDatumPocetkaVazenje
  Integer snabdijevanjePeriodVazenja

  static constraints = {
    distribucijaRegistarskiBroj nullable: true
    distribucijaKomisija nullable: true
    distribucijaDatumPocetkaVazenje nullable: true
    distribucijaPeriodVazenja nullable: true

    snabdijevanjeRegistarskiBroj nullable: true
    snabdijevanjeKomisija nullable: true
    snabdijevanjeDatumPocetkaVazenje nullable: true
    snabdijevanjePeriodVazenja nullable: true
  }
}
