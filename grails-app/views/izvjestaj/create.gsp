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
    <form id="formIzvjestaj">
        <fieldset class="fieldset">
            <legend><g:message code="preduzece.fieldset.title"/></legend>

            <label for="izvjestaj.preduzece.naziv">
                <g:message code="preduzece.naziv.title"/>
            </label>
            <g:textField name="izvjestaj.preduzece.naziv" value="${preduzece?.naziv}"/><br/>

            <label for="sektor">
                <g:message code="preduzece.sektor.title"/>
            </label>
            <g:select name="sektor" from="${ba.giz.Sektor.values()}" value="${izvjestaj?.preduzece?.sektor}" /><br/>

            <label><g:message code="preduzece.uloga.title"/></label>

            <label for="izvjestaj.preduzece.operater" style="width: 10%">
                <g:message code="preduzece.uloga.operater.title"/>
            </label>
            <g:checkBox name="izvjestaj.preduzece.operater" value="${preduzece?.uloga?.operater}" style="width: 5%"/>

            <label for="izvjestaj.preduzece.distributer" style="width: 10%">
                <g:message code="preduzece.uloga.distributer.title"/>
            </label>
            <g:checkBox name="izvjestaj.preduzece.distributer" value="${preduzece?.uloga?.distributer}" style="width: 5%"/>

            <label for="izvjestaj.preduzece.snabdjevac" style="width: 10%">
                <g:message code="preduzece.uloga.snabdjevac.title"/>
            </label>
            <g:checkBox name="izvjestaj.preduzece.snabdjevac" value="${preduzece?.uloga?.snabdjevac}" style="width: 5%"/>

            <label for="izvjestaj.preduzece.adresa">
                <g:message code="preduzece.adresa.title"/>
            </label>
            <g:textField name="izvjestaj.preduzece.adresa" value="${preduzece?.adresa}"/><br/>

            <label for="izvjestaj.preduzece.maticniBrojJedinstvenogRegistra">
                <g:message code="preduzece.maticni.title"/>
            </label>
            <g:textField name="izvjestaj.preduzece.maticniBrojJedinstvenogRegistra" value="${preduzece?.maticniBrojJedinstvenogRegistra}"/><br/>

            <label for="izvjestaj.preduzece.jib">
                <g:message code="preduzece.jib.title"/>
            </label>
            <g:textField name="izvjestaj.preduzece.jib" value="${preduzece?.jib}"/><br/>

            <label for="izvjestaj.preduzece.pib">
                <g:message code="preduzece.pib.title"/>
            </label>
            <g:textField name="izvjestaj.preduzece.pib" value="${preduzece?.pib}"/><br/>

            <label for="izvjestaj.preduzece.telefon">
                <g:message code="preduzece.telefon.title"/>
            </label>
            <g:textField name="izvjestaj.preduzece.telefon" value="${preduzece?.telefon}"/><br/>

            <label for="izvjestaj.preduzece.fax">
                <g:message code="preduzece.fax.title"/>
            </label>
            <g:textField name="izvjestaj.preduzece.fax" value="${preduzece?.fax}"/><br/>

            <label for="izvjestaj.preduzece.email">
                <g:message code="preduzece.email.title"/>
            </label>
            <g:textField name="izvjestaj.preduzece.email" value="${preduzece?.email}"/><br/>

            <label for="izvjestaj.preduzece.brojZaposlenih">
                <g:message code="preduzece.brojzaposlenih.title"/>
            </label>
            <g:textField name="izvjestaj.preduzece.brojZaposlenih" value="${preduzece?.brojZaposlenih}"/><br/>

            <label for="izvjestaj.preduzece.ukupanGodisnjiPromet">
                <g:message code="preduzece.promet.title"/>
            </label>
            <g:textField name="izvjestaj.preduzece.ukupanGodisnjiPromet" value="${preduzece?.ukupanGodisnjiPromet}"/><br/>

            <p><g:message code="izvjestaj.fusnota"/></p>
        </fieldset>


        <fieldset class="fieldset">
            <legend style="width: 60%"><g:message code="podaciDozvolaObavljanjeDjelatnosti.fieldset.title"/></legend>

            <label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj.title"/>
            </label>
            <g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj"/><br/>

            <label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija.title"/>
            </label>
            <g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija"/><br/>

            <label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje.title"/>
            </label>
            <g:datePicker name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje" precision="day" relativeYears="[-10..10]" style="width: 5%"/><br/>

            <label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja.title"/>
            </label>
            <g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaPeriodVazenja"/><br/>

            <label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj.EE.title"/>
            </label>
            <g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeRegistarskiBroj"/><br/>

            <label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija.title"/>
            </label>
            <g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeKomisija"/><br/>

            <label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje.title"/>
            </label>
            <g:datePicker name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje" precision="day" relativeYears="[-10..10]" style="width: 5%"/><br/>

            <label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja.title"/>
            </label>
            <g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja"/><br/>

        </fieldset>

        <fieldset class="fieldset">
            <legend style="width: 40%"><g:message code="podaciPodnosenjeIzvjestaja.fieldset.title"/></legend>

            <label for="izvjestaj.podaciPodnosenjeIzvjestaja.godina">
                <g:message code="podaciPodnosenjeIzvjestaja.godina.title"/>
            </label>
            <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.godina"/><br/>

            <label for="izvjestaj.podaciPodnosenjeIzvjestaja.prezime">
                <g:message code="podaciPodnosenjeIzvjestaja.prezime.title"/>
            </label>
            <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.prezime"/><br/>

            <label for="izvjestaj.podaciPodnosenjeIzvjestaja.telefon">
                <g:message code="podaciPodnosenjeIzvjestaja.telefon.title"/>
            </label>
            <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.telefon"/><br/>

            <label for="izvjestaj.podaciPodnosenjeIzvjestaja.email">
                <g:message code="podaciPodnosenjeIzvjestaja.email.title"/>
            </label>
            <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.email"/><br/>
        </fieldset>

        <fieldset class="fieldset">
            <h5 style="text-align: center;color: #5777ad"><g:message code="izvjestaj.podaciPonudeEnergetskihUsluga.title"/></h5>
            <g:textArea name="izvjestaj.podaciPonudeEnergetskihUsluga" rows="5" cols="100"/><br/>

            <g:if test="${preduzece?.sektor == ba.giz.Sektor.ELEKTRICNA_ENERGIJA}">
                <g:set var="ponudeUgradnjaIndividualnihUredjaja" value="${message(code: 'izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja.EE.title')}"/>
                <g:set var="preuzetaIsporucenaEnergija" value="${message(code: 'izvjestaj.preuzetaIsporucenaEnergija.fieldset.EE.title')}"/>
            </g:if>
            <g:elseif test="${preduzece?.sektor == Sektor.GAS}">
                <g:set var="ponudeUgradnjaIndividualnihUredjaja" value="${message(code: 'izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja.G.title')}"/>
                <g:set var="preuzetaIsporucenaEnergija" value="${message(code: 'izvjestaj.preuzetaIsporucenaEnergija.fieldset.G.title')}"/>
            </g:elseif>
            <g:elseif test="${preduzece?.sektor == Sektor.TOPLOTNA_ENERGIJA}">
                <g:set var="ponudeUgradnjaIndividualnihUredjaja" value="${message(code: 'izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja.TE.title')}"/>
                <g:set var="preuzetaIsporucenaEnergija" value="${message(code: 'izvjestaj.preuzetaIsporucenaEnergija.fieldset.TE.title')}"/>
            </g:elseif>

            <h5 style="text-align: center;color: #5777ad">${ponudeUgradnjaIndividualnihUredjaja}</h5>
            <g:textArea name="izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja" rows="5" cols="100"/><br/>

            <h5 style="text-align: center;color: #5777ad"><g:message code="izvjestaj.podaciOstaloEnergetskaEfikasnost.title"/></h5>
            <g:textArea name="izvjestaj.podaciOstaloEnergetskaEfikasnost" rows="5" cols="100"/><br/>
        </fieldset>

        <g:javascript library='jquery'>
            (function($) {
                $(document).ready(function() {
                    var $TABLE = $('#procjenaStanjaTable');
                    var $BTN = $('#submitButton');

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

                    jQuery.fn.pop = [].pop;
                    jQuery.fn.shift = [].shift;


                    $BTN.click(function() {
                        var $rows = $TABLE.find('tr:not(:hidden)');
                        var headers = [];
                        var data = [];

                        var dataJSON = $("#formIzvjestaj").serialize() + "&izvjestaj.procjenaStanjaEnergetskeEfikasnostiList=";

                        // Get the headers (add special header logic here)
                        $([$rows].shift()).find('th:not(:empty)').each(function () {
                            headers.push(this.id);
                        });

                        // Turn all existing rows into a loopable array
                        $rows.each(function () {
                            var $td = $(this).find('td');
                            var h = {};
                            // Use the headers from earlier to name our hash keys
                            var append = true;
                            dataJSON += "{";
                            headers.forEach(function (header, i) {
                              if($td.text() != "") {
                                  h[header] = $td.eq(i).text();
                                  dataJSON += '"' + header + '"' + ":" + '"' + $td.eq(i).text() + '"' + ",";
                              }
                              else {
                                append = false;
                              }
                            });

                            dataJSON = dataJSON.substr(0, dataJSON.length - 1);
                            if(append) {
                                dataJSON += "},";
                            }

                            data.push(h);
                        });
                        dataJSON = dataJSON.substr(0, dataJSON.length - 1);


                        $.ajax({
                            url: 'save',
                            type: 'post',
                            dataType: 'json',
                            data: dataJSON
                        });
                    });

                });
            })(jQuery);
        </g:javascript>
        
        <div class="container">
            <div id="procjenaStanjaTable" class="table-editable">
                <span class="table-add fa fa-plus fa-2x"></span>
                <table id="izvjestaj.procjenaStanjaEnergetskeEfikasnostiList" class="table">
                    <tr>
                        <th id="primjenjenaMjera" scope="col" style="width: 30%; vertical-align: middle;">Primijenjena mjera</th>
                        <th id="vrstaUstede" scope="col" style="width: 30%; vertical-align: middle;">Vrsta uštede</th>
                        <th id="kolicinaUstede" scope="col" style="width: 20%; vertical-align: middle;">Količina uštede</br>(smanjenje gubitaka)</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                    <tr class="hide">
                        <td id="xxx" contenteditable="true">Untitled</td>
                        <td contenteditable="true">Untitled</td>
                        <td contenteditable="true">Untitled</td>
                        <td style="text-align:center">
                            <span class="table-remove fa fa-trash fa-2x"></span>
                        </td>
                        <td style="text-align:center">
                            <span class="table-up fa fa-angle-up fa-2x" style="horiz-align: center;" ></span>
                        </td>
                        <td style="text-align:center">
                            <span class="table-down fa fa-angle-down fa-2x" style="horiz-align: center;"></span>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <fieldset class="buttons">
            <g:submitButton onClick="" name="create" class="save" value="${message(code: 'default.button.create.label')}" />
        </fieldset>
    </form>

    <button id="submitButton" class="some-class">Submit</button>


</div>
</body>
</html>