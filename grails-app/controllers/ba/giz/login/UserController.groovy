package ba.giz.login

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class UserController {

  static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

  def index(Integer max) {
    params.max = Math.min(max ?: 20, 100)
    respond User.list(params), model: [columns: ["prezimeIme", "preduzece.naziv", "username", "email", "rola", "enabled"], userCount: User.count()]
  }

  def show(User user) {
    respond user
  }

  def create() {
    respond new User(params)
  }

  def edit(User user) {
    respond user
  }

  @Transactional
  def save(User user) {
    if (user == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    if (user.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond user.errors, view: 'create'
      return
    }

    user.save flush: true

    user.roles.each { role ->
      UserRole.create(user, role, true)
    }

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.username])
        redirect user
      }
      '*' { respond user, [status: CREATED] }
    }
  }

  @Transactional
  def update(User user) {
    if (user == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    if (user.hasErrors()) {
      transactionStatus.setRollbackOnly()
      respond user.errors, view: 'edit'
      return
    }

    UserRole.findAllByUser(user).each {
      if (!user.roles?.contains(it.role)) {
        it.delete flush: true
      } else {
        user.roles?.remove(it.role)
      }
    }

    user.roles.each { role ->
      UserRole.create(user, role, true)
    }

    user.save flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), user.username])
        redirect user
      }
      '*' { respond user, [status: OK] }
    }
  }

  @Transactional
  def delete(User user) {

    if (user == null) {
      transactionStatus.setRollbackOnly()
      notFound()
      return
    }

    user.delete flush: true

    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), user.username])
        redirect action: "index", method: "GET"
      }
      '*' { render status: NO_CONTENT }
    }
  }

  protected void notFound() {
    request.withFormat {
      form multipartForm {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.username])
        redirect action: "index", method: "GET"
      }
      '*' { render status: NOT_FOUND }
    }
  }
}
