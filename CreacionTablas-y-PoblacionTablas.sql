create database CyComputerService;

use CyComputerService;

DROP TABLE IF EXISTS CategoriaProducto;

CREATE TABLE CategoriaProducto
(
	IdCategoria		INT PRIMARY KEY IDENTITY(1, 1),
	NombreCategoria VARCHAR(50) NOT NULL,
	Descripcion		VARCHAR(MAX) DEFAULT 'Categoria sin descripcion'
);


drop table if exists Producto
create table Producto
(
	IdProducto		int primary key identity(1, 1),
	IdCategoria		int foreign key references CategoriaProducto(IdCategoria) not null,
	NombreProducto	varchar(30) not null,
	Descripcion		varchar(max) default 'Producto sin descripcion',
	PrecioUnitario	decimal(8, 2)
);


drop table if exists Cliente
create table Cliente
(
	IdCliente		int primary key identity(1, 1),
	NombreCliente	varchar(50) not null,
	TelefonoCliente varchar(9) not null,
	EmailCliente	varchar(50) not null,
	DniCliente		varchar(8)
);

drop table if exists Direccion
create table Direccion
(
	IdDireccion		int primary key identity(1, 1),
	IdCliente		int foreign key references Cliente(IdCliente) not null,
	Direccion		varchar(255) not null,
	Numero			varchar(10) not null,
	Departamento	varchar(30) not null,
	Provincia		varchar(30) not null,
	Distrito		varchar(30) not null,
	Telefono		varchar(20) not null
);

drop table if exists Puesto
create table Puesto
(
	IdPuesto int primary key identity(1, 1),
	NombrePuesto varchar(50) not null,
	Descripcion varchar(max)
);

drop table if exists Empleado
create table Empleado
(
	IdEmpleado		int primary key identity(1, 1),
	IdPuesto		int foreign key references Puesto(IdPuesto) not null,
	NombreEmpleado	varchar(50) not null,
	DniEmpleado		varchar(20) not null,
	FechaContrato	date not null,
	TelefonoEmpleado varchar(20) not null
);

drop table if exists Proveedor
create table Proveedor
(
	IdProveedor		int primary key identity(1, 1),
	RUCProveedor	varchar(20) not null,
	NombreProveedor varchar(50) not null,
	TelefonoProveedor varchar(20) not null,
	EmailProveedor	varchar(50)
);

drop table if exists Transaccion
create table Transaccion
(
	IdTransaccion	int primary key identity(1, 1),
	Fecha			date default getDate(),
	Hora			time default getDate(),
	SubTotal		decimal(6, 2) not null,
	Descuento		decimal(6, 2) default 0.0,
	MontoTotal		decimal(6, 2) not null,
	Comentarios		varchar(max) default 'Sin comentarios'
);

drop table if exists Compra
create table Compra
(
	IdCompra		int primary key identity(1, 1),
	IdTransaccion	int foreign key references Transaccion(IdTransaccion) not null,
	IdProveedor		int foreign key references Proveedor(IdProveedor) not null
);

drop table if exists Venta
create table Venta
(
	IdVenta			int primary key identity(1, 1),
	IdTransaccion	int foreign key references Transaccion(IdTransaccion) not null,
	IdCliente		int foreign key references Cliente(IdCliente) not null,
	IdEmpleado		int foreign key references Empleado(IdEmpleado) not null,
	IdDireccion		int foreign key references Direccion(IdDireccion) not null,
	IGV				decimal(6, 2) not null
);

drop table if exists DetallesTransaccion
create table DetallesTransaccion
(
	IdTransaccion	int foreign key references Transaccion(IdTransaccion) not null,
	IdProducto		int foreign key references Producto(IdProducto) not null,
	Cantidad		int not null,
	PrecioUnitario	float not null,
	MontoTotal		float not null
);

drop table if exists StockKardex
create table StockKardex
(
	IdStock			int primary key identity(1, 1),
	IdProducto		int foreign key references Producto(IdProducto) not null,
	StockActual		int default 0
);

