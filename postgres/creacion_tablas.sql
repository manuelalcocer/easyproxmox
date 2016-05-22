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
    nombre  varchar(30),
    url     varchar(100),
    constraint pk_centros_de_datos primary key (nombre),
    constraint url_unique UNIQUE (url)
);

create table usuarios (
    nombre      varchar(30),
    centro      varchar(30),
    constraint pk_usuarios primary key (nombre),
    constraint fk_usuarios_centros foreign key (centro) references centros_de_datos (nombre)
);

create table logueos (
    usuario     varchar(30),
    fechahora   timestamp,
    ticket      varchar(400),
    csfr        varchar(100),
    constraint pk_logueos primary key (usuario, fechahora),
    constraint fk_logueos_usuario foreign key (usuario) references usuarios (nombre)
);

create table nodos (
    nombre      varchar(30),
    centro      varchar(30),
    constraint pk_nodos primary key (nombre),
    constraint fk_nodos_centros foreign key (centro) references centros_de_datos (nombre)
);

create table maquinas_virtuales (
    id          integer,
    nodo        varchar(30),
    nombre      varchar(30),
    constraint pk_maquinas_virtuales primary key (id,nodo),
    constraint fk_maquinas_nodos foreign key (nodo) references nodos (nombre)
);

create table contenedores (
    id          integer,
    nodo        varchar(30),
    nombre      varchar(30),
    constraint pk_contenedores primary key (id, nodo),
    constraint fk_contenedores_nodos foreign key (nodo) references nodos (id, nodo)
);

create table plantillas (
    id          integer,
    nodo        varchar(30),
    nombre      varchar(30),
    constraint pk_plantillas primary key (id, nodo),
    constraint fk_plantillas_nodos foreign key (nodo) references nodos (nombre)
);

create table tipos_operaciones (
    id              integer,
    nombre          varchar(30),
    descripcion     varchar(100),
    constraint pk_tipos_operaciones primary key (id)
);

create table operaciones (
    id          serial,
    fechahora   timestamp,
    usuario     varchar(30),
    nodo        varchar(30),
    id_tipo     integer,
    constraint pk_operaciones primary key (id, fechahora),
    constraint fk_operaciones_usuario foreign key (usuario) references usuarios (nombre),
    constraint fk_operaciones_nodo foreign key (nodo) references nodos (nombre),
    constraint fk_operaciones_tipo foreign key (id_tipo) references tipos_operaciones (id)
);
