package ba.giz

class Uloga {

  Boolean operator
  Boolean distributer
  Boolean snabdjevac

  static constraints = {
    operator nullable: true
    distributer nullable: true
    snabdjevac nullable: true
  }

  String toString() {
    String uloge = operator ? "OPERATOR, " : ""
    uloge += distributer ? "DISTRIBUTER, " : ""
    uloge += snabdjevac ? "SNABDJEVA\u010C, " : ""
    if (!uloge.equals("")) {
      uloge = uloge[0..-3]
    }

    uloge
  }
}
