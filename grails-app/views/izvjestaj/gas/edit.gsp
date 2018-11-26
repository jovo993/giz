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
    <h1><g:message code="${izvjestaj.status.equals(ba.giz.IzvjestajStatus.KREIRAN) && !isUserAdmin ? 'izvjestaj.izmjeni.title' : 
                           izvjestaj.status.equals(ba.giz.IzvjestajStatus.DORADA) && !isUserAdmin ? 'izvjestaj.izmjeni.title' : 
                           izvjestaj.status.equals(ba.giz.IzvjestajStatus.POSLAN) && !isUserAdmin ? 'izvjestaj.pregled.title' : 
                           izvjestaj.status.equals(ba.giz.IzvjestajStatus.VERIFIKOVAN) && !isUserAdmin ? 'izvjestaj.pregled.title' : 
                           izvjestaj.status.equals(ba.giz.IzvjestajStatus.ZAVRSEN) && !isUserAdmin ? 'izvjestaj.pregled.title' : 
                           izvjestaj.status.equals(ba.giz.IzvjestajStatus.STORNIRAN) && !isUserAdmin ? 'izvjestaj.pregled.title' : 
                           'izvjestaj.pregled.title'}"/>&nbsp;
   </h1><h5 style="font-size: 0.8em;">
                           (<g:message code="${'izvjestaj.trenutnistatus.title'}"/>&nbsp;
                           <g:message code="ba.giz.IzvjestajStatus.${izvjestaj.status}"/>)
    </h5>
    <g:hiddenField id="editable" name="editable" value="${!isUserAdmin && (izvjestaj.status.equals(ba.giz.IzvjestajStatus.KREIRAN) || izvjestaj.status.equals(ba.giz.IzvjestajStatus.DORADA))}"/>
    <form id="formIzvjestaj">
        <g:hiddenField name="izvjestaj.id" value="${izvjestaj.id}"/>

        <g:render template="basicDataEdit" model="[izvjestaj: izvjestaj]"/>

        %{-- funkcije koje onemogucavaju unos u pojedina polja --}%
        <g:javascript library='jquery'>
            (function($) {
                $(document).ready(function() {

                    if (editable.value === 'false') {
                        disableAndHideFields();
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
            <legend style="width: 60%">${message(code: 'izvjestaj.preuzetaIsporucenaEnergija.fieldset.G.title')}</legend>

            <div id="preuzetaIsporucenaTable" class="table-editable">
                <table id="table1" class="table">
                    <tr>
                        <th id="preuzetaKolicina" class="prety-th"><g:message code="izvjestaj.gas.t1.col01"/></th>
                        <th id="industrijskiPotrosaci" class="prety-th"><g:message code="izvjestaj.gas.t1.col02"/></th>
                        <th id="sistemiDaljinskoGrijanja" class="prety-th"><g:message code="izvjestaj.gas.t1.col03"/></th>
                        <th id="komercijalniKrajnjiKupci" class="prety-th"><g:message code="izvjestaj.gas.t1.col04"/></th>
                        <th id="domacinstva" class="prety-th"><g:message code="izvjestaj.gas.t1.col05"/></th>
                        <th id="ukupnoIsporuceno" class="prety-th"><g:message code="izvjestaj.gas.t1.col06"/></th>
                        <th id="gubici" class="prety-th"><g:message code="izvjestaj.gas.t1.col07"/></th>
                    </tr>
                    <tr>
                        <td class="editable-td" contenteditable="true">${izvjestaj.preuzetIsporucenGas?.preuzetaKolicina}</td>
                        <td class="editable-td" contenteditable="true">${izvjestaj.preuzetIsporucenGas?.industrijskiPotrosaci}</td>
                        <td class="editable-td" contenteditable="true">${izvjestaj.preuzetIsporucenGas?.sistemiDaljinskoGrijanja}</td>
                        <td class="editable-td" contenteditable="true">${izvjestaj.preuzetIsporucenGas?.komercijalniKrajnjiKupci}</td>
                        <td class="editable-td" contenteditable="true">${izvjestaj.preuzetIsporucenGas?.domacinstva}</td>
                        <td class="editable-td" contenteditable="true">${izvjestaj.preuzetIsporucenGas?.ukupnoIsporuceno}</td>
                        <td class="editable-td" contenteditable="true">${izvjestaj.preuzetIsporucenGas?.gubici}</td>
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
                    handleButtonClick("${createLink(controller: 'izvjestaj', action: 'update')}", 'ažuriran');
                });

                $('#posaljiButton').click(function() {
                    handleButtonClick("${createLink(controller: 'izvjestaj', action: 'posalji')}", 'poslan');

                });

                function handleButtonClick(url, message) {
                    var dataJSON = $("#formIzvjestaj").serialize();
                    var $TABLE1 = $('#preuzetaIsporucenaTable');
                    var $TABLE2 = $('#procjenaStanjaTable');

                    dataJSON += createJSONData("izvjestaj.preuzetIsporucenGas", $TABLE1);
                    dataJSON += createJSONData("izvjestaj.procjenaStanjaEnergetskeEfikasnostiList", $TABLE2);

                    $.ajax({
                        url: url,
                        type: 'post',
                        dataType: 'json',
                        async: false,
                        data: dataJSON,
                        success: function handleSuccess(data) {
                            if (data.theme === 'warning') { warningNotification({ title: data.title, message: data.message }); }
                            else if (data.theme === 'error') { errorNotification({ title: data.title, message: data.message }); }
                            else { successNotification({ title: data.title, message: data.message }); }
                            if(message === 'poslan') {
                              setTimeout(function() {
                                var path = window.location.pathname.split('/')[1];
                                if (path === 'izvjestaj') {
                                    window.location.href = '/izvjestaj/show/' + ${this.izvjestaj.id};
                                }
                                else {
                                    window.location.href = '/' + path + '/izvjestaj/show/' + ${this.izvjestaj.id};
                                }
                              }, 2000);
                            }
                         },
                        error: function handleError(data) {
                            if (data.theme === 'warning') { warningNotification({ title: data.title, message: data.message }); }
                            else if (data.theme === 'error') { errorNotification({ title: data.title, message: data.message }); }
                            else { successNotification({ title: data.title, message: data.message }); }
                        }
                    });
                }

                function createJSONData(argument, table) {
                    var headers = [], returnValue = '';
                    var $header = table.find('tr:first');
                    var $rows = table.find('tr:not(:hidden):not(:first)');

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