package giz

import ba.giz.Izvjestaj
import ba.giz.IzvjestajStatus
import ba.giz.IzvjestajTip
import ba.giz.PodaciPodnosenjeIzvjestaja
import ba.giz.Preduzece

class BootStrap {

  def init = { servletContext ->
    createRegistryData()
    createIzvjestajData()
  }
  def destroy = {
  }

  private createRegistryData() {
    Preduzece preduzece = new Preduzece(naziv: "Preduzece", adresa: "Ulica veselih preduzeca 1a", maticniBrojJedinstvenogRegistra: "123456",
      jib: "12312", pib: "345345", telefon: "123/456-789", fax: "123/456-789", email: "preduzece@gmail.com", brojZaposlenih: 30, ukupanGodisnjiPromet: 356234).save(flush: true, failOnError: true)
  }

  private createIzvjestajData() {
    PodaciPodnosenjeIzvjestaja podaciPodnosenjeIzvjestaja = new PodaciPodnosenjeIzvjestaja(godina: 2017, prezime: "Bjelica", ime: "Milko", pozicija: "Direktor").save(flush: true, failOnError: true)
    Izvjestaj izvjestaj = new Izvjestaj(tip: IzvjestajTip.EE_DS, preduzece: Preduzece.findById(1), podaciPodnosenjeIzvjestaja: podaciPodnosenjeIzvjestaja,
      datumKreiranja: new Date().clearTime(), datumSlanja: new Date().clearTime(), status: IzvjestajStatus.KREIRAN).save(flush: true, failOnError: true)
  }
}
