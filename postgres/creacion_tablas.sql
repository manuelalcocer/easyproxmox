drop table operaciones;
drop table tipos_operaciones;
drop table plantillas;
drop table contenedores;
drop table maquinas_virtuales;
drop table nodos;
drop table logueos;
drop table usuarios;
drop table centros_de_datos;

create table centros_de_datos (
    id      serial,
    nombre  varchar(30),
    url     varchar(100),
    constraint pk_centros_de_datos primary key (id),
    constraint url_unique UNIQUE (url)
);

create table usuarios (
    id          serial,
    id_centro   integer,
    nombre      varchar(30),
    constraint pk_usuarios primary key (id),
    constraint fk_usuarios_centros foreign key (id_centro) references centros_de_datos (id)
);

create table logueos (
    id          serial,
    fechahora   timestamp,
    id_usuario  integer,
    ticket      varchar(400),
    csfr        varchar(100),
    constraint pk_logueos primary key (id, fechahora),
    constraint fk_logueos_id_usuario foreign key (id_usuario) references usuarios (id)
);

create table nodos (
    id          serial,
    id_centro   integer,
    nombre      varchar(30),
    constraint pk_nodos primary key (id),
    constraint fk_nodos_centros foreign key (id_centro) references centros_de_datos (id)
);

create table maquinas_virtuales (
    id          serial,
    id_nodo     integer,
    nombre      varchar(30),
    constraint pk_maquinas_virtuales primary key (id),
    constraint fk_maquinas_nodos foreign key (id_nodo) references nodos (id)
);

create table contenedores (
    id          serial,
    id_nodo     integer,
    nombre      varchar(30),
    constraint pk_contenedores primary key (id),
    constraint fk_contenedores_nodos foreign key (id_nodo) references nodos (id)
);

create table plantillas (
    id          serial,
    id_nodo     integer,
    nombre      varchar(30),
    constraint pk_plantillas primary key (id),
    constraint fk_plantillas_nodos foreign key (id_nodo) references nodos (id)
);

create table tipos_operaciones (
    id              serial,
    nombre          varchar(30),
    descripcion     varchar(100),
    constraint pk_tipos_operaciones primary key (id)
);

create table operaciones (
    id          serial,
    fechahora   timestamp,
    id_usuario  integer,
    id_nodo     integer,
    id_tipo     integer,
    constraint pk_operaciones primary key (id,fechahora),
    constraint fk_operaciones_usuario foreign key (id_usuario) references usuarios (id),
    constraint fk_operaciones_nodo foreign key (id_nodo) references nodos (id),
    constraint fk_operaciones_tipo foreign key (id_tipo) references tipos_operaciones (id)
);
