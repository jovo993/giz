package ba.giz.login

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString
import grails.compiler.GrailsCompileStatic

@GrailsCompileStatic
@EqualsAndHashCode(includes='authority')
@ToString(includes='authority', includeNames=true, includePackage=false)
class Role implements Serializable {

	private static final long serialVersionUID = 1

	String authority

	static constraints = {
		authority blank: false, unique: true
	}

	static mapping = {
		cache true
	}

	String toString() {
		if (authority == "ROLE_ADMIN") {
			return "admin"
		}
		if (authority == "ROLE_EE_USER") {
			return "korisnik (e)"
		}
		if (authority == "ROLE_G_USER") {
			return "korisnik (g)"
		}
		if (authority == "ROLE_T_USER") {
			return "korisnik (t)"
		}

		authority
	}
}
