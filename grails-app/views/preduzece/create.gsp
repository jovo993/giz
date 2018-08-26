<%@ page import="ba.giz.Sektor" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'preduzece.label', default: 'Preduzece')}"/>
    <title><g:message code="preduzece.create.label" args="[entityName]"/></title>
</head>

<body>
<a href="#create-preduzece" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><g:link class="list" action="index"><g:message code="preduzece.list.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="create-preduzece" class="content scaffold-create" role="main">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.preduzece}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.preduzece}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form action="save">
        <fieldset class="fieldset">
            <legend><g:message code="preduzece.create.label"/></legend>

            <label for="naziv">
                <g:message code="preduzece.naziv.label.colon"/>
            </label>
            <g:textField name="naziv" value="${preduzece?.naziv}" style="width: 50%"/><br/>

            <label for="sektor">
                <g:message code="preduzece.sektor.title"/>
            </label>
            <g:select name="sektor" from="${Sektor.values()}" value="${preduzece?.sektor}" noSelection="${['': 'Odaberite jedan...']}" keys="${Sektor.values()*.name()}" style="width: 50%"/><br/>

            <label style="vertical-align: middle;">
                <g:message code="preduzece.uloga.title"/>
            </label>

            <g:checkBox name="uloga.operator" value="${preduzece?.uloga?.operator}" style="width: 2%; vertical-align: middle;"/>
            <label for="uloga.operator" style="width: 6.6%; vertical-align: middle;">
                <g:message code="preduzece.uloga.operator.title"/>
            </label>

            <g:checkBox name="uloga.distributer" value="${preduzece?.uloga?.distributer}" style="width: 2%; vertical-align: middle;"/>
            <label for="uloga.distributer" style="width: 8%; vertical-align: middle;">
                <g:message code="preduzece.uloga.distributer.title"/>
            </label>

            <g:checkBox name="uloga.snabdjevac" value="${preduzece?.uloga?.snabdjevac}" style="width: 2%; vertical-align: middle;"/>
            <label for="uloga.snabdjevac" style="width: 8%; vertical-align: middle;">
                <g:message code="preduzece.uloga.snabdjevac.title"/>
            </label><br/>

            <label for="status.aktivan">
                <g:message code="preduzece.aktivan.title"/>
            </label>
            <g:checkBox name="status.aktivan" value="${preduzece?.status?.aktivan}" checked="${true}" style="width: 2%"/><br/>


            <label for="adresa">
                <g:message code="preduzece.adresa.title"/>
            </label>
            <g:textField name="adresa" value="${preduzece?.adresa}" style="width: 50%"/><br/>

            <label for="maticniBrojJedinstvenogRegistra">
                <g:message code="preduzece.maticni.title"/>

            </label>
            <g:textField name="maticniBrojJedinstvenogRegistra" value="${preduzece?.maticniBrojJedinstvenogRegistra}" style="width: 50%"/><br/>
            <label for="jib">
                <g:message code="preduzece.jib.title"/>
            </label>
            <g:textField name="jib" value="${preduzece?.jib}" style="width: 50%"/><br/>

            <label for="pib">
                <g:message code="preduzece.pib.title"/>
            </label>
            <g:textField name="pib" value="${preduzece?.pib}" style="width: 50%"/><br/>

            <label for="telefon">
                <g:message code="preduzece.telefon.title"/>
            </label>
            <g:textField name="telefon" value="${preduzece?.telefon}" style="width: 50%"/><br/>

            <label for="fax">
                <g:message code="preduzece.fax.title"/>
            </label>
            <g:textField name="fax" value="${preduzece?.fax}" style="width: 50%"/><br/>

            <label for="email">
                <g:message code="preduzece.email.title"/>
            </label>
            <g:textField name="email" value="${preduzece?.email}" style="width: 50%"/><br/>

            <label for="brojZaposlenih">
                <g:message code="preduzece.brojzaposlenih.title"/>
            </label>
            <g:textField name="brojZaposlenih" value="${preduzece?.brojZaposlenih}" style="width: 50%"/><br/>

            <label for="ukupanGodisnjiPromet">
                <g:message code="preduzece.promet.title"/>
            </label>
            <g:textField name="ukupanGodisnjiPromet" value="${preduzece?.ukupanGodisnjiPromet}" style="width: 50%"/><br/>
        </fieldset>
        <fieldset class="buttons">
            <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" style="width: 10%"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
