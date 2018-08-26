package ba.giz

import com.google.gson.Gson

class ProcjenaStanjaEnergetskeEfikasnosti {

  String primjenjenaMjera
  String vrstaUstede
  String kolicinaUstede

  ProcjenaStanjaEnergetskeEfikasnosti() {

  }

  ProcjenaStanjaEnergetskeEfikasnosti(def procjenaStanjaEnergetskeEfikasnosti) {
    this.primjenjenaMjera = procjenaStanjaEnergetskeEfikasnosti.primjenjenaMjera
    this.vrstaUstede = procjenaStanjaEnergetskeEfikasnosti.vrstaUstede
    this.kolicinaUstede = procjenaStanjaEnergetskeEfikasnosti.kolicinaUstede
  }

  ProcjenaStanjaEnergetskeEfikasnosti(String string) {
    this(new Gson().fromJson(string, ProcjenaStanjaEnergetskeEfikasnosti.class))
  }
}
