<%@ page import="ba.giz.Sektor" %>
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
            <legend style="width: 50%"><g:message code="izvjestaj.excel.title"/></legend>

            <label for="godina">
                <g:message code="izvjestaj.excel.godina.title"/>
            </label>
            <g:textField name="godina" value="${izvjestajExcelDTO?.godina ? izvjestajExcelDTO?.godina : Calendar.getInstance().get(Calendar.YEAR)}" style="width: 30%"/><br/>

            <label for="sektori">
                <g:message code="izvjestaj.excel.sektori.title"/>
            </label>
            <g:select multiple="true" name="sektori" from="${Sektor.values()}" keys="${Sektor.values()*.name()}" value="${izvjestajExcelDTO?.sektori}" style="width: 30%"/><br/>

            <label style="vertical-align: middle;">
                <g:message code="izvjestaj.excel.uloga.title"/>
            </label>

            <g:checkBox name="uloga.operator" value="${izvjestajExcelDTO?.uloga?.operator}" style="width: 2%; vertical-align: middle;"/>
            <label for="uloga.operator" style="width: 6.6%; vertical-align: middle;">
                <g:message code="preduzece.uloga.operator.title"/>
            </label>

            <g:checkBox name="uloga.distributer" value="${izvjestajExcelDTO?.uloga?.distributer}" style="width: 2%; vertical-align: middle;"/>
            <label for="uloga.distributer" style="width: 8%; vertical-align: middle;">
                <g:message code="preduzece.uloga.distributer.title"/>
            </label>

            <g:checkBox name="uloga.snabdjevac" value="${izvjestajExcelDTO?.uloga?.snabdjevac}" style="width: 2%; vertical-align: middle;"/>
            <label for="uloga.snabdjevac" style="width: 8%; vertical-align: middle;">
                <g:message code="preduzece.uloga.snabdjevac.title"/>
            </label><br/>

            <label style="vertical-align: middle;">
                <g:message code="izvjestaj.excel.statusi.title"/>
            </label>

            <g:checkBox name="kreiran" value="${izvjestajExcelDTO?.kreiran}" style="width: 2%; vertical-align: middle;"/>
            <label for="kreiran" style="width: 4.4%; vertical-align: middle;">
                <g:message code="izvjestaj.status.kreiran.label"/>
            </label>

            <g:checkBox name="poslan" value="${izvjestajExcelDTO?.poslan}" style="width: 2%; vertical-align: middle;"/>
            <label for="poslan" style="width: 3.8%; vertical-align: middle;">
                <g:message code="izvjestaj.status.poslan.label"/>
            </label>

            <g:checkBox name="dorada" value="${izvjestajExcelDTO?.dorada}" style="width: 2%; vertical-align: middle;"/>
            <label for="dorada" style="width: 4%; vertical-align: middle;">
                <g:message code="izvjestaj.status.dorada.label"/>
            </label>

            <g:checkBox name="verifikovan" value="${izvjestajExcelDTO?.verifikovan}" style="width: 2%; vertical-align: middle;"/>
            <label for="verifikovan" style="width: 6.7%; vertical-align: middle;">
                <g:message code="izvjestaj.status.verifikovan.label"/>
            </label>

            <g:checkBox name="zavrsen" value="${izvjestajExcelDTO?.zavrsen}" style="width: 2%; vertical-align: middle;"/>
            <label for="zavrsen" style="width: 4%; vertical-align: middle;">
                <g:message code="izvjestaj.status.zavrsen.label"/>
            </label><br/>
        </fieldset>
        <fieldset class="buttons">
            <g:actionSubmit class="excel" resource="${this.izvjestajExcelDTO}" action="generateBasicExcel" value="${message(code: 'izvjestaj.excel.button.generate.basic.label', default: 'Generiši excel')}" style="width: 20%"/>
            <g:actionSubmit class="excel" resource="${this.izvjestajExcelDTO}" action="generateQuantitativeExcel" value="${message(code: 'izvjestaj.excel.button.generate.quantitativeExcel.label', default: 'Generiši kvantitativni excel')}" style="width: 28%"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>