<fieldset class="fieldset" disabled>
    <legend style="width: 38%"><g:message code="homepage.preduzece.fieldset.title"/></legend>
    <label for="naziv">
        <g:message code="preduzece.naziv.title"/>
    </label>
    <g:textField name="naziv" value="${preduzece?.naziv}" style="width: 50%"/><br/>

    <label for="sektor">
        <g:message code="preduzece.sektor.title"/>
    </label>
    <!-- <g:textField name="sektor" value="${preduzece?.sektor}" style="width: 50%"/><br/> -->
    <g:select name="sektor" from="${ba.giz.Sektor.values()}" value="${preduzece?.sektor}" style="width: 50%"/><br/>

    <label>
        <g:message code="preduzece.uloga.title"/>
    </label>
    <g:textField name="uloga" value="${preduzece?.uloga}" style="width: 50%"/><br/>

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

    <p><g:message code="izvjestaj.fusnota"/></p>
</fieldset>