package ba.giz

enum Sektor {

  ELEKTRICNA_ENERGIJA("ELEKTRI\u010CNA ENERGIJA"), GAS("GAS"), TOPLOTNA_ENERGIJA("TOPLOTNA ENERGIJA")

  private final String value

  Sektor (String value) {
    this.value = value
  }

  String toString() {
    value
  }
}
