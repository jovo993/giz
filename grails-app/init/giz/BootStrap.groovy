package giz

import ba.giz.Izvjestaj
import ba.giz.IzvjestajStatus
import ba.giz.IzvjestajTip
import ba.giz.PodaciPodnosenjeIzvjestaja
import ba.giz.Preduzece
import ba.giz.PreduzeceStatus
import ba.giz.Sektor
import ba.giz.Uloga
import ba.giz.login.Role
import ba.giz.login.User
import ba.giz.login.UserRole

class BootStrap {

  def init = { servletContext ->
    createUsersAndRoles()
    createRegistryData()
    createIzvjestajData()
  }
  def destroy = {
  }

  private createRegistryData() {
    Uloga uloga = new Uloga()
    uloga.distributer = true

    PreduzeceStatus preduzeceStatus = new PreduzeceStatus()
    preduzeceStatus.aktivan = true

    Preduzece preduzece = new Preduzece(naziv: "Preduzece", sektor: Sektor.ELEKTRICNA_ENERGIJA, uloga: uloga, status: preduzeceStatus, adresa: "Ulica veselih preduzeca 1a", maticniBrojJedinstvenogRegistra: "123456",
      jib: "12312", pib: "345345", telefon: "123/456-789", fax: "123/456-789", email: "preduzece@gmail.com", brojZaposlenih: 30, ukupanGodisnjiPromet: 356234).save(flush: true, failOnError: true)
  }

  private createIzvjestajData() {
    PodaciPodnosenjeIzvjestaja podaciPodnosenjeIzvjestaja = new PodaciPodnosenjeIzvjestaja(godina: 2017, prezime: "Bjelica", ime: "Milko", pozicija: "Direktor").save(flush: true, failOnError: true)
    Izvjestaj izvjestaj = new Izvjestaj(tip: IzvjestajTip.EE_DS, preduzece: Preduzece.last(), podaciPodnosenjeIzvjestaja: podaciPodnosenjeIzvjestaja,
      datumKreiranja: new Date().clearTime(), datumSlanja: new Date().clearTime(), status: IzvjestajStatus.KREIRAN).save(flush: true, failOnError: true)
  }

  private static createUsersAndRoles() {
    User.withTransaction { status ->

      User adminUser = User.findByUsername('admin')
      if (!adminUser) {
        adminUser = new User(username: 'admin', firstName: 'AdminIme', lastName: 'AdminPrezime', enabled: true, password: 'admin').save(flush: true, failOnError: true)
      }

      Role adminRole = Role.findByAuthority('ROLE_ADMIN')
      if (!adminRole) {
        adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
      }

      User eeUser = User.findByUsername('eeuser')
      if (!eeUser) {
        eeUser = new User(username: 'eeuser', firstName: 'UserIme', lastName: 'UserPrezime', enabled: true, password: 'eeuser').save(flush: true)
      }

      Role eeUserRole = Role.findByAuthority('ROLE_EE_USER')
      if (!eeUserRole) {
        eeUserRole = new Role(authority: 'ROLE_EE_USER').save(flush: true)
      }

      if (!UserRole.get(adminUser.id, adminRole.id)) {
        UserRole.create(adminUser, adminRole, true)
      }

      if (!UserRole.get(eeUser.id, eeUserRole.id)) {
        UserRole.create(eeUser, eeUserRole, true)
      }
    }

    User.withTransaction { status ->
      assert User.count() == 2
      assert Role.count() == 2
      assert UserRole.count() == 2
    }
  }
}
