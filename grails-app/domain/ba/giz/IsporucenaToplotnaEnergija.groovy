package ba.giz

class IsporucenaToplotnaEnergija {

  Double poslovniPotrosaci
  Double stambeniPotrosaciMwh
  Double stambeniPotrosaciM2

  static constraints = {
    poslovniPotrosaci blank: false
    stambeniPotrosaciMwh blank: false
    stambeniPotrosaciM2 blank: false
  }
}
