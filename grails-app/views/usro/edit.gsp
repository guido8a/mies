<%@ page import="mies.seguridad.Usro" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'usro.label', default: 'Usro')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
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
    <g:hasErrors bean="${usroInstance}">
        <div class="errors">
            <g:renderErrors bean="${usroInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form method="post">
        <g:hiddenField name="id" value="${usroInstance?.id}"/>
        <g:hiddenField name="version" value="${usroInstance?.version}"/>
        <div class="dialog">
            <table>
                <tbody>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="sistema"><g:message code="usro.sistema.label" default="Sistema"/></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: usroInstance, field: 'sistema', 'errors')}">
                            <g:select class="field required requiredCmb ui-widget-content ui-corner-all"
                                      name="sistema.id" title="Sistema" from="${mies.seguridad.Sistema.list()}"
                                      optionKey="id" value="${usroInstance?.sistema?.id}"/>
                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="persona"><g:message code="usro.persona.label" default="Persona"/></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: usroInstance, field: 'persona', 'errors')}">
                            <g:select class="field required requiredCmb ui-widget-content ui-corner-all"
                                      name="persona.id" title="Persona" from="${mies.Persona.list()}" optionKey="id"
                                      value="${usroInstance?.persona?.id}"/>
                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="cargoPersonal"><g:message code="usro.cargoPersonal.label"
                                                                  default="Cargo Personal"/></label>
                        </td>
                        <td valign="top"
                            class="value ${hasErrors(bean: usroInstance, field: 'cargoPersonal', 'errors')}">
                            <g:select class="field ui-widget-content ui-corner-all" name="cargoPersonal.id"
                                      title="CargoPersonal" from="${mies.CargoPersonal.list()}" optionKey="id"
                                      value="${usroInstance?.cargoPersonal?.id}" noSelection="['null': '']"/>
                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="usroLogin"><g:message code="usro.usroLogin.label" default="Usro Login"/></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: usroInstance, field: 'usroLogin', 'errors')}">
                            <g:textField name="usroLogin" id="usroLogin" title="UsroLogin"
                                         class="field required ui-widget-content ui-corner-all" minLenght="1"
                                         maxLenght="15" value="${usroInstance?.usroLogin}"/>
                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="usroPassword"><g:message code="usro.usroPassword.label"
                                                                 default="Usro Password"/></label>
                        </td>
                        <td valign="top"
                            class="value ${hasErrors(bean: usroInstance, field: 'usroPassword', 'errors')}">
                            <g:textField name="usroPassword" id="usroPassword" title="UsroPassword"
                                         class="field required ui-widget-content ui-corner-all" minLenght="1"
                                         maxLenght="64" value="${usroInstance?.usroPassword}"/>
                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="autorizacion"><g:message code="usro.autorizacion.label"
                                                                 default="Autorizacion"/></label>
                        </td>
                        <td valign="top"
                            class="value ${hasErrors(bean: usroInstance, field: 'autorizacion', 'errors')}">
                            <g:textField name="autorizacion" id="autorizacion" title="Autorizacion"
                                         class="field required ui-widget-content ui-corner-all" minLenght="1"
                                         maxLenght="255" value="${usroInstance?.autorizacion}"/>
                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="sigla"><g:message code="usro.sigla.label" default="Sigla"/></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: usroInstance, field: 'sigla', 'errors')}">
                            <g:textField name="sigla" id="sigla" title="Sigla"
                                         class="field required ui-widget-content ui-corner-all" minLenght="1"
                                         maxLenght="8" value="${usroInstance?.sigla}"/>
                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="usroActivo"><g:message code="usro.usroActivo.label"
                                                               default="Usro Activo"/></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: usroInstance, field: 'usroActivo', 'errors')}">
                            <g:textField class="field number required ui-widget-content ui-corner-all" name="usroActivo"
                                         title="UsroActivo" id="usroActivo"
                                         value="${fieldValue(bean: usroInstance, field: 'usroActivo')}"/>
                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="fechaPass"><g:message code="usro.fechaPass.label" default="Fecha Pass"/></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: usroInstance, field: 'fechaPass', 'errors')}">
                            <input type="hidden" value="date.struct" name="fechaPass">
                            <input type="hidden" name="fechaPass_day" id="fechaPass_day"
                                   value="${usroInstance?.fechaPass?.format('dd')}">
                            <input type="hidden" name="fechaPass_month" id="fechaPass_month"
                                   value="${usroInstance?.fechaPass?.format('MM')}">
                            <input type="hidden" name="fechaPass_year" id="fechaPass_year"
                                   value="${usroInstance?.fechaPass?.format('yyyy')}">
                            <g:textField class="datepicker field ui-widget-content ui-corner-all" name="fechaPass"
                                         title="FechaPass" id="fechaPass"
                                         value="${usroInstance?.fechaPass?.format('dd-MM-yyyy')}"/>
                            <script type='text/javascript'>
                                $('#fechaPass').datepicker({
                                    changeMonth: true,
                                    changeYear:true,
                                    dateFormat: 'dd-mm-yy',
                                    onClose: function(dateText, inst) {
                                        var date = $(this).datepicker('getDate');
                                        var day, month, year;
                                        if (date != null) {
                                            day = date.getDate();
                                            month = parseInt(date.getMonth()) + 1;
                                            year = date.getFullYear();
                                        } else {
                                            day = '';
                                            month = '';
                                            year = '';
                                        }
                                        var id = $(this).attr('id');
                                        $('#' + id + '_day').val(day);
                                        $('#' + id + '_month').val(month);
                                        $('#' + id + '_year').val(year);
                                    }
                                });
                            </script>
                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="observaciones"><g:message code="usro.observaciones.label"
                                                                  default="Observaciones"/></label>
                        </td>
                        <td valign="top"
                            class="value ${hasErrors(bean: usroInstance, field: 'observaciones', 'errors')}">
                            <g:textField name="observaciones" id="observaciones" title="Observaciones"
                                         class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="255"
                                         value="${usroInstance?.observaciones}"/>
                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="unidad"><g:message code="usro.unidad.label" default="Unidad"/></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: usroInstance, field: 'unidad', 'errors')}">
                            <g:select class="field ui-widget-content ui-corner-all" name="unidad.id" title="Unidad"
                                      from="${mies.UnidadEjecutora.list()}" optionKey="id"
                                      value="${usroInstance?.unidad?.id}" noSelection="['null': '']"/>
                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="accesos"><g:message code="usro.accesos.label" default="Accesos"/></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: usroInstance, field: 'accesos', 'errors')}">

                            <ul>
                                <g:each in="${usroInstance?.accesos?}" var="a">
                                    <li><g:link controller="accs" action="show"
                                                id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                                </g:each>
                            </ul>
                            <g:link controller="accs" action="create"
                                    params="['usro.id': usroInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'accs.label', default: 'Accs')])}</g:link>

                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="alertas"><g:message code="usro.alertas.label" default="Alertas"/></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: usroInstance, field: 'alertas', 'errors')}">

                            <ul>
                                <g:each in="${usroInstance?.alertas?}" var="a">
                                    <li><g:link controller="alerta" action="show"
                                                id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                                </g:each>
                            </ul>
                            <g:link controller="alerta" action="create"
                                    params="['usro.id': usroInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'alerta.label', default: 'Alerta')])}</g:link>

                        </td>
                    </tr>

                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="sesiones"><g:message code="usro.sesiones.label" default="Sesiones"/></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: usroInstance, field: 'sesiones', 'errors')}">

                            <ul>
                                <g:each in="${usroInstance?.sesiones?}" var="s">
                                    <li><g:link controller="sesn" action="show"
                                                id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
                                </g:each>
                            </ul>
                            <g:link controller="sesn" action="create"
                                    params="['usro.id': usroInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sesn.label', default: 'Sesn')])}</g:link>

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
