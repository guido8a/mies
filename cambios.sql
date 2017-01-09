-- Registro de cambios
-- 16-nov-2011

CREATE TABLE ejpg
(
  ejpg__id serial NOT NULL,
  ejpgdscr character varying(127) NOT NULL,
  ejpgordn integer NOT NULL,
  CONSTRAINT ejpg_pkey PRIMARY KEY (ejpg__id )
)
WITH (
  OIDS=FALSE
);
ALTER TABLE ejpg
  OWNER TO postgres;
COMMENT ON TABLE ejpg
  IS 'Ejes programáticos';

-- inserción da datos
insert into ejpg values (1,'Generación de capacidades', 1);
insert into ejpg values (2,'Sistema de protección social integral', 2);
insert into ejpg values (3,'Sistema económico social y solidario', 3);
insert into ejpg values (4,'Reforma del estado', 4);

-- Tabla proyectospara registro de codigo esigef.
alter table proy add proysigf varchar(3);


-- Actualizacion de los pasos para el estado del proyecto
delete from paso where paso__id in (2,3,4);

update paso
  set
     pasotbla = 'Proyecto,MetaBuenVivirProyecto,PoliticasAgendaProyecto,PoliticasProyecto',
     pasotbes = 'Proyecto,Metas del buen vivir,Políticas de agenda social,Políticas MIES'
  where paso__id = 1;

update paso
  set
     pasonmbr = 'Indicadores financieros',
     pasotbla = 'IndicadoresSenplades',
     pasotbes = 'Indicadores de la Senplades',
     pasodscr = 'Indicadores financieros del proyecto'
  where paso__id = 5;

update paso
  set
     pasonmbr = 'Entidades participantes',
     pasotbla = 'EntidadesProyecto',
     pasotbes = 'Entidades participantes',
     pasodscr = 'Entidades participantes del proyecto'
  where paso__id = 6;

insert into paso (prcs__id,pasonmbr,pasodscr, pasooblg,pasoetdo, pasotbla,pasotbes,pasoordn)
        values(1,'Presupuesto/Fuentes','Presupuestos y/o fuentes del proyecto',0,'A','Financiamiento','Financiamiento',4);


--Problemas con parroquias.

  update parr set cntn__id = 178 where parr__id = 779;

-- Cambios para manejar orden de entidades
alter table unej add unejordn integer;
update unej set unejordn = 1;


--Cambios 13/12/2011
ALTER TABLE asgn DROP COLUMN actv__id ;
--despues de esto reiniciar el servidor para que el hibernate vuelva a crear la columna con el cambio
 UPDATE crng SET mesvlor2 = 0;

-- desc de crng:
  Column  |       Type       |                        Modifiers                        
----------+------------------+---------------------------------------------------------
 crng__id | integer          | not null default nextval('crng_crng__id_seq'::regclass)
 crngpdre | integer          | 
 mess__id | integer          | 
 mrlg__id | integer          | 
 fnte__id | integer          | 
 anio__id | integer          | 
 mdfc__id | integer          | 
 messvlor | numeric(14,2)    | 
 crngfcin | date             | 
 crngfcfn | date             | 
 prsp__id | bigint           | 
 prsp2_id | bigint           | 
 mesvlor2 | double precision | 

-- desc prue

