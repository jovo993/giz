package giz

import ba.giz.*
import ba.giz.login.Role
import ba.giz.login.User
import ba.giz.login.UserRole

class BootStrap {

  def init = { servletContext ->
    createRegistryData()
    createUsersAndRoles()
    createIzvjestajData()
  }
  def destroy = {
  }

  private createRegistryData() {
    Uloga uloga = new Uloga()
    uloga.distributer = true

    PreduzeceStatus preduzeceStatus = new PreduzeceStatus()
    preduzeceStatus.aktivan = true

    Preduzece preduzeceEE = new Preduzece(naziv: "PreduzeceEE", sektor: Sektor.ELEKTRICNA_ENERGIJA, uloga: uloga, status: preduzeceStatus, adresa: "Ulica veselih preduzeca 1a", maticniBrojJedinstvenogRegistra: "123456",
      jib: "12312", pib: "345345", telefon: "123/456-789", fax: "123/456-789", email: "preduzece@gmail.com", brojZaposlenih: 30, ukupanGodisnjiPromet: 356234).save(flush: true, failOnError: true)

    Preduzece preduzeceG = new Preduzece(naziv: "PreduzeceG", sektor: Sektor.GAS, uloga: uloga, status: preduzeceStatus, adresa: "Ulica veselih preduzeca 1a", maticniBrojJedinstvenogRegistra: "123456",
      jib: "12312", pib: "345345", telefon: "123/456-789", fax: "123/456-789", email: "preduzece@gmail.com", brojZaposlenih: 30, ukupanGodisnjiPromet: 356234).save(flush: true, failOnError: true)

    Preduzece preduzeceTE = new Preduzece(naziv: "PreduzeceTE", sektor: Sektor.TOPLOTNA_ENERGIJA, uloga: uloga, status: preduzeceStatus, adresa: "Ulica veselih preduzeca 1a", maticniBrojJedinstvenogRegistra: "123456",
      jib: "12312", pib: "345345", telefon: "123/456-789", fax: "123/456-789", email: "preduzece@gmail.com", brojZaposlenih: 30, ukupanGodisnjiPromet: 356234).save(flush: true, failOnError: true)

  }

  private createIzvjestajData() {
    PodaciPodnosenjeIzvjestaja podaciPodnosenjeIzvjestaja = new PodaciPodnosenjeIzvjestaja(godina: 2017, telefon: 065065065, email: 'email@gmail.com', prezimeImePozicija: "Bjelica, Milko / Direktor").save(flush: true, failOnError: true)
    Izvjestaj izvjestajEE = new Izvjestaj(tip: IzvjestajTip.EE_DS, preduzece: Preduzece.findBySektor(Sektor.ELEKTRICNA_ENERGIJA), podaciPodnosenjeIzvjestaja: podaciPodnosenjeIzvjestaja,
      datumKreiranja: new Date().clearTime(), datumSlanja: new Date().clearTime(), prezimeImePozicija: '', status: IzvjestajStatus.KREIRAN).save(flush: true, failOnError: true)

    Izvjestaj izvjestajG = new Izvjestaj(tip: IzvjestajTip.G_DS, preduzece: Preduzece.findBySektor(Sektor.GAS), podaciPodnosenjeIzvjestaja: podaciPodnosenjeIzvjestaja,
      datumKreiranja: new Date().clearTime(), datumSlanja: new Date().clearTime(), prezimeImePozicija: '', status: IzvjestajStatus.KREIRAN).save(flush: true, failOnError: true)

    Izvjestaj izvjestajTE = new Izvjestaj(tip: IzvjestajTip.T_DS, preduzece: Preduzece.findBySektor(Sektor.TOPLOTNA_ENERGIJA), podaciPodnosenjeIzvjestaja: podaciPodnosenjeIzvjestaja,
      datumKreiranja: new Date().clearTime(), datumSlanja: new Date().clearTime(), prezimeImePozicija: '', status: IzvjestajStatus.KREIRAN).save(flush: true, failOnError: true)
  }


  private static createUsersAndRoles() {
    User.withTransaction { status ->

      User adminUser = User.findByUsername('admin')
      if (!adminUser) {
        adminUser = new User(username: 'admin', enabled: true, password: 'admin', preduzece: null, prezime: "AdminPrezime", ime: "AdminIme", pozicija: "Šegrt", telefon: "225 883", email: "admin@admin.com").save(flush: true, failOnError: true)
      }

      Role adminRole = Role.findByAuthority('ROLE_ADMIN')
      if (!adminRole) {
        adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
      }

      User eeUser = User.findByUsername('eeuser')
      if (!eeUser) {
        eeUser = new User(username: 'eeuser', enabled: true, password: 'eeuser', preduzece: Preduzece.findBySektor(Sektor.ELEKTRICNA_ENERGIJA), prezime: "KorisnikPrezime", ime: "KorisnikIme", pozicija: "Majstor", telefon: "226 883", email: "korisnik@korisnik.com").save(flush: true)
      }

      User gUser = User.findByUsername('guser')
      if (!gUser) {
        gUser = new User(username: 'guser', enabled: true, password: 'guser', preduzece: Preduzece.findBySektor(Sektor.GAS), prezime: "KorisnikPrezime", ime: "KorisnikIme", pozicija: "Majstor", telefon: "226 883", email: "korisnik@korisnik.com").save(flush: true)
      }

      User teUser = User.findByUsername('teuser')
      if (!teUser) {
        teUser = new User(username: 'teuser', enabled: true, password: 'teuser', preduzece: Preduzece.findBySektor(Sektor.TOPLOTNA_ENERGIJA), prezime: "KorisnikPrezime", ime: "KorisnikIme", pozicija: "Majstor", telefon: "226 883", email: "korisnik@korisnik.com").save(flush: true)
      }

      Role eeUserRole = Role.findByAuthority('ROLE_EE_USER')
      if (!eeUserRole) {
        eeUserRole = new Role(authority: 'ROLE_EE_USER').save(flush: true)
      }

      Role gUserRole = Role.findByAuthority('ROLE_G_USER')
      if (!gUserRole) {
        gUserRole = new Role(authority: 'ROLE_G_USER').save(flush: true)
      }

      Role teUserRole = Role.findByAuthority('ROLE_TE_USER')
      if (!teUserRole) {
        teUserRole = new Role(authority: 'ROLE_TE_USER').save(flush: true)
      }

      if (!UserRole.get(adminUser.id, adminRole.id)) {
        UserRole.create(adminUser, adminRole, true)
      }

      if (!UserRole.get(eeUser.id, eeUserRole.id)) {
        UserRole.create(eeUser, eeUserRole, true)
      }

      if (!UserRole.get(gUser.id, gUserRole.id)) {
        UserRole.create(gUser, gUserRole, true)
      }

      if (!UserRole.get(teUser.id, teUserRole.id)) {
        UserRole.create(teUser, teUserRole, true)
      }

    }
  }
}
