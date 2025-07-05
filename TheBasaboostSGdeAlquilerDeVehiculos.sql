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

CREATE TABLE ESTADO_RESERVA (
    id_estado_r VARCHAR(12) PRIMARY KEY,
    estado_v VARCHAR(40)
);

CREATE TABLE RESERVA (
    id_reserva VARCHAR(15) PRIMARY KEY,
    id_cliente VARCHAR(50),
    matricula VARCHAR(50),
    fecha_inicio_alquiler DATE,
    fecha_fin_alquiler DATE,
    id_estado_r VARCHAR(12),
    kilometraje_estimado VARCHAR(30),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (matricula) REFERENCES VEHICULO(matricula),
    FOREIGN KEY (id_estado_r) REFERENCES ESTADO_RESERVA(id_estado_r)
);

CREATE TABLE METODO (
    id_metodo_pago VARCHAR(10) PRIMARY KEY,
    metodo_pago VARCHAR(30)
);

CREATE TABLE PAGO (
    id_pago VARCHAR(10) PRIMARY KEY,
    id_reserva VARCHAR(15),
    monto DECIMAL(8, 2),
    fecha_pago DATE,
    id_metodo_pago VARCHAR(10),
    FOREIGN KEY (id_reserva) REFERENCES RESERVA(id_reserva),
    FOREIGN KEY (id_metodo_pago) REFERENCES METODO(id_metodo_pago)
);

CREATE TABLE SERVICIOS_ADICIONALES (
    id_servicio_adicional VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(35),
    costo DECIMAL(7, 2),
    descripcion VARCHAR(80)
);

CREATE TABLE SERVICIO_RESERVA (
    id_servicio_reserva VARCHAR(10) PRIMARY KEY,
    id_servicio_adicional VARCHAR(15),
    id_reserva VARCHAR(15),
    FOREIGN KEY (id_servicio_adicional) REFERENCES SERVICIOS_ADICIONALES(id_servicio_adicional),
    FOREIGN KEY (id_reserva) REFERENCES RESERVA(id_reserva)
);



ALTER TABLE DEPARTAMENTO ADD FOREIGN KEY(id_empleado) REFERENCES PUESTO_EMPLEADO(id_empleado) ON DELETE CASCADE;
ALTER TABLE EMPLEADO ADD FOREIGN KEY(id_puesto) REFERENCES PUESTO_EMPLEADO(id_puesto) ON DELETE CASCADE;
ALTER TABLE MANTENIMIENTO ADD FOREIGN KEY(id_empleado) REFERENCES EMPLEADO(id_empleado) ON DELETE CASCADE;
--- Falta el FK de matricula en la tabla de Mantenimiento
