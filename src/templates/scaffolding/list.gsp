<% import grails.persistence.Event %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName"
               value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>

    <body>

        <div class="dialog" title="\${title}">


            <div class="body">
                <g:if test="\${flash.message}">
                    <div class="message">\${flash.message}</div>
                </g:if>
                <div class="list" style="width: 600px;">
                    <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-top ui-helper-clearfix">
                        %{--<div id="example_length" class="dataTables_length">--}%
                            %{--<g:message code="show" default="Show" />&nbsp;--}%
                            %{--<g:select from="\${[10,20,30,40,50,60,70,80,90,100]}" name="max" value="\${params.max}" />&nbsp;--}%
                            %{--<g:message code="entries" default="entries" />--}%


                            %{--<g:select--}%
                                %{--from="['asc':message(code:'asc', default:'Ascendente'), 'desc':message(code:'desc', default:'Descendente')]"--}%
                                %{--name="order"--}%
                                %{--optionKey="key"--}%
                                %{--optionValue="value"--}%
                                %{--value="\${params.order}"--}%
                                %{--class="ui-widget-content ui-corner-all"/>--}%
                        %{--</div>--}%
                    </div>
                    <table style="width: 600px;">
                        <thead>
                            <tr>
                                <% excludedProps = Event.allEvents.toList() << 'version'
                                allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
                                props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && !Collection.isAssignableFrom(it.type) }
                                Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                                props.eachWithIndex { p, i ->
                                    if (i < 6) {
                                        if (p.isAssociation()) { %>
                                <th class="ui-state-default"><g:message code="${domainClass.propertyName}.${p.name}.label"
                                               default="${p.naturalName}" /></th>
                                <% } else { %>
                                <tdn:sortableColumn property="${p.name}" class="ui-state-default"
                                                  title="\${message(code: '${domainClass.propertyName}.${p.name}.label', default: '${p.naturalName}')}" />
                                <% }
                                }
                                } %>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
                                <tr class="\${(i % 2) == 0 ? 'odd' : 'even'}">
                                    <% props.eachWithIndex { p, i ->
                                        if (i == 0) { %>
                                    <td><g:link action="show"
                                                id="\${${propertyName}.id}">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</g:link></td>
                                    <% } else if (i < 6) {
                                        if (p.type == Boolean.class || p.type == boolean.class) { %>
                                    <td><g:formatBoolean boolean="\${${propertyName}.${p.name}}" /></td>
                                    <% } else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) { %>
                                    <td><g:formatDate date="\${${propertyName}.${p.name}}" /></td>
                                    <% } else { %>
                                    <td>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
                                    <% }
                                    }
                                    } %>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

                <div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bottom ui-helper-clearfix paginateButtons">
                    <tdn:paginate total="\${${propertyName}Total}" />
                </div>
            </div> <!-- body -->
        </div> <!-- dialog -->

        <script type="text/javascript">
            \$(function() {
                \$(".button").button();
                \$(".home").button("option", "icons", {primary:'ui-icon-home'});
                \$(".create").button("option", "icons", {primary:'ui-icon-document'});

                \$(".edit").button("option", "icons", {primary:'ui-icon-pencil'});
                \$(".delete").button("option", "icons", {primary:'ui-icon-trash'}).click(function() {
                    if(confirm("\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}")) {
                        return true;
                    }
                    return false;
                });
            });
        </script>

    </body>
</html>
