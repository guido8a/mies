<%@ page import="mies.PoliticaAplicaProyecto" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName"
           value="${message(code: 'politicaAplicaProyecto.label', default: 'PoliticaAplicaProyecto')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message
            code="default.home.label"/></a></span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label"
                                                                           args="[entityName]"/></g:link></span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label"
                                                                               args="[entityName]"/></g:link></span>
</div>

<div class="body">
    <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${politicaAplicaProyectoInstance}">
        <div class="errors">
            <g:renderErrors bean="${politicaAplicaProyectoInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form method="post">
        <g:hiddenField name="id" value="${politicaAplicaProyectoInstance?.id}"/>
        <g:hiddenField name="version" value="${politicaAplicaProyectoInstance?.version}"/>
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="descripcion"><g:message code="politicaAplicaProyecto.descripcion.label"
                                                            default="Descripcion"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: politicaAplicaProyectoInstance, field: 'descripcion', 'errors')}">
                        <g:textArea class="field required ui-widget-content ui-corner-all" minLenght="1"
                                    maxLenght="1023" name="descripcion" id="descripcion" title="descripcion"
                                    cols="40" rows="5"
                                    value="${politicaAplicaProyectoInstance?.descripcion}"/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><g:actionSubmit class="save" action="update"
                                                 value="${message(code: 'default.button.update.label', default: 'Update')}"/></span>
            <span class="button"><g:actionSubmit class="delete" action="delete"
                                                 value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                 onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
        </div>
    </g:form>
</div>
</body>
</html>