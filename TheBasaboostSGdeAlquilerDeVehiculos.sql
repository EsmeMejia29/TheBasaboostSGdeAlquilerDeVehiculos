DROP DATABASE IF EXISTS TheBasaboostSGdeAlquilerDeVehiculos;
CREATE DATABASE TheBasaboostSGdeAlquilerDeVehiculos;
USE TheBasaboostSGdeAlquilerDeVehiculos;

----- CREACIÓN DE LA BASE DE DATOS -----
--- TABLAS:
CREATE TABLE DEPARTAMENTO(
	id_departamento TINYINT PRIMARY KEY IDENTITY,
	nombre_departamento VARCHAR(35)
);

CREATE TABLE EMPLEADO(
	id_empleado SMALLINT PRIMARY KEY IDENTITY,
	nombre VARCHAR(50) NOT NULL,
	direccion VARCHAR(200) NOT NULL,
	email VARCHAR(40) NOT NULL,
	telefono VARCHAR(14) NOT NULL,
	fecha_contratacion DATE NOT NULL,
	id_puesto TINYINT NOT NULL
);

CREATE TABLE PUESTO_EMPLEADO(
	id_puesto TINYINT PRIMARY KEY IDENTITY,
	puesto VARCHAR(50) NOT NULL
);

--  Intersección Empleado-Departamento
CREATE TABLE EMPLEADO_DEPARTAMENTO (
   	id_empleado SMALLINT NOT NULL,
   	id_departamento TINYINT NOT NULL,
  	PRIMARY KEY (id_empleado, id_departamento),
    	FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado),
    	FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO(id_departamento)
);

CREATE TABLE MANTENIMIENTO(
	id_mantenimiento VARCHAR(15) PRIMARY KEY,
	matricula varchar(10) NOT NULL,
	fecha DATE NOT NULL,
	descripcion VARCHAR(60) NOT NULL,
	costo DECIMAL(6,2) NOT NULL,
	id_empleado SMALLINT NOT NULL
);

--Tablas que eliminan el muchos a muchos en la tabla "vehiculos"
CREATE TABLE MODELO_VEHICULO (
    	id_modelo SMALLINT PRIMARY KEY,
   	modelo VARCHAR(50) NOT NULL
);

CREATE TABLE MARCA_VEHICULO (
        id_marca SMALLINT PRIMARY KEY,
    	marca VARCHAR(30) NOT NULL
);

CREATE TABLE TIPO_VEHICULO (
    	id_tipo SMALLINT PRIMARY KEY,
    	tipo VARCHAR(30) NOT NULL
);

CREATE TABLE ESTADO_VEHICULO (
    	id_estado_v SMALLINT PRIMARY KEY,
    	estado_v VARCHAR(30) NOT NULL
);

CREATE TABLE VEHICULOS (
    	matricula VARCHAR(10) PRIMARY KEY,
    	id_marca SMALLINT NOT NULL,
    	id_modelo SMALLINT NOT NULL,
    	anio DATE NOT NULL,
    	id_tipo SMALLINT NOT NULL,
    	precio_diario DECIMAL(8,2) NOT NULL,
    	id_estado_v SMALLINT NOT NULL,
    	id_empleado SMALLINT NOT NULL
);

CREATE TABLE CLIENTE(
	id_cliente VARCHAR(15) PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	direccion VARCHAR(200),
	email varchar(40) NOT NULL,
	num_licencia VARCHAR(12) NOT NULL,
	telefono VARCHAR(13) NOT NULL,
	fecha_registro DATE NOT NULL
);

CREATE TABLE RESERVA(
    	id_reserva VARCHAR(15) PRIMARY KEY,
    	id_cliente VARCHAR(15) NOT NULL,
    	matricula VARCHAR(10) NOT NULL,
    	fecha_inicio_alquiler DATE NOT NULL,
    	fecha_fin_alquiler DATE NOT NULL,
    	id_estado_r VARCHAR(12) NOT NULL,
    	kilometraje_estimado INT NOT NULL
);

CREATE TABLE ESTADO_RESERVA(
    	id_estado_r VARCHAR(12) PRIMARY KEY,
    	estado_v VARCHAR(40) NOT NULL
);