drop table if exists TipoMovimiento
create table TipoMovimiento
(
	IdTipoMovimiento int primary key identity(1, 1),
	NombreMovimiento varchar(20) not null
);

drop table if exists MovimientosKardex
create table MovimientosKardex
(
	IdMovimiento	int primary key identity(1, 1),
	IdProducto		int foreign key references Producto(IdProducto) not null,
	IdTipoMovimiento int foreign key references TipoMovimiento(IdTipoMovimiento) not null,
	Fecha			date default getDate(),
	Hora			time default getDate()
);

--POBLACION DE TABLAS 

--CATEGORIA DE LOS PRODUCTOS
INSERT INTO CategoriaProducto (NombreCategoria, Descripcion)
VALUES
    ('Laptops', 'Computadoras portátiles'),
    ('Desktops', 'Computadoras de escritorio'),
    ('Accesorios para Computadoras', 'Teclados, ratones, etc.'),
    ('Monitores', 'Pantallas y monitores'),
    ('Impresoras', 'Impresoras y escáneres'),
    ('Almacenamiento', 'Discos duros y unidades de almacenamiento'),
    ('Software', 'Sistemas operativos y software'),
    ('Componentes de Computadoras', 'Tarjetas gráficas, procesadores, etc.'),
    ('Redes', 'Equipos de redes y routers'),
    ('Periféricos', 'Otros dispositivos periféricos'),
    ('Cámaras y Webcams', 'Cámaras y webcams para computadoras'),
    ('Gaming', 'Equipos y accesorios para gaming'),
    ('Servidores', 'Equipos de servidor y soluciones empresariales'),
    ('Tabletas', 'Tabletas y dispositivos similares'),
    ('Electrónicos', 'Productos electrónicos de consumo'),
    ('Móviles', 'Teléfonos móviles y accesorios'),
    ('Computadoras', 'Computadoras y portátiles'),
    ('Software de Seguridad', 'Antivirus y soluciones de seguridad'),
    ('Servidores Rack', 'Equipos de servidor en formato rack para soluciones empresariales'),
    ('Estaciones de Trabajo', 'Computadoras de alto rendimiento para tareas especializadas');

	select*from CategoriaProducto

--PRODUCTOS

