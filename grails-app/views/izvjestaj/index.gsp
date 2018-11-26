<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'meni.izvjestaj.lista.title')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="list-izvjestaj" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <f:table collection="${izvjestajList}" />

            <g:if test="${izvjestajCount.toInteger() > params.max.toInteger()}">
                <div class="pagination">
                    <g:paginate total="${izvjestajCount.toInteger() ?: 0}"/>
                </div>
            </g:if>

        </div>
    </body>
</html>