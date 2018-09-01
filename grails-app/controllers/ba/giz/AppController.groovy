package ba.giz

import grails.core.GrailsApplication
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.SpringSecurityUtils

class AppController {

  SpringSecurityService springSecurityService
  GrailsApplication grailsApplication

  def index() {
    if (SpringSecurityUtils.ifAllGranted("ROLE_ADMIN")) {
      //redirect controller: "admin"
      redirect action: "app"
    } else {
      redirect action: "app"
    }
  }

  def rootHomePage() {
    render(view: "/login/auth")
  }

  def app() {
    // Prevent any caching for this action's output
    if(springSecurityService.currentUser) {
      if(!springSecurityService.currentUser.changedPassword) {
        render view: "/login/changePassword"
      }
    }

    response.setHeader "Cache-Control", "no-store, no-cache, must-revalidate"
  }

  def changePassword() {
    redirect view: "changePassword.gsp"
  }
}