INSERT INTO Producto (IdCategoria, NombreProducto, Descripcion, PrecioUnitario)
VALUES
    (1, 'HP Spectre x360', 'Laptop ultradelgada con la última tecnología', 1200.00),
    (2, 'Dell XPS 8940', 'Computadora de escritorio de alto rendimiento para tareas pesadas', 1500.00),
    (3, 'Razer BlackWidow Elite', 'Teclado mecánico para juegos con iluminación RGB', 80.00),
    (4, 'LG UltraGear 27GL83A-B', 'Monitor Gaming QHD IPS de 27 pulgadas', 250.00),
    (5, 'Epson EcoTank ET-2760', 'Impresora inalámbrica con tanque de tinta recargable', 180.00),
    (6, 'Western Digital 1TB', 'Disco duro externo de gran capacidad', 80.00),
    (7, 'Windows 10 Pro', 'Software de sistema operativo con las últimas actualizaciones', 100.00),
    (8, 'NVIDIA GeForce RTX 3080', 'Tarjeta gráfica de última generación para juegos', 500.00),
    (9, 'Linksys EA9500', 'Router de alta velocidad para conectividad de red sin problemas', 120.00),
    (10, 'Logitech G Pro X', 'Mouse para juegos con precisión y botones personalizables', 60.00),
    (11, 'Logitech C922 Pro', 'Webcam HD 1080p para videoconferencias', 40.00),
    (1, 'Apple MacBook Air', 'Laptop ligera y portátil para uso diario', 800.00),
    (12, 'Alienware Aurora R10', 'PC gaming potente con iluminación RGB', 2000.00),
    (13, 'HPE ProLiant DL380 Gen10', 'Servidor de grado empresarial para soluciones empresariales', 3000.00),
    (14, 'Samsung Galaxy Tab S7', 'Tableta elegante y potente con soporte para S Pen', 400.00),
    (15, 'Sony WH-1000XM4', 'Audífonos inalámbricos con cancelación de ruido', 50.00),
    (16, 'iPhone 13 Pro Max', 'Teléfono móvil insignia con funciones avanzadas', 800.00),
    (17, 'Dell Precision 7920 Tower', 'Estación de trabajo de escritorio de alto rendimiento', 2500.00),
    (7, 'Kaspersky Total Security', 'Software avanzado de antivirus y seguridad', 60.00),
    (9, 'TP-Link Archer C50', 'Router compacto para uso doméstico', 80.00),
    (18, 'Bitdefender Security', 'Software de seguridad avanzado para empresas', 120.00),
    (19, 'Dell PowerEdge R740', 'Servidor montado en rack de grado empresarial', 3500.00),
    (20, 'Lenovo ThinkStation P520', 'Estación de trabajo de alto rendimiento para tareas especializadas', 1800.00),
    (4, 'ASUS ROG Swift PG279Q', 'Monitor gaming 4K UHD de 27 pulgadas', 400.00),
    (16, 'Samsung Galaxy A32', 'Teléfono móvil asequible con funciones esenciales', 200.00),
    (6, 'Seagate Expansion 2TB', 'Disco duro externo de gran capacidad para respaldo', 100.00),
    (5, 'Canon PIXMA MG3620', 'Impresora asequible para uso doméstico', 60.00),
    (3, 'Microsoft Wired Keyboard 600', 'Teclado básico para necesidades diarias', 30.00),
    (10, 'Dell Optical Mouse', 'Mouse sencillo para tareas cotidianas', 20.00),
    (11, 'Logitech C270', 'Webcam de calidad básica para videollamadas', 25.00),
    (15, 'JBL T450', 'Auriculares asequibles para escuchar música', 15.00),
    (14, 'Amazon Fire HD 8 Kids Edition', 'Tableta diseñada para niños con aplicaciones educativas', 100.00),
    (2, 'Acer Aspire TC', 'Computadora de escritorio básica para tareas simples', 300.00),
    (12, 'HP EliteDesk 800 G6', 'PC diseñada para tareas de oficina', 600.00),
    (18, 'McAfee Antivirus Plus', 'Software antivirus básico para protección esencial', 40.00),
    (17, 'HP Z4 G4', 'Estación de trabajo para tareas básicas de diseño', 400.00);

	select*from Producto

--CLIENTES

INSERT INTO Cliente (NombreCliente, TelefonoCliente, EmailCliente, DniCliente)
VALUES
	('Pablo López', '912345678', 'pablo.lopez@email.com', '70123456'),
	('Martina González', '923456789', 'martina.gonzalez@email.com', '71123456'),
	('Alejandro Rodríguez', '934567890', 'alejandro.rodriguez@email.com', '72123456'),
	('Valeria Martínez', '945678901', 'valeria.martinez@email.com', '73123456'),
	('Gabriel Sánchez', '956789012', 'gabriel.sanchez@email.com', '74123456'),
	('Isabella López', '967890123', 'isabella.lopez@email.com', '75123456'),
	('Fernando González', '978901234', 'fernando.gonzalez@email.com', '70234567'),
	('Camila Herrera', '989012345', 'camila.herrera@email.com', '71234567'),
	('Lucas Díaz', '990123456', 'lucas.diaz@email.com', '72234567'),
	('Sophia Fernández', '912398765', 'sophia.fernandez@email.com', '73234567'),
	('Diego Ruiz', '923487654', 'diego.ruiz@email.com', '74234567'),
	('Alicia Jiménez', '934576543', 'alicia.jimenez@email.com', '75234567'),
	('Mateo García', '945665432', 'mateo.garcia@email.com', '70345678'),
	('Valentina Moreno', '956754321', 'valentina.moreno@email.com', '71345678'),
	('Nicolas Torres', '967843210', 'nicolas.torres@email.com', '72345678'),
	('Emma Ramírez', '978932109', 'emma.ramirez@email.com', '73345678'),
	('Santiago Castro', '989021098', 'santiago.castro@email.com', '74345678'),
	('Olivia Soto', '990109876', 'olivia.soto@email.com', '75345678'),
	('Liam Gómez', '912380987', 'liam.gomez@email.com', '70456789'),
	('Aurora Vargas', '923490876', 'aurora.vargas@email.com', '71456789');

	SELECT*FROM Cliente

