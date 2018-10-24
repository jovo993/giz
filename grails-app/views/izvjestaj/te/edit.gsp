<!DOCTYPE html>
<html>
<head>
    <title><g:message code="izvjestaj.title"/></title>
    <meta name="layout" content="main"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <asset:javascript src="application.js"/>
</head>

<body>
<div id="create-izvjestaj" class="content scaffold-create" role="main">
    <h1><g:message code="izvjestaj.izmjeni.title"/></h1>
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
    <g:set var="isAdmin" value="${ba.giz.UserUtils.isUserAdmin(grails.util.Holders.applicationContext.getBean("springSecurityService").currentUser)}"/>
    <g:hiddenField id="editable" name="editable" value="${izvjestaj.status.equals(ba.giz.IzvjestajStatus.KREIRAN) || izvjestaj.status.equals(ba.giz.IzvjestajStatus.DORADA)}"/>
    <form id="formIzvjestaj">
        <fieldset class="fieldset" disabled>
            <legend><g:message code="preduzece.fieldset.title"/></legend>

            <label for="izvjestaj.preduzece.naziv"><g:message code="preduzece.naziv.title"/></label>
            <g:textField name="izvjestaj.preduzece.naziv" value="${izvjestaj.preduzece.naziv}"/><br/>

            <label for="izvjestaj.preduzece.sektor"><g:message code="preduzece.sektor.title"/></label>
            <g:select name="izvjestaj.preduzece.sektor" from="${ba.giz.Sektor.values()}" value="${izvjestaj?.preduzece?.sektor}"/><br/>

            <label><g:message code="preduzece.uloga.title"/></label>

            <label for="izvjestaj.preduzece.operater" style="width: 10%"><g:message code="preduzece.uloga.operater.title"/></label>
            <g:checkBox name="izvjestaj.preduzece.operater" value="${izvjestaj.preduzece?.uloga?.operater}" style="width: 5%"/>

            <label for="izvjestaj.preduzece.distributer" style="width: 10%"><g:message code="preduzece.uloga.distributer.title"/></label>
            <g:checkBox name="izvjestaj.preduzece.distributer" value="${izvjestaj.preduzece?.uloga?.distributer}" style="width: 5%"/>

            <label for="izvjestaj.preduzece.snabdjevac" style="width: 10%"><g:message code="preduzece.uloga.snabdjevac.title"/></label>
            <g:checkBox name="izvjestaj.preduzece.snabdjevac" value="${izvjestaj.preduzece?.uloga?.snabdjevac}" style="width: 5%"/>

            <label for="izvjestaj.preduzece.adresa"><g:message code="preduzece.adresa.title"/></label>
            <g:textField name="izvjestaj.preduzece.adresa" value="${izvjestaj.preduzece?.adresa}"/><br/>

            <label for="izvjestaj.preduzece.maticniBrojJedinstvenogRegistra"><g:message code="preduzece.maticni.title"/></label>
            <g:textField name="izvjestaj.preduzece.maticniBrojJedinstvenogRegistra" value="${izvjestaj.preduzece?.maticniBrojJedinstvenogRegistra}"/><br/>

            <label for="izvjestaj.preduzece.jib"><g:message code="preduzece.jib.title"/></label>
            <g:textField name="izvjestaj.preduzece.jib" value="${izvjestaj.preduzece?.jib}"/><br/>

            <label for="izvjestaj.preduzece.pib"><g:message code="preduzece.pib.title"/></label>
            <g:textField name="izvjestaj.preduzece.pib" value="${izvjestaj.preduzece?.pib}"/><br/>

            <label for="izvjestaj.preduzece.telefon"><g:message code="preduzece.telefon.title"/></label>
            <g:textField name="izvjestaj.preduzece.telefon" value="${izvjestaj.preduzece?.telefon}"/><br/>

            <label for="izvjestaj.preduzece.fax"><g:message code="preduzece.fax.title"/></label>
            <g:textField name="izvjestaj.preduzece.fax" value="${izvjestaj.preduzece?.fax}"/><br/>

            <label for="izvjestaj.preduzece.email"><g:message code="preduzece.email.title"/></label>
            <g:textField name="izvjestaj.preduzece.email" value="${izvjestaj.preduzece?.email}"/><br/>

            <label for="izvjestaj.preduzece.brojZaposlenih"><g:message code="preduzece.brojzaposlenih.title"/></label>
            <g:textField name="izvjestaj.preduzece.brojZaposlenih" value="${izvjestaj.preduzece?.brojZaposlenih}"/><br/>

            <label for="izvjestaj.preduzece.ukupanGodisnjiPromet"><g:message code="preduzece.promet.title"/></label>
            <g:textField name="izvjestaj.preduzece.ukupanGodisnjiPromet" value="${izvjestaj.preduzece?.ukupanGodisnjiPromet}"/><br/>

            <p><g:message code="izvjestaj.fusnota"/></p>
        </fieldset>

        <fieldset class="fieldset">
            <g:hiddenField name="izvjestaj.id" value="${id}"/>
            <legend style="width: 60%"><g:message code="podaciDozvolaObavljanjeDjelatnosti.fieldset.title"/></legend>

            <label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj.title"/>
            </label>
            <g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaRegistarskiBroj"/><br/>

            <label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija.title"/>
            </label>
            <g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaKomisija"/><br/>

            <label>
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje.title"/>
            </label>
            <input name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.distribucijaDatumPocetkaVazenje" type="date"
                   value="${izvjestaj.podaciDozvolaObavljanjeDjelatnosti?.distribucijaDatumPocetkaVazenje?.format("yyyy-mm-dd")}"/><br/>

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

            <label>
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje.title"/>
            </label>
            <input name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjeDatumPocetkaVazenje" type="date"
                   value="${izvjestaj.podaciDozvolaObavljanjeDjelatnosti?.snabdijevanjeDatumPocetkaVazenje?.format("yyyy-mm-dd")}"/></br>

            <label for="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja">
                <g:message code="podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja.title"/>
            </label>
            <g:textField name="izvjestaj.podaciDozvolaObavljanjeDjelatnosti.snabdijevanjePeriodVazenja"/><br/>
        </fieldset>

        <fieldset class="fieldset">
            <legend style="width: 40%"><g:message code="podaciPodnosenjeIzvjestaja.fieldset.title"/></legend>

            <label for="izvjestaj.podaciPodnosenjeIzvjestaja.godina"><g:message code="podaciPodnosenjeIzvjestaja.godina.title"/></label>
            <g:select name="izvjestaj.podaciPodnosenjeIzvjestaja.godina" from="${ba.giz.Godina.findAll()}" value="${izvjestaj.podaciPodnosenjeIzvjestaja?.godina}" style="width: 5%"/><br/>

            <label for="izvjestaj.podaciPodnosenjeIzvjestaja.prezimeImePozicija"><g:message code="podaciPodnosenjeIzvjestaja.prezimeImePozicija.title"/></label>
            <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.prezimeImePozicija" value="${izvjestaj.podaciPodnosenjeIzvjestaja?.prezimeImePozicija}"/><br/>

            <label for="izvjestaj.podaciPodnosenjeIzvjestaja.telefon"><g:message code="podaciPodnosenjeIzvjestaja.telefon.title"/></label>
            <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.telefon" value="${izvjestaj.podaciPodnosenjeIzvjestaja?.telefon}"/><br/>

            <label for="izvjestaj.podaciPodnosenjeIzvjestaja.email"><g:message code="podaciPodnosenjeIzvjestaja.email.title"/></label>
            <g:textField name="izvjestaj.podaciPodnosenjeIzvjestaja.email" value="${izvjestaj.podaciPodnosenjeIzvjestaja?.email}"/><br/>
        </fieldset>

        <fieldset class="fieldset">
            <legend style="width: 60%">${message(code: 'izvjestaj.preuzetaIsporucenaEnergija.fieldset.TE.title')}</legend>

            <div id="preuzetaIsporucenaTable" class="table-editable">
                <table id="table1" class="table">
                    <tr>
                        <th id="poslovniPotrosaciMwh" class="prety-th">Poslovni potrošači po MWh</th>
                        <th id="stambeniPotrosaciMwh" class="prety-th">Stambeni potrošači po MWh</th>
                        <th id="stambeniPotrosaciM2" class="prety-th">Stambeni potrošači po m3</th>
                        <th id="ukupnoIsporuceno" class="prety-th">UKUPNO ISPORUČENO</th>
                        <th id="gubici" scope="col" class="prety-th">GUBICI (%)</th>
                    </tr>
                    <tr>
                        <td class="editable-td" contenteditable="true">${izvjestaj.isporucenaToplotnaEnergija?.poslovniPotrosaciMwh}</td>
                        <td class="editable-td" contenteditable="true">${izvjestaj.isporucenaToplotnaEnergija?.stambeniPotrosaciMwh}</td>
                        <td class="editable-td" contenteditable="true">${izvjestaj.isporucenaToplotnaEnergija?.stambeniPotrosaciM2}</td>
                        <td class="editable-td" contenteditable="true">${izvjestaj.isporucenaToplotnaEnergija?.ukupnoIsporuceno}</td>
                        <td class="editable-td" contenteditable="true">${izvjestaj.isporucenaToplotnaEnergija?.gubici}</td>
                    </tr>
                </table>

                <div class="prety-th" style="text-align: right; padding: 5px">
                    Ukupno isporučena energija krajnjim kupcima u TJ:  <input name="izvjestaj.ukupnoIsporucenaEnergija" value="${izvjestaj.ukupnoIsporucenaEnergija}">
                </div>
            </div>
        </fieldset>

        <g:javascript library='jquery'>
            (function($) {
                $(document).ready(function() {
                    var $TABLE = $('#energentiTable');

                    if (editable.value === 'false') {
                        disableAndHideFields();
                    }

                    $('#energenti').click(function() {
                        var $clone = $TABLE.find('tr.hide').clone(true).removeClass('hide table-line');
                        $TABLE.find('table').append($clone);
                    });

                    $('#energentiRemove').click(function() {
                        $(this).parents('tr').detach();
                    });

                    $('#energentiUp').click(function() {
                        var $row = $(this).parents('tr');
                        if ($row.index() === 1) return; // Don't go above the header
                        $row.prev().before($row.get(0));
                    });

                    $('#energentiDown').click(function() {
                        var $row = $(this).parents('tr');
                        $row.next().after($row.get(0));
                    });

                    function disableAndHideFields() {
                        $('.editable-td').each(function() {
                            $(this).prop('contentEditable', false);
                        });
                        $('.fieldset').each(function() {
                            $(this).prop('disabled', true);
                        });
                        $('.table-add, .table-remove, .table-up, .table-down').each(function() {
                            $(this).hide();
                        });
                    }
                });
            })(jQuery);
        </g:javascript>
        <fieldset class="fieldset">
            <legend style="width: 50%"><g:message code="izvjestaj.podaci.energenti.fieldset.title"/></legend>

            <div id="energentiTable" class="table-editable">
                <span id="energenti" class="table-add fa fa-plus fa-2x"></span>
                <table id="table2" class="table">
                    <tr>
                        <th id="energent" class="prety-th">Energent</th>
                        <th id="godisnjaUpotrebljenaKolicina" class="prety-th">Godišnja upotrijebljena količina</th>
                        <th id="jednicaMjere" class="prety-th">Jedinica mjere</th>
                    </tr>
                    <tr>
                        <td class="prety-th">Prirodni gas (uključujući i tečni prirodni gas)</td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr>
                        <td class="prety-th">Tečni naftni gas</td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr>
                        <td class="prety-th">Goriva za grijanje i hlađenje</td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr>
                        <td class="prety-th">Ugalj i lignit</td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr>
                        <td class="prety-th">Treset</td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr>
                        <td class="prety-th">Gorivo za pogon motornih vozila</td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr>
                        <td class="prety-th">Bio-masa</td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr>
                        <td class="prety-th">Obnovljivi izvor energije</td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr class="hide">
                        <td contenteditable="true" class="editable-td prety-th">Ostalo</td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td style="text-align:center">
                            <span id="energentiRemove" class="table-remove fa fa-trash fa-2x"></span>
                        </td>
                        <td style="text-align:center">
                            <span id="energentiIsporucenaUp" class="table-up fa fa-angle-up fa-2x" style="horiz-align: center;"></span>
                        </td>
                        <td style="text-align:center">
                            <span id="energentiIsporucenaDown" class="table-down fa fa-angle-down fa-2x" style="horiz-align: center;"></span>
                        </td>
                    </tr>
                    <tfoot><tr></tr></tfoot> %{--needed becuase of script--}%
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

                    $('.pst-remove').click(function() {
                        $(this).parents('tr').detach();
                    });

                    $('.pst-up').click(function() {
                        var $row = $(this).parents('tr');
                        if ($row.index() === 1) return; // Don't go above the header
                        $row.prev().before($row.get(0));
                    });

                    $('.pst-down').click(function() {
                        var $row = $(this).parents('tr');
                        $row.next().after($row.get(0));
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
                <tr>
                    <g:each in="${izvjestaj.procjenaStanjaEnergetskeEfikasnostiList}" var="bean" status="i">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td class="editable-td" contenteditable="true">${bean.primjenjenaMjera}</td>
                            <td class="editable-td" contenteditable="true">${bean.vrstaUstede}</td>
                            <td class="editable-td" contenteditable="true">${bean.kolicinaUstede}</td>
                            <td style="text-align:center">
                                <span class="pst-remove table-remove fa fa-trash fa-2x"></span>
                            </td>
                            <td style="text-align:center">
                                <span class="pst-up table-up fa fa-angle-up fa-2x" style="horiz-align: center;"></span>
                            </td>
                            <td style="text-align:center">
                                <span class="pst-down table-down fa fa-angle-down fa-2x" style="horiz-align: center;"></span>
                            </td>
                        </tr>
                    </g:each>
                    <tr class="hide">
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td style="text-align:center">
                            <span class="pst-remove table-remove fa fa-trash fa-2x"></span>
                        </td>
                        <td style="text-align:center">
                            <span class="pst-up table-up fa fa-angle-up fa-2x" style="horiz-align: center;"></span>
                        </td>
                        <td style="text-align:center">
                            <span class="pst-down table-down fa fa-angle-down fa-2x" style="horiz-align: center;"></span>
                        </td>
                    </tr>
                    <tfoot><tr></tr></tfoot> %{--needed because of script--}%
                </table>
            </div>
        </fieldset>

        <g:javascript library='jquery'>
            (function($) {
                $(document).ready(function() {
                    calculateSumStepenMjerenja();

                    calculateSumStepenMjerenja($(this).context.className);
                    // sumiranje
                    for (var i = 1; i < 3; i++) {
                        $('.rowDataSdSmt' + i).each(function() {
                            $(this).on('change', function() {
                                calculateSumStepenMjerenja($(this).context.className);
                            });
                        });
                    }

                    function calculateSumStepenMjerenja(className) {
                        if (className) {
                            var total = 0;
                            $('.' + className).each(function() {
                                total += $(this).val() * 1;
                            });
                            $('.colSumSmt' + className.substr(className.length - 1)).get(0).value = total;
                        }
                        else {
                            for (var i = 1; i < 3; i++) {
                                var total = 0;
                                $('.rowDataSdSmt' + i).each(function() {
                                    total += $(this).val() * 1;
                                });
                                $('.colSumSmt' + i).get(0).value = total;
                            }
                        }
                    }
                });
            })(jQuery);
        </g:javascript>
        <fieldset class="fieldset">
            <legend style="width: 80%"><g:message code="izvjestaj.podaciStepenMjerenja.TE.fieldset.title"/></legend>

            <div id="stepenMjerenjaTable" class="table-editable">
                <table class="table table-bordered table-secondary">
                    <thead>
                    <tr>
                        <th scope="col" style="width: 25%; vertical-align: middle;">&nbsp;</th>
                        <th scope="col" class="prety-th"><g:message code="tabela.stepenMjerenja.TE.th1"/></th>
                        <th scope="col" class="prety-th"><g:message code="tabela.stepenMjerenja.EE.th2"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="prety-th">Sektor domaćinstva</td>
                        <td><input class="rowDataSdSmt1" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoBrojMjerenjePotrosnje"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.domacinstvoBrojMjerenjePotrosnje}"></td>
                        <td><input class="rowDataSdSmt2" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoUkupanBroj"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.domacinstvoUkupanBroj}"></td>
                    </tr>
                    <tr>
                        <td class="prety-th">Sektor industrije</td>
                        <td><input class="rowDataSdSmt1" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaBrojMjerenjePotrosnje"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.industrijaBrojMjerenjePotrosnje}"></td>
                        <td><input class="rowDataSdSmt2" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaUkupanBroj"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.industrijaUkupanBroj}"></td>
                    </tr>
                    <tr>
                        <td class="prety-th">Ostali sektori</td>
                        <td><input class="rowDataSdSmt1" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloBrojMjerenjePotrosnje"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.ostaloBrojMjerenjePotrosnje}"></td>
                        <td><input class="rowDataSdSmt2" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloUkupanBroj"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.ostaloUkupanBroj}"></td>
                    <tr>
                        <td class="prety-th">Ukupno</td>
                        <td><input class="colSumSmt1" disabled="" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojMjerenjePotrosnje"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.ukupnoBrojMjerenjePotrosnje}"></td>
                        <td><input class="colSumSmt2" disabled="" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojKrajnjihKupaca"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.ukupnoBrojKrajnjihKupaca}"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>

        <fieldset class="fieldset">
            <h5 style="text-align: center;color: #5777ad"><g:message code="izvjestaj.podaciPonudeEnergetskihUsluga.title"/></h5>
            <g:textArea name="izvjestaj.podaciPonudeEnergetskihUsluga" value="${izvjestaj.podaciPonudeEnergetskihUsluga}" rows="5" cols="100"/><br/>

            <h5 style="text-align: center;color: #5777ad"><g:message code="izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja.TE.title"/></h5>
            <g:textArea name="izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja" value="${izvjestaj.podaciPonudeUgradnjaIndividualnihUredjaja}" rows="5" cols="100"/><br/>

            <h5 style="text-align: center;color: #5777ad"><g:message code="izvjestaj.podaciOstaloEnergetskaEfikasnost.title"/></h5>
            <g:textArea name="izvjestaj.podaciOstaloEnergetskaEfikasnost" value="${izvjestaj.podaciOstaloEnergetskaEfikasnost}" rows="5" cols="100"/><br/>
        </fieldset>

    </form>

    <g:javascript library='jquery'>
        (function($) {
            $(document).ready(function() {
                jQuery.fn.pop = [].pop;
                jQuery.fn.shift = [].shift;

                var $BTN = $('#submitButton');
                var $SENDBTN = $('#posaljiButton');

                $BTN.click(function() {
                    var dataJSON = $("#formIzvjestaj").serialize();
                    var $TABLE1 = $('#preuzetaIsporucenaTable');
                    var $TABLE2 = $('#procjenaStanjaTable');
                    var $TABLE3 = $('#energentiTable');

                    dataJSON += createJSONData("izvjestaj.isporucenaToplotnaEnergija", $TABLE1);
                    dataJSON += createJSONData("izvjestaj.procjenaStanjaEnergetskeEfikasnostiList", $TABLE2);
                    dataJSON += createJSONData("izvjestaj.podaciEnergenti", $TABLE3);

                    var url="${createLink(controller: 'izvjestaj', action: 'update')}";

                    $.ajax({
                        url: url,
                        type: 'post',
                        dataType: 'json',
                        data: dataJSON,
                        async: false,
                        success: success()
                    });
                });

                $SENDBTN.click(function() {
                    var dataJSON = $("#formIzvjestaj").serialize();
                    var $TABLE1 = $('#preuzetaIsporucenaTable');
                    var $TABLE2 = $('#procjenaStanjaTable');
                    var $TABLE3 = $('#energentiTable');

                    dataJSON += createJSONData("izvjestaj.isporucenaToplotnaEnergija", $TABLE1);
                    dataJSON += createJSONData("izvjestaj.procjenaStanjaEnergetskeEfikasnostiList", $TABLE2);
                    dataJSON += createJSONData("izvjestaj.podaciEnergenti", $TABLE3);

                    var url="${createLink(controller: 'izvjestaj', action: 'send')}";

                    $.ajax({
                        url: url,
                        type: 'post',
                        dataType: 'json',
                        data: dataJSON,
                        async: false,
                        success: success()
                    });
                });

                function success() {
                  window.location="<g:createLink controller="izvjestaj" action="show" params="[id: this.izvjestaj.id]"/>";
                }

                function createJSONData(argument, table) {
                    var headers = [], returnValue = '';
                    var $header = table.find('tr:first');
                    var $rows = table.find('tr:not(:hidden):not(:last)');

                    $header.find('th:not(:empty)').each(function() {
                        if (this.id.length > 0) {
                            headers.push(this.id);
                        }
                    });

                    $rows.each(function() {
                        var $td = $(this).find('td');
                        var h = {};

                        var append = true;
                        returnValue += "{";
                        headers.forEach(function(header, i) {
                            if ($td.text() !== "") {
                                h[header] = $td.eq(i).text();
                                returnValue += '"' + header + '"' + ":" + '"' + $td.eq(i).text() + '"' + ",";
                            }
                            else {
                                append = false;
                            }
                        });

                        returnValue = returnValue.substr(0, returnValue.length - 1);
                        if (append) {
                            returnValue += '},';
                        }
                    });
                    returnValue = returnValue.substr(0, returnValue.length - 1);

                    return '&' + argument + '=[' + returnValue + ']';
                }

            });
        })(jQuery);
    </g:javascript>
    <fieldset class="buttons">
        <g:if test="${izvjestaj.status.equals(ba.giz.IzvjestajStatus.KREIRAN) || izvjestaj.status.equals(ba.giz.IzvjestajStatus.DORADA)}">
            <button id="submitButton"><i class="fa fa-edit"></i>  <g:message code="default.button.edit.label"/></button>
            <button id="posaljiButton"><i class="fa fa-share-square"></i>   <g:message code="default.button.send.label"/></button>
        </g:if>
        <g:if test="${izvjestaj.status.equals(ba.giz.IzvjestajStatus.POSLAN) && this.isAdmin}">
            <g:link controller="izvjestaj" action="vratiNaDoradu" params="[id: izvjestaj.id]">
                <button id="vratiNaDoraduButton"><i class="fa fa-arrow-alt-circle-left"></i>   <g:message code="default.button.dorada.label"/></button>
            </g:link>
            <g:link controller="izvjestaj" action="verifikuj" params="[id: izvjestaj.id]">
                <button id="verifikujButton"><i class="fa fa-check-circle"></i>   <g:message code="default.button.verifikuj.label"/></button>
            </g:link>
        </g:if>
    </fieldset>

</div>
</body>
</html>