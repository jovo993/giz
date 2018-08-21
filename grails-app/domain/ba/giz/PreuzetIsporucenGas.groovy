package ba.giz

class PreuzetIsporucenGas {

  Double preuzetaKolicina
  Double industrijskiPotrosaci
  Double sistemiDaljinskoGrijanja
  Double komercijalniKrajnjiKupci
  Double domacinstva

  static constraints = {
    preuzetaKolicina blank: false
    industrijskiPotrosaci blank: false
    sistemiDaljinskoGrijanja blank: false
    komercijalniKrajnjiKupci blank: false
    domacinstva blank: false
  }
}
