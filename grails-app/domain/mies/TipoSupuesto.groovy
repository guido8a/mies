package mies
class TipoSupuesto implements Serializable {
    String descripcion
    static auditable=[ignore:[]]
    static mapping = {
        table 'tpsp'
        cache usage:'read-write', include:'non-lazy'
        id column:'tpsp__id'
        id generator:'identity'
        version false
        columns {
            id column:'tpsp__id'
            descripcion column: 'tpspdscr'
        }
    }
    static constraints = {
        descripcion(size:1..255, blank:true, nullable:true ,attributes:[mensaje:'Descripción del tipo de supuesto'])
    }

    String toString(){
        "${this.descripcion}"
    }
}