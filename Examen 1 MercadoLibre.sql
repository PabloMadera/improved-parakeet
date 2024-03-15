drop database  ventasMercadolibre;
CREATE DATABASE ventasMercadolibre;
USE ventasMercadoLibre;

drop role if exists Administrador;
create role Administrador;
grant all privileges on ventasmercadolibre.* to Administrador;

drop role if exists Empleado;
create role Empleado;
grant select, insert on ventasmercadolibre.* to Empleado;

drop role if exists Gerente;
create role Gerente;
grant delete on ventasmercadolibre.* to Gerente;


CREATE TABLE usuarios (
    ID_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL,
    correo VARCHAR(45) NOT NULL
);

CREATE TABLE forma_de_pago (
    ID_pago INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    efectivo VARCHAR(45),
    tarjeta VARCHAR(45)
);


CREATE TABLE clientes (
    ID_clientes INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cliente_numero INT,
    forma_pago INT NOT NULL,
    nombre VARCHAR (45) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    ciudad VARCHAR(45) NOT NULL,
    FOREIGN KEY (cliente_numero) REFERENCES usuarios(ID_usuario),
    FOREIGN KEY (forma_pago) REFERENCES forma_de_pago(ID_pago)
);

CREATE TABLE cliente_premium (
    ID_premium INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_clientes INT NOT NULL,
    promocion INT NOT NULL,
    numero_de_pedidos INT NOT NULL,
    FOREIGN KEY (ID_clientes) REFERENCES clientes(ID_clientes)
);

CREATE TABLE pedido (
    ID_pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cliente_registrado INT NOT NULL,
    fecha_de_pedido DATETIME,
    cantidad INT UNSIGNED,
    FOREIGN KEY (cliente_registrado) REFERENCES clientes(ID_clientes)
);

CREATE TABLE recibo (
    ID_recibo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tipo_pago INT NOT NULL,
    numero_pedido INT NOT NULL,
    nomina_cliente INT NOT NULL,
    RFC INT NOT NULL,
    precio_total FLOAT,
    fecha_de_impresion DATETIME,
    FOREIGN KEY (nomina_cliente) REFERENCES clientes(ID_clientes),
    FOREIGN KEY (tipo_pago) REFERENCES forma_de_pago(ID_pago),
    FOREIGN KEY (numero_pedido) REFERENCES pedido(ID_pedido)
);

CREATE TABLE productos (
ID_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR (120) NOT NULL,
precio FLOAT NOT NULL,
numero_pedido INT NOT NULL,
 FOREIGN KEY (numero_pedido) REFERENCES pedido(ID_pedido)
 );
 
 CREATE TABLE inventario (
 ID_inventario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 clave_producto INT NOT NULL,
 cantidad INT,
 fecha_de_ingreso DATETIME,
 fecha_de_salida DATETIME,
 FOREIGN KEY (clave_producto) REFERENCES productos(ID_producto)
 );
 
 
 CREATE TABLE encargado (
ID_encargado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
encargado_de_area INT NOT NULL,
nombre VARCHAR (45),
apellido VARCHAR (45),
area  VARCHAR (45)
);
 
CREATE TABLE departamento (
ID_departamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
numero_producto INT NOT NULL,
numero_inventario INT NOT NULL,
nombre_departamento VARCHAR (45),
encargado_de_area int,
FOREIGN KEY (numero_producto) REFERENCES productos(ID_producto),
FOREIGN KEY (numero_inventario) REFERENCES inventario(ID_inventario),
FOREIGN KEY (encargado_de_area) REFERENCES  encargado(ID_encargado)
);

describe usuarios;
INSERT INTO usuarios (nombre, correo) VALUES 
('Juan','juanito@gmail'),
('Martha','martha@gmail'),
('christian','chirstian@gmail'),
('antonio','antonio@gmail'),
('alexis','alexis@gmail'),
('cristian','cristian@gmail'),
('mia','mia@gmail'),
('ada','ada@gmail'),
('melody','melody@gmail'),
('gloria','gloria@gmail'),
('antonela','antonela@gmail'),
('daniela','daniela@gmail'),
('angel','angel@gmail');


describe forma_de_pago;
INSERT INTO forma_de_pago (efectivo, tarjeta) VALUES 
('No','si'),
('si','no'),
('No','si'),
('si','no'),
('No','si'),
('No','si'),
('No','si'),
('si','no'),
('si','no'),
('si','no'),
('No','si'),
('No','si'),
('No','si');

describe clientes;
INSERT INTO clientes (cliente_numero,forma_de_pago, nombre, apellido, ciudad) VALUES 
(1,1,'Juan','lopez','tijuana'),
(2,2,'Martha','martinez','tijuana'),
(3,3,'christian','gandarilla','tijuana'),
(4,4,'antonio','tellez','tijuana'),
(5,5,'alexis','serrano','tijuana'),
(6,6,'cristian','hermosillo','tijuana'),
(7,7,'mia','aguilar','tijuana'),
(8,8,'ada','hiratome','tijuana'),
(9,9,'melody','dragona','albion'),
(10,10,'gloria','melman','tijuana'),
(11,11,'antonela','divina','tijuana'),
(12,12,'daniela','lujan','tijuana'),
(13,13,'angel','lopez','tijuana');

describe cliente_premium;
INSERT INTO cliente_premium (ID_usuario, ID_clientes, numero_de_pedidos) VALUES 


INSERT INTO pedido (ID_clientes, fecha_de_pedido, cantidad, producto) VALUES 


INSERT INTO recibo (ID_pago, ID_pedido, ID_clientes, RFC, precio_total, fecha_de_impresion) VALUES 


INSERT INTO productos (nombre, precio, ID_pedido) VALUES


INSERT INTO inventario (ID_producto,cantidad,fecha_de_ingreso,fecha_de_salida) VALUES



INSERT INTO departamento (ID_producto,ID_inventario,nombre_departament,encargado_de_area) VALUES


INSERT INTO encargado (ID_departament,nombre) VALUES




-- Procedimiento almacenado 1--
DELIMITER //

CREATE PROCEDURE Nombre_completo()
BEGIN
    SELECT u.nombre, c.apellido
    FROM usuarios AS u
    JOIN clientes AS c ON c.ID_usuario = u.ID_usuario;
END //

DELIMITER ;
CALL nombre_completo ();

-- procedimiento almacenado 2 --
DROP PROCEDURE IF EXISTS registrarCliente;

DELIMITER //


CREATE PROCEDURE registrarCliente(
    IN p_ID_usuario VARCHAR(10),
    IN p_ID_pago INT,
    IN p_ID_pedido INT,
    IN p_apellido VARCHAR(255),
    IN p_cuidad VARCHAR(255)
)
BEGIN
    INSERT INTO clientes (ID_usuario, ID_pago, ID_pedido, apellido, cuidad)
    VALUES (p_ID_usuario, p_ID_pago, p_ID_pedido, p_apellido, p_cuidad);
END //

DELIMITER ;
CALL registrarCliente('016', 4, 4, 'Martinez', 'monterrey');


DELIMITER //

