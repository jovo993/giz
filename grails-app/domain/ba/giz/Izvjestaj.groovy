package ba.giz

class Izvjestaj {

  Preduzece preduzece
  PodaciDozvolaObavljanjeDjelatnosti podaciDozvolaObavljanjeDjelatnosti
  PodaciPodnosenjeIzvjestaja podaciPodnosenjeIzvjestaja

  List<PreuzetaIsporucenaEE> preuzetaIsporucenaEEList
  PreuzetIsporucenGas preuzetIsporucenGas
  IsporucenaToplotnaEnergija isporucenaToplotnaEnergija

  Double ukupnoIsporucenaEnergija

  List<ProcjenaStanjaEnergetskeEfikasnosti> procjenaStanjaEnergetskeEfikasnostiList

  StepenMjerenjeEnergijeStrukturaKupaca stepenMjerenjeEnergijeStrukturaKupaca

  List<PodaciEnergenti> podaciEnergenti

  String podaciPonudeEnergetskihUsluga
  String podaciPonudeUgradnjaIndividualnihUredjaja
  String podaciOstaloEnergetskaEfikasnost
  IzvjestajTip tip
  Date datumKreiranja
  Date datumSlanja
  IzvjestajStatus status

  static auditable = true

  static constraints = {
    preduzece blank: true, nullable: true
    podaciDozvolaObavljanjeDjelatnosti blank: true, nullable: true
    podaciPodnosenjeIzvjestaja blank: true, nullable: true
    podaciPonudeEnergetskihUsluga widget: 'textarea', blank: true, nullable: true
    podaciPonudeUgradnjaIndividualnihUredjaja widget: 'textarea', blank: true, nullable: true
    podaciOstaloEnergetskaEfikasnost widget: 'textarea', blank: true, nullable: true
    stepenMjerenjeEnergijeStrukturaKupaca nullable: true
    tip blank: true, nullable: true
    datumKreiranja nullable: true
    datumSlanja nullable: true
    status nullable: true
    ukupnoIsporucenaEnergija nullable: true
    preuzetaIsporucenaEEList nullable: true
    podaciEnergenti nullable: true
    preuzetIsporucenGas nullable: true
    isporucenaToplotnaEnergija nullable: true
    stepenMjerenjeEnergijeStrukturaKupaca nullable: true
  }
}
