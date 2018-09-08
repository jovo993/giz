package ba.giz

import ba.giz.login.User
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.authentication.encoding.BCryptPasswordEncoder
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.transaction.annotation.Transactional

@Transactional
class UserUtils {

  static def getCurrentUser() {
    User.findByUsername(SecurityContextHolder.context?.authentication?.principal?.username)
  }
}
