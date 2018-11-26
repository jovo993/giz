package ba.giz

import ba.giz.login.Role
import ba.giz.login.User
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.transaction.annotation.Transactional

import grails.util.Holders
import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder as LCU

@Transactional
class UserUtils {

  static def getCurrentUser() {
    User.findByUsername(SecurityContextHolder.context?.authentication?.principal?.username)
  }

  static isUserAdmin(User user) {
    return user.authorities.contains(Role.findByAuthority('ROLE_ADMIN'))
  }

  static msg(String labela) {
    MessageSource messageSource = Holders.applicationContext.getBean("messageSource")
    def msg = messageSource.getMessage(labela, null, LCU.getLocale())
    return msg
  }

}