--DIRECCION

INSERT INTO Direccion (IdCliente, Direccion, Numero, Departamento, Provincia, Distrito, Telefono)
VALUES
    (1, 'Av. Arenales', '2345', 'Lima', 'Lima', 'Lince', '987-654-3210'),
    (2, 'Calle La Merced', '5678', 'Arequipa', 'Arequipa', 'Cayma', '123-456-7890'),
    (3, 'Av. Conquistadores', '8901', 'Lima', 'Lima', 'San Isidro', '555-666-7777'),
    (4, 'Calle Bolívar', '1234', 'Lima', 'Lima', 'Miraflores', '777-888-9999'),
    (5, 'Av. Los Pinos', '4567', 'Lima', 'Lima', 'San Juan de Lurigancho', '111-222-3333'),
    (6, 'Calle Misti', '7890', 'Arequipa', 'Arequipa', 'Yanahuara', '222-333-4444'),
    (7, 'Calle Las Orquídeas', '1011', 'Lima', 'Lima', 'San Borja', '333-444-5555'),
    (8, 'Av. Dolores', '2022', 'Arequipa', 'Arequipa', 'Cercado', '444-555-6666'),
    (9, 'Calle Las Magnolias', '3033', 'Lima', 'Lima', 'Surquillo', '666-777-8888'),
    (10, 'Av. Larco Mar', '4044', 'Lima', 'Lima', 'Miraflores', '888-999-0000'),
    (11, 'Calle Bajada de Baños', '5055', 'Lima', 'Lima', 'Barranco', '999-888-7777'),
    (12, 'Av. Ejército', '6066', 'Arequipa', 'Arequipa', 'Cayma', '111-222-3333'),
    (13, 'Calle San Juan de Dios', '7077', 'Lima', 'Lima', 'San Borja', '222-333-4444'),
    (14, 'Av. Industrial', '8088', 'Arequipa', 'Arequipa', 'Cayma', '333-444-5555'),
    (15, 'Calle Las Begonias', '9099', 'Lima', 'Lima', 'San Isidro', '444-555-6666'),
    (16, 'Av. El Sol', '1112', 'Arequipa', 'Arequipa', 'Cayma', '555-666-7777'),
    (17, 'Calle Los Cipreses', '2223', 'Lima', 'Lima', 'Surco', '666-777-8888'),
    (18, 'Av. Los Laureles', '3334', 'Arequipa', 'Arequipa', 'Cayma', '777-888-9999'),
    (19, 'Calle Tacna', '4445', 'Lima', 'Lima', 'Centro', '888-999-0000'),
    (20, 'Av. San Martín', '5556', 'Arequipa', 'Arequipa', 'Cayma', '999-000-1111');


	SELECT*FROM Direccion

--PUESTOS
INSERT INTO Puesto (NombrePuesto, Descripcion)
VALUES
    ('Gerente de Ventas', 'Supervisa y lidera el equipo de ventas.'),
    ('Especialista en Ventas', 'Realiza ventas directas y brinda asesoramiento.'),
    ('Técnico de Soporte', 'Brinda soporte técnico a clientes antes y después de la venta.'),
    ('Ingeniero de Sistemas', 'Desarrolla soluciones informáticas para clientes.'),
    ('Especialista en Marketing', 'Diseña estrategias de marketing en línea.'),
    ('Gerente de Logística', 'Supervisa gestión de inventario y distribución.'),
    ('Atención al Cliente', 'Atiende consultas y reclamaciones de clientes.'),
    ('Contador Financiero', 'Lleva a cabo contabilidad y elabora informes financieros.'),
    ('Desarrollo de Negocios', 'Busca oportunidades de negocio y alianzas.'),
    ('Gerente de Recursos Humanos', 'Administra reclutamiento y desarrollo de personal.');
    
	select*from Puesto

