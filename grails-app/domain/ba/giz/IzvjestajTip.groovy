package ba.giz

/*
enum IzvjestajTip {
  EE_DS, G_DS, T_DS
}
*/

enum IzvjestajTip implements org.springframework.context.MessageSourceResolvable {
    EE_DS, G_DS, T_DS

    Object[] getArguments() { [] as Object[] }
    String[] getCodes() { ["${getClass().name}.${name()}"] as String[] }
    String getDefaultMessage() { name() }
}