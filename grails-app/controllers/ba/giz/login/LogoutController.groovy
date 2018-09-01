package ba.giz.login

import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.security.access.annotation.Secured
import org.springframework.security.web.RedirectStrategy

import javax.servlet.http.HttpServletResponse

@Secured('permitAll')
class LogoutController {

  /** Dependency injection for RedirectStrategy. */
  RedirectStrategy redirectStrategy

  /**
   * Index action. Redirects to the Spring security logout uri.
   */
  def index() {

    if (!request.post && SpringSecurityUtils.getSecurityConfig().logout.postOnly) {
      response.sendError HttpServletResponse.SC_METHOD_NOT_ALLOWED // 405
      return
    }

    redirectStrategy.sendRedirect request, response, SpringSecurityUtils.securityConfig.logout.filterProcessesUrl // '/logoff'
    response.flushBuffer()
  }
}