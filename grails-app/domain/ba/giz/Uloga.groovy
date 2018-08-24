package ba.giz

class Uloga {

  Boolean operator
  Boolean distributer
  Boolean snabdjevac

  static constraints = {
    operator nullable: true
    distributer nullable: true, validator: {val, obj ->
      if (!(obj.distributer || obj.snabdjevac || val)) return ['ulogaObavezna']
    }
    snabdjevac nullable: true
  }

  String toString() {
    String uloge = operator ? "OPERATOR, " : ""
    uloge += distributer ? "DISTRIBUTER, " : ""
    uloge += snabdjevac ? "SNABDJEVA\u010C, " : ""
    uloge = uloge[0..-3]

    uloge
  }
}