--EMPLEADOS 
INSERT INTO Empleado (IdPuesto, NombreEmpleado, DniEmpleado, FechaContrato, TelefonoEmpleado)
VALUES
    (3, 'Marina Gutiérrez', '70123456', '15-03-2016', '912-345-678'),
    (4, 'Ricardo Pérez', '75123456', '20-05-2017', '913-456-789'),
    (5, 'Liliana Soto', '70456789', '10-08-2016', '914-567-890'),
    (6, 'Hugo González', '75456789', '28-02-2017', '915-678-901'),
    (3, 'Nadia Cáceres', '70789012', '03-11-2015', '916-789-012'),
    (8, 'Diego Vargas', '75789012', '22-09-2016', '917-890-123'),
    (2, 'Sandra Mendoza', '70122334', '14-07-2015', '918-901-234'),
    (10, 'Carlos Rojas', '75122334', '01-10-2014', '919-012-345'),
    (2, 'Verónica Paz', '70445678', '05-12-2016', '920-123-456'),
    (2, 'Gustavo Romero', '75445678', '18-04-2015', '921-234-567'),
    (5, 'Julieta Paredes', '70778901', '29-08-2013', '922-345-678'),
    (4, 'Martín Salas', '75778901', '12-06-2014', '923-456-789'),
    (2, 'Laura Castillo', '70127890', '10-02-2016', '924-567-890'),
    (9, 'Fernando Díaz', '75127890', '25-10-2013', '925-678-901'),
    (7, 'Gabriela Chávez', '70451234', '30-11-2014', '926-789-012'),
    (2, 'Alejandro Torres', '75451234', '17-04-2013', '927-890-123'),
    (6, 'Isabel Núñez', '70784567', '08-09-2015', '928-901-234'),
    (8, 'Juan León', '75784567', '03-07-2014', '929-012-345'),
    (2, 'Cecilia Ríos', '70125678', '14-01-2016', '930-123-456'),
    (1, 'Raúl Medina', '75125678', '28-03-2015', '931-234-567');

	select*from Empleado
--PROVEEDORES
INSERT INTO Proveedor (RUCProveedor, NombreProveedor, TelefonoProveedor, EmailProveedor)
VALUES
    ('78901234567', 'ElectroSuministros', '666-555-4444', 'electrosuministros@example.com'),
    ('23456789012', 'Tecnología Avanzada', '444-333-2222', 'tecnologiaavanzada@example.com'),
    ('34567890123', 'ProveTel S.A.C.', '222-111-0000', 'provetel@example.com'),
    ('45678901234', 'Soluciones Informáticas', '111-000-9999', 'solucionesinformaticas@example.com'),
    ('56789012345', 'Distribuidora Digital', '999-888-1111', 'distribuidoradigital@example.com'),
    ('67890123456', 'Innovatech', '777-666-9999', 'innovatech@example.com'),
    ('78901234561', 'Suministros Electrónicos', '555-444-3333', 'suministroselectronicos@example.com'),
    ('89012345678', 'Computadoras Express', '333-222-8888', 'computadorasexpress@example.com'),
    ('90123456789', 'Electroventas', '111-999-7777', 'electroventas@example.com'),
    ('12345678901', 'ProveElectro S.A.', '999-777-1111', 'proveelectro@example.com'),
    ('98765432109', 'Distribuciones Tecno', '777-111-9999', 'tecno@example.com'),
    ('34567890128', 'TecnoSuministros', '222-111-4444', 'tecno_suministros@example.com'),
    ('45678901237', 'Digital Solutions', '111-444-9999', 'digitalsolutions@example.com'),
    ('56789012348', 'ElectroInnovación', '999-444-1111', 'electroinnovacion@example.com'),
    ('67890123459', 'Tecnología Total', '777-111-8888', 'tecnologiatotal@example.com'),
    ('78901234563', 'ProveTel Express', '555-444-9999', 'provetel_express@example.com'),
    ('89012345672', 'Informática Rápida', '333-222-8888', 'informaticarapida@example.com'),
    ('90123456781', 'ElectroTech', '111-999-7777', 'electrotech@example.com'),
    ('12345678905', 'Suministros Digitales', '999-777-1111', 'suministrosdigitales@example.com'),
    ('98765432102', 'Tech Distribuciones', '777-111-9999', 'techdistribuciones@example.com');

	SELECT*FROM PROVEEDOR

