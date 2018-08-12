<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'izvjestaj.novi.title', default: 'Izvjestaj')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>
<body>

<a href="#create-izvjestaj" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
    </ul>
</div>
<div id="create-izvjestaj" class="content scaffold-create" role="main">
    <h1><g:message code="default.create.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.izvjestaj}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.izvjestaj}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:applyLayout name="singleblock">
    <g:form resource="${this.izvjestaj}" method="POST">
        <content tag="left1">
            <h5><g:message code="preduzece.fieldset.title"/></h5>
            <f:field bean="izvjestaj" property="preduzece.naziv" label="${message(code: 'preduzece.naziv.title')}" />
            <f:field bean="izvjestaj" property="preduzece.adresa" label="${message(code: 'preduzece.adresa.title')}" />
            <f:field bean="izvjestaj" property="preduzece.maticniBrojJedinstvenogRegistra" label="${message(code: 'preduzece.maticni.title')}" />
            <f:field bean="izvjestaj" property="preduzece.jib" label="${message(code: 'preduzece.jib.title')}" />
            <f:field bean="izvjestaj" property="preduzece.pib" label="${message(code: 'preduzece.pib.title')}" />
            <f:field bean="izvjestaj" property="preduzece.telefon" label="${message(code: 'preduzece.telefon.title')}" />
            <f:field bean="izvjestaj" property="preduzece.fax" label="${message(code: 'preduzece.fax.title')}" />
            <f:field bean="izvjestaj" property="preduzece.email" label="${message(code: 'preduzece.email.title')}" />
            <f:field bean="izvjestaj" property="preduzece.brojZaposlenih" label="${message(code: 'preduzece.brojzaposlenih.title')}" />
            <f:field bean="izvjestaj" property="preduzece.ukupanGodisnjiPromet" label="${message(code: 'preduzece.promet.title')}" />
        </content>

        <content tag="left2">
            <h5><g:message code="podaciDozvolaObavljanjeDjelatnosti.fieldset.title"/></h5>
            <f:field bean="izvjestaj" property="podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj" label="${message(code: 'preduzece.naziv.title')}" />
            <f:field bean="izvjestaj" property="podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija" label="${message(code: 'preduzece.adresa.title')}" />
            <f:field bean="izvjestaj" property="podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje" label="${message(code: 'preduzece.maticni.title')}" />
            <f:field bean="izvjestaj" property="podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja" label="${message(code: 'preduzece.jib.title')}" />
            <f:field bean="izvjestaj" property="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj" label="${message(code: 'preduzece.pib.title')}" />
            <f:field bean="izvjestaj" property="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija" label="${message(code: 'preduzece.telefon.title')}" />
            <f:field bean="izvjestaj" property="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje" label="${message(code: 'preduzece.fax.title')}" />
            <f:field bean="izvjestaj" property="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja" label="${message(code: 'preduzece.email.title')}" />
        </content>

        <content tag="left3">
            <h5><g:message code="podaciPodnosenjeIzvjestaja.fieldset.title"/></h5>
            <f:field bean="izvjestaj" property="podaciPodnosenjeIzvjestaja.godina" label="${message(code: 'podaciPodnosenjeIzvjestaja.godina.title')}" />
            <f:field bean="izvjestaj" property="podaciPodnosenjeIzvjestaja.prezime" label="${message(code: 'podaciPodnosenjeIzvjestaja.prezime.title')}" />
            <f:field bean="izvjestaj" property="podaciPodnosenjeIzvjestaja.telefon" label="${message(code: 'podaciPodnosenjeIzvjestaja.telefon.title')}" />
            <f:field bean="izvjestaj" property="podaciPodnosenjeIzvjestaja.email" label="${message(code: 'podaciPodnosenjeIzvjestaja.email.title')}" />
        </content>

        <content tag="left4">
            <h5><g:message code="izvjestaj.podaciPonudeEnergetskihUsluga.title"/></h5>
            <f:field bean="izvjestaj" property="podaciPonudeEnergetskihUsluga" />
            <h5><g:message code="izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja.EE.title"/></h5>
            <f:field bean="izvjestaj" property="podaciPonudeUgradnjaIndividualnihUredjaja" />
            <h5><g:message code="izvjestaj.podaciOstaloEnergetskaEfikasnost.title"/></h5>
            <f:field bean="izvjestaj" property="podaciOstaloEnergetskaEfikasnost" />
        </content>

        <fieldset class="buttons">
            <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Snimi')}" />
        </fieldset>
    </g:form>

    <content tag="right">
        <div id="list-izvjestaj" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <f:table collection="${list}" />

            <div class="pagination">
                <g:paginate total="${count ?: 0}" />
            </div>
        </div>
    </content>

    </g:applyLayout>
</div>
</body>
</html>