<g:javascript library='jquery'>
    (function($) {
        $(document).ready(function() {
            calculateSumStepenMjerenja();

            calculateSumStepenMjerenja($(this).context.className);
            // sumiranje
            for (var i = 1; i < 3; i++) {
                $('.rowDataSdSmt' + i).each(function() {
                    $(this).on('change', function() {
                        calculateSumStepenMjerenja($(this).context.className);
                    });
                });
            }

            function calculateSumStepenMjerenja(className) {
                if (className) {
                    var total = 0;
                    $('.' + className).each(function() {
                        total += $(this).val() * 1;
                    });
                    $('.colSumSmt' + className.substr(className.length - 1)).get(0).value = total;
                }
                else {
                    for (var i = 1; i < 3; i++) {
                        var total = 0;
                        $('.rowDataSdSmt' + i).each(function() {
                            total += $(this).val() * 1;
                        });
                        $('.colSumSmt' + i).get(0).value = total;
                    }
                }
            }
        });
    })(jQuery);
</g:javascript>
<fieldset class="fieldset">
    <legend style="width: 80%"><g:message code="izvjestaj.podaciStepenMjerenja.TE.fieldset.title"/></legend>

    <div id="stepenMjerenjaTable" class="table-editable">
        <table class="table table-bordered table-secondary">
            <thead>
            <tr>
                <th scope="col" style="width: 25%; vertical-align: middle;">&nbsp;</th>
                <th scope="col" class="prety-th"><g:message code="tabela.stepenMjerenja.TE.th1"/></th>
                <th scope="col" class="prety-th"><g:message code="tabela.stepenMjerenja.EE.th2"/></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="prety-th">Sektor domaćinstva</td>
                <td><input class="rowDataSdSmt1" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoBrojMjerenjePotrosnje"
                           value="${izvjestaj?.stepenMjerenjeEnergijeStrukturaKupaca?.domacinstvoBrojMjerenjePotrosnje}"></td>
                <td><input class="rowDataSdSmt2" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.domacinstvoUkupanBroj"
                           value="${izvjestaj?.stepenMjerenjeEnergijeStrukturaKupaca?.domacinstvoUkupanBroj}"></td>
            </tr>
            <tr>
                <td class="prety-th">Sektor industrije</td>
                <td><input class="rowDataSdSmt1" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaBrojMjerenjePotrosnje"
                           value="${izvjestaj?.stepenMjerenjeEnergijeStrukturaKupaca?.industrijaBrojMjerenjePotrosnje}"></td>
                <td><input class="rowDataSdSmt2" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.industrijaUkupanBroj"
                           value="${izvjestaj?.stepenMjerenjeEnergijeStrukturaKupaca?.industrijaUkupanBroj}"></td>
            </tr>
            <tr>
                <td class="prety-th">Ostali sektori</td>
                <td><input class="rowDataSdSmt1" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloBrojMjerenjePotrosnje"
                           value="${izvjestaj?.stepenMjerenjeEnergijeStrukturaKupaca?.ostaloBrojMjerenjePotrosnje}"></td>
                <td><input class="rowDataSdSmt2" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ostaloUkupanBroj"
                           value="${izvjestaj?.stepenMjerenjeEnergijeStrukturaKupaca?.ostaloUkupanBroj}"></td>
            <tr>
                <td class="prety-th">Ukupno</td>
                <td><input class="colSumSmt1" disabled="" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojMjerenjePotrosnje"
                           value="${izvjestaj?.stepenMjerenjeEnergijeStrukturaKupaca?.ukupnoBrojMjerenjePotrosnje}"></td>
                <td><input class="colSumSmt2" disabled="" style="width: 100%" name="izvjestaj.stepenMjerenjeEnergijeStrukturaKupaca.ukupnoBrojKrajnjihKupaca"
                           value="${izvjestaj?.stepenMjerenjeEnergijeStrukturaKupaca?.ukupnoBrojKrajnjihKupaca}"></td>
            </tr>
            </tbody>
        </table>
    </div>
</fieldset>