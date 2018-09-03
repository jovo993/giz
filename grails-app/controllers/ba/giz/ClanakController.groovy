package ba.giz

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class ClanakController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 20, 100)
        respond Clanak.list(params), model: [columns: ["naslov", "datumObjave", "autor"], clanakCount: Clanak.count()]
    }

    def show(Clanak clanak) {
        respond clanak
    }

    def create() {
        respond new Clanak(params)
    }

    def edit(Clanak clanak) {
        respond clanak
    }
    
    @Transactional
    def save(Clanak clanak) {
        if (clanak == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (clanak.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond clanak.errors, view: 'create'
            return
        }

        clanak.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'clanak.label', default: 'Clanak'), clanak.naslov])
                redirect clanak
            }
            '*' { respond clanak, [status: CREATED] }
        }
    }

    @Transactional
    def update(Clanak clanak) {
        if (clanak == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (clanak.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond clanak.errors, view: 'edit'
            return
        }

        clanak.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'clanak.label', default: 'Clanak'), clanak.naslov])
                redirect clanak
            }
            '*'{ respond clanak, [status: OK] }
        }
    }

    @Transactional
    def delete(Clanak clanak) {

        if (clanak == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        clanak.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'clanak.label', default: 'Clanak'), clanak.naslov])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'clanak.label', default: 'Clanak'), params.naslov])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
