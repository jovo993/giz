<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title><g:message code="izvjestaj.excel.title"/></title>
</head>

<body>

<a href="#excelExport-izvjestaj" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div id="excelExport-izvjestaj" class="content" role="main">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.izvjestajExcelDTO}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.izvjestajExcelDTO}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form controller="izvjestaj">
        <fieldset class="fieldset">
            <legend style="width: 65%"><g:message code="izvjestaj.excel.title"/></legend>

            <label for="godina">
                <g:message code="izvjestaj.excel.godina.title"/>
            </label>
            <g:textField name="godina" value="${izvjestajExcelDTO?.godina ? izvjestajExcelDTO?.godina : Calendar.getInstance().get(Calendar.YEAR)}" style="width: 30%"/><br/>

            <label for="sektori">
                <g:message code="izvjestaj.excel.sektori.title"/>
            </label>
            <g:select multiple="true" name="sektori" from="${ba.giz.Sektor.values()}" keys="${ba.giz.Sektor.values()*.name()}" value="${izvjestajExcelDTO?.sektori}" style="width: 30%"/><br/>

            <label style="vertical-align: middle;">
                <g:message code="izvjestaj.excel.uloga.title"/>
            </label>

            <g:checkBox name="uloga.operater" value="${izvjestajExcelDTO?.uloga?.operater}" style="width: 1%; vertical-align: middle;"/>
            <label for="uloga.operater" style="width:85px; text-align: left;">
                <g:message code="ba.giz.Uloga.OPERATER"/>
            </label>

            <g:checkBox name="uloga.distributer" value="${izvjestajExcelDTO?.uloga?.distributer}" style="width: 1%; vertical-align: middle;"/>
            <label for="uloga.distributer" style="width: 115px; text-align: left;">
                <g:message code="ba.giz.Uloga.DISTRIBUTER"/>
            </label>

            <g:checkBox name="uloga.snabdjevac" value="${izvjestajExcelDTO?.uloga?.snabdjevac}" style="width: 1%; vertical-align: middle;"/>
            <label for="uloga.snabdjevac" style="width: 70px; text-align: left;">
                <g:message code="ba.giz.Uloga.SNABDJEVAC"/>
            </label><br/>

            <label style="vertical-align: middle;">
                <g:message code="izvjestaj.excel.statusi.title"/>
            </label>

            <g:checkBox name="kreiran" value="${izvjestajExcelDTO?.kreiran}" style="width: 1%; vertical-align: middle;"/>
            <label for="kreiran" style="width: 70px; vertical-align: middle; text-align: left;">
                <g:message code="izvjestaj.status.kreiran.label"/>
            </label>

            <g:checkBox name="poslan" value="${izvjestajExcelDTO?.poslan}" style="width: 1%; vertical-align: middle;"/>
            <label for="poslan" style="width: 65px; vertical-align: middle; text-align: left;">
                <g:message code="izvjestaj.status.poslan.label"/>
            </label>

            <g:checkBox name="dorada" value="${izvjestajExcelDTO?.dorada}" style="width: 1%; vertical-align: middle;"/>
            <label for="dorada" style="width: 70px; vertical-align: middle; text-align: left;">
                <g:message code="izvjestaj.status.dorada.label"/>
            </label>

            <g:checkBox name="verifikovan" value="${izvjestajExcelDTO?.verifikovan}" style="width: 1%; vertical-align: middle;"/>
            <label for="verifikovan" style="width: 115px; vertical-align: middle; text-align: left;">
                <g:message code="izvjestaj.status.verifikovan.label"/>
            </label>

            <g:checkBox name="zavrsen" value="${izvjestajExcelDTO?.zavrsen}" style="width: 1%; vertical-align: middle;"/>
            <label for="zavrsen" style="width: 0px; vertical-align: middle; text-align: left;">
                <g:message code="izvjestaj.status.zavrsen.label"/>
            </label><br/>
        </fieldset>
        <fieldset class="buttons">
            <g:actionSubmit class="excel" resource="${this.izvjestajExcelDTO}" action="generateBasicExcel" value="${message(code: 'izvjestaj.excel.button.generate.basic.label', default: 'Osnovni spisak svih izvještaja (Excel)')}" style="width: 260px"/>
            <g:actionSubmit class="excel" resource="${this.izvjestajExcelDTO}" action="generateQuantitativeExcel" value="${message(code: 'izvjestaj.excel.button.generate.quantitativeExcel.label', default: 'Kvantitativni izvještaj (Excel)')}" style="width: 380px"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>