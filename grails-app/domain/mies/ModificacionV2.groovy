package mies

class ModificacionV2 {

    String dominio
    String campo
    int id_remoto
    String oldValue
    String newValue
    Date fecha = new Date()
    mies.seguridad.Usro usuario
    String tipo
    static mapping = {
        table 'mdv2'
        cache usage:'read-write', include:'non-lazy'
        id column:'mdv2__id'
        id generator:'identity'
        version false
        columns {
            id column:'mdv2__id'
            dominio column: 'mdv2dmno'
            id_remoto column: 'mdv2idrm'
            oldValue column: 'mdv2olva'
            newValue column: 'mdv2nwva'
            usuario column: 'usro__id'
            fecha column: 'mdv2fcha'
            tipo column: 'mdv2tipo'
        }
    }
    static constraints = {
        dominio(nullable: false,blank:false)
        oldValue(size: 1..500,nullable: true,blank: true)
        newValue(size: 1..500,nullable: true,blank: true)
        dominio(size:1..120,nullable: false,blank: false)
        campo(size: 1..100,nullable: true,blank: true)
        tipo(size: 1..100,nullable: true,blank: true)
    }
}
