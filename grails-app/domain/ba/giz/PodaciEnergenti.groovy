package ba.giz

class PodaciEnergenti {

  String energent
  Double godisnjaUpotrebljenaKolicina
  String jednicaMjere

  static constraints = {
    energent blank: false
    godisnjaUpotrebljenaKolicina blank: false
    jednicaMjere blank: false
  }
}
