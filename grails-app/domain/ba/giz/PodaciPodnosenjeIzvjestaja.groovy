package ba.giz

class PodaciPodnosenjeIzvjestaja {

  Integer godina
  String prezimeImePozicija
  String telefon
  String email

  static constraints = {
    godina blank: true, nullable: true
    prezimeImePozicija blank: true, nullable: true
    telefon blank: true, nullable: true
    email blank: true, nullable: true
  }
}
