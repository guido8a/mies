
<%@ page import="mies.Asignacion; mies.MarcoLogico" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <script src="${resource(dir: 'js/jquery/plugins/jBreadCrumb/js', file: 'jquery.jBreadCrumb.1.1.js')}"
            type="text/javascript" language="JavaScript"></script>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'Base.css')}"
          type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/jBreadCrumb/Styles', file: 'BreadCrumb.css')}"
          type="text/css"/>
    <title>P.A.C. del proyecto: ${proyecto.nombre}</title>
</head>

<body style="font-size: 10px;">
<div class="breadCrumbHolder module">
    <div id="breadCrumb" class="breadCrumb module">
        <ul>
            <li>
                <g:link class="bc" controller="proyecto" action="show"
                        id="${proyecto.id}">
                    Proyecto
                </g:link>
            </li>

            <li>
                P.A.C.
            </li>
        </ul>
    </div>
</div>


<div style="margin-left: 10px;">
    <a class="btn_arbol btn"  href="${g.createLink(action: 'pacWeb',controller: 'reportes')}/?id=${proyecto.unidadEjecutora.id}&anio=${actual.id}" target="_blank">Reporte</a>

    <b>Año:</b><g:select from="${mies.Anio.list([sort:'anio'])}" id="anio_asg"
                         name="anio" optionKey="id" optionValue="anio"
                         value="${actual.id}"/>
</div>

<div id="accordion" style="width:1030px">

<g:each in="${acts}" var="act" status="k">
<g:set var="asgs" value="${Asignacion.findAllByMarcoLogicoAndAnio(act,actual)}"></g:set>

<g:if test="${asgs.size()>0}">

