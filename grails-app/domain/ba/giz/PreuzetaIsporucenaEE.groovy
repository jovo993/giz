package ba.giz

class PreuzetaIsporucenaEE {

  String radnaJedinica
  Double preuzetaElektricnaEnergija
  Double potrosnjaNa110kV
  Double potrosnjaNa35kV
  Double potrosnjaNa1Do35kV
  Double potrosnjaOstala
  Double potrosnjaDomacinstva
  Double potrosnjaJavnaRasvjeta
  Double ukupnoIsporuceno
  Double gubici

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
