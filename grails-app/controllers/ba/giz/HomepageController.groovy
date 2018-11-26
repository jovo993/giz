package ba.giz

import ba.giz.login.User
import grails.transaction.Transactional
import org.springframework.security.access.annotation.Secured
import org.springframework.security.core.context.SecurityContextHolder

import static org.springframework.http.HttpStatus.NOT_FOUND

@Transactional(readOnly = true)
@Secured('permitAll')
class HomepageController {

  static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

  def homepage(Integer max, Integer offset, String sort, String order) {
    params.max = (max ?: 10)
    params.offset = (offset ?: 0)
    params.sort = (sort ?: 'datumKreiranja')
    params.order = (order ?: 'desc')

    def response = prepareHomepageResponse(params.max, params.offset, params.sort, params.order)

    respond response.preduzece, model: [list: response.izvjestajList, properties: response.properties, izvjestajCount:  response.izvjestajCount]
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

  private def prepareHomepageResponse(Integer max, Integer offset, String sort, String order) {
    def izvjestajList = []
    def preduzece = new Preduzece()
    // def properties = [ "tip", "podaciPodnosenjeIzvjestaja.godina"]
    def properties = [ [fld:"tip", sort:true], [fld:"podaciPodnosenjeIzvjestaja.godina", sort:true] ]
    def ukupno = 0
    User currentUser = User.findByUsername(SecurityContextHolder.context?.authentication?.principal?.username)
    List currentUserAuthorities = currentUser?.getAuthorities()?.authority

    if (currentUserAuthorities.contains("ROLE_ADMIN")) {
      izvjestajList = Izvjestaj.findAll([max: max, offset: offset, sort: sort, order: order]) // , sort: sort, order: order
      // properties += ["preduzece.naziv"]
      properties += [ [fld:"preduzece.naziv", sort:true] ]
      ukupno = Izvjestaj.count()
    }

    if (currentUserAuthorities.contains("ROLE_EE_USER") || currentUserAuthorities.contains("ROLE_G_USER") || currentUserAuthorities.contains("ROLE_TE_USER")) {
      preduzece = Preduzece.findById(currentUser?.preduzece?.id)
      izvjestajList = Izvjestaj.findAllByPreduzece(preduzece,[max: max, offset: offset, sort: sort, order: order])
      ukupno = Izvjestaj.countByPreduzece(preduzece)
    }

    // properties += ["datumKreiranja", "datumSlanja", "podaciPodnosenjeIzvjestaja.prezimeImePozicija", "status"]
    properties += [ [fld:"datumKreiranja", sort:true], [fld:"datumSlanja", sort:true], [fld:"podaciPodnosenjeIzvjestaja.prezimeImePozicija", sort:true], [fld:"status", sort:true] ]

    [izvjestajList: izvjestajList, preduzece: preduzece, properties: properties, izvjestajCount: ukupno]
  }
}
