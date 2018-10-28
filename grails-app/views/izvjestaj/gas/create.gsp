<%@ page import="ba.giz.Sektor" %>
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
            <legend style="width: 60%">${message(code: 'izvjestaj.preuzetaIsporucenaEnergija.fieldset.G.title')}</legend>

            <div id="preuzetaIsporucenaTable" class="table-editable">
                <table id="table1" class="table">
                    <tr>
                        <th id="preuzetaKolicina" class="prety-th">PREUZETE KOLIČINE GASA (Sm3)</th>
                        <th id="industrijskiPotrosaci" class="prety-th">Industrijski potrošači</th>
                        <th id="sistemiDaljinskoGrijanja" class="prety-th">Sistemi daljinskog grijanja</th>
                        <th id="komercijalniKrajnjiKupci" class="prety-th">Komercijalni krajnji kupci</th>
                        <th id="domacinstva" class="prety-th">Domaćinstva</th>
                        <th id="ukupnoIsporuceno" class="prety-th">UKUPNO ISPORUČENO</th>
                        <th id="gubici" class="prety-th">GUBICI (%)</th>
                    </tr>
                    <tr>
                        <td class="editable-td" contenteditable="true"></td>
                        <td class="editable-td" contenteditable="true"></td>
                        <td class="editable-td" contenteditable="true"></td>
                        <td class="editable-td" contenteditable="true"></td>
                        <td class="editable-td" contenteditable="true"></td>
                        <td class="editable-td" contenteditable="true"></td>
                        <td class="editable-td" contenteditable="true"></td>
                    </tr>
                    <tfoot><tr></tr></tfoot>
                </table>

                <g:render template="ukupnoIsporucenaEnergija" bean="izvjestaj" />
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

                    dataJSON += createJSONData("izvjestaj.preuzetIsporucenGas", $TABLE1);
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
        <button id="submitButton"><i class="fa fa-save"></i>  <g:message code="default.button.create.label"/></button>
    </fieldset>

</div>
</body>
</html>