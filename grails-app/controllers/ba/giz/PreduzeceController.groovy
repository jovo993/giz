package ba.giz

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.util.Holders

@Transactional(readOnly = true)
class PreduzeceController {

  static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

  def index(Integer max, Integer offset) {
    if (!UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser)) {
	   redirect(controller: "homepage", action: "homepage")
	   return
	}

    params.max = (max ?: 10)
    params.offset = (offset ?: 0)

    respond Preduzece.list(params), model: [columns: ["naziv", "sektor", "uloga", "status"], preduzeceCount: Preduzece.count()]
  }

  def show(Preduzece preduzece) {
    if (!UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser)) {
	   redirect(controller: "homepage", action: "homepage")
	   return
	}

    respond preduzece
  }

  def create() {
    if (!UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser)) {
	   redirect(controller: "homepage", action: "homepage")
	   return
	}

    respond new Preduzece(params)
  }

  def edit(Preduzece preduzece) {
    preduzece.clearErrors()
    respond preduzece
  }

  def basicEdit(Preduzece preduzece) {
    if (!UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser) &&
	    preduzece.id != Holders.applicationContext.getBean("springSecurityService").currentUser?.preduzece?.id) {
	   redirect(controller: "homepage", action: "homepage")
	   return
	}

    respond preduzece
  }

  @Transactional
  def save(Preduzece preduzece) {
    if (preduzece == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    if (preduzece.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond preduzece.errors, view: 'create'
      return
    }

    preduzece.save flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.created.message', args: [message(code: 'preduzece.label', default: 'Preduzece'), preduzece.naziv])
        redirect preduzece
      }
      '*' { respond preduzece, [status: CREATED] }
    }
  }

  @Transactional
  def update(Preduzece preduzece) {
    if (preduzece == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    if (preduzece.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond preduzece.errors, view: 'edit'
      return
    }

    preduzece.save flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.updated.message', args: [message(code: 'preduzece.label', default: 'Preduzece'), preduzece.naziv])
        redirect preduzece
      }
      '*' { respond preduzece, [status: OK] }
    }
  }

  @Transactional
  def basicUpdate(Preduzece preduzece) {
    if (preduzece == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    if (preduzece.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond preduzece.errors, view: 'basicEdit'
      return
    }

    preduzece.save flush: true

    flash.message = message(code: 'default.updated.message', args: [message(code: 'preduzece.label', default: 'Preduzece'), preduzece.naziv])
    redirect action: "basicEdit", id: preduzece.id, status: OK
  }

  @Transactional
  def delete(Preduzece preduzece) {

    if (preduzece == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    preduzece.delete flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.deleted.message', args: [message(code: 'preduzece.label', default: 'Preduzece'), preduzece.naziv])
        redirect action: "index", method: "GET"
      }
      '*' { render status: NO_CONTENT }
    }
  }

  protected void notFound() {
    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'preduzece.label', default: 'Preduzece'), params.naziv])
        redirect action: "index", method: "GET"
      }
      '*' { render status: NOT_FOUND }
    }
  }
}
