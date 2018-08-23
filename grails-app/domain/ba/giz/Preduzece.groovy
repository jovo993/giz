package ba.giz

class Preduzece {

  String naziv
  String adresa
  Long maticniBrojJedinstvenogRegistra
  Long jib
  Long pib
  String telefon
  String fax
  String email
  Integer brojZaposlenih
  Double ukupanGodisnjiPromet

  static constraints = {
    naziv blank: true, nullable: true
    adresa blank: true, nullable: true
    maticniBrojJedinstvenogRegistra blank: true, nullable: true
    jib blank: true, nullable: true
    pib blank: true, nullable: true
    telefon matches: "[0-9]{3}/[0-9]{3}-[0-9]{3}", blank: true, nullable: true
    fax phone: true, blank: true, nullable: true
    email email: true, blank: true, nullable: true
    brojZaposlenih blank: true, nullable: true
    ukupanGodisnjiPromet blank: true, nullable: true
  }

  String toString() {
    return naziv
  }
}
