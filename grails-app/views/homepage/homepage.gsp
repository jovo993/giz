<%@ page import="ba.giz.IzvjestajStatus" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <style>

    td, th {
        text-align: center
    }

    .kreiran {
        color: green;
    }

    .dorada {
        color: darkred;
    }

    .status {
        color: cornflowerblue;
    }

    </style>
</head>

<body>

<div id="homepage" class="content scaffold-create" role="main">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.preduzece}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.preduzece}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <sec:ifAnyGranted roles="ROLE_EE_USER, ROLE_G_USER, ROLE_TE_USER">
        <g:render template="preduzeceData" bean="${this.preduzece}"/>
    </sec:ifAnyGranted>
    <fieldset class="fieldset">
        <legend style="width: 18%"><g:message code="homepage.izvjestajList.fieldset.title"/></legend>
        <table>
            <thead>
            <tr>
                <g:each in="${properties}" var="p" status="i">
                    <g:set var="propTitle">homepage.list.${p}.label</g:set>
                    <g:sortableColumn property="${p}" title="${message(code: propTitle)}"/>
                </g:each>
                <th>Prikaži</th>
            </tr>
            </thead>
            <tbody>

            <g:each in="${list}" var="bean" status="i">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td>${bean.tip}</td>
                    <td>${bean.podaciPodnosenjeIzvjestaja.godina}</td>
                    <sec:ifAnyGranted roles="ROLE_ADMIN">
                        <td>${bean.preduzece.naziv}</td>
                    </sec:ifAnyGranted>
                    <td><g:formatDate>${bean.datumKreiranja}</g:formatDate></td>
                    <td><g:formatDate>${bean.datumSlanja}</g:formatDate></td>
                    <td>${bean.podaciPodnosenjeIzvjestaja.prezimeImePozicija}</td>
                    <td class="${bean.status == ba.giz.IzvjestajStatus.KREIRAN ? 'kreiran' : bean.status == ba.giz.IzvjestajStatus.DORADA ? 'dorada' : 'status'}">${bean.status}</td>
                    <td style="text-align: center"><g:link controller="izvjestaj" action="resolveViewAndRedirect" resource="${bean}"><span class="fa fa-search"
                                                                                                                                           style="horiz-align: center;"></span></g:link></td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </fieldset>
</form>
</div>
</body>
</html>