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
    podaciPonudeEnergetskihUsluga nullable: true
    podaciPonudeUgradnjaIndividualnihUredjaja nullable: true
    podaciOstaloEnergetskaEfikasnost nullable: true
  }
}
