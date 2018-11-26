<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title><g:message code="godina.show.label" /></title>
    </head>
    <body>
        <div class="nav" role="navigation">
            <ul>
                <li><g:link class="list" action="index"><g:message code="godina.list.label" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="godina.create.label" /></g:link></li>
            </ul>
        </div>
        <div id="show-godina" class="content scaffold-show" role="main">
            <h1><g:message code="godina.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <f:display bean="godina" />
            <g:form resource="${this.godina}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.godina}" style="width: 160px"><g:message code="godina.edit.label" /></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" style="width: 110px" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
