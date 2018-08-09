package ba.giz

class PodaciPodnosenjeIzvjestaja {

  Integer godina
  String prezime
  String ime
  String pozicija
  String telefon
  String email

  static constraints = {
    godina blank: false
    prezime blank: false
    ime blank: false
    pozicija blank: false
    telefon blank: false
    email blank: false
  }
}
