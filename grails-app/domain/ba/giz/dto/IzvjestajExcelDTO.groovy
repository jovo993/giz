package ba.giz.dto

import ba.giz.Sektor
import ba.giz.Uloga

class IzvjestajExcelDTO {

  Integer godina
  List<Sektor> sektori
  Uloga uloga

  Boolean kreiran
  Boolean poslan
  Boolean dorada
  Boolean verifikovan
  Boolean zavrsen

  static constraints = {
    godina blank: true, nullable: true
  }
}
