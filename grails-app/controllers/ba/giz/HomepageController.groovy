package ba.giz

import grails.transaction.Transactional
import grails.util.Holders
import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.NOT_FOUND

@Transactional(readOnly = true)
@Secured('permitAll')
class HomepageController {

  static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

  def homepage() {
    Preduzece preduzece = Preduzece.findById(Holders.applicationContext.getBean("springSecurityService").currentUser?.preduzece?.id)
    def izvjestajList = Izvjestaj.findByPreduzece(preduzece)
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
