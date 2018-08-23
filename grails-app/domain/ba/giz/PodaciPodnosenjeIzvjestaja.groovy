package ba.giz

class PodaciPodnosenjeIzvjestaja {

  Integer godina
  String prezime
  String ime
  String pozicija
  String telefon
  String email
  String displayName

  static transients = ["displayName"]

  String getDisplayName() {
    "${prezime ?: ""} ${ime ?: ""}, ${pozicija ?: ""}".trim()
  }

  static constraints = {
    godina blank: true, nullable: true
    prezime blank: true, nullable: true
    ime blank: true, nullable: true
    pozicija blank: true, nullable: true
    telefon blank: true, nullable: true
    email blank: true, nullable: true
    displayName blank: true, nullable: true
  }
}
