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
    naziv blank: false
    adresa blank: false
    maticniBrojJedinstvenogRegistra blank: false
    jib blank: false
    pib blank: false
    telefon matches: "[0-9]{3}/[0-9]{3}-[0-9]{3}"
    fax phone: true
    email email: true
    brojZaposlenih blank: true
    ukupanGodisnjiPromet blank: true
  }

  String toString() {
    return naziv
  }
}
