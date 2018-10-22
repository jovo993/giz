<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title><g:message code="godina.list.label"/></title>
    </head>
    <body>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="godina.create.label"/></g:link></li>
            </ul>
        </div>
        <div id="list-godina" class="content scaffold-list" role="main">
            <h1><g:message code="godina.list.label.bigger"/></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <f:table collection="${godinaList}" />

            <div class="pagination">
                <g:paginate total="${godinaCount ?: 0}" />
            </div>
        </div>
    </body>
</html>