CREATE TABLE prue
(
  prue__id bigserial NOT NULL,
  anio__id bigint NOT NULL,
  unej__id bigint NOT NULL,
  pruemxcr numeric(14,2),
  pruemxiv numeric(14,2),
  CONSTRAINT prue_pkey PRIMARY KEY (prue__id ),
  CONSTRAINT fk34a41232edebe5 FOREIGN KEY (anio__id)
      REFERENCES anio (anio__id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk34a4124bcbdf1a FOREIGN KEY (unej__id)
      REFERENCES unej (unej__id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE prue
  OWNER TO postgres;

-- 15-dic-2011
-- cambios para tener referencia padre - hijo en asignaciones.
alter table asgn add asgnpdre integer;

-- desc de asgn
  Column  |          Type           |                        Modifiers                        
----------+-------------------------+---------------------------------------------------------
 asgn__id | integer                 | not null default nextval('asgn_asgn__id_seq'::regclass)
 anio__id | integer                 | 
 fnte__id | integer                 | 
 mrlg__id | integer                 | 
 prsp__id | integer                 | 
 tpgs__id | integer                 | 
 asgnplan | numeric(14,2)           | 
 asgnrdst | numeric(14,2)           | 
 unej__id | bigint                  | 
 pgps__id | bigint                  | 
 asgnactv | character varying(1024) | 
 asgnpdre | bigint                  | 


arreglo de la tabla pgps: programas presupuestarios

copy pgps_t from '/tmp/pgps_t.csv' DELIMITERS '&' CSV;
update pgps set pgpscdgo = pgps__id;
update pgps set pgpsdscr = (select pgpsdscr from pgps_t where cast(pgps_t.pgpscdgo as integer) = pgps.pgps__id);
insert into pgps(pgpscdgo, pgpsdscr) select pgpscdgo, pgpsdscr from pgps_t where pgpscdgo not in (select pgpscdgo from pgps);
copiar datos desde pgps.csv.



Arreglar las asignaciones!!
SELECT a.asgn__id,a.mrlg__id,a.unej__id,a.asgnplan,asgnplan - (select sum(messvlor) from pras where asgn__id=a.asgn__id ) from asgn as a order by 5 ;

select asgn.asgn__id, mrlg__id, unej__id, asgnplan, prsp__id, asgnplan - sum(messvlor) 
from asgn, pras 
where pras.asgn__id = asgn.asgn__id 
group by asgn.asgn__id, mrlg__id, unej__id, asgnplan, prsp__id
having asgnplan - sum(messvlor) <> 0;

SELECT unejnmbr from unej where unej__id in (85,93,96);
entrar por el sistema y arreglar.... buscar en el arbol esas unidades y arreglar por el sistema mismo

--fuentes de financiamiento
update fnte set fntecdgo = '001' where fnte__id = 1;

update pgps set pgpscdgo = '01' where pgpscdgo = '1';
update pgps set pgpscdgo = '02' where pgpscdgo = '2';
update pgps set pgpscdgo = '04' where pgpscdgo = '4';

-- cp -r /home/guido/.grails/1.3.7/projects/mies/plugins/pdf-0.6 .

------------------- arreglo de cronograma con valores negativos ----
--!! alter table meta alter metainvs type numeric(14,2);


1. vseer proyectos
   select proy__id, substr(proynmbr, 1,50) from proy;
2. del proyecto en cuestion:
select sum(messvlor + mesvlor2) cronograma, sum(metainvs) meta, sum(metainvs) - sum(messvlor + mesvlor2) diff,  mrlg.mrlg__id, crng.anio__id, mrlgobjt from crng, mrlg, meta where mrlg.mrlg__id = crng.mrlg__id and proy__id = 7  and mrlg.mrlg__id = meta.mrlg__id  group by mrlg.mrlg__id, crng.anio__id, mrlgobjt;
3. identificar el mrlg__id del problema: 162

-- hay valores en el cronogrma que no tienen metas.


-- valores en cronograma superiores a las metas....
select sum(messvlor + mesvlor2) cronograma, sum(metainvs) meta, sum(metainvs) - sum(messvlor + mesvlor2) diff,  mrlg.mrlg__id, crng.anio__id, mrlgobjt from crng, mrlg, meta where mrlg.mrlg__id = crng.mrlg__id and proy__id = 13  and mrlg.mrlg__id = meta.mrlg__id  group by mrlg.mrlg__id, crng.anio__id, mrlgobjt;

update crng set messvlor = 0 , mesvlor2 = 0 where  mrlg__id = 225;
update crng set messvlor = 0 , mesvlor2 = 0 where  mrlg__id = 229;

-- aparecen con valores negativos en "Sin asignar"
select * from crng where mrlg__id in (152,153,154,163);


update crng set messvlor = 0 , mesvlor2 = 0 where  mrlg__id in (152,153,154, 163);


--Cambios en aprovacion de asignaciones... correr el war y despues ejecutar los sqls
update prue SET prueapcr = 0;
update prue SET prueapin = 0;
update prue SET prueorcr = 0;
update prue SET prueorin = 0;


--Arreglar cronogramana
   DELETE FROM pras WHERE asgn__id in (select asgn__id FROM asgn WHERE  mrlg__id is not null and mrlg__id in (select mrlg__id from mrlg where proy__id = 13)) ;
   delete from asgn where mrlg__id in(select mrlg__id from mrlg where proy__id = 13);
   DELETE FROM crng WHERE crng__id in (582,636,635,637);

-- borrar proyectos:

   delete from etpy where proy__id = 2;
   delete from fina where proy__id = 2;
   delete from crng where mrlg__id in (select mrlg__id from mrlg where proy__id = 2);
   delete from mrlg where proy__id = 2;
   delete from mtpy where proy__id = 2;
   delete from papy where proy__id = 2;
   delete from plpy where proy__id = 2;


 -- Arreglar maximo corrientes
 update prue set pruemxcr = pruemxcr + 1381.81 where prue__id = 43;

/* 21-mar-2012 
* Bloqueo de acceso a los proyectos para personal de Planificación y dueños de proyectos (personal de UE)
* Responsables: dar de baja, reasignar y reactivar
* --------- ALERTAS----------
* Reportes de alertas de programación de asignaciones
* Alertas respecto de lo ejecutado en el eSIGEF
* Solicitudes pendientes de certificaciones POA y PAC
* ---------- corregir-------
* Solicitud de certifcaciones
* ------Anular certificaciones y volver a certificar ----
* Para la anulación de una certificación se debe cargar un pdf de "insubsistencia"
* Modificar la signación
* Cetificar lo nuevo
* =============== Cambios ===============
* Hacer que el registro y control de proyectos sea algo satélite al POA de inversiones:
* - Usar el proyecto sólo hasta generar registros en ASGN
* - Una vez que hay registros en ASGN se los debe gestionar independiente del proyecto
* - Las asignaciones se pueden reasignar a otras UE
* - Cada UE puede dividir o modificar la partida del dinero reasignado (padre)
* + Registro de METAS por componente no por actividad:
*   - Dentro de cada componente se registran tanto para corrientes como para inversiones
*     las actividades (texto) y metas (valores y unidades)
*   - Debe haber algún control para determinar si yase han ejecutado las metas:
*     - Para registro de avance de metas debe haber una asignación certificada
*     - Puede haber un PAC certificado.
*/



---- arreglo de asignaciones perdidas al modificar cronograma y correr asignaciones.
asgn__id | anio__id | fnte__id | mrlg__id | prsp__id | tpgs__id | asgnplan  | asgnrdst | unej__id | pgps__id | asgnactv | asgnpdre | asgnindi | asgnmeta | comp__id | unejrcbe | asgnrubi
----------+----------+----------+----------+----------+----------+-----------+----------+----------+----------+----------+----------+----------+----------+----------+----------+----------
     6213 |        3 |        1 |      136 |      350 |          |  67000.00 |     0.00 |       55 |          |          |     5513 |          |          |          |          | N
     6243 |        3 |        1 |      142 |      364 |          |  19658.45 |     0.00 |       55 |          |          |     5528 |          |          |          |          | N
     6244 |        3 |        1 |      142 |      362 |          | 137341.55 |     0.00 |       55 |          |          |     5528 |          |          |          |          | N
(3 rows)


insert into asgn values(default,3,1,136,350,null,67000,0,103,null,null,null,null,null,null,null,'N');
insert into asgn values(default,3,1,142,364,null,19658.45,0,103,null,null,null,null,null,null,null,'N');
insert into asgn values(default,3,1,142,362,null,137341.55,0,103,null,null,null,null,null,null,null,'N');

Los IDs afectados fueron: 7347, 7348 y 7349.

insert into asgn VALUES (default,3,1,143,358,null,43126.71,0,40,null,null,null,null,null,null,null,'N');
El ID generado es: 7350.

-- cambio de códigos en prgogramas presupuestarios
update pgps set pgpscdgo = substr(pgpscdgo,2,3);

-- Asignaciones dobles:
update asgn set asgnplan=0 where asgn__id = 4469;
update asgn set asgnplan=0 where asgn__id = 4464;
update asgn set asgnplan=0 where asgn__id = 4465;
update asgn set asgnplan=0 where asgn__id = 4466;

