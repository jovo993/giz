package ba.giz

import ba.giz.login.User
import grails.util.Holders

class Clanak {

  String naslov
  Date datumObjave = new Date()
  User autor = Holders.applicationContext.getBean("springSecurityService").currentUser
  String sadrzaj

  static auditable = true

  static constraints = {
    naslov nullable: false, blank: false
    sadrzaj nullable: false, blank: false
  }

  String toString() {
    return naslov
  }
}
