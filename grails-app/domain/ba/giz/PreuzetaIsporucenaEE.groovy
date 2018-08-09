package ba.giz

class PreuzetaIsporucenaEE {

  Double rjPreuzetaEE
  Double rjPotrosnjaNa110kV
  Double rjPotrosnjaNa35kV
  Double rjPotrosnjaNa1Do35kV
  Double rjPotrosnjaOstala
  Double rjPotrisnjaDomacinstva
  Double rjPotrosnjaJavnaRasvjeta

  static constraints = {
    rjPreuzetaEE blank: false
    rjPotrosnjaNa110kV blank: false
    rjPotrosnjaNa35kV blank: false
    rjPotrosnjaNa1Do35kV blank: false
    rjPotrosnjaOstala blank: false
    rjPotrisnjaDomacinstva blank: false
    rjPotrosnjaJavnaRasvjeta blank: false
  }
}
