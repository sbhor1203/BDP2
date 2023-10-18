create table paciente(
	dpi varchar(50) primary key,
	nombre varchar(50),
	direccion varchar(50),
	telefono varchar(50),
	altura varchar(50),
	masa_corporal varchar(50),
	peso varchar(50),
	enfermedades_herencia varchar(50)
);

create table centro_medico(
	id int primary key,
	nombre varchar(50),
	direccion varchar(50),
	telefono varchar(50)
);

create table inventario(
	id_centro_medico int,
	nombre_producto varchar(50),
	cantidad_producto int,
	capacidad_producto int,
	fecha_vencimiento date,
	foreign key (id_centro_medico) references centro_medico(id)
);
CREATE INDEX idx_inventario_id_centro_medico ON inventario (id_centro_medico);
CREATE INDEX idx_inventario_nombre_producto ON inventario (nombre_producto);
create table medico(
	num_colegiatura varchar(50) primary key,
	nombre varchar(50),
	direccion varchar(50),
	telefono varchar(50),
	id_centro_medico int,
	especialidad varchar(50),
	contraseña varchar(50),
	foreign key (id_centro_medico) references centro_medico(id)
);

create table reporte_medico(
	id_reporte varchar(50) primary key,
	id_paciente varchar(50),
	id_medico varchar(50),
	enfermedad_tratada varchar(50),
	medicamento_administrado varchar(50),
	examenes_realizados varchar(50),
	id_centro_medico int,
	foreign key (id_paciente) references paciente(dpi),
	foreign key (id_medico) references medico(num_colegiatura),
	foreign key (id_centro_medico) references centro_medico(id)
);
CREATE INDEX idx_reporte_medico_id_paciente ON reporte_medico (id_paciente);
CREATE INDEX idx_reporte_medico_id_medico ON reporte_medico (id_medico);
create table historial(
	id_reporte varchar(50),
	fecha date,
	hora varchar(50),
	seguimiento varchar(200),
	Status_Paciente varchar(200),
	primary key(id_reporte, fecha),
	foreign key (id_reporte) references reporte_medico(id_reporte)
);
CREATE INDEX idx_historial_id_reporte ON historial (id_reporte);

create table bitacora_bd(
	id serial primary key,
	fecha_hora timestamp with time zone,
	origen_insert text,
	nombre_usuario text
	);
CREATE TABLE historial_cambios_medicos (
    id serial PRIMARY KEY,
    num_colegiatura_anterior varchar(50),
    num_colegiatura_nuevo varchar(50),
    fecha_cambio date,
    motivo_cambio varchar(200)
);
Create Table usuarios(
	usuario varchar(30) primary key,
	contraseña varchar(20)
)