--TRANSACCIONES

INSERT INTO Transaccion (Fecha, Hora, SubTotal, Descuento, MontoTotal, Comentarios)
VALUES
    ('15-01-2023', '12:30:00', 1000.00, 50.00, 950.00, 'Venta'),
    ('20-02-2023', '15:45:00', 960.00, 20.00, 940.00, 'Compra'),
    ('12-03-2023', '10:15:00', 1200.00, 60.00, 1140.00, 'Venta'),
     ('18-04-2023', '09:00:00', 1440.00, 40.00, 1400.00, 'Compra'),
    ('23-05-2023', '14:20:00', 1500.00, 75.00, 1425.00, 'Venta'),
   ('05-06-2023', '11:30:00', 1152.00, 152.00, 1000.00, 'Compra'),
    ('08-07-2023', '16:00:00', 900.00, 45.00, 855.00, 'Venta'),
    ('14-08-2023', '13:15:00', 3840.00, 40.00, 3800.00, 'Compra'),
    ('19-09-2023', '08:45:00', 1300.00, 65.00, 1235.00, 'Venta'),
    ('25-10-2023', '17:10:00', 720.00, 30.00, 690.00, 'Compra'),
    ('03-11-2023', '14:45:00', 1000.00, 50.00, 950.00, 'Venta'),
  ('09-12-2023', '09:30:00', 1920.00, 120.00, 1800.00, 'Compra'),
    ('22-01-2024', '11:20:00', 1200.00, 60.00, 1140.00, 'Venta'),
    ('17-02-2024', '10:00:00', 1728.00, 228.00, 1500.00, 'Compra '),
    ('14-03-2024', '15:40:00', 1500.00, 75.00, 1425.00, 'Venta'),
    ('06-04-2024', '12:00:00', 3840.00, 240.00, 3600.00, 'Compra '),
    ('01-05-2024', '16:30:00', 900.00, 45.00, 855.00, 'Venta'),
     ('28-06-2024', '13:00:00', 3840.00, 300.00, 3540.00, 'Compra'),
    ('11-07-2024', '08:15:00', 1300.00, 65.00, 1235.00, 'Venta'),
    ('19-08-2024', '17:50:00', 5760.00, 460.00, 5300.00, 'Compra');

	select*from Transaccion

--COMPRAS
INSERT INTO Compra (IdTransaccion, IdProveedor)
VALUES
    (2, 1),
    (4, 3),
    (6, 5),
    (8, 7),
    (10, 9),
    (12, 11),
    (14, 13),
    (16, 15),
    (18, 17),
    (20, 19);


--VENTAS
INSERT INTO Venta (IdTransaccion, IdCliente, IdEmpleado, IdDireccion, IGV)
VALUES
    (1, 1, 7, 1, 18.00),
    (3, 2, 9, 3, 18.00),
    (5, 3, 11, 5, 18.00),
    (7, 4, 7, 7, 18.00),
    (9, 5, 9, 9, 18.00),
    (11, 6, 16, 11, 18.00),
    (13, 7, 19, 13, 18.00),
    (15, 8, 13, 15, 18.00),
    (17, 9, 7, 17, 18.00),
    (19, 10, 19, 19, 18.00);

--DETALLES-TRANSACCION
INSERT INTO DetallesTransaccion (IdTransaccion, IdProducto, Cantidad, PrecioUnitario, MontoTotal)
VALUES

