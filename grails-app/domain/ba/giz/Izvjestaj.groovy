package ba.giz

class Izvjestaj {

  Preduzece preduzece
  PodaciDozvolaObavljanjeDjelatnosti podaciDozvolaObavljanjeDjelatnosti
  PodaciPodnosenjeIzvjestaja podaciPodnosenjeIzvjestaja

  String podaciPonudeEnergetskihUsluga
  String podaciPonudeUgradnjaIndividualnihUredjaja
  String podaciOstaloEnergetskaEfikasnost

  static constraints = {
    preduzece blank: true, nullable: true
    podaciDozvolaObavljanjeDjelatnosti blank: true, nullable: true
    podaciPodnosenjeIzvjestaja blank: true, nullable: true
    podaciPonudeEnergetskihUsluga widget :'textarea', blank: true, nullable: true
    podaciPonudeUgradnjaIndividualnihUredjaja widget :'textarea', blank: true, nullable: true
    podaciOstaloEnergetskaEfikasnost widget :'textarea', blank: true, nullable: true
  }
}
