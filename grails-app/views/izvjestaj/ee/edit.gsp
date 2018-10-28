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
    <g:hiddenField id="editable" name="editable" value="${izvjestaj.status.equals(ba.giz.IzvjestajStatus.KREIRAN) || izvjestaj.status.equals(ba.giz.IzvjestajStatus.DORADA)}"/>
    <form id="formIzvjestaj">
        <g:hiddenField name="izvjestaj.id" value="${izvjestaj.id}"/>
        <g:render template="basicDataEdit" model="[izvjestaj: izvjestaj]"/>

        %{-- funkcije koje rade dodavanje novog, brisanje i pomjeranje postojeceg reda za tabelu Preuzeta i isporucena EE --}%
        <g:javascript library='jquery'>
            (function($) {
                $(document).ready(function() {
                    var preuzetaIsporucena = "preuzetaIsporucena";
                    var $TABLE = $('#' + preuzetaIsporucena + 'Table');

                    if (editable.value === 'false') {
                        disableAndHideFields();
                    }

                    calculateSumPreuzetaIsporucena();

                    $('#' + preuzetaIsporucena).click(function() {
                        var $clone = $TABLE.find('tr.hide').clone(true).removeClass('hide table-line');
                        $TABLE.find('table').append($clone);
                    });

                    $('.table-remove').click(function() {
                        $(this).parents('tr').detach();
                        calculateSumPreuzetaIsporucena();
                    });

                    $('table-up').click(function() {
                        var $row = $(this).parents('tr');
                        if ($row.index() === 1)
                            return;
                        $row.prev().before($row.get(0));
                    });

                    $('.table-down').click(function() {
                        var $row = $(this).parents('tr');
                        $row.next().after($row.get(0));
                    });

                    // sumiranje
                    for (var i = 1; i < $('#table1').find('tr:eq(1) td').length; i++) {
                        $('td.rowDataSd:eq(' + i + ')', 'tr').each(function() {
                            $(this).on('input', function() {
                                calculateSumPreuzetaIsporucena($(this).context.cellIndex);
                            });
                        });
                    }

                    function calculateSumPreuzetaIsporucena(index) {
                        if (index) {
                            var total = 0;
                            $('td.rowDataSd:eq(' + index + ')', 'tr').each(function() {
                                total += $(this).text() * 1;
                            });
                            $('#table1').find('tr:last td').eq(index).text(total.toFixed(3));
                        }
                        else {
                            // sumiranje
                            for (var i = 1; i < $('#table1').find('tr:eq(1) td').length; i++) {
                                var total = 0;
                                $('td.rowDataSd:eq(' + i + ')', 'tr').each(function() {
                                    total += $(this).text() * 1;
                                });
                                $('#table1').find('tr:last td').eq(i).text(total.toFixed(3));
                            }
                        }
                    }

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
            <legend style="width: 60%">${message(code: 'izvjestaj.preuzetaIsporucenaEnergija.fieldset.EE.title')}</legend>

            <div id="preuzetaIsporucenaTable" class="table-editable">
                <span id="preuzetaIsporucena" class="table-add fa fa-plus fa-2x"></span>
                <table id="table1" class="table">
                    <tr>
                        <th id="radnaJedinica" class="prety-th" style="width: 10%">Radna jedinica</th>
                        <th id="preuzetaElektricnaEnergija" class="prety-th" style="width: 10%">PREUZETA ELEKTRIČNA ENERGIJA (MWh)</th>
                        <th id="potrosnjaNa110kV" class="prety-th" style="width: 10%">potrošnja na 110 kV naponu</th>
                        <th id="potrosnjaNa35kV" class="prety-th" style="width: 10%">potrošnja na 35 kV naponu</th>
                        <th id="potrosnjaNa1Do35kV" class="prety-th" style="width: 10%">potrošnja na naponskom nivou od 1 kV do 35 kV</th>
                        <th id="potrosnjaOstala" class="prety-th" style="width: 10%">ostala potrošnja na niskom naponu (0.4kV)</th>
                        <th id="potrosnjaDomacinstva" class="prety-th" style="width: 10%">domaćinstva (0.4kV)</th>
                        <th id="potrosnjaJavnaRasvjeta" class="prety-th" style="width: 10%">javna rasvjeta (0.4kV)</th>
                        <th id="ukupnoIsporuceno" class="prety-th" style="width: 10%">UKUPNO ISPORUČENO</th>
                        <th id="gubici" class="prety-th" style="width: 10%">GUBICI (%)</th>
                    </tr>
                    <g:each in="${izvjestaj.preuzetaIsporucenaEEList}" var="it">
                        <tr>
                            <td class="editable-td rowDataSd" contenteditable="true">${it.radnaJedinica}</td>
                            <td class="editable-td rowDataSd" contenteditable="true">${it.preuzetaElektricnaEnergija}</td>
                            <td class="editable-td rowDataSd" contenteditable="true">${it.potrosnjaNa110kV}</td>
                            <td class="editable-td rowDataSd" contenteditable="true">${it.potrosnjaNa35kV}</td>
                            <td class="editable-td rowDataSd" contenteditable="true">${it.potrosnjaNa1Do35kV}</td>
                            <td class="editable-td rowDataSd" contenteditable="true">${it.potrosnjaOstala}</td>
                            <td class="editable-td rowDataSd" contenteditable="true">${it.potrosnjaDomacinstva}</td>
                            <td class="editable-td rowDataSd" contenteditable="true">${it.potrosnjaJavnaRasvjeta}</td>
                            <td class="editable-td rowDataSd" contenteditable="true">${it.ukupnoIsporuceno}</td>
                            <td class="editable-td rowDataSd" contenteditable="true">${it.gubici}</td>
                            <td style="text-align:center">
                                <span class="table-remove fa fa-trash fa-2x"></span>
                            </td>
                            <td style="text-align:center">
                                <span class="table-up fa fa-angle-up fa-2x" style="horiz-align: center;"></span>
                            </td>
                            <td style="text-align:center">
                                <span class="table-down fa fa-angle-down fa-2x" style="horiz-align: center;"></span>
                            </td>
                        </tr>
                    </g:each>
                    <tr class="hide">
                        <td class="editable-td rowDataSd" contenteditable="true"></td>
                        <td class="editable-td rowDataSd" contenteditable="true"></td>
                        <td class="editable-td rowDataSd" contenteditable="true"></td>
                        <td class="editable-td rowDataSd" contenteditable="true"></td>
                        <td class="editable-td rowDataSd" contenteditable="true"></td>
                        <td class="editable-td rowDataSd" contenteditable="true"></td>
                        <td class="editable-td rowDataSd" contenteditable="true"></td>
                        <td class="editable-td rowDataSd" contenteditable="true"></td>
                        <td class="editable-td rowDataSd" contenteditable="true"></td>
                        <td class="editable-td rowDataSd" contenteditable="true"></td>
                        <td style="text-align:center">
                            <span class="table-remove fa fa-trash fa-2x"></span>
                        </td>
                        <td style="text-align:center">
                            <span class="table-up fa fa-angle-up fa-2x" style="horiz-align: center;"></span>
                        </td>
                        <td style="text-align:center">
                            <span class="table-down fa fa-angle-down fa-2x" style="horiz-align: center;"></span>
                        </td>
                    </tr>
                    <tfoot>
                    <tr>
                        <td style="vertical-align: middle; text-align: center;">UKUPNO</td>
                        <td style="vertical-align: middle; text-align: center;" class="totalCol"></td>
                        <td style="vertical-align: middle; text-align: center;" class="totalCol"></td>
                        <td style="vertical-align: middle; text-align: center;" class="totalCol"></td>
                        <td style="vertical-align: middle; text-align: center;" class="totalCol"></td>
                        <td style="vertical-align: middle; text-align: center;" class="totalCol"></td>
                        <td style="vertical-align: middle; text-align: center;" class="totalCol"></td>
                        <td style="vertical-align: middle; text-align: center;" class="totalCol"></td>
                        <td style="vertical-align: middle; text-align: center;" class="totalCol"></td>
                        <td style="vertical-align: middle; text-align: center;" class="totalCol"></td>
                    </tr>
                    </tfoot>
                </table>

                <g:render template="ukupnoIsporucenaEnergija" bean="izvjestaj" />
            </div>
        </fieldset>

        <g:render template="procjenaStanjaTable" bean="izvjestaj"/>


        <g:javascript library='jquery'>
            (function($) {
                $(document).ready(function() {
                    calculateSumStepenMjerenja();

                    // sumiranje
                    for (var i = 1; i < 4; i++) {
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
                            for (var i = 1; i < 4; i++) {
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
            <legend style="width: 80%"><g:message code="izvjestaj.podaciStepenMjerenja.EE.fieldset.title"/></legend>

            <div id="stepenMjerenjaTable" class="table-editable">
                <table id="smt" class="table table-bordered table-secondary">
                    <thead>
                    <tr>
                        <th scope="col" style="width: 25%; vertical-align: middle;">&nbsp;</th>
                        <th scope="col" class="prety-th"><g:message code="tabela.stepenMjerenja.EE.th1"/></th>
                        <th scope="col" class="prety-th"><g:message code="tabela.stepenMjerenja.EE.th2"/></th>
                        <th scope="col" class="prety-th"><g:message code="tabela.stepenMjerenja.EE.th3"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="prety-th">Sektor domaćinstva</td>
                        <td><input class="rowDataSdSmt1" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoBrojMjerenjePotrosnje"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.domacinstvoBrojMjerenjePotrosnje}"></td>
                        <td><input class="rowDataSdSmt2" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoUkupanBroj"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.domacinstvoUkupanBroj}"></td>
                        <td><input class="rowDataSdSmt3" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoBrojDaljinskoOcitavanje"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.domacinstvoBrojDaljinskoOcitavanje}"></td>
                    </tr>
                    <tr>
                        <td class="prety-th">Sektor industrije</td>
                        <td><input class="rowDataSdSmt1" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaBrojMjerenjePotrosnje"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.industrijaBrojMjerenjePotrosnje}"></td>
                        <td><input class="rowDataSdSmt2" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaUkupanBroj"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.industrijaUkupanBroj}"></td>
                        <td><input class="rowDataSdSmt3" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaBrojDaljinskoOcitavanje"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.industrijaBrojDaljinskoOcitavanje}"></td>
                    </tr>
                    <tr>
                        <td class="prety-th">Ostali sektori</td>
                        <td><input class="rowDataSdSmt1" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloBrojMjerenjePotrosnje"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.ostaloBrojMjerenjePotrosnje}"></td>
                        <td><input class="rowDataSdSmt2" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloUkupanBroj"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.ostaloUkupanBroj}"></td>
                        <td><input class="rowDataSdSmt3" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloBrojDaljinskoOcitavanje"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.ostaloBrojDaljinskoOcitavanje}"></td>
                    <tr>
                        <td class="prety-th">Ukupno</td>
                        <td><input class="colSumSmt1" disabled="" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojMjerenjePotrosnje"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.ukupnoBrojMjerenjePotrosnje}"></td>
                        <td><input class="colSumSmt2" disabled="" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojKrajnjihKupaca"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.ukupnoBrojKrajnjihKupaca}"></td>
                        <td><input class="colSumSmt3" disabled="" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojDaljinskoOcitavanje"
                                   value="${izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca?.ukupnoBrojDaljinskoOcitavanje}"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>

        <g:render template="ostaliPodaci" bean="izvjestaj"/>

    </form>

    <g:javascript library='jquery'>
        (function($) {
            $(document).ready(function() {
                jQuery.fn.pop = [].pop;
                jQuery.fn.shift = [].shift;

                $('#submitButton').click(function() {
                    handleButtonClick("${createLink(controller: 'izvjestaj', action: 'update')}", 'ažuriran');
                });

                $('#posaljiButton').click(function() {
                    handleButtonClick("${createLink(controller: 'izvjestaj', action: 'posalji')}", 'poslan');

                });
                
                function handleButtonClick(url, message) {
                    var dataJSON = $("#formIzvjestaj").serialize();
                    var $TABLE1 = $('#preuzetaIsporucenaTable');
                    var $TABLE2 = $('#procjenaStanjaTable');

                    dataJSON += createJSONData("izvjestaj.preuzetaIsporucenaEEList", $TABLE1);
                    dataJSON += createJSONData("izvjestaj.procjenaStanjaEnergetskeEfikasnostiList", $TABLE2);

                    $.ajax({
                        url: url,
                        type: 'post',
                        dataType: 'json',
                        async: false,
                        data: dataJSON,
                        success: function handleSuccess(data) {
                            successNotification({
                              title: data.title,
                              message: data.message
                           });
                            if(message === 'poslan') {
                              setTimeout(function() {window.location.href="/izvjestaj/show/" + ${this.izvjestaj.id} ;}, 2000);
                            }
                         },
                        error: function handleError(data) {
                            errorNotification({
                              title: data.title,
                              message: data.message
                          });
                        }
                    });
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

    <g:render template="actionsMenuBar" bean="izvjestaj"/>
</div>
</body>
</html>