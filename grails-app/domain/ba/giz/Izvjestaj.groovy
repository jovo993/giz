package ba.giz

class Izvjestaj {

  Preduzece preduzece
  PodaciDozvolaObavljanjeDjelatnosti podaciDozvolaObavljanjeDjelatnosti
  PodaciPodnosenjeIzvjestaja podaciPodnosenjeIzvjestaja

  String podaciPonudeEnergetskihUsluga
  String podaciPonudeUgradnjaIndividualnihUredjaja
  String podaciOstaloEnergetskaEfikasnost

  static constraints = {
    preduzece nullable: true
    podaciDozvolaObavljanjeDjelatnosti nullable: true
    podaciPodnosenjeIzvjestaja nullable: true
    podaciPonudeEnergetskihUsluga widget :'textarea', nullable: true
    podaciPonudeUgradnjaIndividualnihUredjaja widget :'textarea', nullable: true
    podaciOstaloEnergetskaEfikasnost widget :'textarea', nullable: true
  }
}