<fieldset class="ui-corner-all" style="position: relative;" id="act_${act.id}">
<legend>Actividad ${k + 1}: ${(act?.objeto.length() > 40) ? act?.objeto.substring(0, 40) + "..." : act.objeto}</legend>
<table style="/*width: 900px;*/ margin-top: 40px;">
<thead>
<th width="70">Fuente</th>
<th width="75">Presupuesto</th>
<th width="155">Descripci&oacute;n</th>
<th width="100">Unidad</th>
<th width="85">Codigo CPC</th>
<th width="107">Tipo</th>
<th width="48">Cant.</th>
<th width="78">Costo</th>
<th width="22">C1</th>
<th width="22">C2</th>
<th width="22">C3</th>
<th width="16">Desc</th>
<th width="16"></th>
<th width="16"></th>
<th width="16"></th>
</thead>
<tbody>
<g:each in="${asgs}" var="asg" status="i">
    <g:set var="obras" value="${mies.Obra.findAllByAsignacionAndObraIsNull(asg, [sort:'id'])}"/>
    <g:if test="${obras.size() > 0}">
        <g:set var="asigs" value="${0}"/>
        <g:each in="${obras}" var="obra" status="j">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <td class="fuente" style="font-size: 11px;">
                    <g:if test="${asigs == 0}">
                        ${(asg.fuente.toString().size() > 40) ? asg.fuente.toString().substring(0, 40) : asg.fuente}
                    </g:if>
                </td>

                <td class="asg" style="font-size: 11px;">
                    <g:if test="${asigs == 0}">
                        <input type="hidden" class="asg" value="${asg.id}">
                        <g:formatNumber number="${asg.planificado}" format="###,##0"
                                        minFractionDigits="2" maxFractionDigits="2"/>
                    </g:if>
                </td>

                <td>
                    ${asg.presupuesto.descripcion} (${asg.presupuesto.numero})
                </td>
                <g:set var="asigs" value="${asigs+1}"/>

                <td class="unidad">
                    <g:select from="${unidades}" name="unidad"
                              value="${obra.unidad}" optionKey="id"
                              optionValue="descripcion"
                              style="font-size: 9px;"/>
                </td>

                <td class="cp">
                    <input type="hidden" class="cpac"
                           value="${obra.codigoComprasPublicas.id}">

                    <input type="text" id="cpac_${k}${i}${j}" style="width: 100px;color:black"
                           value="${obra.codigoComprasPublicas.numero}" ${(actual.estado != 0) ? "disabled" : 'class="buscar"'}>
                </td>

                <td class="tipo"><g:select from="${tipoCompra}" name="tipoCompra"
                                           optionKey="id" optionValue="descripcion"
                                           value="${obra.tipoCompra.id}"
                                           style="font-size: 9px;"/></td>

                <td class="cantidad">
                    <input type="text" style="width: 50px;color:black; text-align: right;"
                           class="cantidad can_${asg.id}" asg="${asg.id}" max="${asg.planificado}"
                           value="${g.formatNumber(number: obra.cantidad, format: '###,##0', maxFractionDigits: 2, minFractionDigits: 2)}" ${(actual.estado != 0) ? "disabled" : ""}>
                </td>

                <td class="costo">
                    <input type="text" style="width: 60px;color:black; text-align: right;"
                           class="costo costo_${asg.id}" asg="${asg.id}" max="${asg.planificado}"
                           value="${g.formatNumber(number: obra.costo, format: '###,##0', maxFractionDigits: 2, minFractionDigits: 2)}" ${(actual.estado != 0) ? "disabled" : ""}>
                </td>

                <td class="ctr1">
                    <input type="checkbox"
                           class="chk ctr1" ${(obra.cuatrimestre1 == "1") ? "checked" : ""} ${(actual.estado != 0) ? "disabled" : ""}>
                </td>

                <td class="ctr2"><input type="checkbox"
                                        class="chk ctr2" ${(obra.cuatrimestre2 == "1") ? "checked" : ""} ${(actual.estado != 0) ? "disabled" : ""}>
                </td>

                <td class="ctr3"><input type="checkbox"
                                        class="chk ctr3" ${(obra.cuatrimestre3 == "1") ? "checked" : ""} ${(actual.estado != 0) ? "disabled" : ""}>
                </td>

                <td class="desc_obs">
                    <input type="hidden" id="dscr_${k}${i}${j}" class="desc"
                           value="${obra.descripcion}">

                    <input type="hidden" id="obs_${k}${i}${j}" class="obs"
                           value="${obra.observaciones}">

                    <a href="#" class="btn_editar" desc="dscr_${k}${i}${j}"
                       obs="obs_${k}${i}${j}">Editar</a>
                </td>

                <td class="agr">
                    <a href="#" class="btn_agregar" desc="agr_${k}${i}${j}" ml="${asg.id}" max="${asg.planificado}"
                       obs="agr_${k}${i}${j}">Agregar</a>

                    <a href="#" class="btn_eliminar" desc="elm_${k}${i}${j}" ml="${asg.id}" max="${asg.planificado}" iden="${obra.id}"
                       obs="elm_${k}${i}${j}">Eliminar</a>
                </td>

                <td>
                    <g:if test="${actual.estado==0}">
                        <a href="#" class="btn guardar ajax ajax" ml="${asg.id}"
                           iden="${obra.id}" icono="ico_${k}${i}${j}" max="${asg.planificado}"
                           clase="_${asg.id}" asg="asignado_${asg.id}">Guardar</a>
                    </g:if>
                </td>

                <td class="ui-state-active">
                    <span class="" id="ico_${k}${i}${j}" title="asignado">
                        <span class="ui-icon ui-icon-check"></span>
                    </span>
                </td>
            </tr>
        </g:each>
    </g:if>
    <g:else>
        <g:if test="${actual.estado==0}">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <td class="fuente"
                    style="font-size: 11px;">${(asg.fuente.toString().size() > 40) ? asg.fuente.toString().substring(0, 40) : asg.fuente}</td>

                <td class="asg" style="font-size: 11px;">
                    <input type="hidden" class="asg" value="${asg.id}">
                    <g:formatNumber number="${asg.planificado}" format="###,##0"
                                    minFractionDigits="2" maxFractionDigits="2"/>
                </td>

                <td>
                    ${asg.presupuesto.descripcion} (${asg.presupuesto.numero})
                </td>

                <td class="unidad"><g:select from="${unidades}" name="unidad" value=""
                                             optionKey="id" optionValue="descripcion"
                                             style="font-size: 9px;"/></td>

                <td class="cp">
                    <input type="hidden" class="cpac" value="nan">

                    <input type="text" id="cpac_n${k}${i}" style="width: 100px;"
                           class="buscar">
                </td>

                <td class="tipo"><g:select from="${tipoCompra}" name="tipoCompra"
                                           optionKey="id" optionValue="descripcion"
                                           style="font-size: 9px;"/></td>

                <td class="cantidad"><input type="text" style="width: 50px;"
                                            class="cantidad can_${asg.id}" value="1">
                </td>

                <td class="costo"><input type="text" style="width: 60px;"
                                         class="costo costo_${asg.id}">
                </td>


                <td class="ctr1"><input type="checkbox" class="chk ctr1"></td>

                <td class="ctr2"><input type="checkbox" class="chk ctr2"></td>

                <td class="ctr3"><input type="checkbox" class="chk ctr3"></td>

                <td class="desc_obs">
                    <input type="hidden" id="dscr_${k}${i}" class="desc">

                    <input type="hidden" id="obs_${k}${i}" class="obs">

                    <a href="#" class="btn_editar" desc="dscr_${k}${i}"
                       obs="obs_${k}${i}">Editar</a>
                </td>

                <td class="agr">
                    <a href="#" class="btn_agregar" id="agr_${k}${i}${j}" desc="agr_${k}${i}${j}" ml="${asg.id}" style="display: none;" max="${asg.planificado}"
                       obs="agr_${k}${i}">Agregar</a>

                    <a href="#" class="btn_eliminar" id="elm_${k}${i}${j}" desc="elm_${k}${i}${j}" ml="${asg.id}" style="display: none;" max="${asg.planificado}"
                       obs="elm_${k}${i}">Eliminar</a>
                </td>

                <td><a href="#" class="btn guardar ajax" ml="${asg.id}" ident="${k}${i}${j}"
                       icono="ico_${k}${i}${j}" max="${asg.planificado}" clase="_${asg.id}"
                       asg="asignado_${asg.id}">Guardar</a></td>

                <td class="ui-state-active"><span class="" id="ico_${k}${i}${j}"
                                                  title="asignado"
                                                  style="display: none"><span
                            class="ui-icon ui-icon-check"></span></span></td>
            </tr>
        </g:if>
    </g:else>
