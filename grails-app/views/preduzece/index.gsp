<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'preduzece.label.lower', default: 'Preduzece')}" />
        <title><g:message code="preduzece.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-preduzece" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-preduzece" class="content scaffold-list" role="main">
            <h1><g:message code="preduzece.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <f:table collection="${preduzeceList}" />

            <g:if test="${preduzeceCount.toInteger() > params.max.toInteger()}">
                <div class="pagination">
                    <g:paginate total="${preduzeceCount ?: 0}" />
                </div>
            </g:if>
        </div>
    </body>
</html>