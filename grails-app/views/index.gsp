<%@page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>${grailsApplication.config.grich.core.general.appHtmlTitle}</title>
</head>
<body>
<div class="body" style="margin: 10px">
    <h1>${grailsApplication.config.grich.core.general.appHtmlTitle}</h1>
    <sec:ifNotLoggedIn>
        <p><g:link controller="login" action="auth"><g:message code="app.view.login.label" default="Login"/></g:link></p>
    </sec:ifNotLoggedIn>
    <sec:ifLoggedIn>
        <p><g:link controller="app" action="app">${grailsApplication.config.grich.core.general.appHtmlTitle}</g:link></p>
    </sec:ifLoggedIn>
    <sec:ifAllGranted roles="ROLE_ADMIN">
        <p><g:link controller="admin" action="index"><g:message code="app.view.administration.label" default="Administration"/></g:link></p>
    </sec:ifAllGranted>
    <sec:ifLoggedIn>
        <p><g:link controller="logout"><g:message code="app.view.logout.label" default="Logout"/></g:link></p>
    </sec:ifLoggedIn>
</div>
</body>
</html>