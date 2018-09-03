<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'preduzece.label', default: 'Preduzece')}" />
        <title><g:message code="preduzece.show.label"/></title>
    </head>
    <body>
        <a href="#show-preduzece" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><g:link class="list" action="index"><g:message code="preduzece.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="preduzece.create.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-preduzece" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:form resource="${this.preduzece}" method="DELETE">
                <fieldset class="fieldset">
                    <legend style="width: 18%"><g:message code="preduzece.show.label"/></legend>
                    <label for="naziv">
                        <g:message code="preduzece.naziv.label.colon"/>
                    </label>
                    <g:textField name="naziv" required="false" value="${this.preduzece?.naziv}" readonly="readonly" style="width: 40%"/><br/>

                    <label for="sektor">
                        <g:message code="preduzece.sektor.title"/>
                    </label>
                    <g:textField name="sektor" required="false" value="${this.preduzece?.sektor}" readonly="readonly" style="width: 40%"/><br/>

                    <label for="uloga">
                        <g:message code="preduzece.uloga.title"/>
                    </label>
                    <g:textField name="uloga" required="false" value="${this.preduzece?.uloga}" readonly="readonly" style="width: 40%"/><br/>

                    <label for="status">
                        <g:message code="preduzece.status.title"/>
                    </label>
                    <g:textField name="status" required="false" value="${this.preduzece?.status}" readonly="readonly" style="width: 40%"/><br/>

                    <label for="adresa">
                        <g:message code="preduzece.adresa.title"/>
                    </label>
                    <g:textField name="adresa" required="false" value="${this.preduzece?.adresa}" readonly="readonly" style="width: 40%"/><br/>

                    <label for="maticniBrojJedinstvenogRegistra">
                        <g:message code="preduzece.maticni.title"/>
                    </label>
                    <g:textField name="maticniBrojJedinstvenogRegistra" required="false" value="${this.preduzece?.maticniBrojJedinstvenogRegistra}" readonly="readonly" style="width: 40%"/><br/>

                    <label for="jib">
                        <g:message code="preduzece.jib.title"/>
                    </label>
                    <g:textField name="jib" required="false" value="${this.preduzece?.jib}" readonly="readonly" style="width: 40%"/><br/>

                    <label for="pib">
                        <g:message code="preduzece.pib.title"/>
                    </label>
                    <g:textField name="pib" required="false" value="${this.preduzece?.pib}" readonly="readonly" style="width: 40%"/><br/>

                    <label for="telefon">
                        <g:message code="preduzece.telefon.title"/>
                    </label>
                    <g:textField name="telefon" required="false" value="${this.preduzece?.telefon}" readonly="readonly" style="width: 40%"/><br/>

                    <label for="fax">
                        <g:message code="preduzece.fax.title"/>
                    </label>
                    <g:textField name="fax" required="false" value="${this.preduzece?.fax}" readonly="readonly" style="width: 40%"/><br/>

                    <label for="email">
                        <g:message code="preduzece.email.title"/>
                    </label>
                    <g:textField name="email" required="false" value="${this.preduzece?.email}" readonly="readonly" style="width: 40%"/><br/>

                    <label for="brojZaposlenih">
                        <g:message code="preduzece.brojzaposlenih.title"/>
                    </label>
                    <g:textField name="brojZaposlenih" required="false" value="${this.preduzece?.brojZaposlenih}" readonly="readonly" style="width: 40%"/><br/>

                    <label for="ukupanGodisnjiPromet">
                        <g:message code="preduzece.promet.title"/>
                    </label>
                    <g:textField name="ukupanGodisnjiPromet" required="false" value="${this.preduzece?.ukupanGodisnjiPromet}" readonly="readonly" style="width: 40%"/><br/>
                </fieldset>
                <fieldset class="buttons">
                    <g:actionSubmit class="edit" action="edit" resource="${this.preduzece}" value="${message(code: 'default.button.edit.label', default: 'Edit')}" style="width: 10%"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
