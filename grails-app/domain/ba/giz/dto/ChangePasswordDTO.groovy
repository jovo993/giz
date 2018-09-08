package ba.giz.dto

import ba.giz.UserUtils
import ba.giz.login.User
import grails.plugin.springsecurity.authentication.encoding.BCryptPasswordEncoder

class ChangePasswordDTO {

  String password
  String newPassword
  String confirmNewPassword

  @SuppressWarnings("GroovyAssignabilityCheck")
  static constraints = {
    password nullable: false, blank: false, validator: { password, obj ->
      User currentUser = UserUtils.getCurrentUser()
      BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder(12)
      if(!passwordEncoder.isPasswordValid(currentUser.password, password, null)) { return ['oldPasswordMatching'] }
    }
    newPassword nullable: false, blank: false, validator: { password, commandInstance, errors ->
      if(password != commandInstance.confirmNewPassword) { return ['newPasswordMatching'] }
    }

    confirmNewPassword nullable: false, blank: false
  }
}