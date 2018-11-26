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

        <fieldset class="fieldset">
            <legend style="width: 60%">${message(code: 'izvjestaj.preuzetaIsporucenaEnergija.fieldset.TE.title')}</legend>

            <div id="preuzetaIsporucenaTable" class="table-editable">
                <table id="table1" class="table">
                    <tr>
                        <th id="poslovniPotrosaciMwh" class="prety-th"><g:message code="izvjestaj.te.t1.col01"/></th>
                        <th id="stambeniPotrosaciMwh" class="prety-th"><g:message code="izvjestaj.te.t1.col02"/></th>
                        <th id="stambeniPotrosaciM2" class="prety-th"><g:message code="izvjestaj.te.t1.col03"/></th>
                        <th id="ukupnoIsporuceno" class="prety-th"><g:message code="izvjestaj.te.t1.col04"/></th>
                        <th id="gubici" scope="col" class="prety-th"><g:message code="izvjestaj.te.t1.col05"/></th>
                    </tr>
                    <tr>
                        <td class="editable-td" contenteditable="true"></td>
                        <td class="editable-td" contenteditable="true"></td>
                        <td class="editable-td" contenteditable="true"></td>
                        <td class="editable-td" contenteditable="true"></td>
                        <td class="editable-td" contenteditable="true"></td>
                    </tr>
                    <tfoot><tr></tr></tfoot> %{--needed becuase of script--}%
                </table>

                <g:render template="ukupnoIsporucenaEnergija" bean="izvjestaj"/>
            </div>
        </fieldset>

        <g:javascript library='jquery'>
            (function($) {
                $(document).ready(function() {
                    var $TABLE = $('#energentiTable');

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
                });
            })(jQuery);
        </g:javascript>
        <fieldset class="fieldset">
            <legend style="width: 50%"><g:message code="izvjestaj.podaci.energenti.fieldset.title"/></legend>

            <div id="energentiTable" class="table-editable">
                <span id="energenti" class="table-add fa fa-plus fa-2x"></span>
                <table id="table2" class="table">
                    <tr>
                        <th id="energent" class="prety-th"><g:message code="izvjestaj.te.t2.col01"/></th>
                        <th id="godisnjaUpotrebljenaKolicina" class="prety-th"><g:message code="izvjestaj.te.t2.col02"/></th>
                        <th id="jednicaMjere" class="prety-th"><g:message code="izvjestaj.te.t2.col03"/></th>
                    </tr>
                    <tr>
                        <td class="prety-th"><g:message code="izvjestaj.te.t2.row01"/></td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr>
                        <td class="prety-th"><g:message code="izvjestaj.te.t2.row02"/></td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr>
                        <td class="prety-th"><g:message code="izvjestaj.te.t2.row03"/></td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr>
                        <td class="prety-th"><g:message code="izvjestaj.te.t2.row04"/></td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr>
                        <td class="prety-th"><g:message code="izvjestaj.te.t2.row05"/></td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr>
                        <td class="prety-th"><g:message code="izvjestaj.te.t2.row06"/></td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr>
                        <td class="prety-th"><g:message code="izvjestaj.te.t2.row07"/></td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr>
                        <td class="prety-th"><g:message code="izvjestaj.te.t2.row08"/></td>
                        <td contenteditable="true" class="editable-td"></td>
                        <td contenteditable="true" class="editable-td"></td>
                    </tr>
                    <tr class="hide">
                        <td contenteditable="true" class="editable-td"><g:message code="izvjestaj.te.t2.row09"/></td>
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
                    var dataJSON = $("#formIzvjestaj").serialize();
                    var $TABLE1 = $('#preuzetaIsporucenaTable');
                    var $TABLE2 = $('#procjenaStanjaTable');
                    var $TABLE3 = $('#energentiTable');

                    dataJSON += createJSONData("izvjestaj.isporucenaToplotnaEnergija", $TABLE1);
                    dataJSON += createJSONData("izvjestaj.procjenaStanjaEnergetskeEfikasnostiList", $TABLE2);
                    dataJSON += createJSONData("izvjestaj.podaciEnergenti", $TABLE3);

                    $.ajax({
                        url: 'save',
                        type: 'post',
                        dataType: 'json',
                        async: false,
                        data: dataJSON,
                        success: function handleSuccess(data) {
                            if (data.theme === 'warning') { warningNotification({ title: data.title, message: data.message }); }
                            else if (data.theme === 'error') { errorNotification({ title: data.title, message: data.message }); }
                            else { successNotification({ title: data.title, message: data.message }); }
                            setTimeout(function() {
                                var path = window.location.pathname.split('/')[1];
                                if (path === 'izvjestaj') {
                                    window.location.href = '/izvjestaj/show/' + data.id;
                                }
                                else {
                                    window.location.href = '/' + path + '/izvjestaj/show/' + data.id;
                                }
                            }, 2000);
                        },
                        error: function handleError(data) {
                            if (data.theme === 'warning') { warningNotification({ title: data.title, message: data.message }); }
                            else if (data.theme === 'error') { errorNotification({ title: data.title, message: data.message }); }
                            else { successNotification({ title: data.title, message: data.message }); }
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
        <button id="submitButton"><i class="fa fa-save"></i>  <g:message code="default.button.create.label"/></button>
    </fieldset>
</div>
</body>
</html>