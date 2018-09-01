<%@ page import="ba.giz.dto.IzvjestajExcelDTO; ba.giz.Preduzece" %>
<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="rODS"/>
    </title>
    <asset:link rel="icon" href="logo_fond.ico" type="image/x-ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <asset:stylesheet src="application.css"/>

    <g:layoutHead/>
</head>

<body>

<div class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/#">
                <i class="fa grails-icon">
                    <asset:image src="logo_fond.png"/>
                </i> rODS - Registar operatora, distributera i snabdjevača energijom
            </a>
        </div>

        <div class="navbar-collapse collapse" aria-expanded="false" style="height: 0.8px;">
            <ul class="nav navbar-nav navbar-right">
                <li><g:link controller="homepage" action="homepage"><g:message code="meni.homepage.title"/></g:link></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><g:message code="meni.izvjestaj.title"/><span
                            class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><g:link controller="izvjestaj" action="index"><g:message code="meni.izvjestaj.lista.title"/></g:link></li>
                        <li><g:link controller="izvjestaj" action="create"><g:message code="meni.izvjestaj.novi.title"/></g:link></li>
                    </ul>
                </li>
                %{--TODO: change to preduzece of current user--}%
                <li><g:link controller="preduzece" action="basicEdit" resource="${Preduzece.last() ? Preduzece.last() : new Preduzece()}"><g:message code="meni.obveznik.izmjena.title"/></g:link></li>
                <li><g:link controller="izvjestaj" action="excelExport"><g:message code="meni.izvjestavanje.title"/></g:link></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><g:message code="meni.sifarnici.title"/><span
                            class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><g:link controller="preduzece" action="index"><g:message code="meni.sifarnici.preduzece.title"/></g:link></li>
                    </ul>
                </li>
                <li><g:link controller="uputstvo" action="index"><g:message code="meni.uputstvo.title"/></g:link></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><g:message code="meni.options.title"/><span
                            class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><g:link controller="logout" action="index"><g:message code="meni.logout.title"/></g:link></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</div>

<div style="width: 1200px">
    <g:layoutBody/>
</div>

<div class="footer" role="contentinfo"></div>

<div id="spinner" class="spinner" style="display:none;">
    <g:message code="spinner.alt" default="Loading&hellip;"/>
</div>

<asset:javascript src="application.js"/>

</body>
</html>
