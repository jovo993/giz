grails {
    plugin {
      auditLog {
        auditDomainClassName = 'ba.giz.AuditLog'
        stampEnabled = true
        logIds = true
      }
    }
  }


// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'ba.giz.login.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'ba.giz.login.UserRole'
grails.plugin.springsecurity.authority.className = 'ba.giz.login.Role'
grails.plugin.springsecurity.successHandler.defaultTargetUrl = "/homepage/homepage"
grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	// TODO: change this line. For now, allowed all urls, to everyone.
	[pattern: '/**',             access: ['permitAll']],

	[pattern: '/error',          access: ['permitAll']],
	[pattern: '/index',          access: ['permitAll']],
	[pattern: '/index.gsp',      access: ['permitAll']],
	[pattern: '/shutdown',       access: ['permitAll']],
	[pattern: '/assets/**',      access: ['permitAll']],
	[pattern: '/**/js/**',       access: ['permitAll']],
	[pattern: '/**/css/**',      access: ['permitAll']],
	[pattern: '/**/images/**',   access: ['permitAll']],
	[pattern: '/**/favicon.ico', access: ['permitAll']]
]

grails.plugin.springsecurity.filterChain.chainMap = [
	[pattern: '/assets/**',      filters: 'none'],
	[pattern: '/**/js/**',       filters: 'none'],
	[pattern: '/**/css/**',      filters: 'none'],
	[pattern: '/**/images/**',   filters: 'none'],
	[pattern: '/**/favicon.ico', filters: 'none'],
	[pattern: '/**',             filters: 'JOINED_FILTERS']
]

