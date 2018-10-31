<g:javascript library='jquery'>
        (function($) {
            $(document).ready(function() {
                jQuery.fn.pop = [].pop;
                jQuery.fn.shift = [].shift;

                $('#vratiNaDoraduButton').click(function() {
                    handleButtonClick("${createLink(controller: 'izvjestaj', action: 'vratiNaDoradu')}");

                });

                $('#verifikujButton').click(function() {
                    handleButtonClick("${createLink(controller: 'izvjestaj', action: 'verifikuj')}");

                });

                $('#potvrdiButton').click(function() {
                    handleButtonClick("${createLink(controller: 'izvjestaj', action: 'potvrdi')}");

                });

                $('#printPdfButton').click(function() {
                    downloadPdf("${createLink(controller: 'izvjestaj', action: 'printPdf')}");
                });

                function handleButtonClick(url) {
                  $.ajax({
                    url: url,
                    type: 'post',
                    dataType: 'json',
                    async: false,
                    data: {id : ${this.izvjestaj.id}},
                    success: function handleSuccess(data) {
                      successNotification({
                        title: data.title,
                          message: data.message
                      });
                      setTimeout(function() {window.location.href="/izvjestaj/show/" + ${this.izvjestaj.id} ;}, 2000);
                    },
                    error: function handleError(data) {
                      errorNotification({
                          title: data.title,
                          message: data.message
                      });
                    }
                  });
                }

                function downloadPdf(url) {
                  $.ajax({
                    url: url,
                    type: 'post',
                    dataType: 'json',
                    async: false,
                    data: {id : ${this.izvjestaj.id}},
                    success: function handleSuccess(response) {
                      var a = document.createElement("a");
                      a.href = "data:application/pdf;base64," + response.pdfByteArray;
                      a.download = response.name || "Izvjestaj";
                      document.body.appendChild(a);
                      a.click();
                      document.body.removeChild(a)
                    }
                  });
                }
         });

        })(jQuery);
</g:javascript>
<fieldset class="buttons">
<sec:ifAnyGranted roles="ROLE_EE_USER, ROLE_G_USER, ROLE_TE_USER">
    <g:if test="${izvjestaj.status.equals(ba.giz.IzvjestajStatus.KREIRAN) || izvjestaj.status.equals(ba.giz.IzvjestajStatus.DORADA)}">
        <button id="submitButton"><i class="fa fa-edit"></i>  <g:message code="default.button.edit.label"/></button>
        <button id="posaljiButton"><i class="fa fa-share-square"></i>   <g:message code="default.button.send.label"/></button>
        <button id="printPdfButton"><i class="fa fa-file-pdf"></i>   <g:message code="default.button.pdf.label"/></button>
    </g:if>
</sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_ADMIN">
        <g:if test="${izvjestaj.status.equals(ba.giz.IzvjestajStatus.POSLAN)}">
            <button id="vratiNaDoraduButton"><i class="fa fa-arrow-alt-circle-left"></i>   <g:message code="default.button.dorada.label"/></button>
            <button id="verifikujButton"><i class="fa fa-check-circle"></i>   <g:message code="default.button.verifikuj.label"/></button>
            <button id="potvrdiButton"><i class="fa fa-inbox"></i>   <g:message code="default.button.potvrdi.label"/></button>
        </g:if>
    </sec:ifAnyGranted>
    <g:link controller="homepage" action="homepage" params="[id: izvjestaj.id]">
        <button id="odustaniButton"><i class="fa fa-home"></i>   <g:message code="default.button.odustani.label"/></button>
    </g:link>
</fieldset>