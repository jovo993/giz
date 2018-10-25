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
    <legend style="width: 50%"><g:message code="izvjestaj.procjenastanja.fieldset.TE.title"/></legend>

    <div id="procjenaStanjaTable" class="table-editable">
        <span id="procjenaStanja" class="table-add fa fa-plus fa-2x"></span>
        <table class="table">
            <tr>
                <th id="primjenjenaMjera" scope="col" class="prety-th">Primjenjena mjera</th>
                <th id="vrstaUstede" scope="col" class="prety-th">Vrsta uštede</th>
                <th id="kolicinaUstede" class="prety-th">Količina uštede (smanjenje gubitaka)</th>
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