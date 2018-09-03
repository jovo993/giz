<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'clanak.label', default: 'Preduzece')}"/>
    <title><g:message code="clanak.edit.label" args="[entityName]"/></title>
</head>

<body>
<a href="#edit-clanak" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                             default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><g:link class="list" action="index"><g:message code="clanak.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class="create" action="create"><g:message code="clanak.create.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="edit-clanak" class="content scaffold-edit" role="main">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.clanak}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.clanak}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form resource="${this.clanak}" action="update">
        <g:hiddenField name="version" value="${this.clanak?.version}"/>
        <fieldset class="fieldset">
            <legend style="width: 15.5%"><g:message code="clanak.edit.label"/></legend>

            <label for="naslov" style="width: 5%">
                <g:message code="clanak.naslov.title"/>
            </label>
            <g:textField name="naslov" value="${clanak?.naslov}" style="width: 94%"/><br/><br/>

            <label for="sadrzaj" style="width: 5.3%">
                <g:message code="clanak.sadrzaj.title"/>
            </label>
            <g:textArea name="sadrzaj" value="${clanak?.sadrzaj}" style="width: 100%; height: 500px"/><br/>
        </fieldset>
        <fieldset class="buttons">
            <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" style="width: 10%"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