CREATE TABLE SERVICIO_RESERVA (
    	id_reserva VARCHAR(15) NOT NULL,
    	id_servicio_adicional VARCHAR(15) NOT NULL,
    	PRIMARY KEY (id_reserva, id_servicio_adicional)
);

-- Intersección Reserva-Servicios Adicionales
CREATE TABLE SERVICIOS_ADICIONALES(
    	id_servicio_adicional VARCHAR(15) PRIMARY KEY,
    	nombre VARCHAR(35) NOT NULL,
    	costo DECIMAL(7, 2) NOT NULL,
    	descripcion VARCHAR(80) NOT NULL
);

CREATE TABLE PAGO (
    	id_pago VARCHAR(15) PRIMARY KEY,
    	id_reserva VARCHAR(15) NOT NULL,	
   	monto DECIMAL(8, 2) NOT NULL,
    	fecha_pago DATE NOT NULL,
    	id_metodo_pago VARCHAR(10) NOT NULL	
);

CREATE TABLE METODO_PAGO (
    	id_metodo_pago VARCHAR(10) PRIMARY KEY,
    	metodo_pago VARCHAR(30) NOT NULL
);

-- FOREIGN KEYS:
-- PARA LA TABLA "EMPLEADO"
ALTER TABLE EMPLEADO ADD FOREIGN KEY(id_puesto) REFERENCES PUESTO_EMPLEADO(id_puesto);

-- PARA LA TABLA INTERMEDIA "EMPLEADO_DEPARTAMENTO"
ALTER TABLE EMPLEADO_DEPARTAMENTO ADD FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado) ON DELETE CASCADE;
ALTER TABLE EMPLEADO_DEPARTAMENTO ADD FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO(id_departamento) ON DELETE CASCADE;	

-- PARA LA TABLA "VEHICULOS"
ALTER TABLE VEHICULOS ADD FOREIGN KEY (id_marca) REFERENCES MARCA_VEHICULO(id_marca) ON DELETE CASCADE;
ALTER TABLE VEHICULOS ADD FOREIGN KEY (id_modelo) REFERENCES MODELO_VEHICULO(id_modelo) ON DELETE CASCADE;
ALTER TABLE VEHICULOS ADD FOREIGN KEY (id_tipo) REFERENCES TIPO_VEHICULO(id_tipo) ON DELETE CASCADE;
ALTER TABLE VEHICULOS ADD FOREIGN KEY (id_estado_v) REFERENCES ESTADO_VEHICULO(id_estado_v) ON DELETE CASCADE;
ALTER TABLE VEHICULOS ADD FOREIGN KEY (id_empleado) REFERENCES EMPLEADO (id_empleado);

-- PARA LA TABLA "MANTENIMIENTO"
ALTER TABLE MANTENIMIENTO ADD FOREIGN KEY(id_empleado) REFERENCES EMPLEADO(id_empleado) ON DELETE CASCADE; 
ALTER TABLE MANTENIMIENTO ADD FOREIGN KEY(matricula) REFERENCES VEHICULOS(matricula) ON DELETE CASCADE; 

-- PARA LA TABLA "RESERVA"
ALTER TABLE RESERVA ADD FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente) ON DELETE CASCADE;
ALTER TABLE RESERVA ADD FOREIGN KEY (matricula) REFERENCES VEHICULOS(matricula) ON DELETE CASCADE;
ALTER TABLE RESERVA ADD FOREIGN KEY (id_estado_r) REFERENCES ESTADO_RESERVA(id_estado_r) ON DELETE CASCADE;

--PARA LA TABLA "PAGO"
ALTER TABLE PAGO ADD FOREIGN KEY (id_reserva) REFERENCES RESERVA(id_reserva) ON DELETE CASCADE;
ALTER TABLE PAGO ADD FOREIGN KEY (id_metodo_pago) REFERENCES METODO_PAGO(id_metodo_pago) ON DELETE CASCADE;

-- PARA LA TABLA INTERMEDIA "SERVICIO_RESERVA"
ALTER TABLE SERVICIO_RESERVA ADD FOREIGN KEY (id_reserva) REFERENCES RESERVA(id_reserva) ON DELETE CASCADE;
ALTER TABLE SERVICIO_RESERVA ADD FOREIGN KEY (id_servicio_adicional) REFERENCES SERVICIOS_ADICIONALES(id_servicio_adicional) ON DELETE CASCADE;


