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
    distribucijaRegistarskiBroj blank: true, nullable: true
    distribucijaKomisija blank: true, nullable: true
    distribucijaDatumPocetkaVazenje blank: true, nullable: true
    distribucijaPeriodVazenja blank: true, nullable: true

    snabdijevanjeRegistarskiBroj blank: true, nullable: true
    snabdijevanjeKomisija blank: true, nullable: true
    snabdijevanjeDatumPocetkaVazenje blank: true, nullable: true
    snabdijevanjePeriodVazenja blank: true, nullable: true
  }
}
