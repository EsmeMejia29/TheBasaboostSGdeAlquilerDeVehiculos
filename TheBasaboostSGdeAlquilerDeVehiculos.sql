DROP DATABASE TheBasaboostSGdeAlquilerDeVehiculos
CREATE DATABASE TheBasaboostSGdeAlquilerDeVehiculos;
USE TheBasaboostSGdeAlquilerDeVehiculos;

----- CREACIÓN DE LA BASE DE DATOS -----
--- TABLAS:
CREATE TABLE DEPARTAMENTO(
	id_departamento TINYINT PRIMARY KEY IDENTITY,
	nombre_departamento VARCHAR(35),
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

CREATE TABLE DEPARTAMENTO_EMPLEADO(
	id_departamento_empleado INT PRIMARY KEY IDENTITY
	id_departamento TINYINT
	id_empleado SMALLINT,
	FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO(id_departamento),
	FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);

CREATE TABLE MANTENIMIENTO(
	id_mantenimiento VARCHAR(15) PRIMARY KEY,
	matricula varchar(10)
	fecha DATE,
	descripcion VARCHAR(60),
	costo DECIMAL(5,2)
);

CREATE TABLE CLIENTE(
	id_cliente VARCHAR(15) PRIMARY KEY,
	nombre VARCHAR(50),
	direccion VARCHAR(100),
	email varchar(40),
	num_licencia VARCHAR(12),
	telefono VARCHAR(13),
	fecha_registro DATE
);

CREATE TABLE RESERVA(
    id_reserva VARCHAR(15) PRIMARY KEY,
    id_cliente VARCHAR(50),
    matricula VARCHAR(50),
    fecha_inicio_alquiler DATE,
    fecha_fin_alquiler DATE,
    id_estado_r VARCHAR(12),
    kilometraje_estimado INT
);

CREATE TABLE ESTADO_RESERVA(
    id_estado_r VARCHAR(12) PRIMARY KEY,
    estado_v VARCHAR(40)
);

CREATE TABLE PAGO (
    id_pago VARCHAR(10) PRIMARY KEY,
    monto DECIMAL(8, 2),
    fecha_pago DATE
);

CREATE TABLE METODO (
    id_metodo_pago VARCHAR(10) PRIMARY KEY,
    metodo_pago VARCHAR(30)
);

CREATE TABLE SERVICIO_RESERVA(
    id_servicio_reserva VARCHAR(10) PRIMARY KEY
);

CREATE TABLE SERVICIOS_ADICIONALES(
    id_servicio_adicional VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(35),
    costo DECIMAL(7, 2),
    descripcion VARCHAR(80)
);


-- FOREIGN KEYS:
ALTER TABLE DEPARTAMENTO ADD FOREIGN KEY(id_empleado) REFERENCES PUESTO_EMPLEADO(id_empleado) ON DELETE CASCADE;
ALTER TABLE EMPLEADO ADD FOREIGN KEY(id_puesto) REFERENCES PUESTO_EMPLEADO(id_puesto) ON DELETE CASCADE;
ALTER TABLE MANTENIMIENTO ADD FOREIGN KEY(id_empleado) REFERENCES EMPLEADO(id_empleado) ON DELETE CASCADE;
--- Falta el FK de matricula en la tabla de Mantenimiento
ALTER TABLE RESERVA ADD FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente) ON DELETE CASCADE;
------ Descomentar cuando esté la tabla de Vehículo: ALTER TABLE RESERVA ADD FOREIGN KEY (matricula) REFERENCES VEHICULO(matricula)
ALTER TABLE RESERVA ADD FOREIGN KEY (id_estado_r) REFERENCES ESTADO_RESERVA(id_estado_r) ON DELETE CASCADE;
ALTER TABLE PAGO ADD FOREIGN KEY (id_reserva) REFERENCES RESERVA(id_reserva) ON DELETE CASCADE;
ALTER TABLE PAGO ADD FOREIGN KEY (id_metodo_pago) REFERENCES METODO(id_metodo_pago) ON DELETE CASCADE;
ALTER TABLE SERVICIO_RESERVA ADD FOREIGN KEY (id_servicio_adicional) REFERENCES SERVICIOS_ADICIONALES(id_servicio_adicional) ON DELETE CASCADE;
ALTER TABLE SERVICIO_RESERVA ADD FOREIGN KEY (id_reserva) REFERENCES RESERVA(id_reserva) ON DELETE CASCADE;

CREATE TABLE MODELO_VEHICULO (
    id_modelo SMALLINT UNSIGNED PRIMARY KEY,
    modelo VARCHAR(30) NOT NULL
);

CREATE TABLE MARCA_VEHICULO (
    id_marca SMALLINT UNSIGNED PRIMARY KEY,
    marca VARCHAR(30) NOT NULL
);

CREATE TABLE TIPO_VEHICULO (
    id_tipo SMALLINT UNSIGNED PRIMARY KEY,
    tipo VARCHAR(30) NOT NULL
);

CREATE TABLE ESTADO_VEHICULO (
    id_estado_v SMALLINT UNSIGNED PRIMARY KEY,
    estado_v VARCHAR(30) NOT NULL
);

CREATE TABLE VEHICULOS (
    matricula VARCHAR(10) PRIMARY KEY,
    id_marca SMALLINT UNSIGNED NOT NULL,
    id_modelo SMALLINT UNSIGNED NOT NULL,
    anio DATE NOT NULL,
    id_tipo SMALLINT UNSIGNED NOT NULL,
    precio_diario DECIMAL(8,2) NOT NULL,
    id_estado_v SMALLINT UNSIGNED NOT NULL,
    id_empleado SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY (id_marca) REFERENCES MARCA_VEHICULO(id_marca),
    FOREIGN KEY (id_modelo) REFERENCES MODELO_VEHICULO(id_modelo),
    FOREIGN KEY (id_tipo) REFERENCES TIPO_VEHICULO(id_tipo),
    FOREIGN KEY (id_estado_v) REFERENCES ESTADO_VEHICULO(id_estado_v)
);


--  Intersección Empleado-Departamento
CREATE TABLE EMPLEADO_DEPARTAMENTO (
    id_empleado SMALLINT NOT NULL,
    id_departamento TINYINT NOT NULL,
    PRIMARY KEY (id_empleado, id_departamento),
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado),
    FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO(id_departamento)
);

-- Intersección Reserva-Servicios Adicionales
CREATE TABLE SERVICIO_RESERVA (
    id_reserva VARCHAR(15) NOT NULL,
    id_servicio_adicional VARCHAR(15) NOT NULL,
    PRIMARY KEY (id_reserva, id_servicio_adicional),
    FOREIGN KEY (id_reserva) REFERENCES RESERVA(id_reserva),
    FOREIGN KEY (id_servicio_adicional) REFERENCES SERVICIOS_ADICIONALES(id_servicio_adicional)
);

