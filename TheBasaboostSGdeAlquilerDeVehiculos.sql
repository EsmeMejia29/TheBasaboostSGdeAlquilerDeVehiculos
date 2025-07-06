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

CREATE TABLE VEHICULOS(
    	matricula VARCHAR(10) PRIMARY KEY,
    	id_marca SMALLINT NOT NULL,
    	id_modelo SMALLINT NOT NULL,
    	anio DATE NOT NULL,
    	id_tipo SMALLINT NOT NULL,
    	precio_diario DECIMAL(8,2) NOT NULL,
    	id_estado_v SMALLINT NOT NULL,
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

CREATE TABLE SERVICIO_RESERVA(
    	id_reserva VARCHAR(15) NOT NULL,
    	id_servicio_adicional VARCHAR(15) NOT NULL,
    	PRIMARY KEY (id_reserva, id_servicio_adicional)
);

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
-- Clientes:
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

-- Departamentos:
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

-- Puestos de empleados:
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

-- Marcas de vehículos:
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

-- Modelos de vehículos:
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

-- Tipos de vehículo:
insert into tipo_vehiculo (id_tipo, tipo) values
(1, 'Sedán'),
(2, 'SUV'),
(3, 'Hatchback'),
(4, 'Pick-up'),
(5, 'Deportivo'),
(6, 'Blindado'),
(7, 'Extra lujoso'),
(8, 'Buseta'),
(9, 'Camión'),
(10, 'SUV XL, tipo Suburban');

-- Estados de vehículo:
insert into estado_vehiculo (id_estado_v, estado_v) values
(1, 'Disponible'),
(2, 'Alquilado'),
(3, 'En mantenimiento');

-- Estados de reserva:
insert into estado_reserva (id_estado_r, estado_v) values
('conf', 'Confirmada'),
('canc', 'Cancelada'),
('comp', 'Completada');

-- Métodos de pago:
insert into metodo_pago (id_metodo_pago, metodo_pago) values
('efec', 'Efectivo'),
('tarj', 'Tarjeta'),
('Cheq', 'Cheque´'),
('tran', 'Transferencia');

-- Servicios adicionales:
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

-- Empleados:
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

-- Relación empleado-departamento:
insert into empleado_departamento (id_empleado, id_departamento) values
(1, 1), (1, 4), (2, 1), (3, 2), (4, 3), (5, 1), (6, 2), (7, 4), (8, 5), (9, 6),
(2, 3), (4, 2), (5, 7), (6, 8), (7, 9), (8, 10), (10, 1);

-- Vehículos:
INSERT INTO vehiculos (matricula, id_marca, id_modelo, anio, id_tipo, precio_diario, id_estado_v, id_empleado) VALUES
('P378-814', 3, 13, '2019-07-31', 3, 36.15, 1, 9),
('P953-899', 6, 16, '2022-01-13', 4, 61.53, 1, 1),
('P481-629', 2, 12, '2023-08-17', 1, 107.01, 1, 10),
('P314-100', 7, 7, '2021-04-24', 3, 110.31, 1, 1),
('P956-630', 10, 20, '2022-01-13', 3, 32.65, 1, 8),
('P248-106', 2, 2, '2019-09-21', 4, 142.05, 1, 8),
('P654-864', 9, 19, '2023-05-03', 3, 28.16, 1, 3),
('P287-552', 5, 5, '2023-10-09', 2, 36.42, 1, 7),
('P706-435', 7, 7, '2020-02-27', 3, 42.44, 1, 2),
('P983-783', 6, 6, '2021-11-21', 5, 103.56, 1, 3),
('P679-761', 7, 17, '2019-11-13', 4, 84.53, 1, 2),
('P279-385', 4, 14, '2023-12-01', 1, 43.52, 1, 9),
('P276-124', 1, 11, '2022-10-04', 5, 97.91, 1, 1),
('P582-623', 1, 11, '2020-08-03', 3, 41.8, 1, 7),
('P330-216', 3, 13, '2021-08-08', 5, 146.59, 1, 7),
('P860-666', 7, 17, '2022-01-13', 3, 47.72, 1, 5),
('P690-721', 4, 4, '2021-08-08', 5, 26.8, 1, 7),
('P911-523', 2, 12, '2021-11-21', 4, 88.27, 1, 5),
('P158-540', 9, 9, '2022-01-13', 4, 134.43, 1, 6),
('P717-132', 5, 15, '2023-03-12', 2, 27.3, 1, 5),
('P883-685', 10, 20, '2022-10-04', 1, 95.97, 1, 8),
('P284-577', 3, 3, '2023-08-17', 3, 148.82, 1, 4),
('P623-101', 6, 6, '2022-11-26', 5, 82.48, 1, 9),
('P235-909', 6, 16, '2023-08-17', 5, 56.13, 1, 5),
('P254-590', 1, 11, '2023-08-17', 4, 143.46, 1, 2),
('P928-536', 5, 15, '2022-08-12', 3, 89.27, 1, 9),
('P840-955', 3, 13, '2022-03-07', 3, 28.61, 1, 9),
('P484-286', 8, 8, '2021-06-16', 5, 123.91, 1, 4),
('P335-116', 3, 13, '2022-10-04', 3, 123.67, 1, 10),
('P784-453', 2, 2, '2022-04-29', 1, 41.01, 1, 9),
('P818-672', 10, 10, '2019-01-01', 1, 141.33, 1, 5),
('P162-696', 6, 6, '2020-04-20', 5, 40.06, 1, 4),
('P900-582', 3, 13, '2022-01-13', 5, 135.49, 1, 10),
('P416-140', 1, 11, '2019-07-31', 4, 82.6, 1, 7),
('P526-876', 8, 18, '2019-11-13', 5, 100.54, 1, 3);

-- Mantenimientos:
INSERT INTO MANTENIMIENTO (id_mantenimiento, matricula, fecha, descripcion, costo, id_empleado) VALUES
('MT001', 'P378-814', '2024-05-20', 'Cambio de aceite y filtro', 45.00, 2),
('MT002', 'P953-899', '2024-04-15', 'Cambio de llantas', 120.00, 5),
('MT003', 'P481-629', '2024-06-02', 'Alineación y balanceo', 55.00, 1),
('MT004', 'P314-100', '2024-03-21', 'Limpieza interior', 30.00, 4),
('MT005', 'P956-630', '2024-02-12', 'Mantenimiento de frenos', 70.00, 3),
('MT006', 'P378-814', '2024-01-15', 'Cambio de batería', 80.00, 2),
('MT007', 'P953-899', '2024-06-01', 'Pulido de carrocería', 60.00, 6),
('MT008', 'P481-629', '2024-05-25', 'Cambio de bujías', 40.00, 5),
('MT009', 'P314-100', '2024-04-19', 'Limpieza de motor', 50.00, 1),
('MT010', 'P956-630', '2024-03-10', 'Ajuste de suspensión', 95.00, 7);

-- Reservas:
INSERT INTO reserva (id_reserva, id_cliente, matricula, fecha_inicio_alquiler, fecha_fin_alquiler, id_estado_r, kilometraje_estimado) VALUES
('RSV001', 'cli006', 'P378-814', '2024-08-01', '2024-08-07', 'conf', 735),
('RSV002', 'cli007', 'P953-899', '2024-08-03', '2024-08-09', 'canc', 543),
('RSV003', 'cli008', 'P481-629', '2024-08-05', '2024-08-11', 'canc', 257),
('RSV004', 'cli009', 'P314-100', '2024-08-07', '2024-08-13', 'conf', 343),
('RSV005', 'cli010', 'P956-630', '2024-08-09', '2024-08-15', 'comp', 312),
('RSV006', 'cli011', 'P248-106', '2024-08-11', '2024-08-17', 'comp', 347),
('RSV007', 'cli012', 'P654-864', '2024-08-13', '2024-08-19', 'conf', 369),
('RSV008', 'cli013', 'P287-552', '2024-08-15', '2024-08-21', 'canc', 521),
('RSV009', 'cli014', 'P706-435', '2024-08-17', '2024-08-23', 'conf', 863),
('RSV010', 'cli015', 'P983-783', '2024-08-19', '2024-08-25', 'canc', 661),
('RSV011', 'cli016', 'P279-385', '2024-08-21', '2024-08-27', 'comp', 330),
('RSV012', 'cli017', 'P276-124', '2024-08-23', '2024-08-29', 'comp', 397),
('RSV013', 'cli018', 'P582-623', '2024-08-25', '2024-08-31', 'comp', 435),
('RSV014', 'cli019', 'P330-216', '2024-08-27', '2024-09-02', 'conf', 300),
('RSV015', 'cli020', 'P860-666', '2024-08-29', '2024-09-04', 'canc', 506),
('RSV016', 'cli021', 'P690-721', '2024-08-31', '2024-09-06', 'canc', 353),
('RSV017', 'cli022', 'P911-523', '2024-09-02', '2024-09-08', 'canc', 986),
('RSV018', 'cli023', 'P158-540', '2024-09-04', '2024-09-10', 'canc', 440),
('RSV019', 'cli024', 'P717-132', '2024-09-06', '2024-09-12', 'comp', 457),
('RSV020', 'cli025', 'P883-685', '2024-09-08', '2024-09-14', 'comp', 600),
('RSV021', 'cli026', 'P284-577', '2024-09-10', '2024-09-16', 'conf', 954),
('RSV022', 'cli001', 'P378-814', '2024-09-11', '2024-09-15', 'conf', 900),
('RSV023', 'cli002', 'P276-124', '2024-09-12', '2024-10-07', 'conf', 1000),
('RSV024', 'cli003', 'P983-783', '2024-09-13', '2024-09-25', 'canc', 800),
('RSV025', 'cli011', 'P248-106', '2024-10-11', '2024-10-17', 'comp', 600),
('RSV026', 'cli013', 'P582-623', '2024-10-25', '2024-10-31', 'comp', 670);

-- Servicios adicionales por reserva:
insert into servicio_reserva (id_reserva, id_servicio_adicional) values
('RSV001', 'gps'), ('RSV001', 'seguro'), ('RSV001', 'wifi'),
('RSV002', 'seguro'), ('RSV002', 'bebe'),
('RSV003', 'asist'), ('RSV003', 'musica'),
('RSV004', 'conductor'), ('RSV004', 'gps'),
('RSV005', 'llantas');

-- Pagos: 
INSERT INTO pago (id_pago, id_reserva, monto, fecha_pago, id_metodo_pago) VALUES
('PG006', 'RSV006', 305.17, '2024-08-10', 'tarj'),
('PG007', 'RSV007', 229.35, '2024-08-13', 'tarj'),
('PG008', 'RSV008', 366.02, '2024-08-16', 'tran'),
('PG009', 'RSV009', 356.51, '2024-08-19', 'tran'),
('PG010', 'RSV010', 366.70, '2024-08-22', 'tarj'),
('PG011', 'RSV011', 432.85, '2024-08-25', 'tarj'),
('PG012', 'RSV012', 394.89, '2024-08-28', 'efec'),
('PG013', 'RSV013', 371.96, '2024-08-31', 'tran'),
('PG014', 'RSV014', 170.29, '2024-09-03', 'tarj'),
('PG015', 'RSV015', 301.58, '2024-09-06', 'tran'),
('PG016', 'RSV016', 425.92, '2024-09-09', 'efec'),
('PG017', 'RSV017', 282.43, '2024-09-12', 'tran'),
('PG018', 'RSV018', 358.07, '2024-09-15', 'tarj'),
('PG019', 'RSV019', 243.06, '2024-09-18', 'tran'),
('PG020', 'RSV020', 276.44, '2024-09-21', 'efec'),
('PG021', 'RSV021', 453.92, '2024-09-24', 'tarj'),
('PG022', 'RSV022', 479.81, '2024-09-27', 'efec'),
('PG023', 'RSV023', 413.25, '2024-09-30', 'tran'),
('PG024', 'RSV024', 226.76, '2024-10-03', 'tarj'),
('PG025', 'RSV025', 353.55, '2024-10-06', 'tran'),
('PG026', 'RSV026', 478.38, '2024-10-09', 'tarj');

----- CONSULTAS -----
---- 1. Obtener todas las reservas de un cliente en específíco
SELECT 
    R.id_reserva, 
    R.fecha_inicio_alquiler, 
    R.fecha_fin_alquiler, 
    R.matricula, 
    ER.id_estado_r
FROM RESERVA R
INNER JOIN ESTADO_RESERVA ER ON R.id_estado_r = ER.id_estado_r
WHERE R.id_cliente = 'cli009';

--- Procedimiento almacenado
CREATE PROCEDURE sp_obtener_reservas_cliente
    @id_cliente VARCHAR(15)
AS
BEGIN
    SELECT 
        R.id_reserva, 
        R.fecha_inicio_alquiler, 
        R.fecha_fin_alquiler, 
        R.matricula, 
        ER.id_estado_r
    FROM RESERVA R
    INNER JOIN ESTADO_RESERVA ER ON R.id_estado_r = ER.id_estado_r
    WHERE R.id_cliente = @id_cliente;
END;

--- Ejecutable
EXEC sp_obtener_reservas_cliente @id_cliente = 'cli009';


--- 2. Obtener todos los vehiculos disponibles 
SELECT 
    V.matricula, 
    MV.marca, 
    MODV.modelo, 
    V.anio, 
    TV.tipo, 
    V.precio_diario,
	EV.estado_v
FROM VEHICULOS V
INNER JOIN MARCA_VEHICULO MV ON V.id_marca = MV.id_marca
INNER JOIN MODELO_VEHICULO MODV ON V.id_modelo = MODV.id_modelo
INNER JOIN TIPO_VEHICULO TV ON V.id_tipo = TV.id_tipo
INNER JOIN ESTADO_VEHICULO EV ON V.id_estado_v = EV.id_estado_v
WHERE EV.estado_v = 'Disponible';

--- Procedimiento almacenado
CREATE PROCEDURE sp_obtener_vehiculos_disponibles
AS
BEGIN
    SELECT 
        V.matricula, 
        MV.marca, 
        MODV.modelo, 
        V.anio, 
        TV.tipo, 
        V.precio_diario,
		EV.estado_v
    FROM VEHICULOS V
    INNER JOIN MARCA_VEHICULO MV ON V.id_marca = MV.id_marca
    INNER JOIN MODELO_VEHICULO MODV ON V.id_modelo = MODV.id_modelo
    INNER JOIN TIPO_VEHICULO TV ON V.id_tipo = TV.id_tipo
    INNER JOIN ESTADO_VEHICULO EV ON V.id_estado_v = EV.id_estado_v
    WHERE EV.estado_v = 'Disponible';
END;

--- Ejecutable
EXEC sp_obtener_vehiculos_disponibles;

---- 3. Obtener el total de pagos recibidos en un mes específico
SELECT 
    SUM(monto) AS "Pago total"
FROM PAGO
WHERE MONTH(fecha_pago) = 8 AND YEAR(fecha_pago) = 2024;

--- Procedimiento almacenado
CREATE PROCEDURE sp_total_pagos_por_mes
    @mes INT,
    @anio INT
AS
BEGIN
    SELECT 
        SUM(monto) AS total_pagado
    FROM PAGO
    WHERE MONTH(fecha_pago) = @mes AND YEAR(fecha_pago) = @anio;
END;

--- Ejecutable
EXEC sp_total_pagos_por_mes @mes = 8, @anio = 2024;

-- 4. Obtener todos los empleados en un departamento específico. Para este ejemplo se eligio a "Atencion al 
--cliente" pero puede cambiarse a su gusto
SELECT E.id_empleado, E.nombre, E.fecha_contratacion, E.id_puesto, ED.id_departamento, D.nombre_departamento
FROM EMPLEADO E
INNER JOIN EMPLEADO_DEPARTAMENTO ED
ON E.id_empleado = ED.id_empleado
INNER JOIN DEPARTAMENTO D
ON ED.id_departamento = D.id_departamento
WHERE ED.id_departamento = 2;

-- Ejercicio 4 en forma de procedimiento almacenado pero con el id del departamento
DROP PROCEDURE IF EXISTS EMPLEADOS_DE_UN_DEPARTAMENTO; --Consulta de ayuda

CREATE PROCEDURE EMPLEADOS_DE_UN_DEPARTAMENTO
	@DEPARTAMENTO TINYINT
AS BEGIN
	SELECT E.id_empleado, E.nombre, E.fecha_contratacion, E.id_puesto, ED.id_departamento, D.nombre_departamento
	FROM EMPLEADO E
	INNER JOIN EMPLEADO_DEPARTAMENTO ED
	ON E.id_empleado = ED.id_empleado
	INNER JOIN DEPARTAMENTO D
	ON ED.id_departamento = D.id_departamento
	WHERE ED.id_departamento = @DEPARTAMENTO
END;

EXEC EMPLEADOS_DE_UN_DEPARTAMENTO @DEPARTAMENTO = 3;

-- Ejercicio 4 en forma de procedimiento almacenado pero con el nombre del departamento. De igual forma, lo puede cambiar por 
--cualquiera de los departamentos de esta base para probar el procedimiento almacenado y la consulta
DROP PROCEDURE IF EXISTS EMPLEADOS_DE_UN_DEPARTAMENTO_NOMBRE; --Consulta de ayuda

CREATE PROCEDURE EMPLEADOS_DE_UN_DEPARTAMENTO_NOMBRE
	@DEPARTAMENTO_NOMBRE VARCHAR(35)
AS BEGIN
	SELECT E.id_empleado, E.nombre, E.fecha_contratacion, E.id_puesto, ED.id_departamento, D.nombre_departamento
	FROM EMPLEADO E
	INNER JOIN EMPLEADO_DEPARTAMENTO ED
	ON E.id_empleado = ED.id_empleado
	INNER JOIN DEPARTAMENTO D
	ON ED.id_departamento = D.id_departamento
	WHERE D.nombre_departamento COLLATE Latin1_General_CI_AI = @DEPARTAMENTO_NOMBRE COLLATE Latin1_General_CI_AI --descubri que se puede usar CI y AI para ignorar el case y las tildes
END;

EXEC EMPLEADOS_DE_UN_DEPARTAMENTO_NOMBRE @DEPARTAMENTO_NOMBRE = 'atencion al cliente';

--5. Obtener todos los servicios adicionales usados en una reserva específica. 
SELECT R.id_reserva, R.id_cliente, R.matricula, R.fecha_fin_alquiler, R.fecha_fin_alquiler, ER.estado_v, SA.nombre AS 'nombre del Servicio Adicional', SA.descripcion, SA.costo
FROM SERVICIO_RESERVA SR
INNER JOIN RESERVA R
ON SR.id_reserva = R.id_reserva
INNER JOIN SERVICIOS_ADICIONALES SA
ON SR.id_servicio_adicional = SA.id_servicio_adicional
INNER JOIN ESTADO_RESERVA ER
ON R.id_estado_r = ER.id_estado_r
WHERE R.id_reserva = 'RSV001';

-- Procedimiento almacenado del ejercicio 5.
DROP PROCEDURE IF SERVICIO_ADICIONALES_RESERVA;

CREATE PROCEDURE SERVICIO_ADICIONALES_RESERVA
@ID_RESERVA VARCHAR(15)
AS BEGIN
	SELECT R.id_reserva, R.id_cliente, R.matricula, R.fecha_fin_alquiler, R.fecha_fin_alquiler, ER.estado_v, SA.nombre AS 'nombre del Servicio Adicional', SA.descripcion, SA.costo
	FROM SERVICIO_RESERVA SR
	INNER JOIN RESERVA R
	ON SR.id_reserva = R.id_reserva
	INNER JOIN SERVICIOS_ADICIONALES SA
	ON SR.id_servicio_adicional = SA.id_servicio_adicional
	INNER JOIN ESTADO_RESERVA ER
	ON R.id_estado_r = ER.id_estado_r
	WHERE R.id_reserva = @ID_RESERVA
END;

EXEC SERVICIO_ADICIONALES_RESERVA @ID_RESERVA = 'RSV002';

----- CONSULTAS EXTRA: -----
----1. Vehiculo más alquilado (en este caso se hace top 5, porque hay 5 vehiculos que tienen la misma cantidad de veces alquiladas)
SELECT TOP 5 R.matricula, COUNT(*) AS "Veces que se ha alquilado"
FROM RESERVA R
GROUP BY R.matricula
ORDER BY "Veces que se ha alquilado" DESC;

---Procedimiento almacenado
CREATE PROCEDURE sp_vehiculo_mas_alquilado
AS
BEGIN
    SELECT TOP 5 R.matricula, COUNT(*) AS "Veces que se ha alquilado"
    FROM RESERVA R
    GROUP BY R.matricula
    ORDER BY "Veces que se ha alquilado" DESC;
END;

-- Ejecutable
EXEC sp_vehiculo_mas_alquilado;

---2. Cliente que más paga
SELECT TOP 1 C.id_cliente, C.nombre, SUM(P.monto) AS "Pago total"
FROM CLIENTE C
JOIN RESERVA R ON C.id_cliente = R.id_cliente
JOIN PAGO P ON R.id_reserva = P.id_reserva
GROUP BY C.id_cliente, C.nombre
ORDER BY "Pago total" DESC;

--- Procedimiento almacenado
CREATE PROCEDURE sp_cliente_que_mas_paga
AS
BEGIN
    SELECT TOP 1 C.id_cliente, C.nombre, SUM(P.monto) AS "Pago total"
    FROM CLIENTE C
    JOIN RESERVA R ON C.id_cliente = R.id_cliente
    JOIN PAGO P ON R.id_reserva = P.id_reserva
    GROUP BY C.id_cliente, C.nombre
    ORDER BY "Pago total" DESC;
END;

-- Ejecutable
EXEC sp_cliente_que_mas_paga;

-- Consultas adicional extra No. 3. ingresos por tipo de vehículo.
SELECT tipo, 
       COALESCE(
         (SELECT SUM(P.monto)
          FROM VEHICULOS V
          JOIN RESERVA R ON V.matricula = R.matricula
          JOIN PAGO P ON R.id_reserva = P.id_reserva
          WHERE V.id_tipo = TV.id_tipo
            AND P.monto > 0), 0) AS "Ingresos por tipo de vehiculo"
FROM TIPO_VEHICULO TV;

select * from pago;
select * from reserva;
select * from VEHICULOS;
select * from TIPO_VEHICULO;

-- Procedimiento almacenado de la consulta adicion No. 3 Pero para un tipo de vehiculo especifico mediante id
DROP PROCEDURE IF EXISTS INGRESO_TIPO_VEHICULO_ID;

CREATE PROCEDURE INGRESO_TIPO_VEHICULO_ID
@TIPO_VEHICULO SMALLINT 
AS BEGIN
	SELECT tipo, 
       COALESCE(
         (SELECT SUM(P.monto)
          FROM VEHICULOS V
          JOIN RESERVA R ON V.matricula = R.matricula
          JOIN PAGO P ON R.id_reserva = P.id_reserva
          WHERE V.id_tipo = TV.id_tipo
            AND P.monto > 0), 0) AS "Ingresos por tipo de vehiculo"
	FROM TIPO_VEHICULO TV
	WHERE TV.id_tipo = @TIPO_VEHICULO
END;

EXEC INGRESO_TIPO_VEHICULO_ID @TIPO_VEHICULO = 1;


-- Procedimiento almacenado de la consulta adicion No. 3 Pero para un tipo de vehiculo especifico mediante nombre
DROP PROCEDURE IF EXISTS INGRESO_TIPO_VEHICULO_NOMBRE;
CREATE PROCEDURE INGRESO_TIPO_VEHICULO_NOMBRE
@TIPO_VEHICULO_NOMBRE VARCHAR(30) 
AS BEGIN
	SELECT tipo, 
       COALESCE(
         (SELECT SUM(P.monto)
          FROM VEHICULOS V
          JOIN RESERVA R ON V.matricula = R.matricula
          JOIN PAGO P ON R.id_reserva = P.id_reserva
          WHERE V.id_tipo = TV.id_tipo
            AND P.monto > 0), 0) AS "Ingresos por tipo de vehiculo"
	FROM TIPO_VEHICULO TV
	WHERE TV.tipo = @TIPO_VEHICULO_NOMBRE
END;

EXEC INGRESO_TIPO_VEHICULO_NOMBRE @TIPO_VEHICULO_NOMBRE = 'SUV';

--Mismo procedimiento almacenado pero sin parametros
CREATE PROCEDURE INGRESOS_TIPO_VEHICULO
AS BEGIN
	SELECT tipo, 
       COALESCE(
         (SELECT SUM(P.monto)
          FROM VEHICULOS V
          JOIN RESERVA R ON V.matricula = R.matricula
          JOIN PAGO P ON R.id_reserva = P.id_reserva
          WHERE V.id_tipo = TV.id_tipo
            AND P.monto > 0), 0) AS "Ingresos por tipo de vehiculo"
	FROM TIPO_VEHICULO TV
END;

EXEC INGRESOS_TIPO_VEHICULO;

--Consulta adicional No 4. Metodo de pago mas y menos utilizado

-- Consulta para método de pago más utilizado
SELECT MP.metodo_pago, COUNT(*) AS total_uso
FROM PAGO P
INNER JOIN METODO_PAGO MP ON P.id_metodo_pago = MP.id_metodo_pago
GROUP BY MP.metodo_pago
HAVING COUNT(*) = (
    SELECT MAX(cantidad)
    FROM (
        SELECT COUNT(*) AS cantidad
        FROM PAGO
        GROUP BY id_metodo_pago
    ) AS sub
);

--Procedimiento almacenado de la Consulta adicional No. 4
CREATE PROCEDURE METODO_MAS_USADO
AS BEGIN
	SELECT MP.metodo_pago, COUNT(*) AS total_uso
	FROM PAGO P
	JOIN METODO_PAGO MP ON P.id_metodo_pago = MP.id_metodo_pago
	GROUP BY MP.metodo_pago
	HAVING COUNT(*) = (
		SELECT MAX(cantidad)
		FROM (
			SELECT COUNT(*) AS cantidad
			FROM PAGO
			GROUP BY id_metodo_pago
		) AS sub
	)
END;

EXEC METODO_MAS_USADO;

--Consulta adicional No 5. Cantidad de mantenimientos que cada Empleado ha hecho.
SELECT 
    E.id_empleado,
    E.nombre,
    (SELECT COUNT(*) 
     FROM MANTENIMIENTO M
     WHERE M.id_empleado = E.id_empleado) AS total_mantenimientos
FROM EMPLEADO E;

--Procedimiento almacenado de la consulta adicional No.5 pero por id del empleado
CREATE PROCEDURE CANTIDAD_MANTENIMIENTOS_EMPLEADO_ID
    @id_empleado SMALLINT
AS
BEGIN
    DECLARE @nombre VARCHAR(50);
    DECLARE @total INT;

    SELECT @nombre = nombre
    FROM EMPLEADO
    WHERE id_empleado = @id_empleado;

    SELECT @total = COUNT(*)
    FROM MANTENIMIENTO
    WHERE id_empleado = @id_empleado;

    PRINT 'El empleado ' + ISNULL(@nombre, 'desconocido') + 
          ' ha realizado ' + CAST(@total AS VARCHAR) + ' mantenimientos.';
END;

EXEC CANTIDAD_MANTENIMIENTOS_EMPLEADO_ID @id_empleado = 3;

select * from EMPLEADO;

--Procedimiento almacenado de la consulta adicional No.5 pero por nombre del empleado
CREATE PROCEDURE CANTIDAD_MANTENIMIENTOS_EMPLEADO_NOMBRE
    @nombre_empleado VARCHAR(50)
AS
BEGIN
    DECLARE @id_empleado SMALLINT;
    DECLARE @total INT;

    SELECT TOP 1 @id_empleado = id_empleado
    FROM EMPLEADO
    WHERE nombre = @nombre_empleado;

    IF @id_empleado IS NULL
    BEGIN
        PRINT 'Empleado no encontrado.';
        RETURN;
    END

    SELECT @total = COUNT(*)
    FROM MANTENIMIENTO
    WHERE id_empleado = @id_empleado;

    PRINT 'El empleado ' + @nombre_empleado + 
          ' ha realizado ' + CAST(@total AS VARCHAR) + ' mantenimientos.';
END;

EXEC CANTIDAD_MANTENIMIENTOS_EMPLEADO_NOMBRE @nombre_empleado = 'Andrea Claramunt';

-- Mismo procedimiento almacenado pero con todos los empleados
CREATE PROCEDURE CANTIDAD_MANTENIMIENTOS_EMPLEADOS
AS
BEGIN
	SELECT 
    E.id_empleado,
    E.nombre,
    (SELECT COUNT(*) 
     FROM MANTENIMIENTO M
     WHERE M.id_empleado = E.id_empleado) AS total_mantenimientos
	FROM EMPLEADO E;
END;

EXEC CANTIDAD_MANTENIMIENTOS_EMPLEADOS;

---- TRIGGERS ----
-- Se crea una tabla "Reserva"
CREATE TABLE CONTROL_RESERVA (
    id_control INT PRIMARY KEY IDENTITY,
    id_reserva VARCHAR(15),
    matricula VARCHAR(10),
    fecha_hora_reserva DATETIME DEFAULT GETDATE()
);

-- Trigger despues de hacer un insert
CREATE TRIGGER tr_actualizar_estado_vehiculo_y_control
ON RESERVA
AFTER INSERT
AS
BEGIN
    -- Cambiar estado del vehículo a 'Alquilado' (id_estado_v = 2)
    UPDATE VEHICULOS
    SET id_estado_v = 2
    WHERE matricula IN (
        SELECT matricula FROM inserted
    );

    -- Insertar en tabla de control con fecha y hora actual
    INSERT INTO CONTROL_RESERVA (id_reserva, matricula)
    SELECT id_reserva, matricula
    FROM inserted;

END;

-- Trigger para Registrar Pago Automático
CREATE TRIGGER tr_pago_automatico_reserva
ON RESERVA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Insertar automáticamente un pago con monto 0 para cada nueva reserva
    INSERT INTO PAGO (id_pago, id_reserva, monto, fecha_pago, id_metodo_pago)
    SELECT 
        CONCAT('PG_', id_reserva),   -- ID de pago generado como 'PG' + (id_reserva)
        id_reserva,
        0.00,
        GETDATE(),
        'efec'  -- Método de pago por defecto
    FROM inserted;
END;

--- VISTAS ---
-- Crear vista para obtener todas las reservas que se marcan como "Alquiladas"
CREATE VIEW vista_reservas_actuales AS
SELECT 
    R.id_reserva,
    C.id_cliente,
    C.nombre AS nombre_cliente,
    C.telefono,
    V.matricula,
    MV.marca,
    MODV.modelo,
    V.anio,
    R.fecha_inicio_alquiler,
    R.fecha_fin_alquiler
FROM RESERVA R
JOIN CLIENTE C ON R.id_cliente = C.id_cliente
JOIN VEHICULOS V ON R.matricula = V.matricula
JOIN ESTADO_VEHICULO EV ON V.id_estado_v = EV.id_estado_v
JOIN MARCA_VEHICULO MV ON V.id_marca = MV.id_marca
JOIN MODELO_VEHICULO MODV ON V.id_modelo = MODV.id_modelo
WHERE 
    GETDATE() BETWEEN R.fecha_inicio_alquiler AND R.fecha_fin_alquiler
    AND EV.estado_v = 'Alquilado';

-- Ejecucion de la vista
SELECT * FROM vista_reservas_actuales;

-- Vista de Ingresos Mensuales
CREATE VIEW vista_ingresos_mensuales AS
SELECT 
    YEAR(fecha_pago) AS anio,
    MONTH(fecha_pago) AS mes,
    SUM(monto) AS ingresos_totales
FROM PAGO
GROUP BY 
    YEAR(fecha_pago),
    MONTH(fecha_pago);

-- Ejecutamos la vista
SELECT * FROM vista_ingresos_mensuales
ORDER BY anio, mes;
