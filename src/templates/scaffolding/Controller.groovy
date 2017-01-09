<%=packageName ? "package ${packageName}\n\n" : ''%>class ${className}Controller {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code:"${className.toLowerCase()}.list", default:"${className} List")
//        <g:message code="default.list.label" args="[entityName]" />
        
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [${propertyName}List: ${className}.list(params), ${propertyName}Total: ${className}.count(), title: title, params:params]
    }

    def form = {
        def title
        def ${propertyName}

        if(params.source == "create") {
            ${propertyName} = new ${className}()
            ${propertyName}.properties = params
            title = g.message(code:"${className.toLowerCase()}.create", default:"Create ${className}")
        } else if(params.source == "edit") {
            ${propertyName} = ${className}.get(params.id)
            if (!${propertyName}) {
                flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code:"${className.toLowerCase()}.edit", default:"Edit ${className}")
        }

        return [${propertyName}: ${propertyName}, title:title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action:"form", params:params)
    }

    def save = {
        def title
        if(params.id) {
            title = g.message(code:"${className.toLowerCase()}.edit", default:"Edit ${className}")
            def ${propertyName} = ${className}.get(params.id)
            if (${propertyName}) {
                ${propertyName}.properties = params
                if (!${propertyName}.hasErrors() && ${propertyName}.save(flush: true)) {
                    flash.message = "\${message(code: 'default.updated.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])}"
                    redirect(action: "show", id: ${propertyName}.id)
                }
                else {
                    render(view: "form", model: [${propertyName}: ${propertyName}, title:title, source: "edit"])
                }
            }
            else {
                flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code:"${className.toLowerCase()}.create", default:"Create ${className}")
            def ${propertyName} = new ${className}(params)
            if (${propertyName}.save(flush: true)) {
                flash.message = "\${message(code: 'default.created.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])}"
                redirect(action: "show", id: ${propertyName}.id)
            }
            else {
                render(view: "form", model: [${propertyName}: ${propertyName}, title:title, source: "create"])
            }
        }
    }

    def update = {
        def ${propertyName} = ${className}.get(params.id)
        if (${propertyName}) {
            if (params.version) {
                def version = params.version.toLong()
                if (${propertyName}.version > version) {
                    <% def lowerCaseName = grails.util.GrailsNameUtils.getPropertyName(className) %>
                    ${propertyName}.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: '${domainClass.propertyName}.label', default: '${className}')] as Object[], "Another user has updated this ${className} while you were editing")
                    render(view: "edit", model: [${propertyName}: ${propertyName}])
                    return
                }
            }
            ${propertyName}.properties = params
            if (!${propertyName}.hasErrors() && ${propertyName}.save(flush: true)) {
                flash.message = "\${message(code: 'default.updated.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])}"
                redirect(action: "show", id: ${propertyName}.id)
            }
            else {
                render(view: "edit", model: [${propertyName}: ${propertyName}])
            }
        }
        else {
            flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def ${propertyName} = ${className}.get(params.id)
        if (!${propertyName}) {
            flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code:"${className.toLowerCase()}.show", default:"Show ${className}")

            [${propertyName}: ${propertyName}, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action:"form", params:params)
    }

    def delete = {
        def ${propertyName} = ${className}.get(params.id)
        if (${propertyName}) {
            try {
                ${propertyName}.delete(flush: true)
                flash.message = "\${message(code: 'default.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "\${message(code: 'default.not.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
            redirect(action: "list")
        }
    }
}
