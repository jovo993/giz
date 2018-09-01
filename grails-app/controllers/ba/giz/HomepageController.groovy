package ba.giz

import grails.transaction.Transactional
import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.NOT_FOUND

@Transactional(readOnly = true)
@Secured('permitAll')
class HomepageController {

  static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

  def homepage() {
    // TODO: Find preduzece by current user
    // TODO: Find Izvjestaj list by current user preduzece
    //Mocked for now
    def preduzece = Preduzece.last() ? Preduzece.last() : new Preduzece()
    def izvjestajList = Izvjestaj.findAll()
    respond preduzece, model: [list: izvjestajList, properties: ["tip", "podaciPodnosenjeIzvjestaja.godina", "datumKreiranja",
                                                                 "datumSlanja", "podaciPodnosenjeIzvjestaja.displayName", "status"]]
  }

  protected void notFound() {
    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'izvjestaj.label', default: 'Book'), params.id])
        redirect action: "index", method: "GET"
      }
      '*' { render status: NOT_FOUND }
    }
  }
}
