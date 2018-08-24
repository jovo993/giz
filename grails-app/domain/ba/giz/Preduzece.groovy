package ba.giz

class Preduzece {

  String naziv
  Sektor sektor
  Uloga uloga
  PreduzeceStatus status
  String adresa
  String maticniBrojJedinstvenogRegistra
  String jib
  String pib
  String telefon
  String fax
  String email
  Integer brojZaposlenih
  Double ukupanGodisnjiPromet

  static embedded = ["uloga", "status"]

  static constraints = {
    naziv nullable: false
    sektor nullable: false
    uloga nullable: false
    status nullable: false
    adresa nullable: false
    maticniBrojJedinstvenogRegistra matches: "^\\d+\$", nullable: false
    jib nullable: false
    pib nullable: false
    telefon matches: "[0-9]{3}/[0-9]{3}-[0-9]{3}", blank: false, nullable: false
    fax phone: true, blank: false, nullable: true
    email email: true, blank: false, nullable: false
    brojZaposlenih nullable: true
    ukupanGodisnjiPromet nullable: true
  }

  String toString() {
    return naziv
  }
}
