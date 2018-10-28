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
    <h1><g:message code="izvjestaj.novi.title"/></h1>
     <form id="formIzvjestaj">

        <g:render template="basicDataCreate" model="[preduzece: preduzece]"/>

        %{-- funkcije koje rade dodavanje novog, brisanje i pomjeranje postojeceg reda za tabelu Preuzeta i isporucena EE --}%
        <g:javascript library='jquery'>
            (function($) {
                $(document).ready(function() {
                    var preuzetaIsporucena = "preuzetaIsporucena";
                    var $TABLE = $('#' + preuzetaIsporucena + 'Table');

                    $('#' + preuzetaIsporucena).click(function() {
                        var $clone = $TABLE.find('tr.hide').clone(true).removeClass('hide table-line');
                        $TABLE.find('table').append($clone);
                    });

                    $('#' + preuzetaIsporucena + 'Remove').click(function() {
                        $(this).parents('tr').detach();
                        calculateSumPreuzetaIsporucena();
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

        <g:render template="stepenMjerenjaTableEE" bean="izvjestaj"/>

        <g:render template="ostaliPodaci" bean="izvjestaj"/>

    </form>

    <g:javascript library='jquery'>
        (function($) {
            $(document).ready(function() {
                jQuery.fn.pop = [].pop;
                jQuery.fn.shift = [].shift;

                $('#submitButton').click(function() {
                    var dataJSON = $("#formIzvjestaj").serialize();
                    var $TABLE1 = $('#preuzetaIsporucenaTable');
                    var $TABLE2 = $('#procjenaStanjaTable');

                    dataJSON += createJSONData("izvjestaj.preuzetaIsporucenaEEList", $TABLE1);
                    dataJSON += createJSONData("izvjestaj.procjenaStanjaEnergetskeEfikasnostiList", $TABLE2);

                    $.ajax({
                        url: 'save',
                        type: 'post',
                        dataType: 'json',
                        async: false,
                        data: dataJSON,
                        success: function handleSuccess(data) {
                            successNotification({
                                title: data.title,
                                message: data.message
                            });
                            setTimeout(function() {
                                window.location.href = "/izvjestaj/show/" + data.id;
                            }, 2000);
                        },
                        error: function handleError(data) {
                            errorNotification({
                                title: data.title,
                                message: data.message
                            });
                        }
                    });
                });

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

                        var append = true;
                        returnValue += "{";
                        headers.forEach(function(header, i) {
                            if ($td.text() !== "") {
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
        <button id="submitButton"><i class="fa fa-save"></i> <g:message code="default.button.create.label"/></button>
    </fieldset>
</div>
</body>
</html>