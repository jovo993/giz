<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'Korisnik')}" />
        <title><g:message code="user.show.label"/></title>
    </head>
    <body>
        <a href="#show-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><g:link class="list" action="index"><g:message code="user.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="user.create.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-user" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:form resource="${this.user}" method="DELETE">
                <fieldset class="fieldset">
                    <legend style="width: 17%"><g:message code="user.show.label"/></legend>
                    <label for="prezime">
                        <g:message code="user.prezime.title"/>
                    </label>
                    <g:textField name="prezime" required="false" value="${this.user?.prezime}" readonly="readonly" style="width: 50%"/><br/>

                    <label for="ime">
                        <g:message code="user.ime.title"/>
                    </label>
                    <g:textField name="ime" required="false" value="${this.user?.ime}" readonly="readonly" style="width: 50%"/><br/>

                    <label for="username">
                        <g:message code="user.username.title"/>
                    </label>
                    <g:textField name="username" required="false" value="${this.user?.username}" readonly="readonly" style="width: 50%"/><br/>

                    <label for="preduzece.naziv">
                        <g:message code="user.preduzece.naziv.title"/>
                    </label>
                    <g:textField name="preduzece.naziv" required="false" value="${this.user?.preduzece?.naziv}" readonly="readonly" style="width: 50%"/><br/>

                    <label for="email">
                        <g:message code="user.email.title"/>
                    </label>
                    <g:textField name="email" required="false" value="${this.user?.email}" readonly="readonly" style="width: 50%"/><br/>

                    <label for="rola">
                        <g:message code="user.rola.title"/>
                    </label>
                    <g:textField name="rola" required="false" value="${this.user?.rola}" readonly="readonly" style="width: 50%"/><br/>

                    <label for="enabled">
                        <g:message code="user.enabled.title"/>
                    </label>
                    <g:textField name="enabled" required="false" value="${this.user?.enabled}" readonly="readonly" style="width: 50%"/><br/>
                </fieldset>
                <fieldset class="buttons">
                    <g:actionSubmit class="edit" action="edit" resource="${this.user}" value="${message(code: 'default.button.edit.label', default: 'Edit')}" style="width: 10%"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
