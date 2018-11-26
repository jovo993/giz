<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title><g:message code="godina.create.label" /></title>
    </head>
    <body>
        <div class="nav" role="navigation">
            <ul>
                <li><g:link class="list" action="index"><g:message code="godina.list.label"/></g:link></li>
            </ul>
        </div>
        <div id="create-godina" class="content scaffold-create" role="main">
            <h1><g:message code="godina.create.label"/></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.godina}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.godina}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form action="save">
                <fieldset class="form">
                    <f:all bean="godina"/>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" style="width: 160px"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
