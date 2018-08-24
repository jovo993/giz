package ba.giz

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PreduzeceController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Preduzece.list(params), model: [columns: ["naziv", "sektor", "uloga", "status"], propertiespreduzeceCount: Preduzece.count()]
    }

    def show(Preduzece preduzece) {
        respond preduzece
    }

    def create() {
        respond new Preduzece(params)
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
            respond preduzece.errors, view:'create'
            return
        }

        preduzece.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'preduzece.label', default: 'Preduzece'), preduzece.naziv])
                redirect preduzece
            }
            '*' { respond preduzece, [status: CREATED] }
        }
    }

    def edit(Preduzece preduzece) {
        respond preduzece
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
            respond preduzece.errors, view:'edit'
            return
        }

        preduzece.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'preduzece.label', default: 'Preduzece'), preduzece.naziv])
                redirect preduzece
            }
            '*'{ respond preduzece, [status: OK] }
        }
    }

    @Transactional
    def delete(Preduzece preduzece) {

        if (preduzece == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        preduzece.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'preduzece.label', default: 'Preduzece'), preduzece.naziv])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'preduzece.label', default: 'Preduzece'), params.naziv])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
