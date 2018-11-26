package ba.giz

/*
// originalni kod - prije BB izmjene
enum Sektor {

  ELEKTRICNA_ENERGIJA("ELEKTRI\u010CNA ENERGIJA"), GAS("GAS"), TOPLOTNA_ENERGIJA("TOPLOTNA ENERGIJA")

  private final String value

  Sektor (String value) {
    this.value = value
  }

  String toString() {
    return value
  }
}
*/

enum Sektor implements org.springframework.context.MessageSourceResolvable {
    ELEKTRICNA_ENERGIJA, GAS, TOPLOTNA_ENERGIJA

    Object[] getArguments() { [] as Object[] }
    String[] getCodes() {
        // [name()] // ako bi bile vracane name vrijednosti: ELEKTRICNA_ENERGIJA, GAS, TOPLOTNA_ENERGIJA

        ["${getClass().name}.${name()}"] as String[]
        // jer u .properties fajlu stoji ba.giz.Sektor.ELEKTRICNA_ENERGIJA ... (jer je klasa ba.giz a name je Sektor)

        // ["excel1.${name()}"] ako bi u .properties fajlu stajalo npr. excel1.ELEKTRICNA_ENERGIJA
    }
    String getDefaultMessage() { name() }
}