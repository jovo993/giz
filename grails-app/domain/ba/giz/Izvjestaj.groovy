package ba.giz

class Izvjestaj {

  Preduzece preduzece
  PodaciDozvolaObavljanjeDjelatnosti podaciDozvolaObavljanjeDjelatnosti
  PodaciPodnosenjeIzvjestaja podaciPodnosenjeIzvjestaja

  String podaciPonudeEnergetskihUsluga
  String podaciPonudeUgradnjaIndividualnihUredjaja
  String podaciOstaloEnergetskaEfikasnost

  static constraints = {
    preduzece blank: true
    podaciDozvolaObavljanjeDjelatnosti blank: true
    podaciPodnosenjeIzvjestaja blank: true
    podaciPonudeEnergetskihUsluga widget :'textarea', blank: true
    podaciPonudeUgradnjaIndividualnihUredjaja widget :'textarea', blank: true
    podaciOstaloEnergetskaEfikasnost widget :'textarea', blank: true
  }
}
