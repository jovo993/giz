package spring

import ba.giz.CustomAuditLogListener
import org.springframework.web.servlet.i18n.SessionLocaleResolver

// Place your Spring DSL code here
beans = {
  localeResolver(SessionLocaleResolver) {
    // defaultLocale= new Locale('bs')
    defaultLocale= new Locale('cy')
  }

  customAuditLogListener(CustomAuditLogListener)
}
