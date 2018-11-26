package ba.giz

/*
enum IzvjestajStatus {
  KREIRAN, POSLAN, DORADA, VERIFIKOVAN, ZAVRSEN, STORNIRAN
}
*/

enum IzvjestajStatus implements org.springframework.context.MessageSourceResolvable {
    KREIRAN, POSLAN, DORADA, VERIFIKOVAN, ZAVRSEN, STORNIRAN

    Object[] getArguments() { [] as Object[] }
    String[] getCodes() { ["${getClass().name}.${name()}"] as String[] }
    String getDefaultMessage() { "?-" + name() }
}