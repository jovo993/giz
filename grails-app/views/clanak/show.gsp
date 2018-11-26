<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'clanak.label', default: 'Preduzece')}" />
        <title><g:message code="clanak.show.label"/></title>
    </head>
    <body>
        <a href="#show-clanak" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><g:link class="list" action="index"><g:message code="clanak.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="clanak.create.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-clanak" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:form resource="${this.clanak}">
                <fieldset class="fieldset">
                    <legend style="width: 15.5%"><g:message code="clanak.show.label"/></legend>
                    <label for="datumObjave_" style="width: 9%">
                        <g:message code="clanak.datumObjave.title"/>
                    </label>
                    <g:textField name="datumObjave_" required="false" value="${this.clanak?.datumObjave.format("dd.MM.yyyy.")}" readonly="readonly" style="width: 15%"/><br/>

                    <label for="autor_" style="width: 9%">
                        <g:message code="clanak.autor.title"/>
                    </label>
                    <g:textField name="autor_" required="false" value="${this.clanak?.autor?.username}" readonly="readonly" style="width: 15%"/><br/><br/>

                    <label for="naslov" style="width: 5%">
                        <g:message code="clanak.naslov.title"/>
                    </label>
                    <g:textField name="naslov" required="false" value="${this.clanak?.naslov}" readonly="readonly" style="width: 94%"/><br/>

                    
                    <label for="sadrzaj" style="width: 5.3%">
                        <g:message code="clanak.sadrzaj.title"/>
                    </label>
                    <g:textArea name="sadrzaj" required="false" value="${this.clanak?.sadrzaj}" readonly="readonly" style="width: 100%; height: 300px"/><br/>
                </fieldset>
                <fieldset class="buttons">
                    <g:actionSubmit class="edit" action="edit" resource="${this.clanak}" value="${message(code: 'default.button.edit.label', default: 'Edit')}" style="width: 110px"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
