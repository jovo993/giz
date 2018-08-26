<table>
    <thead>
    <tr>
        <g:each in="${columns}" var="p" status="i">
            <g:set var="propTitle">${domainClass.propertyName}.${p}.label</g:set>
            <g:sortableColumn property="${p}" title="${message(code: propTitle)}"/>
        </g:each>
        <g:sortableColumn property="akcije" title="Akcije"/>
    </tr>
    </thead>
    <tbody>
    <g:each in="${collection}" var="bean" status="i">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
            <g:each in="${columns}" var="p" status="j">
                <td><f:display bean="${bean}" property="${p}" displayStyle="${displayStyle ?: 'table'}"/></td>
            </g:each>
            <td><div class="nav" role="navigation">
                <ul>
                    <li><g:link class="info" method="GET" resource="${bean}"><g:message code="show.label"/></g:link></li>
                </ul>
            </div></td>
        </tr>
    </g:each>
    </tbody>
</table>

