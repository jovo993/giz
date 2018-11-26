<!DOCTYPE html>
<%@ page import="ba.giz.IzvjestajStatus" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <style>

    td, th { text-align: center }
    .kreiran { color: indianred; }
    .poslan { color: darkgreen; }
    .dorada { color: darkred; }
    .verifikovan { color: cornflowerblue; }
    .zavrsen { color: blue; }
    .storniran { color: black; }
    .status { color: white; }

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
        <legend style="width: 38%"><g:message code="homepage.izvjestajList.fieldset.title"/></legend>
        <table>
            <thead>
            <tr>
                <g:each in="${properties}" var="p" status="i">
                    <g:set var="propTitle">homepage.list.${p.fld}.label</g:set>

<!--
                    <g:sortableColumn property="${p}" title="${message(code: propTitle)}"/>
-->

                    <g:if test="${p.sort}">
                        <g:sortableColumn property="${p.fld}" title="${message(code: propTitle)}"/>
                    </g:if>
                    <g:else>
                        <th>${message(code: propTitle)}</th>
                    </g:else>

                </g:each>
                <th><g:message code="show.label"/></th>
            </tr>
            </thead>
            <tbody>

            <g:each in="${list}" var="bean" status="i">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td>
                        
                        <g:message code="ba.giz.IzvjestajTip.${bean.tip}"/>
                        
                        <!-- BB; PRVA VERZIJA; LOSIJA, ODBACENA;
                           <g:if test="${bean.tip == ba.giz.IzvjestajTip.EE_DS}"><g:message code="ba.giz.IzvjestajTip.EE_DS"/></g:if>
                           <g:elseif test="${bean.tip == ba.giz.IzvjestajTip.G_DS}"><g:message code="ba.giz.IzvjestajTip.G_DS"/></g:elseif>
                           <g:elseif test="${bean.tip == ba.giz.IzvjestajTip.T_DS}"><g:message code="ba.giz.IzvjestajTip.T_DS"/></g:elseif>
                           <g:else>???</g:else>
                        BB; PRVA VERZIJA; LOSIJA, ODBACENA; -->

                        <!-- ${bean.tip} -->
                        
                    </td>
                    <td>${bean.podaciPodnosenjeIzvjestaja.godina}</td>
                    <sec:ifAnyGranted roles="ROLE_ADMIN">
                        <td>${bean.preduzece.naziv}</td>
                    </sec:ifAnyGranted>
                    <td><g:formatDate format="dd.MM.yyyy." date="${bean.datumKreiranja}"/></td>
                    <td><g:formatDate format="dd.MM.yyyy." date="${bean.datumSlanja}"/></td>
                    <td>${bean.podaciPodnosenjeIzvjestaja.prezimeImePozicija}</td>
                    <td class="${bean.status == ba.giz.IzvjestajStatus.KREIRAN ? 'kreiran' : 
                    bean.status == ba.giz.IzvjestajStatus.DORADA ? 'dorada' : 
                    bean.status == ba.giz.IzvjestajStatus.POSLAN ? 'poslan' : 
                    bean.status == ba.giz.IzvjestajStatus.VERIFIKOVAN ? 'verifikovan' : 
                    bean.status == ba.giz.IzvjestajStatus.ZAVRSEN ? 'zavrsen' : 
                    bean.status == ba.giz.IzvjestajStatus.STORNIRAN ? 'storniran' : 
                    'status'}">
                        
                        <g:message code="ba.giz.IzvjestajStatus.${bean.status}"/>
                        
                        <!-- BB; PRVA VERZIJA; LOSIJA, ODBACENA;
                           <g:if test="${bean.status == ba.giz.IzvjestajStatus.KREIRAN}"><g:message code="ba.giz.IzvjestajStatus.KREIRAN"/></g:if>
                           <g:elseif test="${bean.status == ba.giz.IzvjestajStatus.POSLAN}"><g:message code="ba.giz.IzvjestajStatus.POSLAN"/></g:elseif>
                           <g:elseif test="${bean.status == ba.giz.IzvjestajStatus.DORADA}"><g:message code="ba.giz.IzvjestajStatus.DORADA"/></g:elseif>
                           <g:elseif test="${bean.status == ba.giz.IzvjestajStatus.VERIFIKOVAN}"><g:message code="ba.giz.IzvjestajStatus.VERIFIKOVAN"/></g:elseif>
                           <g:elseif test="${bean.status == ba.giz.IzvjestajStatus.ZAVRSEN}"><g:message code="ba.giz.IzvjestajStatus.ZAVRSEN"/></g:elseif>
                           <g:elseif test="${bean.status == ba.giz.IzvjestajStatus.STORNIRAN}"><g:message code="ba.giz.IzvjestajStatus.STORNIRAN"/></g:elseif>
                           <g:else>???</g:else>
                        BB; PRVA VERZIJA; LOSIJA, ODBACENA; -->
                        
                        <!-- ${bean.status} -->
                        
                    </td>
                    <td style="text-align: center"><g:link controller="izvjestaj" action="resolveViewAndRedirect" resource="${bean}"><span class="fa fa-search"
                                                                                                                                           style="horiz-align: center;"></span></g:link></td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </fieldset>

    <g:if test="${izvjestajCount.toInteger() > params.max.toInteger()}">
        <div class="pagination">
            <g:paginate total="${izvjestajCount.toInteger() ?: 0}"/>
        </div>
    </g:if>

</div>
</body>
</html>