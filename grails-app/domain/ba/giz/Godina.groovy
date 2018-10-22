package ba.giz

class Godina {

  String godina

  static auditable = true

  static constraints = {
    godina nullable: false, blank: false
  }

  String toString() {
    return godina
  }
}