--Inserciones
--Inserciones
INSERT INTO cliente (id_cliente, nombre, direccion, email, num_licencia, telefono, fecha_registro) VALUES
('cli001', 'Elena Claramount', 'Residencial Santa Elena, Calle El Pedregal #115, San Salvador', 'eclaramunt@gmail.com', 'E41773130', '7789-4472', '2024-05-02'),
('cli002', 'Santiago Saca', 'Residencial Altos de la Escalón, Calle Los Laureles #77, San Salvador', 'ssaca@gmail.com', 'C78537056', '7715-6709', '2024-06-25'),
('cli003', 'Manuel de Sola', 'Colonia Escalón, Calle Circunvalación #164, Antiguo Cuscatlán, La Libertad', 'mde sola@gmail.com', 'C25419590', '7764-5815', '2024-11-19'),
('cli004', 'Rebeca Dueñas', 'Colonia Maquilishuat, Calle El Bosque #5, Antiguo Cuscatlán, La Libertad', 'rdueñas@gmail.com', 'E44802930', '7722-3017', '2024-02-06'),
('cli005', 'Manuel Poma', 'Residencial Altos de la Escalón, Calle Los Laureles #45, Santa Tecla, La Libertad', 'mpoma@gmail.com', 'A83858100', '7788-4158', '2024-01-06'),
('cli006', 'Arturo de Sola', 'Colonia La Mascota, Calle La Mascota #179, Santa Tecla, La Libertad', 'ade sola@gmail.com', 'D87022680', '7727-3925', '2024-07-25'),
('cli007', 'Andrea Dueñas', 'Residencial Palmira, Calle Palmira #183, San Salvador', 'adueñas@gmail.com', 'D15199287', '7796-1270', '2024-11-11'),
('cli008', 'Juan Diego Poma', 'Colonia Escalón, Avenida Masferrer Norte #64, San Salvador', 'jpoma@gmail.com', 'D67993754', '7787-4993', '2024-12-06'),
('cli009', 'Arturo de Sola', 'Residencial Vía del Mar, Calle Playa Dorada #3, Antiguo Cuscatlán, La Libertad', 'ade sola@gmail.com', 'A76552008', '7732-9401', '2024-02-15'),
('cli010', 'Alejandro Poma', 'Residencial Portal del Casco Norte, Calle del Portal #181, Antiguo Cuscatlán, La Libertad', 'apoma@gmail.com', 'D22442768', '7774-5986', '2024-03-08'),
('cli011', 'Diana Claramount', 'Residencial Portal del Casco Norte, Calle del Portal #80, Antiguo Cuscatlán, La Libertad', 'dclaramunt@gmail.com', 'D57585980', '7782-5006', '2024-08-21'),
('cli012', 'Paulina Claramount', 'Residencial Altos de la Escalón, Calle Los Laureles #46, Antiguo Cuscatlán, La Libertad', 'pclaramunt@gmail.com', 'E24856284', '7719-5786', '2024-08-20'),
('cli013', 'Jimena Funes', 'Residencial Vía del Mar, Calle Playa Dorada #171, Santa Tecla, La Libertad', 'jfunes@gmail.com', 'A98091688', '7777-5798', '2024-11-05'),
('cli014', 'Ivanna Saca', 'Residencial Vía del Mar, Calle Playa Dorada #134, Antiguo Cuscatlán, La Libertad', 'isaca@gmail.com', 'A34671635', '7761-8368', '2024-09-09'),
('cli015', 'Juliana Kriete', 'Residencial Villas de La Cañada, Calle El Roble #92, Santa Tecla, La Libertad', 'jkriete@gmail.com', 'B46776983', '7736-3155', '2024-09-16'),
('cli016', 'Enrique Sifontes', 'Colonia San Francisco, Avenida San Francisco #158, Santa Tecla, La Libertad', 'esifontes@gmail.com', 'D45459116', '7743-4347', '2024-05-11'),
('cli017', 'Luis Saca', 'Colonia Escalón, Avenida Masferrer Norte #46, San Salvador', 'lsaca@gmail.com', 'D13010907', '7772-9330', '2024-02-10'),
('cli018', 'Rodrigo Saca', 'Colonia La Mascota, Calle La Mascota #106, San Salvador', 'rsaca@gmail.com', 'E98987528', '7713-8422', '2024-10-23'),
('cli019', 'Valeria Simán', 'Residencial Portal del Casco Norte, Calle del Portal #184, Antiguo Cuscatlán, La Libertad', 'vsimán@gmail.com', 'A88522757', '7722-2555', '2024-08-08'),
('cli020', 'Ana Sofía Llach', 'Residencial Altos de la Escalón, Calle Los Laureles #59, San Salvador', 'allach@gmail.com', 'C73163516', '7749-4097', '2024-10-08'),
('cli021', 'Camila Simán', 'Residencial Vía del Mar, Calle Playa Dorada #112, San Salvador', 'csimán@gmail.com', 'C20222639', '7773-5982', '2024-07-21'),
('cli022', 'Juan Diego de Sola', 'Residencial Vía del Mar, Calle Playa Dorada #20, San Salvador', 'jde sola@gmail.com', 'C13365567', '7795-3337', '2024-10-10'),
('cli023', 'Juan Diego Kriete', 'Colonia La Mascota, Calle La Mascota #172, San Salvador', 'jkriete@gmail.com', 'B20840899', '7727-1490', '2024-03-05'),
('cli024', 'Diego Dueñas', 'Colonia San Francisco, Avenida San Francisco #50, Antiguo Cuscatlán, La Libertad', 'ddueñas@gmail.com', 'E70199375', '7796-4221', '2024-08-03'),
('cli025', 'Sebastián Kriete', 'Residencial Portal del Casco Norte, Calle del Portal #88, Santa Tecla, La Libertad', 'skriete@gmail.com', 'C90360750', '7730-6925', '2024-09-12'),
('cli026', 'Mauricio Funes', 'Colonia San Benito, Avenida La Capilla #98, Santa Tecla, La Libertad', 'mfunes@gmail.com', 'D34098272', '7749-5532', '2024-11-19'),
('cli027', 'Emilio Poma', 'Residencial Lomas de San Francisco, Calle Loma Linda #36, Santa Tecla, La Libertad', 'epoma@gmail.com', 'A97483910', '7721-2983', '2024-06-17'),
('cli028', 'Daniel Palomo', 'Colonia San Francisco, Avenida San Francisco #59, San Salvador', 'dpalomo@gmail.com', 'B17148867', '7752-6416', '2024-08-01'),
('cli029', 'Andrea Palomo', 'Residencial Cumbres de Cuscatlán, Calle Las Cumbres #16, San Salvador', 'apalomo@gmail.com', 'C48988500', '7723-6485', '2024-09-14'),
('cli030', 'Daniel Simán', 'Residencial Altos de la Escalón, Calle Los Laureles #85, Antiguo Cuscatlán, La Libertad', 'dsimán@gmail.com', 'C46704010', '7766-1050', '2024-12-26'),
('cli031', 'Camila Safie', 'Colonia Escalón, Avenida Masferrer Norte #183, San Salvador', 'csafie@gmail.com', 'B77427437', '7753-8359', '2024-09-15'),
('cli032', 'Alejandro Poma', 'Colonia San Francisco, Avenida San Francisco #91, Santa Tecla, La Libertad', 'apoma@gmail.com', 'C89840513', '7737-4220', '2024-06-26'),
('cli033', 'Cristina de Sola', 'Colonia San Benito, Avenida La Capilla #45, San Salvador', 'cde sola@gmail.com', 'D74102079', '7785-1995', '2024-07-15'),
('cli034', 'Diana Kattán', 'Residencial Vía del Mar, Calle Playa Dorada #156, Antiguo Cuscatlán, La Libertad', 'dkattán@gmail.com', 'A27935253', '7763-4858', '2024-07-19'),
('cli035', 'Valeria Steiner', 'Residencial Palmira, Calle Palmira #174, Antiguo Cuscatlán, La Libertad', 'vsteiner@gmail.com', 'D27120750', '7720-1931', '2024-07-25'),
('cli036', 'Fernando Kattán', 'Residencial Vía del Mar, Calle Playa Dorada #155, Antiguo Cuscatlán, La Libertad', 'fkattán@gmail.com', 'D41734491', '7765-1893', '2024-05-23'),
('cli037', 'Paula Funes', 'Colonia La Mascota, Calle La Mascota #16, Santa Tecla, La Libertad', 'pfunes@gmail.com', 'C10276108', '7741-2503', '2024-02-23'),
('cli038', 'Cristina Dueñas', 'Colonia Escalón, Avenida Masferrer Norte #8, Santa Tecla, La Libertad', 'cdueñas@gmail.com', 'A69462007', '7761-7351', '2024-11-15'),
('cli039', 'Samuel de Sola', 'Residencial Santa Elena, Calle El Pedregal #144, San Salvador', 'sde sola@gmail.com', 'A27691990', '7731-4178', '2024-04-13'),
('cli040', 'Ana Sofía Bukele', 'Residencial Lomas de San Francisco, Calle Loma Linda #113, Antiguo Cuscatlán, La Libertad', 'abukele@gmail.com', 'C88089622', '7712-9301', '2024-12-17'),
('cli041', 'Elena Steiner', 'Residencial Portal del Casco Norte, Calle del Portal #54, Antiguo Cuscatlán, La Libertad', 'esteiner@gmail.com', 'A33642782', '7775-1497', '2024-06-23'),
('cli042', 'Mario Steiner', 'Residencial Portal del Casco Norte, Calle del Portal #120, Antiguo Cuscatlán, La Libertad', 'msteiner@gmail.com', 'C22528367', '7717-5491', '2024-05-02'),
('cli043', 'Elena Kattán', 'Residencial Santa Elena, Calle El Pedregal #76, San Salvador', 'ekattán@gmail.com', 'D13442418', '7765-9283', '2024-09-25'),
('cli044', 'Luis Saca', 'Residencial La Montaña, Avenida La Montaña #85, Antiguo Cuscatlán, La Libertad', 'lsaca@gmail.com', 'C53525114', '7795-5391', '2024-12-13'),
('cli045', 'Ignacio Kriete', 'Residencial Lomas de San Francisco, Calle Loma Linda #134, San Salvador', 'ikriete@gmail.com', 'E55031583', '7780-2982', '2024-01-23'),
('cli046', 'Valeria Claramunt', 'Residencial La Montaña, Avenida La Montaña #54, Santa Tecla, La Libertad', 'vclaramunt@gmail.com', 'D29546749', '7726-7288', '2024-06-22'),
('cli047', 'Alberto Steiner', 'Residencial Villas de La Cañada, Calle El Roble #53, Santa Tecla, La Libertad', 'asteiner@gmail.com', 'E26331217', '7760-9064', '2024-10-11'),
('cli048', 'Mauricio Funes', 'Residencial Portal del Casco Norte, Calle del Portal #28, Antiguo Cuscatlán, La Libertad', 'mfunes@gmail.com', 'E42358352', '7768-8957', '2024-08-03'),
('cli049', 'Andrea Safie', 'Residencial La Montaña, Avenida La Montaña #31, Santa Tecla, La Libertad', 'asafie@gmail.com', 'D82850564', '7736-1899', '2024-06-25'),
('cli050', 'Carolina Sifontes', 'Residencial Palmira, Calle Palmira #85, San Salvador', 'csifontes@gmail.com', 'D38859166', '7715-9780', '2024-08-14');

