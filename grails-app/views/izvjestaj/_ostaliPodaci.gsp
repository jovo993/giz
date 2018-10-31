<g:if test="${preduzece?.sektor == ba.giz.Sektor.TOPLOTNA_ENERGIJA || izvjestaj?.preduzece?.sektor == ba.giz.Sektor.TOPLOTNA_ENERGIJA}">
    <g:set var="title1" value="${message(code : 'izvjestaj.podaciPonudeEnergetskihUsluga.TE.title')}"/>
    <g:set var="title2" value="${message(code : 'izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja.TE.title')}"/>
    <g:set var="title3" value="${message(code : 'izvjestaj.podaciOstaloEnergetskaEfikasnost.TE.title')}"/>
</g:if>
<g:elseif test="${preduzece?.sektor == ba.giz.Sektor.GAS || izvjestaj?.preduzece?.sektor == ba.giz.Sektor.GAS}">
    <g:set var="title1" value="${message(code : 'izvjestaj.podaciPonudeEnergetskihUsluga.title')}"/>
    <g:set var="title2" value="${message(code : 'izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja.G.title')}"/>
    <g:set var="title3" value="${message(code : 'izvjestaj.podaciOstaloEnergetskaEfikasnost.title')}"/>
</g:elseif>
<g:else>
    <g:set var="title1" value="${message(code : 'izvjestaj.podaciPonudeEnergetskihUsluga.title')}"/>
    <g:set var="title2" value="${message(code : 'izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja.EE.title')}"/>
    <g:set var="title3" value="${message(code : 'izvjestaj.podaciOstaloEnergetskaEfikasnost.title')}"/>
</g:else>
<fieldset class="fieldset">
    <h5 style="text-align: center;color: #5777ad">${title1}</h5>
    <g:textArea name="izvjestaj.podaciPonudeEnergetskihUsluga" value="${izvjestaj?.podaciPonudeEnergetskihUsluga}" rows="5" cols="100"/><br/>

    <h5 style="text-align: center;color: #5777ad">${title2}</h5>
    <g:textArea name="izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja" value="${izvjestaj?.podaciPonudeUgradnjaIndividualnihUredjaja}" rows="5" cols="100"/><br/>

    <h5 style="text-align: center;color: #5777ad">${title3}</h5>
    <g:textArea name="izvjestaj.podaciOstaloEnergetskaEfikasnost" value="${izvjestaj?.podaciOstaloEnergetskaEfikasnost}" rows="5" cols="100"/><br/>
</fieldset>