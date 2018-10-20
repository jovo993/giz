package ba.giz

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

class GodinaController {

  static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

  def index(Integer max) {
    params.max = Math.min(max ?: 20, 100)
    respond Godina.list(params), model: [columns: ["godina"], godinaCount: Godina.count()]
  }

  def show(Godina godina) {
    respond godina
  }

  def create() {
    respond new Godina(params)
  }

  def edit(Godina godina) {
    respond godina
  }

  @Transactional
  def save(Godina godina) {
    if (godina == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    if (godina.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond godina.errors, view: 'create'
      return
    }

    godina.save flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.created.message', args: [message(code: 'godina.label', default: 'Godina'), godina.godina])
        redirect godina
      }
      '*' { respond godina, [status: CREATED] }
    }
  }

  @Transactional
  def update(Godina godina) {
    if (godina == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    if (godina.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond godina.errors, view: 'edit'
      return
    }

    godina.save flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.updated.message', args: [message(code: 'godina.label', default: 'Godina'), godina.godina])
        redirect godina
      }
      '*' { respond godina, [status: OK] }
    }
  }

  @Transactional
  def delete(Godina godina) {

    if (godina == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    godina.delete flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.deleted.message', args: [message(code: 'godina.label', default: 'Godina'), godina.godina])
        redirect action: "index", method: "GET"
      }
      '*' { render status: NO_CONTENT }
    }
  }

  protected void notFound() {
    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'godina.label', default: 'Godina'), params.godina])
        redirect action: "index", method: "GET"
      }
      '*' { render status: NOT_FOUND }
    }
  }
}