-- Departamentos
insert into departamento (nombre_departamento) values
('Mecánica'),
('Atención al Cliente'),
('Limpieza'),
('Administración'),
('Finanzas'),
('Sistemas'),
('Logística'),
('Compras'),
('Marketing'),
('Recursos humanos');

-- Puestos de empleado
insert into puesto_empleado (puesto) values
('Agente de alquiler'),
('Mecánico'),
('CEO'),
('COO'),
('CFO'),
('Personal de limpieza'),
('Administrador'),
('Jefe de taller'),
('Recepcionista'),
('Asistente administrativo'),
('Analista de sistemas'),
('Contador'),
('Supervisor de flota');

-- Marcas de vehículos
insert into marca_vehiculo (id_marca, marca) values
(1, 'Kia'),
(2, 'Hyundai'),
(3, 'Toyota'),
(4, 'Nissan'),
(5, 'Porsche'),
(6, 'Chevrolet'),
(7, 'Mazda'),
(8, 'Honda'),
(9, 'Suzuki'),
(10, 'Ford');

-- Modelos de vehículos
insert into modelo_vehiculo (id_modelo, modelo) values
(1, 'Soul'),
(2, 'Elantra'),
(3, 'Corolla'),
(4, 'Sentra'),
(5, 'Cayenne'),
(6, 'Spark'),
(7, 'CX-5'),
(8, 'CR-V'),
(9, 'Swift'),
(10, 'EcoSport'),
(11, 'Sportage'),
(12, 'Tucson'),
(13, 'RAV4'),
(14, 'Altima'),
(15, 'Macan'),
(16, 'Aveo'),
(17, 'Mazda 3'),
(18, 'Civic'),
(19, 'Vitara'),
(20, 'Escape');

