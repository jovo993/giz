package ba.giz

class PreuzetaIsporucenaEE {

  String radnaJedinica
  Double preuzetaElektricnaEnergija = 0
  Double potrosnjaNa110kV = 0
  Double potrosnjaNa35kV = 0
  Double potrosnjaNa1Do35kV = 0
  Double potrosnjaOstala = 0
  Double potrosnjaDomacinstva = 0
  Double potrosnjaJavnaRasvjeta = 0
  Double ukupnoIsporuceno = 0
  Double gubici = 0

  static constraints = {
    radnaJedinica nullable: true
    preuzetaElektricnaEnergija nullable: true
    potrosnjaNa110kV nullable: true
    potrosnjaNa35kV nullable: true
    potrosnjaNa1Do35kV nullable: true
    potrosnjaOstala nullable: true
    potrosnjaDomacinstva nullable: true
    potrosnjaJavnaRasvjeta nullable: true
    ukupnoIsporuceno nullable: true
    gubici nullable: true
  }

}
