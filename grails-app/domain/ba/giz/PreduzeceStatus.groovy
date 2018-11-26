package ba.giz

class PreduzeceStatus {

  Boolean aktivan = true

  String toString() {
    if (aktivan) {
      // "aktivan"
      UserUtils.msg("ba.giz.User.AKTIVAN")
    } else {
      // "neaktivan"
      UserUtils.msg("ba.giz.User.NEAKTIVAN")
    }
  }
}
