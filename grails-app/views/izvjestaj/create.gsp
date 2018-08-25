<%@ page import="ba.giz.Sektor" %>
<!DOCTYPE html>
<html>
<head>
    <asset:javascript src="application.js"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <g:set var="entityName" value="${message(code: 'izvjestaj.create.title', default: 'Izvjestaj')}"/>
    <meta name="layout" content="main"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<a href="#create-izvjestaj" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div id="create-izvjestaj" class="content scaffold-create" role="main">
    <h1><g:message code="default.create.label" args="[entityName]"/></h1>
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
    <form id="createIzvjestajForm">
        <fieldset class="fieldset">
            <legend><g:message code="preduzece.fieldset.title"/></legend>
            <label for="naziv">
                <g:message code="preduzece.naziv.title"/>

            </label>
            <g:textField name="naziv" value="${preduzece?.naziv}"/><br/>

            <label for="sektor">
                <g:message code="preduzece.sektor.title"/>

            </label>
            <g:select name="sektor" from="${ba.giz.Sektor.values()}" value="${preduzece?.sektor}"/><br/>

            <label>
                <g:message code="preduzece.uloga.title"/>

            </label>

            <label for="operater" style="width: 10%">
                <g:message code="preduzece.uloga.operater.title"/>
            </label>
            <g:checkBox name="operater" value="${preduzece?.uloga?.operater}" style="width: 5%"/>

            <label for="distributer" style="width: 10%">
                <g:message code="preduzece.uloga.distributer.title"/>
            </label>
            <g:checkBox name="distributer" value="${preduzece?.uloga?.distributer}" style="width: 5%"/>

            <label for="snabdjevac" style="width: 10%">
                <g:message code="preduzece.uloga.snabdjevac.title"/>
            </label>
            <g:checkBox name="snabdjevac" value="${preduzece?.uloga?.snabdjevac}" style="width: 5%"/>

            <label for="adresa">
                <g:message code="preduzece.adresa.title"/>

            </label>
            <g:textField name="adresa" value="${preduzece?.adresa}"/><br/>

            <label for="maticniBrojJedinstvenogRegistra">
                <g:message code="preduzece.maticni.title"/>

            </label>
            <g:textField name="maticniBrojJedinstvenogRegistra" value="${preduzece?.maticniBrojJedinstvenogRegistra}"/><br/>

            <label for="jib">
                <g:message code="preduzece.jib.title"/>

            </label>
            <g:textField name="jib" value="${preduzece?.jib}"/><br/>

            <label for="pib">
                <g:message code="preduzece.pib.title"/>

            </label>
            <g:textField name="pib" value="${preduzece?.pib}"/><br/>

            <label for="telefon">
                <g:message code="preduzece.telefon.title"/>

            </label>
            <g:textField name="telefon" value="${preduzece?.telefon}"/><br/>

            <label for="fax">
                <g:message code="preduzece.fax.title"/>

            </label>
            <g:textField name="fax" value="${preduzece?.fax}"/><br/>

            <label for="email">
                <g:message code="preduzece.email.title"/>

            </label>
            <g:textField name="email" value="${preduzece?.email}"/><br/>

            <label for="brojZaposlenih">
                <g:message code="preduzece.brojzaposlenih.title"/>

            </label>
            <g:textField name="brojZaposlenih" value="${preduzece?.brojZaposlenih}"/><br/>

            <label for="ukupanGodisnjiPromet">
                <g:message code="preduzece.promet.title"/>

            </label>
            <g:textField name="ukupanGodisnjiPromet" value="${preduzece?.ukupanGodisnjiPromet}"/><br/>

            <p><g:message code="izvjestaj.fusnota"/></p>
        </fieldset>


        <fieldset class="fieldset">
            <legend style="width: 40%"><g:message code="podaciDozvolaObavljanjeDjelatnosti.fieldset.title"/></legend>
            <label for="distribucijaRegistarskiBroj">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj.title"/>

            </label>
            <g:textField name="distribucijaRegistarskiBroj" value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.distribucijaRegistarskiBroj}"/><br/>

            <label for="distribucijaKomisija">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija.title"/>

            </label>
            <g:textField name="distribucijaKomisija" value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.distribucijaKomisija}"/><br/>

            <label for="distribucijaDatumPocetkaVazenje">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje.title"/>

            </label>
            <g:datePicker name="distribucijaDatumPocetkaVazenje" precision="day" relativeYears="[-10..10]" style="width: 5%"
                          value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.distribucijaDatumPocetkaVazenje}"/><br/>

            <label for="distribucijaPeriodVazenja">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja.title"/>

            </label>
            <g:textField name="distribucijaPeriodVazenja" value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.distribucijaPeriodVazenja}"/><br/>

            <label for="snabdijevanjeRegistarskiBroj">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj.EE.title"/>

            </label>
            <g:textField name="snabdijevanjeRegistarskiBroj" value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.snabdijevanjeRegistarskiBroj}"/><br/>

            <label for="snabdijevanjeKomisija">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija.title"/>

            </label>
            <g:textField name="snabdijevanjeKomisija" value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.snabdijevanjeKomisija}"/><br/>

            <label for="snabdijevanjeDatumPocetkaVazenje">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje.title"/>

            </label>
            <g:datePicker name="snabdijevanjeDatumPocetkaVazenje" precision="day" relativeYears="[-10..10]" style="width: 5%"
                          value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.snabdijevanjeDatumPocetkaVazenje}"/><br/>

            <label for="snabdijevanjePeriodVazenja">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja.title"/>

            </label>
            <g:textField name="snabdijevanjePeriodVazenja" value="${this.izvjestaj?.podaciDozvolaObavljanjeDjelatnosti?.snabdijevanjePeriodVazenja}"/><br/>

        </fieldset>

        <fieldset class="fieldset">
            <legend style="width: 30%"><g:message code="podaciPodnosenjeIzvjestaja.fieldset.title"/></legend>
            <label for="godina">
                <g:message code="podaciPodnosenjeIzvjestaja.godina.title"/>

            </label>
            <g:textField name="godina" value="${this.izvjestaj?.podaciPodnosenjeIzvjestaja?.godina}"/><br/>

            <label for="prezime">
                <g:message code="podaciPodnosenjeIzvjestaja.prezime.title"/>

            </label>
            <g:textField name="prezime" value="${this.izvjestaj?.podaciPodnosenjeIzvjestaja?.prezime}"/><br/>

            <label for="telefon">
                <g:message code="podaciPodnosenjeIzvjestaja.telefon.title"/>

            </label>
            <g:textField name="telefon" value="${this.izvjestaj?.podaciPodnosenjeIzvjestaja?.telefon}"/><br/>

            <label for="email">
                <g:message code="podaciPodnosenjeIzvjestaja.email.title"/>

            </label>
            <g:textField name="godina"/><br/>

        </fieldset>

        <fieldset class="fieldset">
            <h5 style="text-align: center;color: #5777ad"><g:message code="izvjestaj.podaciPonudeEnergetskihUsluga.title"/></h5>
            <g:textArea name="podaciPonudeEnergetskihUsluga" rows="5" cols="100"/><br/>

            <g:if test="${preduzece.sektor == ba.giz.Sektor.ELEKTRICNA_ENERGIJA}">
                <g:set var="ponudeUgradnjaIndividualnihUredjaja" value="${message(code: 'izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja.EE.title')}"/>
                <g:set var="preuzetaIsporucenaEnergija" value="${message(code: 'izvjestaj.preuzetaIsporucenaEnergija.fieldset.EE.title')}"/>
            </g:if>
            <g:elseif test="${preduzece.sektor == Sektor.GAS}">
                <g:set var="ponudeUgradnjaIndividualnihUredjaja" value="${message(code: 'izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja.G.title')}"/>
                <g:set var="preuzetaIsporucenaEnergija" value="${message(code: 'izvjestaj.preuzetaIsporucenaEnergija.fieldset.G.title')}"/>
            </g:elseif>
            <g:elseif test="${preduzece.sektor == Sektor.TOPLOTNA_ENERGIJA}">
                <g:set var="ponudeUgradnjaIndividualnihUredjaja" value="${message(code: 'izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja.TE.title')}"/>
                <g:set var="preuzetaIsporucenaEnergija" value="${message(code: 'izvjestaj.preuzetaIsporucenaEnergija.fieldset.TE.title')}"/>
            </g:elseif>

            <h5 style="text-align: center;color: #5777ad">${ponudeUgradnjaIndividualnihUredjaja}</h5>
            <g:textArea name="podaciPonudeUgradnjaIndividualnihUredjaja" rows="5" cols="100"/><br/>

            <h5 style="text-align: center;color: #5777ad"><g:message code="izvjestaj.podaciOstaloEnergetskaEfikasnost.title"/></h5>
            <g:textArea name="podaciOstaloEnergetskaEfikasnost" rows="5" cols="100"/><br/>
        </fieldset>

        <g:javascript library='jquery'>
            (function($) {
                $(document).ready(function() {
                    var $TABLE = $('#procjenaStanjaTable');

                    $('.table-add').click(function() {
                        var $clone = $TABLE.find('tr.hide').clone(true).removeClass('hide table-line');
                        $TABLE.find('table').append($clone);
                    });

                    $('.table-remove').click(function() {
                        $(this).parents('tr').detach();
                    });

                    $('.table-up').click(function() {
                        var $row = $(this).parents('tr');
                        if ($row.index() === 1) return; // Don't go above the header
                        $row.prev().before($row.get(0));
                    });

                    $('.table-down').click(function() {
                        var $row = $(this).parents('tr');
                        $row.next().after($row.get(0));
                    });
                });
            })(jQuery);
        </g:javascript>

        <div class="container">
            <div id="procjenaStanjaTable" class="table-editable">
                <table class="table">
                    <tr>
                        <th scope="col" style="width: 30%; vertical-align: middle;">Primijenjena mjera</th>
                        <th scope="col" style="width: 30%; vertical-align: middle;">Vrsta uštede</th>
                        <th scope="col" style="width: 20%; vertical-align: middle;">Količina uštede</br>(smanjenje gubitaka)</th>
                        <th></th>
                        <th></th>
                        <th style="text-align:center; vertical-align: middle;"><span class="table-add fa fa-plus fa-2x"></span></th>

                    </tr>
                    <tr class="hide">
                        <td contenteditable="true">Primijenjena mjera</td>
                        <td contenteditable="true">Vrsta uštede</td>
                        <td contenteditable="true">Količina uštede</td>
                        <td style="text-align:center">
                            <span class="table-remove fa fa-trash fa-2x"></span>
                        </td>
                        <td style="text-align:center">
                            <span class="table-up fa fa-angle-up fa-3x" style="horiz-align: center;" ></span>
                        </td>
                        <td style="text-align:center">
                            <span class="table-down fa fa-angle-down fa-3x" style="horiz-align: center;"></span>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
    <fieldset class="buttons">
        <button class="some-class" onclick="jQuery('#createIzvjestajForm').submit()">Submit</button>
    </fieldset>

</div>
</body>
</html>