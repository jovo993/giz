package ba.giz

class PodaciPodnosenjeIzvjestaja {

  Integer godina
  String prezime
  String ime
  String pozicija
  String telefon
  String email

  static constraints = {
    godina blank: true, nullable: true
    prezime blank: true, nullable: true
    ime blank: true, nullable: true
    pozicija blank: true, nullable: true
    telefon blank: true, nullable: true
    email blank: true, nullable: true
  }
}
