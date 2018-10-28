<!DOCTYPE html>
<html>
<head>
    <title><g:message code="izvjestaj.title"/></title>
    <meta name="layout" content="main"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <asset:javascript src="application.js"/>
</head>

<body>
<div id="create-izvjestaj" role="main">
    <h1 style="padding-left: 15px"><g:message code="izvjestaj.izmjeni.title"/></h1>
    <g:hiddenField id="editable" name="editable" value="${izvjestaj.status.equals(ba.giz.IzvjestajStatus.KREIRAN) || izvjestaj.status.equals(ba.giz.IzvjestajStatus.DORADA)}"/>
    <form id="formIzvjestaj">
        <g:hiddenField name="izvjestaj.id" value="${izvjestaj.id}"/>

        <g:render template="basicDataEdit" model="[izvjestaj: izvjestaj]"/>

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

                <g:render template="ukupnoIsporucenaEnergija" bean="izvjestaj" />
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

                    $('.energentiRemove').click(function() {
                        $(this).parents('tr').detach();
                    });

                    $('.energentiUp').click(function() {
                        var $row = $(this).parents('tr');
                        if ($row.index() === 1) return; // Don't go above the header
                        $row.prev().before($row.get(0));
                    });

                    $('.energentiDown').click(function() {
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
                    <g:each in="${izvjestaj.podaciEnergenti}" var="it" status="i">
                        <tr>
                            <td class="prety-th">${it?.energent}</td>
                            <td contenteditable="true" class="editable-td">${it?.godisnjaUpotrebljenaKolicina}</td>
                            <td contenteditable="true" class="editable-td">${it?.jednicaMjere}</td>
                            <g:if test="${i > 7}">
                                <td style="text-align:center">
                                    <span class="energentiRemove table-remove fa fa-trash fa-2x"></span>
                                </td>
                                <td style="text-align:center">
                                    <span class="energentiIsporucenaUp table-up fa fa-angle-up fa-2x" style="horiz-align: center;"></span>
                                </td>
                                <td style="text-align:center">
                                    <span class="energentiIsporucenaDown table-down fa fa-angle-down fa-2x" style="horiz-align: center;"></span>
                                </td>
                            </g:if>
                        </tr>
                    </g:each>
                    <tr class="hide">
                        <td contenteditable="true" class="editable-td prety-th"></td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td style="text-align:center">
                            <span class="energentiRemove table-remove fa fa-trash fa-2x"></span>
                        </td>
                        <td style="text-align:center">
                            <span class="energentiIsporucenaUp table-up fa fa-angle-up fa-2x" style="horiz-align: center;"></span>
                        </td>
                        <td style="text-align:center">
                            <span class="energentiIsporucenaDown table-down fa fa-angle-down fa-2x" style="horiz-align: center;"></span>
                        </td>
                    </tr>
                    <tfoot><tr></tr></tfoot> %{--needed becuase of script--}%
                </table>
            </div>
        </fieldset>

        <g:render template="procjenaStanjaTable" bean="izvjestaj"/>

        <g:render template="stepenMjerenjaTable" bean="izvjestaj"/>

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
                    var $TABLE3 = $('#energentiTable');

                    dataJSON += createJSONData("izvjestaj.isporucenaToplotnaEnergija", $TABLE1);
                    dataJSON += createJSONData("izvjestaj.procjenaStanjaEnergetskeEfikasnostiList", $TABLE2);
                    dataJSON += createJSONData("izvjestaj.podaciEnergenti", $TABLE3);

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
                        error: function handleError() {
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

    <g:render template="actionsMenuBar" bean="izvjestaj" />

</div>
</body>
</html>