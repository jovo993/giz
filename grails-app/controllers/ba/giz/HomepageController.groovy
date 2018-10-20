package ba.giz

import ba.giz.login.Role
import ba.giz.login.User
import grails.transaction.Transactional
import grails.util.Holders
import org.springframework.security.access.annotation.Secured
import org.springframework.security.core.context.SecurityContextHolder

import static org.springframework.http.HttpStatus.NOT_FOUND

@Transactional(readOnly = true)
@Secured('permitAll')
class HomepageController {

  static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

  def homepage() {
    def response = prepareHomepageResponse()

    respond response.preduzece, model: [list: response.izvjestajList, properties: response.properties]
  }

  protected void notFound() {
    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'meni.izvjestaj.title', default: 'Izvjestaj'), params.id])
        redirect action: "index", method: "GET"
      }
      '*' { render status: NOT_FOUND }
    }
  }

  private def prepareHomepageResponse() {
    def izvjestajList = []
    def preduzece = new Preduzece()
    def properties = ["tip", "podaciPodnosenjeIzvjestaja.godina"]
    List currentUserAuthorities = User.findByUsername(SecurityContextHolder.context?.authentication?.principal?.username)?.getAuthorities()?.authority
    if(currentUserAuthorities.contains("ROLE_ADMIN")){
      izvjestajList = Izvjestaj.findAllByStatusInList([IzvjestajStatus.POSLAN, IzvjestajStatus.VERIFIKOVAN, IzvjestajStatus.ZAVRSEN])
      properties += ["preduzece.naziv"]
    }

    if(currentUserAuthorities.contains("ROLE_EE_USER") || currentUserAuthorities.contains("ROLE_G_USER") || currentUserAuthorities.contains("ROLE_TE_USER")){
      preduzece = Preduzece.findById(Holders.applicationContext.getBean("springSecurityService").currentUser?.preduzece?.id)
      izvjestajList = Izvjestaj.findAllByPreduzeceAndStatusInList(preduzece, [IzvjestajStatus.KREIRAN, IzvjestajStatus.DORADA])
    }

    properties += ["datumKreiranja", "datumSlanja", "podaciPodnosenjeIzvjestaja.prezimeImePozicija", "status"]

    [izvjestajList: izvjestajList, preduzece: preduzece, properties: properties]
  }
}
