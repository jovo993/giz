package ba.giz

class ProcjenaStanjaEnergetskeEfikasnosti {

  String primjenjenaMjera
  String vrstaUstede
  String kolicinaUstede

  static constraints = {
    primjenjenaMjera nullable: false
    vrstaUstede nullable: false
    kolicinaUstede nullable: false
  }
}
