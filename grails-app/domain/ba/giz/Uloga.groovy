package ba.giz

class Uloga  {
  Boolean operater
  Boolean distributer
  Boolean snabdjevac

  static constraints = {
    operater nullable: true
    distributer nullable: true
    snabdjevac nullable: true
  }

  String toString() {

/*
    String uloge = operater ? "OPERATER, " : ""
    uloge += distributer ? "DISTRIBUTER, " : ""
    uloge += snabdjevac ? "SNABDJEVA\u010C, " : ""
    if (!uloge.equals("")) {
      uloge = uloge[0..-3]
    }
    uloge
*/

    String uloge = operater ? UserUtils.msg("ba.giz.Uloga.OPERATER")+", " : ""
    uloge += distributer ? UserUtils.msg("ba.giz.Uloga.DISTRIBUTER")+", " : ""
    uloge += snabdjevac ? UserUtils.msg("ba.giz.Uloga.SNABDJEVAC")+", " : ""
    if (!uloge.equals("")) {
      uloge = uloge[0..-3]
    }
    uloge

  }
}