</g:each>
%{--</tr>--}%
%{--</g:each>--}%
</tbody>
</table>

<div id="divTotalPresupuestos" style="position: absolute; top: 15px; left: 2px;">
    <span style="font-weight: bold; margin-right: 5px;">Total Presupuestos:</span>
    <span class="totalPresupuestos">

    </span>
</div>

<div id="divTotalCostos" style="position: absolute; top: 2px; left: 300px;">
    <span style="font-weight: bold; margin-right: 5px;">Total Costos:</span>
    <span class="totalCostos">

    </span>
</div>

<div class="ui-corner-all" style="height: 15px;margin-top: 5px;">
    %{--<div style="width: 100px;float: left"><b>Monto:</b> ${act.monto}</div><div style="width: 100px;float: left;margin-left: 10px;"><b>Por asignar:</b></div> <div id="asignado_${act.id}" class="asignado" style="width: 100px;float: left" monto="${act.monto}">${(act.monto-asignado.toDouble()).toFloat().round(2)}</div><br>--}%
</div>

</fieldset>
</g:if>
</g:each>
</div>

<div id="buscar">
    <input type="hidden" id="id_txt">

    <div>
        Buscar por:
        <select id="tipo">
            <option value="1">Número</option>
            <option value="2">Descripción</option>
        </select>

        <input type="text" id="par" style="width: 160px;">

        <a href="#" class="btn" id="btn_buscar">Buscar</a>
    </div>

    <div id="resultado" style="width: 450px;margin-top: 10px;" class="ui-corner-all"></div>
</div>

<div id="dlg_desc_obs">
    <input type="hidden" id="hid_desc">

    <input type="hidden" id="hid_obs">
    <b>Descripción (255 caracteres):</b><br>

    <textArea name="desc" rows="6" cols="40" id="dlg_desc" ${(actual.estado != 0) ? "disabled" : ""}
              style="color: black"></textArea>
    <b>Observaciones (127 caracteres):</b><br>

    <textArea name="desc" rows="4" cols="40" id="dlg_obs" ${(actual.estado != 0) ? "disabled" : ""}
              style="color: black"></textArea> <br>

    <div id="dlg_error"
         style="width: 350px;height: 60px;margin-top: 5px;margin-left: 2px;display: none;padding: 3px;line-height: 24px;border:1px solid red;"
         class="ui-corner-all"></div>
