<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'clanak.label.lower', default: 'Clanak')}" />
        <title><g:message code="clanak.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-clanak" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-clanak" class="content scaffold-list" role="main">
            <h1><g:message code="clanak.list.label.bigger" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <f:table collection="${clanakList}" />

            <div class="pagination">
                <g:paginate total="${clanakCount ?: 0}" />
            </div>
        </div>
    </body>
</html>