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
        <g:hiddenField name="izvjestaj.id" value="${izvjestaj.id}"/>

        <g:render template="basicDataEdit" model="[izvjestaj: izvjestaj]"/>

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

                <div class="prety-th" style="text-align: right; padding: 5px">Ukupno isporučena energija krajnjim kupcima u TJ:  <input name="izvjestaj.ukupnoIsporucenaEnergija"
                                                                                                                                        value="${izvjestaj.ukupnoIsporucenaEnergija}"></div>
            </div>
        </fieldset>

        <g:render template="procjenaStanjaTable" bean="izvjestaj"/>

        <g:render template="stepenMjerenjaTableEdit" bean="izvjestaj"/>

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

    <g:render template="actionsMenuBar" bean="izvjestaj" />

</div>
</body>
</html>