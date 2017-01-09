package mies.seguridad

class Usro implements Serializable{
    mies.Persona persona
    mies.CargoPersonal cargoPersonal
    mies.UnidadEjecutora unidad
    String usroLogin
    String usroPassword
    String autorizacion
    String sigla
    int usroActivo
    Date fechaPass
    String observaciones
    
    static hasMany = [sesiones:Sesn, accesos: Accs,alertas:mies.alertas.Alerta]
    static auditable = [ ignore:['usroPassword']]
        
	                       
    static mapping = {
        table 'usro'
        cache usage:'read-write', include:'non-lazy'
        version false
        id generator: 'identity'
        
        columns {
            id column: 'usro__id'
            persona column: 'prsn__id'
            cargoPersonal column: 'cgpr__id'
            usroLogin column: 'usrologn'
            usroPassword column: 'usropass'
            autorizacion column: 'usroatrz'
            sigla column: 'usrosgla'
            usroActivo column: 'usroactv'
            fechaPass column: 'usrofcps'
            observaciones column: 'usroobsr'
            unidad column: 'unej__id'
        }
    }
	
    static constraints = {
        persona(blank:false,nullable: false, attributes: [mensaje: 'Persona'],unique:true)
        cargoPersonal(blank:true,nullable: true, attributes: [mensaje: 'Cargo'])
        usroLogin(matches:/^[a-zA-Z0-9ñÑ .,áéíóúÁÉÍÚÓüÜ#_+-]{1,15}$/,size:1..15,blank:false,nullable:false,unique:true, attributes: [mensaje: 'Nombre de usuario'])
        usroPassword(matches:/^[a-zA-Z0-9ñÑ .,áéíóúÁÉÍÚÓüÜ#_+-]+$/,size:1..64,blank:false,nullable:false, attributes: [mensaje: 'Contraseña para el ingreso al sistema'])
        autorizacion (matches:/^[a-zA-Z0-9ñÑ .,áéíóúÁÉÍÚÓüÜ#_+-]+$/,size:1..255,blank:false,nullable:false, attributes: [mensaje: 'Contraseña para autorizaciones'])
        sigla (matches:/^[a-zA-Z]{1,8}$/,size:1..8,blank:false,nullable:false, attributes: [mensaje: 'Sigla del usuario'])
        usroActivo (matches:/^[0-1]{1}$/,size:1..1,blank:false,nullable: false, attributes: [mensaje: 'Usuario activo o no'])
        fechaPass (blank:true, nullable:true, attributes: [mensaje: 'Fecha de cambio de contraseña'])
        observaciones (matches:/^[a-zA-Z0-9ñÑ .,áéíóúÁÉÍÚÓüÜ#_+-]+$/,size:1..255,blank:true, nullable:true, attributes: [mensaje: 'Observaciones'])
        unidad(blank: true,nullable: true, attributes: [mensaje: 'Unidad Ejecutora a la que pertenece el usuario'])
    }

    
    String toString(){
        return "${this.usroLogin}"
    }
    
}
