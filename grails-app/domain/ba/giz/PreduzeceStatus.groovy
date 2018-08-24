package ba.giz

class PreduzeceStatus {

  Boolean aktivan = true

  String toString() {
    if (aktivan) {
      "aktivan"
    } else {
      "neaktivan"
    }
  }
}
