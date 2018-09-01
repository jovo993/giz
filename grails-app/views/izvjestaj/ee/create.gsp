<%@ page import="ba.giz.Sektor" %>
<!DOCTYPE html>
<html>
<head>
    <asset:javascript src="application.js"/>
    <g:set var="entityName" value="${message(code: 'izvjestaj.create.title', default: 'Izvjestaj')}"/>

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <meta name="layout" content="main"/>
    <title><g:message code="izvjestaj.EE.title"/></title>
</head>

<body>

<a href="#create-izvjestaj" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div id="create-izvjestaj" class="content scaffold-create" role="main">
    <h1><g:message code="izvjestaj.EE.title"/></h1>
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
        <fieldset class="fieldset" disabled="true">
            <legend><g:message code="preduzece.fieldset.title"/></legend>

            <label for="izvjestaj.preduzece.naziv"><g:message code="preduzece.naziv.title"/></label>
            <g:textField name="izvjestaj.preduzece.naziv" value="${preduzece?.naziv}"/><br/>

            <label for="sektor"><g:message code="preduzece.sektor.title"/></label>
            <g:select name="sektor" from="${ba.giz.Sektor.values()}" value="${izvjestaj?.preduzece?.sektor}"/><br/>

            <label><g:message code="preduzece.uloga.title"/></label>

            <label for="izvjestaj.preduzece.operater" style="width: 10%"><g:message code="preduzece.uloga.operater.title"/></label>
            <g:checkBox name="izvjestaj.preduzece.operater" value="${preduzece?.uloga?.operater}" style="width: 5%"/>

            <label for="izvjestaj.preduzece.distributer" style="width: 10%"><g:message code="preduzece.uloga.distributer.title"/></label>
            <g:checkBox name="izvjestaj.preduzece.distributer" value="${preduzece?.uloga?.distributer}" style="width: 5%"/>

            <label for="izvjestaj.preduzece.snabdjevac" style="width: 10%"><g:message code="preduzece.uloga.snabdjevac.title"/></label>
            <g:checkBox name="izvjestaj.preduzece.snabdjevac" value="${preduzece?.uloga?.snabdjevac}" style="width: 5%"/>

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

            <p><g:message code="izvjestaj.EE.fusnota"/></p>
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

            <label for="izvjestaj.podaciPodnosenjeIzvjestaja.godina"><g:message code="podaciPodnosenjeIzvjestaja.godina.title"/></label>
            <g:datePicker name="izvjestaj.podaciPodnosenjeIzvjestaja.godina" precision="year" relativeYears="[-5..5]" style="width: 5%"/><br/><br/>

            <label for="izvjestaj.podaciPodnosenjeIzvjestaja.prezime"><g:message code="podaciPodnosenjeIzvjestaja.prezime.title"/></label>
            <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.prezime"/><br/>

            <label for="izvjestaj.podaciPodnosenjeIzvjestaja.telefon"><g:message code="podaciPodnosenjeIzvjestaja.telefon.title"/></label>
            <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.telefon"/><br/>

            <label for="izvjestaj.podaciPodnosenjeIzvjestaja.email"><g:message code="podaciPodnosenjeIzvjestaja.email.title"/></label>
            <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.email"/><br/>
        </fieldset>

        %{-- dodati dio koji odredjuje o kakvom izvjestaju se radi--}%
        <g:if test="${preduzece?.sektor == ba.giz.Sektor.ELEKTRICNA_ENERGIJA}">
            <g:set var="ponudeUgradnjaIndividualnihUredjaja" value="${message(code: 'izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja.EE.title')}"/>
            <g:set var="stepenMjerenja" value="${message(code: 'izvjestaj.podaciStepenMjerenja.EE.fieldset.title')}"/>
            <g:set var="stepenMjerenjath1" value="${message(code: 'tabela.stepenMjerenja.EE.th1')}"/>
            <g:set var="elektricnaEnergija" value="true"/>
        </g:if>

        %{-- funkcije koje rade dodavanje novog, brisanje i pomjeranje postojeceg reda za tabelu Preuzeta i isporucena... --}%
        <g:javascript library='jquery'>
            (function($) {
                $(document).ready(function() {
                    var preuzetaIsporucena = "preuzetaIsporucena";
                    var $TABLE = $('#' + preuzetaIsporucena + 'Table');

                    $('#' + preuzetaIsporucena).click(function() {
                        var $clone = $TABLE.find('tr.hide').clone(true).removeClass('hide table-line');
                        $TABLE.find('table').append($clone);
                        calculateSum();
                    });

                    $('#' + preuzetaIsporucena + 'Remove').click(function() {
                        $(this).parents('tr').detach();
                        calculateSum();
                    });

                    $('#' + preuzetaIsporucena + 'Up').click(function() {
                        var $row = $(this).parents('tr');
                        if ($row.index() === 1) return; // Don't go above the header
                        $row.prev().before($row.get(0));
                    });

                    $('#' + preuzetaIsporucena + 'Down').click(function() {
                        var $row = $(this).parents('tr');
                        $row.next().after($row.get(0));
                    });

                });
            })(jQuery);
        </g:javascript>

        <fieldset class="fieldset">
            <legend style="width: 60%">${message(code: 'izvjestaj.preuzetaIsporucenaEnergija.fieldset.EE.title')}</legend>

            <div id="preuzetaIsporucenaTable" class="table-editable">
                <span id="preuzetaIsporucena" class="table-add fa fa-plus fa-2x"></span>
                <table id="table1" class="table">
                    <tr>
                        <th id="radnaJedinica" scope="col" style="width: 10%; vertical-align: middle;" rowspan="2">Radna jedinica</th>
                        <th id="preuzetaElektricnaEnergija" scope="col" style="width: 10%; vertical-align: middle;" rowspan="2">PREUZETA EL. ENERGIJA (MWh)</th>
                        <th scope="col" style="width: 10%; vertical-align: middle;" colspan="7">ISPORUČENA ELEKTRIČNA ENERGIJA (MWh)</th>
                        <th id="gubici" scope="col" style="width: 10%; vertical-align: middle;" rowspan="2">GUBICI (%)</th>
                    </tr>
                    <tr>
                        <th id="potrosnjaNa110kV" scope="col" style="width: 10%; vertical-align: middle;">potrošnja na 110 kV naponu</th>
                        <th id="potrosnjaNa35kV" scope="col" style="width: 10%; vertical-align: middle;">potrošnja na 35 kV naponu</th>
                        <th id="potrosnjaNa1Do35kV" scope="col" style="width: 10%; vertical-align: middle;">potrošnja na naponskom nivou od 1 kV do 35 kV</th>
                        <th id="potrosnjaOstala" scope="col" style="width: 10%; vertical-align: middle;">ostala potrošnja na niskom naponu (0.4kV)</th>
                        <th id="potrisnjaDomacinstva" scope="col" style="width: 10%; vertical-align: middle;">domaćinstva (0.4kV)</th>
                        <th id="potrosnjaJavnaRasvjeta" scope="col" style="width: 10%; vertical-align: middle;">javna rasvjeta (0.4kV)</th>
                        <th scope="col" style="width: 10%; vertical-align: middle;">UKUPNO ISPORUČENO</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                    <tr class="hide">
                        <td class="contenteditable" contenteditable="true"></td>
                        <td class="contenteditable" contenteditable="true"></td>
                        <td class="contenteditable" contenteditable="true"></td>
                        <td class="contenteditable" contenteditable="true"></td>
                        <td class="contenteditable" contenteditable="true"></td>
                        <td class="contenteditable" contenteditable="true"></td>
                        <td class="contenteditable" contenteditable="true"></td>
                        <td class="contenteditable" contenteditable="true"></td>
                        <td></td>
                        <td></td>
                        <td style="text-align:center">
                            <span id="preuzetaIsporucenaRemove" class="table-remove fa fa-trash fa-2x"></span>
                        </td>
                        <td style="text-align:center">
                            <span id="preuzetaIsporucenaUp" class="table-up fa fa-angle-up fa-2x" style="horiz-align: center;"></span>
                        </td>
                        <td style="text-align:center">
                            <span id="preuzetaIsporucenaDown" class="table-down fa fa-angle-down fa-2x" style="horiz-align: center;"></span>
                        </td>
                    </tr>
                    <tfoot>
                    <tr>
                        <td style="vertical-align: middle; text-align: right;">UKUPNO:</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="9" style="vertical-align: middle; text-align: right;">Ukupno isporučena energija krajnjim kupcima u TJ:</td>
                        <td colspan="5"><input type="text" class="form-control" value="&nbsp;"></td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </fieldset>


        <g:javascript library='jquery'>
            (function($) {
                $(document).ready(function() {
                    var $TABLE = $('#procjenaStanjaTable');


                    $('#procjenaStanja').click(function() {
                        var $clone = $TABLE.find('tr.hide').clone(true).removeClass('hide table-line');
                        $TABLE.find('table').append($clone);
                    });

                    $('#procjenaStanjaRemove').click(function() {
                        $(this).parents('tr').detach();
                    });

                    $('#procjenaStanjaUp').click(function() {
                        var $row = $(this).parents('tr');
                        if ($row.index() === 1) return; // Don't go above the header
                        $row.prev().before($row.get(0));
                    });

                    $('#procjenaStanjaDown').click(function() {
                        var $row = $(this).parents('tr');
                        $row.next().after($row.get(0));
                    });

                    jQuery.fn.pop = [].pop;
                    jQuery.fn.shift = [].shift;

                    var $BTN = $('#submitButton');
                    $BTN.click(function() {
                        var $rows = $TABLE.find('tr:not(:hidden)');
                        var headers = [];
                        var data = [];

                        var dataJSON = $("#formIzvjestaj").serialize() + "&izvjestaj.procjenaStanjaEnergetskeEfikasnostiList=";

                        // Get the headers (add special header logic here)
                        $([$rows].shift()).find('th:not(:empty)').each(function() {
                            headers.push(this.id);
                        });

                        // Turn all existing rows into a loopable array
                        $rows.each(function() {
                            var $td = $(this).find('td');
                            var h = {};
                            // Use the headers from earlier to name our hash keys
                            var append = true;
                            dataJSON += "{";
                            headers.forEach(function(header, i) {
                                if ($td.text() != "") {
                                    h[header] = $td.eq(i).text();
                                    dataJSON += '"' + header + '"' + ":" + '"' + $td.eq(i).text() + '"' + ",";
                                }
                                else {
                                    append = false;
                                }
                            });

                            dataJSON = dataJSON.substr(0, dataJSON.length - 1);
                            if (append) {
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
        <fieldset class="fieldset">
            <legend style="width: 50%"><g:message code="izvjestaj.procjenastanja.fieldset.title"/></legend>

            <div id="procjenaStanjaTable" class="table-editable">
                <span id="procjenaStanja" class="table-add fa fa-plus fa-2x"></span>
                <table class="table">
                    <tr>
                        <th id="primjenjenaMjera" scope="col" class="prety-th">Primjenjena mjera</th>
                        <th id="vrstaUstede" scope="col" class="prety-th">Vrsta uštede</th>
                        <th id="kolicinaUstede" class="prety-th">Količina uštede (smanjenje gubitaka)</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                    <tr class="hide">
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td style="text-align:center">
                            <span id="procjenaStanjaRemove" class="table-remove fa fa-trash fa-2x"></span>
                        </td>
                        <td style="text-align:center">
                            <span id="procjenaStanjaUp" class="table-up fa fa-angle-up fa-2x" style="horiz-align: center;"></span>
                        </td>
                        <td style="text-align:center">
                            <span id="procjenaStanjaDown" class="table-down fa fa-angle-down fa-2x" style="horiz-align: center;"></span>
                        </td>
                    </tr>
                </table>
            </div>
        </fieldset>

        <fieldset class="fieldset">
            <legend style="width: 80%"><g:message code="${stepenMjerenja}"/></legend>
            <table class="table table-bordered table-secondary">
                <thead>
                <tr>
                    <th scope="col" style="width: 25%; vertical-align: middle;">&nbsp;</th>
                    <th scope="col" class="prety-th"><g:message code="${stepenMjerenjath1}"/></th>
                    <th scope="col" class="prety-th"><g:message code="tabela.stepenMjerenja.EE.th2"/></th>
                    <g:if test="${elektricnaEnergija.equals("true")}">
                        <th scope="col" class="prety-th"><g:message code="tabela.stepenMjerenja.EE.th3"/></th>
                    </g:if>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Sektor domaćinstva</td>
                    <td contenteditable="true" class="editable-td"></td>
                    <td contenteditable="true" class="editable-td"></td>
                    <g:if test="${elektricnaEnergija.equals("true")}"><td contenteditable="true">Untitled</td></g:if>
                </tr>
                <tr>
                    <td>Sektor industrije</td>
                    <td contenteditable="true" class="editable-td"></td>
                    <td contenteditable="true" class="editable-td"></td>
                    <g:if test="${elektricnaEnergija.equals("true")}"><td contenteditable="true">Untitled</td></g:if>
                </tr>
                <tr>
                    <td>Ostali sektori</td>
                    <td contenteditable="true" class="editable-td"></td>
                    <td contenteditable="true" class="editable-td"></td>
                    <g:if test="${elektricnaEnergija.equals("true")}"><td contenteditable="true">Untitled</td></g:if>
                <tr>
                    <td>Ukupno</td>
                    <td contenteditable="true" class="editable-td"></td>
                    <td contenteditable="true" class="editable-td"></td>
                    <g:if test="${elektricnaEnergija.equals("true")}"><td contenteditable="true">Untitled</td></g:if>
                </tr>
                </tbody>
            </table>
        </fieldset>

        <fieldset class="fieldset">
            <h5 style="text-align: center;color: #5777ad"><g:message code="izvjestaj.podaciPonudeEnergetskihUsluga.title"/></h5>
            <g:textArea name="izvjestaj.podaciPonudeEnergetskihUsluga" rows="5" cols="100"/><br/>

            <h5 style="text-align: center;color: #5777ad">${ponudeUgradnjaIndividualnihUredjaja}</h5>
            <g:textArea name="izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja" rows="5" cols="100"/><br/>

            <h5 style="text-align: center;color: #5777ad"><g:message code="izvjestaj.podaciOstaloEnergetskaEfikasnost.title"/></h5>
            <g:textArea name="izvjestaj.podaciOstaloEnergetskaEfikasnost" rows="5" cols="100"/><br/>
        </fieldset>

    </form>

    %{-- dodati dio koji kupi podatke sa forme, kod tabela uzeti u obzir koji je tip izvjestaja--}%
    <fieldset class="buttons">
        <button id="submitButton"><i class="fa fa-save"></i><g:message code="default.button.create.label"/></button>
    </fieldset>

</div>
</body>
</html>