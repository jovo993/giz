<g:javascript library='jquery'>
    (function($) {
        $(document).ready(function() {
            var $TABLE = $('#procjenaStanjaTable');

            $('#procjenaStanja').click(function() {
                var $clone = $TABLE.find('tr.hide').clone(true).removeClass('hide table-line');
                $TABLE.find('table').append($clone);
            });

            $('.pst-remove').click(function() {
                $(this).parents('tr').detach();
            });

            $('.pst-up').click(function() {
                var $row = $(this).parents('tr');
                if ($row.index() === 1) return; // Don't go above the header
                $row.prev().before($row.get(0));
            });

            $('.pst-down').click(function() {
                var $row = $(this).parents('tr');
                $row.next().after($row.get(0));
            });

        });
    })(jQuery);
</g:javascript>
<fieldset class="fieldset">
    <g:if test="${preduzece?.sektor == ba.giz.Sektor.TOPLOTNA_ENERGIJA || izvjestaj?.preduzece?.sektor == ba.giz.Sektor.TOPLOTNA_ENERGIJA}">
        <legend style="width: 55%"><g:message code="izvjestaj.procjenastanja.fieldset.TE.title"/></legend>
    </g:if>
    <g:else>
        <legend style="width: 55%"><g:message code="izvjestaj.procjenastanja.fieldset.title"/></legend>
    </g:else>

    <div id="procjenaStanjaTable" class="table-editable">
        <span id="procjenaStanja" class="table-add fa fa-plus fa-2x"></span>
        <table class="table">
            <tr>
                <th id="primjenjenaMjera" scope="col" class="prety-th"><g:message code="izvjestaj.ee.t3.col01"/></th>
                <th id="vrstaUstede" scope="col" class="prety-th"><g:message code="izvjestaj.ee.t3.col02"/></th>
                <th id="kolicinaUstede" class="prety-th"><g:message code="izvjestaj.ee.t3.col03"/></th>
                <th></th>
                <th></th>
                <th></th>
            </tr>
        <tr>
            <g:each in="${izvjestaj?.procjenaStanjaEnergetskeEfikasnostiList}" var="bean" status="i">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td class="editable-td" contenteditable="true">${bean.primjenjenaMjera}</td>
                    <td class="editable-td" contenteditable="true">${bean.vrstaUstede}</td>
                    <td class="editable-td" contenteditable="true">${bean.kolicinaUstede}</td>
                    <td style="text-align:center">
                        <span class="pst-remove table-remove fa fa-trash fa-2x"></span>
                    </td>
                    <td style="text-align:center">
                        <span class="pst-up table-up fa fa-angle-up fa-2x" style="horiz-align: center;"></span>
                    </td>
                    <td style="text-align:center">
                        <span class="pst-down table-down fa fa-angle-down fa-2x" style="horiz-align: center;"></span>
                    </td>
                </tr>
            </g:each>
            <tr class="hide">
                <td contenteditable="true" class="editable-td"></td>
                <td contenteditable="true" class="editable-td"></td>
                <td contenteditable="true" class="editable-td"></td>
                <td style="text-align:center">
                    <span class="pst-remove table-remove fa fa-trash fa-2x"></span>
                </td>
                <td style="text-align:center">
                    <span class="pst-up table-up fa fa-angle-up fa-2x" style="horiz-align: center;"></span>
                </td>
                <td style="text-align:center">
                    <span class="pst-down table-down fa fa-angle-down fa-2x" style="horiz-align: center;"></span>
                </td>
            </tr>
            <tfoot><tr></tr></tfoot> %{--needed because of script--}%
        </table>
    </div>
</fieldset>