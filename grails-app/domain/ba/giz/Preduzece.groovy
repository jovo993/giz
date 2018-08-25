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
    naziv nullable: false, blank: false
    sektor nullable: false, blank: false
    uloga nullable: false, blank: false, validator: {val -> if (!val || !(val.operator || val.distributer || val.snabdjevac)) return ['ulogaObavezna'] }
    status nullable: false, blank: false
    adresa nullable: false, blank: false
    maticniBrojJedinstvenogRegistra matches: "^\\d+\$", nullable: false, blank: false
    jib nullable: false, blank: false
    pib nullable: false, blank: false
    telefon matches: "[0-9]{3}/[0-9]{3}-[0-9]{3}", nullable: false, blank: false
    fax phone: true, nullable: true
    email email: true, nullable: false, blank: false
    brojZaposlenih nullable: true
    ukupanGodisnjiPromet nullable: true
  }

  String toString() {
    return naziv
  }
}
