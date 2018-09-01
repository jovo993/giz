package ba.giz

import grails.transaction.Transactional
import org.springframework.boot.autoconfigure.security.SecurityProperties

import static org.springframework.http.HttpStatus.CREATED
import static org.springframework.http.HttpStatus.NOT_FOUND
import static org.springframework.http.HttpStatus.NO_CONTENT
import static org.springframework.http.HttpStatus.OK

@Transactional(readOnly = true)
class IzvjestajController {

  def index(Integer max) {
    params.max = Math.min(max ?: 10, 100)
    respond Izvjestaj.list(params), model: [columns: ["tip", "status", "datumKreiranja"], izvjestajCount: Izvjestaj.count()]
  }

  def show(Izvjestaj izvjestaj) {
    respond izvjestaj
  }

  def create() {
    Preduzece preduzece = Preduzece.findBySektor(Sektor.GAS)
    if(preduzece.sektor.equals(Sektor.ELEKTRICNA_ENERGIJA)) {
      redirect action: createEE(preduzece)
    }
    else if(preduzece.sektor.equals(Sektor.GAS)) {
      redirect action: createG(preduzece)
    }
    else if(preduzece.sektor.equals(Sektor.TOPLOTNA_ENERGIJA)) {
      redirect action: createTE(preduzece)
    }
  }

  def createEE(Preduzece preduzece) {
    Izvjestaj izvjestaj = new Izvjestaj(params)
    izvjestaj.preduzece = preduzece

    respond izvjestaj, model:[preduzece: preduzece]
  }

  def createG(Preduzece preduzece) {
    Izvjestaj izvjestaj = new Izvjestaj(params)
    izvjestaj.preduzece = preduzece

    respond izvjestaj, model:[preduzece: preduzece]
  }

  def createTE(Preduzece preduzece) {
    Izvjestaj izvjestaj = new Izvjestaj(params)
    izvjestaj.preduzece = preduzece

    respond izvjestaj, model:[preduzece: preduzece]
  }


  @Transactional
  def save(Izvjestaj izvjestaj) {

    izvjestaj.preduzece = Preduzece.findBySektor(Sektor.ELEKTRICNA_ENERGIJA)

    if (izvjestaj == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    if (izvjestaj.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond izvjestaj.errors, view:'create'
      return
    }

    izvjestaj.save flush:true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.created.message', args: [message(code: 'izvjestaj.create.title', default: 'Izvjestaj'), izvjestaj.id])
        redirect action : 'index'
      }
      '*' { respond izvjestaj, [status: CREATED] }
    }
  }

  @Transactional
  def update(Izvjestaj izvjestaj) {
    if (izvjestaj == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    if (izvjestaj.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond izvjestaj.errors, view:'edit'
      return
    }

    izvjestaj.save flush:true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.updated.message', args: [message(code: 'izvjestaj.create.title', default: 'Izvjestaj'), izvjestaj.id])
        redirect izvjestaj
      }
      redirect action: 'home'
    }
  }

  @Transactional
  def delete(Izvjestaj izvjestaj) {

    if (izvjestaj == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    izvjestaj.delete flush:true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.deleted.message', args: [message(code: 'izvjestaj.create.title', default: 'Izvjestaj'), izvjestaj.id])
        redirect action:"index", method:"GET"
      }
      '*'{ render status: NO_CONTENT }
    }
  }

  protected void notFound() {
    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'izvjestaj.create.title', default: 'Izvjestaj'), params.id])
        redirect action: "index", method: "GET"
      }
      '*'{ render status: NOT_FOUND }
    }
  }
}