</div>

%{--TODO validar al rato de guardar, poner en disabled los campos despues de guardar--}%

<script type="text/javascript">

    function sumas(fieldset) {

        var tp = 0, tc = 0;

//                //console.log(fieldset.find("td.asg"));
//                //console.log(fieldset.find("input.costo"));
//                //console.log(fieldset.find(".totalPresupuestos"));
//                //console.log(fieldset.find(".totalCostos"));

        fieldset.find("td.asg").each(function () {
            var v = $(this).text().trim();
            v = str_replace(".", "", v);
            v = str_replace(",", ".", v);
            v = parseFloat(v);
            if (!isNaN(v)) {
                tp += v;
            }
        });

        fieldset.find("input.costo").each(function () {
            var v = $(this).val().trim();
            v = str_replace(".", "", v);
            v = str_replace(",", ".", v);
            v = parseFloat(v);
            if (!isNaN(v)) {
                var cant = parseFloat($(this).parent().prev().children().first().val());
                tc += (cant * v);
            }
        });

        fieldset.find(".totalPresupuestos").html(number_format(tp, 2, ",", "."));
        fieldset.find(".totalCostos").html(number_format(tc, 2, ",", "."));
    }

    function validarMax(fieldset, asg, max) {
//                //console.log(fieldset, asg, max);
        var total = 0;

        var arr = new Array();

        fieldset.find(".error").removeClass("error");

        fieldset.find(".costo [asg=" + asg + "]").each(function () {
//                    //console.log($(this));
            var costo = $(this).val();
            var cant = parseFloat($(this).parent().prev().children().first().val());

            arr.push($(this).parent().prev().children().first());
            arr.push($(this));

            costo = str_replace(".", "", costo);
            costo = str_replace(",", ".", costo);
            costo = parseFloat(costo);
            $(this).val(number_format(costo, 2, ",", ".")).css({textAlign:"right"});

//                    //console.log(costo + " x " + cant + " = " + (costo * cant) + "          " + total);

            total += (cant * costo);
        });

        if (total > max) {
            for (var i = 0; i < arr.length; i++) {
                arr[i].addClass("error");
            }
            alert("La suma de los campos marcados con rojo (" + number_format(total, 2, ",", ".") + ") debe ser inferior a " + number_format(max, 2, ",", "."));
            return false;
        } else {
            return true;
        }
    }

    $(function () {
        $("fieldset").each(function () {
            sumas($(this));
        });

        $(".costo").blur(function () {
            validarMax($(this).parents("fieldset"), $(this).attr("asg"), parseFloat($(this).attr("max")));
        });

        $(".cantidad").blur(function () {
            validarMax($(this).parents("fieldset"), $(this).attr("asg"), parseFloat($(this).attr("max")));
        });


        $(".btn_eliminar").button({
            icons:{
                primary:"ui-icon-trash"
            },
            text:false
        }).css({
                    width:18,
                    height:18
                }).click(function () {
                    if (confirm("Desea eliminar esta entrada?")) {
                        var btn = $(this);
                        var id = btn.attr("iden");

                        $.ajax({
                            type:"POST",
                            url:"${createLink(action:'eliminarFila',controller:'obra')}",
                            data:{
                                id:id
                            },
                            success:function (msg) {
                                if (msg == "OK") {
                                    window.location.reload(true);
                                }
                            }
                        });

                    }
                });
        $(".btn_agregar").button({
            icons:{
                primary:"ui-icon-plusthick"
            },
            text:false
        }).css({
                    width:18,
                    height:18
                }).click(function () {
                    if (confirm("Desea crear una nueva entrada en el plan de compras?")) {
                        var band = true
                        var mensaje = ""
                        var error
                        var max = $(this).attr("max") * 1
                        var asignado = 0
                        var padre = $(this).parent().parent()
                        var boton = $(this)
                        var costo = 0
                        var cantidad = 1
                        var unidad = padre.find(".unidad").children().val()
                        var cp = padre.find(".cp").find(".cpac").val()
                        var tipo = padre.find(".tipo").children().val()
                        var c1 = 0
                        var c2 = 0
                        var c3 = 0
                        var asg = boton.attr("ml")
                        var icono = $("#" + $(this).attr("icono"))
                        var valor = 0

                        $.ajax({
                            type:"POST",
                            url:"${createLink(action:'agregarFila',controller:'obra')}",
                            data:"costo=" + costo + "&unidad.id=" + unidad + "&cantidad=" + cantidad + "&tipoCompra.id=" + tipo + "&codigoComprasPublicas.id=" + cp + "&cuatrimestre1=" + c1 + "&cuatrimestre2=" + c2 + "&cuatrimestre3=" + c3 + "&asignacion.id=" + asg + ((isNaN(boton.attr("iden"))) ? "" : "&id=" + boton.attr("iden")),
                            success:function (msg) {
                                window.location.reload(true);
                            }
                        });
                    }
                });

        $("#breadCrumb").jBreadCrumb({
            beginingElementsToLeaveOpen:10
        });
        $(".btn").button()
        $(".btn_editar").button({
            icons:{
                primary:"ui-icon-pencil"
            },
            text:false
        }).click(function () {
                    $("#hid_desc").val($(this).attr("desc"))
                    $("#hid_obs").val($(this).attr("obs"))
                    $("#dlg_desc").val($("#" + $(this).attr("desc")).val())
                    $("#dlg_obs").val($("#" + $(this).attr("obs")).val())
                    $("#dlg_error").hide().html("")
                    $("#dlg_desc_obs").dialog("open")
                })
        $(".guardar").button({
            icons:{
                primary:"ui-icon-disk"
            },
            text:false
        })

        $("#anio_asg").change(function () {
            location.href = "${createLink(controller:'obra',action:'pacProyecto')}?id=${proyecto.id}&anio=" + $(this).val()
        });

        $(".guardar").click(function () {
            var boton = $(this);
            var max = $(this).attr("max") * 1;
            var asg = boton.attr("ml");
            var fieldset = $(this).parents("fieldset");

            if (validarMax(fieldset, asg, max)) {
                var band = true
                var mensaje = ""
                var error
                var asignado = 0
                var padre = $(this).parent().parent()

                var costo = padre.find(".costo").children().val();
                costo = str_replace(".", "", costo);
                costo = str_replace(",", ".", costo);
                costo = parseFloat(costo);
                var cantidad = padre.find(".cantidad").children().val();
                cantidad = str_replace(".", "", cantidad);
                cantidad = str_replace(",", ".", cantidad);
                cantidad = parseFloat(cantidad);
                var unidad = padre.find(".unidad").children().val()
                var cp = padre.find(".cp").find(".cpac").val()
                var tipo = padre.find(".tipo").children().val()
                var c1 = (padre.find(".ctr1").find(".ctr1").attr("checked") == "checked") ? 1 : 0
                var c2 = (padre.find(".ctr2").find(".ctr2").attr("checked") == "checked") ? 1 : 0
                var c3 = (padre.find(".ctr3").find(".ctr3").attr("checked") == "checked") ? 1 : 0
                var desc = padre.find(".desc_obs").find(".desc").val()
                var obs = padre.find(".desc_obs").find(".obs").val()

                var icono = $("#" + $(this).attr("icono"));
                var agr = $("#agr_" + $(this).attr("ident"));
                var elm = $("#elm_" + $(this).attr("ident"));
                var valor = 0
                if (isNaN(costo) || isNaN(cantidad)) {
                    band = false
                    mensaje = "El costo y la cantidad deben ser números"
                } else {
                    valor = cantidad * costo
                    if (valor > max) {
                        band = false
                        mensaje = "El valor total (" + valor + ") supera al monto de la asignación (" + max + ")"
                    } else {
                        if (valor == 0) {
                            band = false
                            mensaje = "El costo y la cantidad deben ser mayores a 0"
                        }
                    }
                }
                if (c1 + c2 + c3 < 1) {
                    band = false
                    mensaje = "Seleccione al menos un cuatrimestre"
                }

                if (isNaN(cp)) {
                    band = false
                    mensaje = "Seleccione un código de compras publicas"
                }

                ////console.log("costo "+costo+" cantidad "+cantidad+" unidad "+unidad+" cp "+cp+" tipo "+tipo+" c1 "+c1+" c2 "+c2+" c3 "+c3+" desc "+desc+" obs "+obs+" asg "+asg )

                if (band) {
//                            var fieldset = $(this).parents("fieldset");
//                    //console.log(fieldset);
                    $.ajax({
                        type:"POST",
                        url:"${createLink(action:'guardarObra',controller:'obra')}",
                        data:"costo=" + costo + "&unidad.id=" + unidad + "&cantidad=" + cantidad + "&tipoCompra.id=" + tipo + "&codigoComprasPublicas.id=" + cp + "&cuatrimestre1=" + c1 + "&cuatrimestre2=" + c2 + "&cuatrimestre3=" + c3 + "&descripcion=" + desc + "&observaciones=" + obs + "&asignacion.id=" + asg + ((isNaN(boton.attr("iden"))) ? "" : "&id=" + boton.attr("iden")),
                        success:function (msg) {
                            if (msg * 1 >= 0) {
                                var totalCostos = 0;

//                                        fieldset.find("input.costo").each(function () {
//                                            var cant = $(this).parent().prev().children().first().val();
//                                            var cost = $(this).val();
////                                    //console.log(cant);
////                                    //console.log(cost);
////                                    //console.log("---");
//                                            cant = parseFloat(cant);
//                                            cost = parseFloat(cost);
////                                    //console.log(cant);
////                                    //console.log(cost);
////                                    //console.log("---");
//                                            totalCostos += (cost * cant);
////                                    //console.log(totalCostos);
////                                    //console.log("***************************");
//                                        });
//
//                                        fieldset.find(".totalCostos").text(number_format(totalCostos, 2, ',', '.'));

                                boton.attr("iden", msg);
                                icono.show("pulsate");
                                agr.show();
                                elm.show();
                                var v = number_format(costo, 2, ",", ".");
                                padre.find(".costo").children().css({textAlign:"right"}).val(v);
                                sumas(fieldset);
                            } else {
                                alert("Error al guardar los datos")
                            }

                        }
                    });
                } else {
                    alert(mensaje)
//            error.addClass("error").show("pulsate")
                }
            }
            return false;
        });

        $(".buscar").click(function () {
            $("#id_txt").val($(this).attr("id"))
            $("#buscar").dialog("open")
        });
        $("#btn_buscar").click(function () {
            $.ajax({
                type:"POST",
                url:"${createLink(action:'buscarCcp',controller:'asignacion')}",
                data:"parametro=" + $("#par").val() + "&tipo=" + $("#tipo").val(),
                success:function (msg) {
                    $("#resultado").html(msg)
                }
            });
        });
        $("#buscar").dialog({
            title:"Cuentas presupuestarias",
            width:620,
            height:500,
            autoOpen:false,
            modal:true
        })
        $("#dlg_desc_obs").dialog({
            title:"Editar descripción y observaciones",
            width:400,
            height:400,
            autoOpen:false,
            modal:true,
            buttons:{
                "Aceptar":function () {
                    if ($("#dlg_desc").val().length < 255) {
                        if ($("#dlg_obs").val().length < 127) {
                            $("#" + $("#hid_desc").val()).val($("#dlg_desc").val())
                            $("#dlg_desc").val("")
                            $("#" + $("#hid_obs").val()).val($("#dlg_obs").val())
                            $("#dlg_obs").val("")
                            $("#dlg_desc_obs").dialog("close")
                        } else {
                            $("#dlg_error").html("El campo observaciones no puede contener mas de 127 caracteres. Actual(" + $("#dlg_obs").val().length + ")")
                            $("#dlg_error").addClass("error")
                            $("#dlg_error").show("pulsate")
                        }
                    } else {
                        $("#dlg_error").html("El campo descripción no puede contener mas de 255 caracteres. Actual(" + $("#dlg_dscr").val().length + ")")
                        $("#dlg_error").addClass("error")
                        $("#dlg_error").show("pulsate")
                    }
                }

            }
        })
    });

</script>

</body>
</html>