-- Tipos de vehículo
insert into tipo_vehiculo (id_tipo, tipo) values
(1, 'Sedán'),
(2, 'SUV'),
(3, 'Hatchback'),
(4, 'Pick-up'),
(5, 'Deportivo');

-- Estados de vehículo
insert into estado_vehiculo (id_estado_v, estado_v) values
(1, 'Disponible'),
(2, 'Alquilado'),
(3, 'En mantenimiento');

-- Estados de reserva
insert into estado_reserva (id_estado_r, estado_v) values
('conf', 'Confirmada'),
('canc', 'Cancelada'),
('comp', 'Completada');

-- Métodos de pago
insert into metodo_pago (id_metodo_pago, metodo_pago) values
('efec', 'Efectivo'),
('tarj', 'Tarjeta'),
('Cheq', 'Cheque´'),
('tran', 'Transferencia');

-- Servicios adicionales
insert into servicios_adicionales (id_servicio_adicional, nombre, costo, descripcion) values
('gps', 'GPS', 6.00, 'Sistema de navegación por satélite'),
('seguro', 'Seguro Extra', 10.00, 'Cobertura total contra accidentes'),
('bebe', 'Silla de Bebé', 4.00, 'Silla de seguridad para infantes'),
('asist', 'Asistencia en Carretera', 7.00, 'Soporte vial 24/7'),
('wifi', 'Wi-Fi', 5.00, 'Conexión inalámbrica en el vehículo'),
('limpieza', 'Limpieza Premium', 8.00, 'Desinfección y limpieza profunda'),
('equipaje', 'Porta Equipaje', 6.50, 'Soporte adicional para equipaje'),
('musica', 'Audio Premium', 3.00, 'Sonido envolvente de alta fidelidad'),
('conductor', 'Conductor Adicional', 11.00, 'Permite un conductor adicional'),
('llantas', 'Protección de Llantas', 4.50, 'Cobertura por daño a llantas');

