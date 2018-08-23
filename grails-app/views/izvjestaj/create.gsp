<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'izvjestaj.create.title', default: 'Izvjestaj')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>
<body>

<a href="#create-izvjestaj" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
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
    <form controller="izvjestaj" action="save">
        <fieldset class="fieldset">
            <legend><g:message code="preduzece.fieldset.title"/></legend>
            <label for="naziv">
                <g:message code="preduzece.naziv.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="naziv" required="false" value="${this.izvjestaj?.preduzece?.naziv}"/><br/>

            <label for="sektor">
                <g:message code="preduzece.sektor.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:select name="sektor" from="${ba.giz.Sektor.values()}" required="false" value="${this.izvjestaj?.preduzece?.sektor}"/><br/>

            <label>
                <g:message code="preduzece.uloga.title"/>
                <span class="required-indicator">*</span>
            </label>

            <label for="operater" style="width: 10%">
                <g:message code="preduzece.uloga.operater.title"/>
            </label>
            <g:checkBox name="operater" value="${true}" style="width: 5%"/>

            <label for="distributer" style="width: 10%">
                <g:message code="preduzece.uloga.distributer.title"/>
            </label>
            <g:checkBox name="distributer" value="${true}" style="width: 5%"/>

            <label for="snabdjevac" style="width: 10%">
                <g:message code="preduzece.uloga.snabdjevac.title"/>
            </label>
            <g:checkBox name="snabdjevac" value="${true}" style="width: 5%"/>

            <label for="adresa">
                <g:message code="preduzece.adresa.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="adresa" required="false" value="${this.izvjestaj?.preduzece?.adresa}"/><br/>

            <label for="maticniBrojJedinstvenogRegistra">
                <g:message code="preduzece.maticni.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="maticniBrojJedinstvenogRegistra" required="false" value="${this.izvjestaj?.preduzece?.maticniBrojJedinstvenogRegistra}"/><br/>

            <label for="jib">
                <g:message code="preduzece.jib.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="jib" required="false" value="${this.izvjestaj?.preduzece?.jib}"/><br/>

            <label for="pib">
                <g:message code="preduzece.pib.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="pib" required="false" value="${this.izvjestaj?.preduzece?.pib}"/><br/>

            <label for="telefon">
                <g:message code="preduzece.telefon.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="telefon" required="false" value="${this.izvjestaj?.preduzece?.telefon}"/><br/>

            <label for="fax">
                <g:message code="preduzece.fax.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="fax" required="false" value="${this.izvjestaj?.preduzece?.fax}"/><br/>

            <label for="email">
                <g:message code="preduzece.email.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="email" required="false" value="${this.izvjestaj?.preduzece?.email}"/><br/>

            <label for="brojZaposlenih">
                <g:message code="preduzece.brojzaposlenih.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="brojZaposlenih" required="false" value="${this.izvjestaj?.preduzece?.brojZaposlenih}"/><br/>

            <label for="ukupanGodisnjiPromet">
                <g:message code="preduzece.promet.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="ukupanGodisnjiPromet" required="false" value="${this.izvjestaj?.preduzece?.ukupanGodisnjiPromet}"/><br/>
        </fieldset>


        <fieldset class="fieldset">
            <legend style="width: 40%"><g:message code="podaciDozvolaObavljanjeDjelatnosti.fieldset.title"/></legend>
            <label for="distribucijaRegistarskiBroj">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="distribucijaRegistarskiBroj" required="false" value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.distribucijaRegistarskiBroj}"/><br/>

            <label for="distribucijaKomisija">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="distribucijaKomisija" required="false" value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.distribucijaKomisija}"/><br/>

            <label for="distribucijaDatumPocetkaVazenje">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:datePicker name="distribucijaDatumPocetkaVazenje" required="false" precision="day" relativeYears="[-10..10]" style="width: 5%"
                          value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.distribucijaDatumPocetkaVazenje}"/><br/>

            <label for="distribucijaPeriodVazenja">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="distribucijaPeriodVazenja" required="false" value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.distribucijaPeriodVazenja}"/><br/>

            <label for="snabdijevanjeRegistarskiBroj">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj.EE.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="snabdijevanjeRegistarskiBroj" required="false" value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.snabdijevanjeRegistarskiBroj}"/><br/>

            <label for="snabdijevanjeKomisija">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="snabdijevanjeKomisija" required="false" value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.snabdijevanjeKomisija}"/><br/>

            <label for="snabdijevanjeDatumPocetkaVazenje">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:datePicker name="snabdijevanjeDatumPocetkaVazenje" required="false" precision="day" relativeYears="[-10..10]" style="width: 5%"
                          value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.snabdijevanjeDatumPocetkaVazenje}"/><br/>

            <label for="snabdijevanjePeriodVazenja">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="snabdijevanjePeriodVazenja" required="false" value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.snabdijevanjePeriodVazenja}"/><br/>

        </fieldset>

        <fieldset class="fieldset">
            <legend style="width: 30%"><g:message code="podaciPodnosenjeIzvjestaja.fieldset.title"/></legend>
            <label for="godina">
                <g:message code="podaciPodnosenjeIzvjestaja.godina.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="godina" required="false" value="${this.izvjestaj?.podaciPodnosenjeIzvjestaja?.godina}"/><br/>

            <label for="prezime">
                <g:message code="podaciPodnosenjeIzvjestaja.prezime.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="prezime" required="false" value="${this.izvjestaj?.podaciPodnosenjeIzvjestaja?.prezime}"/><br/>

            <label for="telefon">
                <g:message code="podaciPodnosenjeIzvjestaja.telefon.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="telefon" required="false" value="${this.izvjestaj?.podaciPodnosenjeIzvjestaja?.telefon}"/><br/>

            <label for="email">
                <g:message code="podaciPodnosenjeIzvjestaja.email.title"/>
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="godina" required="false" value="${this.izvjestaj?.podaciPodnosenjeIzvjestaja?.email}"/><br/>

        </fieldset>

        <fieldset class="fieldset">
            <h5 style="text-align: center;color: #5777ad"><g:message code="izvjestaj.podaciPonudeEnergetskihUsluga.title"/></h5>
            <g:textArea name="podaciPonudeEnergetskihUsluga" required="false" rows="5" cols="100" value="${this.izvjestaj?.podaciPonudeEnergetskihUsluga}"/><br/>

            <h5 style="text-align: center;color: #5777ad"><g:message code="izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja.EE.title"/></h5>
            <g:textArea name="podaciPonudeUgradnjaIndividualnihUredjaja" required="false" rows="5" cols="100" value="${this.izvjestaj?.podaciPonudeUgradnjaIndividualnihUredjaja}"/><br/>

            <h5 style="text-align: center;color: #5777ad"><g:message code="izvjestaj.podaciOstaloEnergetskaEfikasnost.title"/></h5>
            <g:textArea name="podaciOstaloEnergetskaEfikasnost" required="false" rows="5" cols="100" value="${this.izvjestaj?.podaciOstaloEnergetskaEfikasnost}"/><br/>
        </fieldset>

        <fieldset class="buttons">
            <g:actionSubmit class="save" value="${message(code: 'default.button.create.label', default: 'Snimi')}"/>
        </fieldset>

    </form>

</div>
</body>
</html>