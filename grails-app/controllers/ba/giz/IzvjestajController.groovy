package ba.giz

import ba.giz.dto.IzvjestajExcelDTO
import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.CREATED
import static org.springframework.http.HttpStatus.NOT_FOUND
import static org.springframework.http.HttpStatus.NO_CONTENT
import static org.springframework.http.HttpStatus.OK

@Transactional(readOnly = true)
class IzvjestajController {

  static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

  def index(Integer max) {
    params.max = Math.min(max ?: 10, 100)
    respond Izvjestaj.list(params), model:[izvjestajCount: Izvjestaj.count()]
  }

  def show(Izvjestaj izvjestaj) {
    respond izvjestaj
  }

  def create() {
    Preduzece preduzece = Preduzece.findBySektor(Sektor.ELEKTRICNA_ENERGIJA)
    respond new Izvjestaj(params), model:[preduzece: preduzece]
  }

  def excelExport() {
    respond new IzvjestajExcelDTO()
  }

  @Transactional
  def save(Izvjestaj izvjestaj) {
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
        redirect izvjestaj
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
      '*'{ respond izvjestaj, [status: OK] }
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

  @Transactional
  def generateBasicExcel(IzvjestajExcelDTO izvjestajExcelDTO) {
    null
  }

  @Transactional
  def generateQuantitativeExcel(IzvjestajExcelDTO izvjestajExcelDTO) {
    null
  }
}