-- Empleados
insert into empleado (nombre, direccion, email, telefono, fecha_contratacion, id_puesto) values
('Roberto Safie Safie', 'Avenida Jerusalén #324, Colonia Escalón, San Salvador', 'rsafie@basaboost.com', '7842-1101', '2023-01-10', 1),
('Claudia Steiner Morán', 'Calle La Mascota #88, Colonia San Benito, San Salvador', 'csteiner@basaboost.com', '7820-2012', '2022-03-12', 2),
('Fernando Kattán Hidalgo', 'Calle El Mirador #102, Colonia Escalón, San Salvador', 'fkattan@basaboost.com', '7750-4522', '2021-07-19', 4),
('Sofía Bukele Altamirano', 'Boulevard Constitución #301, Urbanización La Sultana, Antiguo Cuscatlán, La Libertad', 'sbukele@basaboost.com', '7241-9632', '2023-05-01', 3),
('Iván Sifontes', 'Calle 7 Poniente #67, Barrio El Centro, Santa Ana', 'isifontes@basaboost.com', '7012-5486', '2022-08-08', 5),
('Andrea Claramunt', 'Colonia San José, Calle Circunvalación #12, Santa Tecla, La Libertad', 'aclaramunt@basaboost.com', '7891-3322', '2022-10-15', 6),
('Alejandro Martínez', 'Residencial Altos del Cerro, Calle principal #27, Soyapango, San Salvador', 'amartinez@basaboost.com', '7584-9123', '2023-02-18', 7),
('Gabriela Vásquez', 'Urbanización Madre Tierra, Avenida Las Camelias #101, Apopa, San Salvador', 'gvasquez@basaboost.com', '7501-8845', '2021-09-22', 8),
('César Meléndez', 'Colonia Miramonte, 21 Avenida Norte #122, San Salvador', 'cmelendez@basaboost.com', '7702-5421', '2022-11-29', 9),
('Paola Ramírez', 'Residencial Villas de Oriente, Calle Los Claveles #9, San Miguel', 'pramirez@basaboost.com', '7904-1876', '2023-06-06', 10);


