<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title><g:message code="godina.list.label"/></title>
    </head>
    <body>
        <div class="nav" role="navigation">
            <ul>
                <li><g:link class="create" action="create"><g:message code="godina.create.label"/></g:link></li>
            </ul>
        </div>
        <div id="list-godina" class="content scaffold-list" role="main">
            <h1><g:message code="godina.list.label.bigger"/></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <f:table collection="${godinaList}" />

            <g:if test="${godinaCount.toInteger() > params.max.toInteger()}">
                <div class="pagination">
                    <g:paginate total="${godinaCount.toInteger() ?: 0}" />
                </div>
            </g:if>
        </div>
    </body>
</html>