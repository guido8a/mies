package mies
class ParroquiasDistrito implements Serializable {
    int dstt__id
    int parr__id
    static auditable = [ignore: []]
    static mapping = {
        table 'prdt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prdt__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'prdt__id'
            dstt__id column: 'dstt__id'
            parr__id column: 'parr__id'
        }
    }
    static constraints = {
        dstt__id(blank: true, nullable: true, attributes: [mensaje: 'Distrito'])
        parr__id(blank: true, nullable: true, attributes: [mensaje: 'Parroquia'])
    }
}