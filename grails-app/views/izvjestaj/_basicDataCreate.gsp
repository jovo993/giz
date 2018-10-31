<g:if test="${preduzece?.sektor == ba.giz.Sektor.TOPLOTNA_ENERGIJA || izvjestaj?.preduzece?.sektor == ba.giz.Sektor.TOPLOTNA_ENERGIJA}">
    <g:set var="title1" value="${message(code : 'podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj.TE.title')}"/>
    <g:set var="title2" value="${message(code : 'podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj.TE.title')}"/>
</g:if>
<g:elseif test="${preduzece?.sektor == ba.giz.Sektor.GAS || izvjestaj?.preduzece?.sektor == ba.giz.Sektor.GAS}">
    <g:set var="title1" value="${message(code : 'podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj.G.title')}"/>
    <g:set var="title2" value="${message(code : 'podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj.G.title')}"/>
</g:elseif>
<g:else>
    <g:set var="title1" value="${message(code : 'podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj.EE.title')}"/>
    <g:set var="title2" value="${message(code : 'podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj.EE.title')}"/>
</g:else>
<fieldset class="fieldset" disabled="">
    <legend><g:message code="preduzece.fieldset.title"/></legend>

    <label for="izvjestaj.preduzece.naziv"><g:message code="preduzece.naziv.title"/></label>
    <g:textField name="izvjestaj.preduzece.naziv" value="${preduzece?.naziv}"/><br/>

    <label for="sektor"><g:message code="preduzece.sektor.title"/></label>
    <g:textField name="sektor" value="${preduzece?.sektor}"/><br/>

    <label>
        <g:message code="preduzece.uloga.title"/>
    </label>
    <g:textField name="uloga" value="${preduzece?.uloga}"/><br/>

    <label for="izvjestaj.preduzece.adresa"><g:message code="preduzece.adresa.title"/></label>
    <g:textField name="izvjestaj.preduzece.adresa" value="${preduzece?.adresa}"/><br/>

    <label for="izvjestaj.preduzece.maticniBrojJedinstvenogRegistra"><g:message code="preduzece.maticni.title"/></label>
    <g:textField name="izvjestaj.preduzece.maticniBrojJedinstvenogRegistra" value="${preduzece?.maticniBrojJedinstvenogRegistra}"/><br/>

    <label for="izvjestaj.preduzece.jib"><g:message code="preduzece.jib.title"/></label>
    <g:textField name="izvjestaj.preduzece.jib" value="${preduzece?.jib}"/><br/>

    <label for="izvjestaj.preduzece.pib"><g:message code="preduzece.pib.title"/></label>
    <g:textField name="izvjestaj.preduzece.pib" value="${preduzece?.pib}"/><br/>

    <label for="izvjestaj.preduzece.telefon"><g:message code="preduzece.telefon.title"/></label>
    <g:textField name="izvjestaj.preduzece.telefon" value="${preduzece?.telefon}"/><br/>

    <label for="izvjestaj.preduzece.fax"><g:message code="preduzece.fax.title"/></label>
    <g:textField name="izvjestaj.preduzece.fax" value="${preduzece?.fax}"/><br/>

    <label for="izvjestaj.preduzece.email"><g:message code="preduzece.email.title"/></label>
    <g:textField name="izvjestaj.preduzece.email" value="${preduzece?.email}"/><br/>

    <label for="izvjestaj.preduzece.brojZaposlenih"><g:message code="preduzece.brojzaposlenih.title"/></label>
    <g:textField name="izvjestaj.preduzece.brojZaposlenih" value="${preduzece?.brojZaposlenih}"/><br/>

    <label for="izvjestaj.preduzece.ukupanGodisnjiPromet"><g:message code="preduzece.promet.title"/></label>
    <g:textField name="izvjestaj.preduzece.ukupanGodisnjiPromet" value="${preduzece?.ukupanGodisnjiPromet}"/><br/>

    <p><g:message code="izvjestaj.fusnota"/></p>
</fieldset>

<fieldset class="fieldset">
    <legend style="width: 60%"><g:message code="podaciDozvolaObavljanjeDjelatnosti.fieldset.title"/></legend>

<label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj">
    ${title1}
</label>
<g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj" type="number"/><br/>

<label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija">
    <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija.title"/>
</label>
<g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija"/><br/>

<label>
    <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje.title"/>
</label>
<input name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje" type="date" value=<g:formatDate date="${Calendar.getInstance()}" format="yyyy-MM-dd"/>></br>

<label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja">
    <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja.title"/>
</label>
<g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja"/><br/>

<label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj">
    ${title2}
</label>
<g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj"/><br/>

<label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija">
    <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija.title"/>
</label>
<g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija"/><br/>

<label>
    <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje.title"/>
</label>
<input name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje" type="date" value=<g:formatDate date="${Calendar.getInstance()}" format="yyyy-MM-dd"/>></br>

<label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja">
    <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja.title"/>
</label>
<g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja" type="number"/><br/>
</fieldset>

<fieldset class="fieldset">
    <legend style="width: 40%"><g:message code="podaciPodnosenjeIzvjestaja.fieldset.title"/></legend>

    <label for="izvjestaj.podaciPodnosenjeIzvjestaja.godina"><g:message code="podaciPodnosenjeIzvjestaja.godina.title"/></label>
    <g:select name="izvjestaj.podaciPodnosenjeIzvjestaja.godina" from="${ba.giz.Godina.findAll()}" /><br/>

    <label for="izvjestaj.podaciPodnosenjeIzvjestaja.prezimeImePozicija"><g:message code="podaciPodnosenjeIzvjestaja.prezimeImePozicija.title"/></label>
    <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.prezimeImePozicija"/><br/>

    <label for="izvjestaj.podaciPodnosenjeIzvjestaja.telefon"><g:message code="podaciPodnosenjeIzvjestaja.telefon.title"/></label>
    <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.telefon"/><br/>

    <label for="izvjestaj.podaciPodnosenjeIzvjestaja.email"><g:message code="podaciPodnosenjeIzvjestaja.email.title"/></label>
    <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.email"/><br/>
</fieldset>