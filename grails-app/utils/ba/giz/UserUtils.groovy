package ba.giz

import ba.giz.login.Role
import ba.giz.login.User
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.transaction.annotation.Transactional

@Transactional
class UserUtils {

  static def getCurrentUser() {
    User.findByUsername(SecurityContextHolder.context?.authentication?.principal?.username)
  }

  static isUserAdmin(User user) {
    return user.authorities.contains(Role.findByAuthority('ROLE_ADMIN'))
  }
}
