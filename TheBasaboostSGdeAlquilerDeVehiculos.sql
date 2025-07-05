DROP DATABASE TheBasaboostSGdeAlquilerDeVehiculos
CREATE DATABASE TheBasaboostSGdeAlquilerDeVehiculos;
USE TheBasaboostSGdeAlquilerDeVehiculos;

----- CREACIÓN DE LA BASE DE DATOS -----

CREATE TABLE DEPARTAMENTO(
	id_departamento TINYINT PRIMARY KEY IDENTITY,
	nombre_departamento VARCHAR(35),
	direccion VARCHAR(100),
	telefono CHAR(10),
	correo VARCHAR(50)
);

CREATE TABLE EMPLEADO(
	id_empleado SMALLINT PRIMARY KEY IDENTITY,
	nombre VARCHAR(100),
	direccion VARCHAR(100),
	email VARCHAR(100),
	telefono VARCHAR(100),
	fecha_contratacion DATE
);

CREATE TABLE PUESTO_EMPLEADO(
	id_puesto TINYINT PRIMARY KEY IDENTITY,
	puesto VARCHAR(50)
);

CREATE TABLE MANTENIMIENTO(
	id_mantenimiento VARCHAR(15) PRIMARY KEY,
	fecha DATE,
	descripcion VARCHAR(60),
	costo DECIMAL(5,2)
);

CREATE TABLE CLIENTE(
	id_cliente VARCHAR(15) PRIMARY KEY,
	nombre VARCHAR(50),
	direccion VARCHAR(100),
	num_licencia VARCHAR(12),
	telefono VARCHAR(13),
	fecha_registro DATE
);


ALTER TABLE DEPARTAMENTO ADD FOREIGN KEY(id_empleado) REFERENCES PUESTO_EMPLEADO(id_empleado) ON DELETE CASCADE;
ALTER TABLE EMPLEADO ADD FOREIGN KEY(id_puesto) REFERENCES PUESTO_EMPLEADO(id_puesto) ON DELETE CASCADE;
ALTER TABLE MANTENIMIENTO ADD FOREIGN KEY(id_empleado) REFERENCES EMPLEADO(id_empleado) ON DELETE CASCADE;
--- Falta el FK de matricula en la tabla de Mantenimiento
