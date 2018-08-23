<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>

<body>

<a href="#homepage" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div id="homepage" class="content scaffold-create" role="main">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.preduzece}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.preduzece}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <form>
        <fieldset class="fieldset">
            <legend><g:message code="homepage.preduzece.fieldset.title"/></legend>
            <label for="naziv">
                <g:message code="preduzece.naziv.title"/>
            </label>
            <g:textField name="naziv" required="false" value="${this.preduzece?.naziv}" readonly="readonly"/><br/>

            <label for="sektor">
                <g:message code="preduzece.sektor.title"/>
            </label>
            <g:textField name="sektor" required="false" value="${this.preduzece?.sektor}" readonly="readonly"/><br/>

            <label>
                <g:message code="preduzece.uloga.title"/>
            </label>
            <g:textField name="uloga" required="false" value="${this.preduzece?.uloga}" readonly="readonly"/><br/>

            <label for="adresa">
                <g:message code="preduzece.adresa.title"/>
            </label>
            <g:textField name="adresa" required="false" value="${this.preduzece?.adresa}" readonly="readonly"/><br/>

            <label for="maticniBrojJedinstvenogRegistra">
                <g:message code="preduzece.maticni.title"/>
            </label>
            <g:textField name="maticniBrojJedinstvenogRegistra" required="false" value="${this.preduzece?.maticniBrojJedinstvenogRegistra}" readonly="readonly"/><br/>

            <label for="jib">
                <g:message code="preduzece.jib.title"/>
            </label>
            <g:textField name="jib" required="false" value="${this.preduzece?.jib}" readonly="readonly"/><br/>

            <label for="pib">
                <g:message code="preduzece.pib.title"/>
            </label>
            <g:textField name="pib" required="false" value="${this.preduzece?.pib}" readonly="readonly"/><br/>

            <label for="telefon">
                <g:message code="preduzece.telefon.title"/>
            </label>
            <g:textField name="telefon" required="false" value="${this.preduzece?.telefon}" readonly="readonly"/><br/>

            <label for="fax">
                <g:message code="preduzece.fax.title"/>
            </label>
            <g:textField name="fax" required="false" value="${this.preduzece?.fax}" readonly="readonly"/><br/>

            <label for="email">
                <g:message code="preduzece.email.title"/>
            </label>
            <g:textField name="email" required="false" value="${this.preduzece?.email}" readonly="readonly"/><br/>

            <label for="brojZaposlenih">
                <g:message code="preduzece.brojzaposlenih.title"/>
            </label>
            <g:textField name="brojZaposlenih" required="false" value="${this.preduzece?.brojZaposlenih}" readonly="readonly"/><br/>

            <label for="ukupanGodisnjiPromet">
                <g:message code="preduzece.promet.title"/>
            </label>
            <g:textField name="ukupanGodisnjiPromet" required="false" value="${this.preduzece?.ukupanGodisnjiPromet}" readonly="readonly"/><br/>
        </fieldset>
        <fieldset class="fieldset">
            <legend><g:message code="homepage.izvjestajList.fieldset.title"/></legend>
            <table>
                <thead>
                <tr>
                    <g:each in="${properties}" var="p" status="i">
                        <g:set var="propTitle">homepage.list.${p}.label</g:set>
                        <g:sortableColumn property="${p}" title="${message(code: propTitle)}"/>
                    </g:each>
                </tr>
                </thead>
                <tbody>
                <g:each in="${list}" var="bean" status="i">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <g:each in="${properties}" var="p" status="j">
                            <td><f:display bean="${bean}" property="${p}" displayStyle="${displayStyle ?: 'table'}"/></td>
                        </g:each>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </fieldset>
    </form>
</div>
</body>
</html>