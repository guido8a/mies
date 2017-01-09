package mies
class Cuatrimestre implements Serializable {
    Integer numero
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'ctrm'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'ctrm__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'ctrm__id'
            numero column: 'ctrmnmro'
            descripcion column: 'ctrmdscr'
        }
    }
    static constraints = {
        numero(blank: true, nullable: true, attributes: [mensaje: 'Número de cuatrimestre'])
        descripcion(size: 1..15, blank: true, nullable: true, attributes: [mensaje: 'Descripción del cuatrimestre'])
    }
}