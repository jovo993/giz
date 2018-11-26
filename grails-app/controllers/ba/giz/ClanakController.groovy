package ba.giz

import grails.transaction.Transactional
import grails.util.Holders

import static org.springframework.http.HttpStatus.*
import java.text.SimpleDateFormat

@Transactional(readOnly = true)
class ClanakController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max, Integer offset) {
        if (!UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser)) {
	       redirect(controller: "homepage", action: "homepage")
	       return
	    }

        params.max = (max ?: 10)
        params.offset = (offset ?: 0)

        respond Clanak.list(params), model: [columns: ["naslov", "datumObjave", "autor"], clanakCount: Clanak.count()]
    }

    def show(Clanak clanak) {
        if (!UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser)) {
	       redirect(controller: "homepage", action: "homepage")
	       return
	    }

        respond clanak
    }

    def create() {
        if (!UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser)) {
	       redirect(controller: "homepage", action: "homepage")
	       return
	    }

        respond new Clanak(params)
    }

    def edit(Clanak clanak) {
        if (!UserUtils.isUserAdmin(Holders.applicationContext.getBean("springSecurityService").currentUser)) {
	       redirect(controller: "homepage", action: "homepage")
	       return
	    }

        respond clanak
    }
    
    @Transactional
    def save(Clanak clanak) {

        if (clanak == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        // HTML input tag sa type="date" zahtijeva konverziju "yyyy-MM-dd" jer je i za value vrijednost obavezno koristenje format("yyyy-MM-dd")
        clanak.datumObjave = new SimpleDateFormat("yyyy-MM-dd").parse params.datumObjave
        // g:textField zahtijeva konverziju params.datumObjave u datum
        // clanak.datumObjave = new SimpleDateFormat("dd.MM.yyyy").parse params.datumObjave
        // g:datePicker ne treba nikakav dodatni kod
        clanak.clearErrors()
        // bez .clearErrors() se javlja greska u konverziji datuma !!! zasto ???

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

        // HTML input tag sa type="date" zahtijeva konverziju "yyyy-MM-dd" jer je i za value vrijednost obavezno koristenje format("yyyy-MM-dd")
        clanak.datumObjave = new SimpleDateFormat("yyyy-MM-dd").parse params.datumObjave
        // g:textField zahtijeva konverziju params.datumObjave u datum
        // clanak.datumObjave = new SimpleDateFormat("dd.MM.yyyy").parse params.datumObjave
        // g:datePicker ne treba nikakav dodatni kod
        clanak.clearErrors()
        // bez .clearErrors() se javlja greska u konverziji datuma !!! zasto ???

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
