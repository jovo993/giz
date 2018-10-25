<g:if test="${izvjestaj}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<fieldset class="fieldset" disabled>
    <legend><g:message code="preduzece.fieldset.title"/></legend>

    <label for="izvjestaj.preduzece.naziv"><g:message code="preduzece.naziv.title"/></label>
    <g:textField name="izvjestaj.preduzece.naziv" value="${izvjestaj?.preduzece?.naziv}"/><br/>

    <label for="izvjestaj.preduzece.sektor"><g:message code="preduzece.sektor.title"/></label>
    <g:select name="izvjestaj.preduzece.sektor" from="${ba.giz.Sektor.values()}" value="${izvjestaj?.preduzece?.sektor}"/><br/>

    <label><g:message code="preduzece.uloga.title"/></label>

    <label for="izvjestaj.preduzece.operater" style="width: 10%"><g:message code="preduzece.uloga.operater.title"/></label>
    <g:checkBox name="izvjestaj.preduzece.operater" value="${izvjestaj?.preduzece?.uloga?.operator}" style="width: 5%"/>

    <label for="izvjestaj.preduzece.distributer" style="width: 10%"><g:message code="preduzece.uloga.distributer.title"/></label>
    <g:checkBox name="izvjestaj.preduzece.distributer" value="${izvjestaj?.preduzece?.uloga?.distributer}" style="width: 5%"/>

    <label for="izvjestaj.preduzece.snabdjevac" style="width: 10%"><g:message code="preduzece.uloga.snabdjevac.title"/></label>
    <g:checkBox name="izvjestaj.preduzece.snabdjevac" value="${izvjestaj?.preduzece?.uloga?.snabdjevac}" style="width: 5%"/>

    <label for="izvjestaj.preduzece.adresa"><g:message code="preduzece.adresa.title"/></label>
    <g:textField name="izvjestaj.preduzece.adresa" value="${izvjestaj?.preduzece?.adresa}"/><br/>

    <label for="izvjestaj.preduzece.maticniBrojJedinstvenogRegistra"><g:message code="preduzece.maticni.title"/></label>
    <g:textField name="izvjestaj.preduzece.maticniBrojJedinstvenogRegistra" value="${izvjestaj?.preduzece?.maticniBrojJedinstvenogRegistra}"/><br/>

    <label for="izvjestaj.preduzece.jib"><g:message code="preduzece.jib.title"/></label>
    <g:textField name="izvjestaj.preduzece.jib" value="${izvjestaj?.preduzece?.jib}"/><br/>

    <label for="izvjestaj.preduzece.pib"><g:message code="preduzece.pib.title"/></label>
    <g:textField name="izvjestaj.preduzece.pib" value="${izvjestaj?.preduzece?.pib}"/><br/>

    <label for="izvjestaj.preduzece.telefon"><g:message code="preduzece.telefon.title"/></label>
    <g:textField name="izvjestaj.preduzece.telefon" value="${izvjestaj?.preduzece?.telefon}"/><br/>

    <label for="izvjestaj.preduzece.fax"><g:message code="preduzece.fax.title"/></label>
    <g:textField name="izvjestaj.preduzece.fax" value="${izvjestaj?.preduzece?.fax}"/><br/>

    <label for="izvjestaj.preduzece.email"><g:message code="preduzece.email.title"/></label>
    <g:textField name="izvjestaj.preduzece.email" value="${izvjestaj?.preduzece?.email}"/><br/>

    <label for="izvjestaj.preduzece.brojZaposlenih"><g:message code="preduzece.brojzaposlenih.title"/></label>
    <g:textField name="izvjestaj.preduzece.brojZaposlenih" value="${izvjestaj?.preduzece?.brojZaposlenih}"/><br/>

    <label for="izvjestaj.preduzece.ukupanGodisnjiPromet"><g:message code="preduzece.promet.title"/></label>
    <g:textField name="izvjestaj.preduzece.ukupanGodisnjiPromet" value="${izvjestaj?.preduzece?.ukupanGodisnjiPromet}"/><br/>

    <p><g:message code="izvjestaj.fusnota"/></p>
</fieldset>

<fieldset class="fieldset">
    <legend style="width: 60%"><g:message code="podaciDozvolaObavljanjeDjelatnosti.fieldset.title"/></legend>

<label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj">
    <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj.title"/>
</label>
<g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj" value="${izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.distribucijaRegistarskiBroj}"/><br/>

<label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija">
    <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija.title"/>
</label>
<g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija" value="${izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.distribucijaKomisija}"/><br/>

<label>
    <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje.title"/>
</label>
<input name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje" type="date"
       value="${izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.distribucijaDatumPocetkaVazenje?.format("yyyy-mm-dd")}"/><br/>

<label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja">
    <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja.title"/>
</label>
<g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja" value="${izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.distribucijaPeriodVazenja}"/><br/>

<label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj">
    <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj.EE.title"/>
</label>
<g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj" value="${izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.snabdijevanjeRegistarskiBroj}"/><br/>

<label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija">
    <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija.title"/>
</label>
<g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija" value="${izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.snabdijevanjeKomisija}"/><br/>

<label>
    <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje.title"/>
</label>
<input name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje" type="date"
       value="${izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.snabdijevanjeDatumPocetkaVazenje?.format("yyyy-mm-dd")}"/></br>

<label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja">
    <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja.title"/>
</label>
<g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja" value="${izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.snabdijevanjePeriodVazenja}"/><br/>
</fieldset>

<fieldset class="fieldset">
    <legend style="width: 40%"><g:message code="podaciPodnosenjeIzvjestaja.fieldset.title"/></legend>

    <label for="izvjestaj.podaciPodnosenjeIzvjestaja.godina"><g:message code="podaciPodnosenjeIzvjestaja.godina.title"/></label>
    <g:select name="izvjestaj.podaciPodnosenjeIzvjestaja.godina" from="${ba.giz.Godina.findAll()}" value="${izvjestaj?.podaciPodnosenjeIzvjestaja?.godina}" style="width: 5%"/><br/>

    <label for="izvjestaj.podaciPodnosenjeIzvjestaja.prezimeImePozicija"><g:message code="podaciPodnosenjeIzvjestaja.prezimeImePozicija.title"/></label>
    <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.prezimeImePozicija" value="${izvjestaj?.podaciPodnosenjeIzvjestaja?.prezimeImePozicija}"/><br/>

    <label for="izvjestaj.podaciPodnosenjeIzvjestaja.telefon"><g:message code="podaciPodnosenjeIzvjestaja.telefon.title"/></label>
    <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.telefon" value="${izvjestaj?.podaciPodnosenjeIzvjestaja?.telefon}"/><br/>

    <label for="izvjestaj.podaciPodnosenjeIzvjestaja.email"><g:message code="podaciPodnosenjeIzvjestaja.email.title"/></label>
    <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.email" value="${izvjestaj?.podaciPodnosenjeIzvjestaja?.email}"/><br/>
</fieldset>