(1,30,2,25.00,50),(1,8,1,500.00,500.00),(1,24,1,400.00,400.00),
(2,7,12,80.00,960.00),
(3,25,5,200.00,1000.00),(3,26,2,100.00,200.00),
(4,33,6,240.00,1440.00),
(5,24,2,400.00,800.00),(5,4,2,250.00,500.00),(5,25,1,200.00,200.00),
(6,27,24,48.00,1152.00),
(7,16,4,50.00,200.00),(7,15,1,400.00,400.00),(7,33,1,300.00,300.00),
(8,17,6,640.00,3840),
(9,1,1,1200.00,1200.00),(9,7,1,100.00,100.00),
(10,30,36,20.00,720.00),
(11,17,1,800.00,800.00),(11,35,5,40.00,200.00),
(12,24,6,320.00,1920.00),
(13,24,3,400.00,1200.00),
(14,5,12,144.00,1728.00),
(15,2,1,1500.00,1500.00),
(16,15,12,320.00,3840.00),
(17,12,1,800.00,800.00),(17,29,5,20.00,100.00),
(18,36,12,320.00,3840.00),
(19,34,2,600.00,1200.00),(19,30,4,25.00,100.00),
(20,1,6,960.00,5760.00);

--STOCK-KARDEX
INSERT INTO StockKardex (IdProducto, StockActual)
VALUES
	
    (1, 15), (2, 20), (3, 8), (4, 25), (5, 18),
    (6, 12), (7, 30), (8, 5), (9, 22), (10, 15),
    (11, 10), (12, 28), (13, 5), (14, 18), (15, 12),
    (16, 8), (17, 15), (18, 10), (19, 25), (20, 18),
    (21, 13), (22, 16), (23, 7), (24, 20), (25, 10),
    (26, 15), (27, 12), (28, 8), (29, 18), (30, 10),
    (31, 25), (32, 10), (33, 15), (34, 8), (35, 12), (36, 20);

--TIPO MOVIMIENTO
INSERT INTO TipoMovimiento (NombreMovimiento)
VALUES
	('Entrada'),
	('Salida');

--MOVIMIENTOS-KARDEX
INSERT INTO MovimientosKardex (IdProducto, IdTipoMovimiento, Fecha, Hora)
VALUES
    (15, 1, '10-01-2023', '08:00:00'),
    (5, 1, '12-01-2023', '09:30:00'),
    (28, 2, '15-02-2023', '11:45:00'),
    (8, 1, '05-03-2023', '14:15:00'),
    (11, 2, '20-03-2023', '16:30:00'),
    (3, 1, '02-04-2023', '10:00:00'),
    (22, 2, '15-04-2023', '13:45:00'),
    (9, 1, '01-05-2023', '17:30:00'),
    (36, 1, '12-05-2023', '08:45:00'),
    (7, 2, '05-06-2023', '12:30:00'),
    (19, 1, '20-06-2023', '15:00:00'),
    (25, 2, '10-07-2023', '09:15:00'),
    (14, 1, '03-08-2023', '11:30:00'),
    (31, 2, '18-08-2023', '14:45:00'),
    (1, 1, '05-09-2023', '16:30:00'),
    (20, 2, '20-09-2023', '18:00:00'),
    (6, 1, '10-10-2023', '10:15:00'),
    (13, 2, '25-10-2023', '12:45:00'),
    (30, 1, '08-11-2023', '15:15:00'),
    (4, 2, '23-11-2023', '17:30:00'),
    (12, 1, '05-12-2023', '20:00:00'),
    (32, 2, '15-12-2023', '22:30:00'),
    (26, 1, '01-01-2024', '09:45:00'),
    (23, 2, '10-01-2024', '11:00:00'),
    (18, 1, '20-02-2024', '13:15:00'),
    (35, 2, '05-03-2024', '15:30:00'),
    (27, 1, '18-03-2024', '17:45:00'),
    (2, 2, '02-04-2024', '20:00:00'),
    (24, 1, '15-04-2024', '22:15:00'),
    (10, 2, '01-05-2024', '08:30:00'),
    (29, 1, '12-05-2024', '10:45:00'),
    (21, 2, '25-06-2024', '13:00:00'),
    (17, 1, '10-07-2024', '15:15:00'),
    (33, 2, '20-07-2024', '17:30:00'),
    (16, 1, '05-08-2024', '19:45:00'),
    (34, 2, '20-08-2024', '22:00:00');