-- Relación empleado-departamento
insert into empleado_departamento (id_empleado, id_departamento) values
(1, 1), (1, 4), (2, 1), (3, 2), (4, 3), (5, 1), (6, 2), (7, 4), (8, 5), (9, 6),
(2, 3), (4, 2), (5, 7), (6, 8), (7, 9), (8, 10), (10, 1);

-- Vehículos (ejemplos; repite hasta llegar a 20)
insert into vehiculos (matricula, id_marca, id_modelo, anio, id_tipo, precio_diario, id_estado_v, id_empleado) values
('P123-456', 1, 1, '2021-01-01', 2, 38.00, 1, 1),    -- Kia Soul SUV
('P234-567', 3, 3, '2020-01-01', 1, 36.00, 1, 2),    -- Toyota Corolla Sedán
('P345-678', 5, 5, '2022-01-01', 2, 140.00, 1, 3),   -- Porsche Cayenne SUV
('P456-789', 2, 2, '2021-01-01', 1, 33.50, 1, 4),    -- Hyundai Elantra Sedán
('P567-890', 4, 4, '2019-01-01', 1, 31.00, 1, 5);   -- Nissan ROGUE

-- Mantenimientos 
insert into mantenimiento (id_mantenimiento, matricula, fecha, descripcion, costo, id_empleado) values
('MT001', 'P123-456', '2024-05-20', 'Cambio de aceite y filtro', 45.00, 2),
('MT002', 'P234-567', '2024-04-15', 'Cambio de llantas', 120.00, 5),
('MT003', 'P345-678', '2024-06-02', 'Alineación y balanceo', 55.00, 1),
('MT004', 'P456-789', '2024-03-21', 'Limpieza interior', 30.00, 4),
('MT005', 'P567-890', '2024-02-12', 'Mantenimiento de frenos', 70.00, 3),
('MT006', 'P123-456', '2024-01-15', 'Cambio de batería', 80.00, 2),
('MT007', 'P234-567', '2024-06-01', 'Pulido de carrocería', 60.00, 6),
('MT008', 'P345-678', '2024-05-25', 'Cambio de bujías', 40.00, 5),
('MT009', 'P456-789', '2024-04-19', 'Limpieza de motor', 50.00, 1),
('MT010', 'P567-890', '2024-03-10', 'Ajuste de suspensión', 95.00, 7);

-- Reservas 
insert into reserva (id_reserva, id_cliente, matricula, fecha_inicio_alquiler, fecha_fin_alquiler, id_estado_r, kilometraje_estimado) values
('RSV001', 'cli001', 'P123-456', '2024-07-01', '2024-07-07', 'conf', 400),
('RSV002', 'cli002', 'P234-567', '2024-07-03', '2024-07-10', 'comp', 500),
('RSV003', 'cli003', 'P345-678', '2024-07-05', '2024-07-12', 'canc', 600),
('RSV004', 'cli004', 'P456-789', '2024-07-08', '2024-07-14', 'conf', 450),
('RSV005', 'cli005', 'P567-890', '2024-07-11', '2024-07-18', 'conf', 350);


-- Servicios adicionales por reserva 
insert into servicio_reserva (id_reserva, id_servicio_adicional) values
('RSV001', 'gps'), ('RSV001', 'seguro'), ('RSV001', 'wifi'),
('RSV002', 'seguro'), ('RSV002', 'bebe'),
('RSV003', 'asist'), ('RSV003', 'musica'),
('RSV004', 'conductor'), ('RSV004', 'gps'),
('RSV005', 'llantas');

-- Pagos 
insert into pago (id_pago, id_reserva, monto, fecha_pago, id_metodo_pago) values
('PG001', 'RSV001', 272.00, '2024-07-07', 'tarj'),
('PG002', 'RSV002', 344.00, '2024-07-10', 'efec'),
('PG003', 'RSV003', 0.00, '2024-07-12', 'tarj'),
('PG004', 'RSV004', 289.00, '2024-07-14', 'tran'),
('PG005', 'RSV005', 220.00, '2024-07-18', 'efec');

