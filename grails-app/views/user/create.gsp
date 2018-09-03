<%@ page import="ba.giz.Preduzece; ba.giz.login.Role" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'Korisnik')}"/>
    <title><g:message code="user.create.label" args="[entityName]"/></title>
</head>

<body>
<a href="#create-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><g:link class="list" action="index"><g:message code="user.list.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="create-user" class="content scaffold-create" role="main">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.user}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.user}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form action="save">
        <fieldset class="fieldset">
            <legend style="width: 14%"><g:message code="user.create.label"/></legend>

            <label for="prezime">
                <g:message code="user.prezime.title"/>
            </label>
            <g:textField name="prezime" value="${user?.prezime}" style="width: 40%"/><br/>

            <label for="ime">
                <g:message code="user.ime.title"/>
            </label>
            <g:textField name="ime" value="${user?.ime}" style="width: 40%"/><br/>

            <label for="username">
                <g:message code="user.username.title"/>
            </label>
            <g:textField name="username" value="${user?.username}" style="width: 40%"/><br/>

            <label for="password">
                <g:message code="user.password.title"/>
            </label>
            <g:passwordField name="password" value="${user?.password}" style="width: 40%"/><br/>

            <label for="roles">
                <g:message code="user.rola.title"/>
            </label>
            <g:select multiple="true" name="roles" from="${Role.list()}" value="${user?.roles*.id}" optionKey="id" style="width: 30%"/>

            <label for="enabled" style="vertical-align: middle">
                <g:message code="user.aktivan.title"/>
            </label>
            <g:checkBox name="enabled" value="${user?.enabled}" checked="${true}" style="width: 2%; vertical-align: middle;"/><br/>

            <label for="preduzece.id">
                <g:message code="user.preduzece.naziv.title"/>
            </label>
            <g:select name="preduzece.id" from="${Preduzece.list()}" value="${user?.preduzece?.id}" optionKey="id" noSelection="${['': 'Odaberite jednoga...']}" style="width: 40%"/><br/>

            <label for="pozicija">
                <g:message code="user.pozicija.title"/>
            </label>
            <g:textField name="pozicija" value="${user?.pozicija}" style="width: 40%"/><br/>

            <label for="email">
                <g:message code="user.email.title"/>
            </label>
            <g:textField name="email" value="${user?.email}" style="width: 40%"/><br/>

            <label for="telefon">
                <g:message code="user.telefon.title"/>
            </label>
            <g:textField name="telefon" value="${user?.telefon}" style="width: 40%"/><br/>
        </fieldset>
        <fieldset class="buttons">
            <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" style="width: 10%"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
