<table>
    <thead>
    <tr>
        <g:each in="${columns}" var="p" status="i">
            <g:set var="propTitle">${domainClass.propertyName}.${p}.label</g:set>
            <g:sortableColumn property="${p}" title="${message(code: propTitle)}"/>
        </g:each>
    </tr>
    </thead>
    <tbody>
    <g:each in="${collection}" var="bean" status="i">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
            <g:each in="${columns}" var="p" status="j">
                <g:if test="${j == 0}">
                    <td><g:link method="GET" resource="${bean}"><f:display bean="${bean}" property="${p}"
                                                                           displayStyle="${displayStyle ?: 'table'}"/></g:link></td>
                </g:if>
                <g:else>
                    <td><f:display bean="${bean}" property="${p}" displayStyle="${displayStyle ?: 'table'}"/></td>
                </g:else>
            </g:each>
        </tr>
    </g:each>
    </tbody>
</table>

