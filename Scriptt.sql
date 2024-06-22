Create table Taller(
Codigo_Taller VARCHAR2(10) primary key,
Nombre_Dueno VARCHAR2(50) NOT NULL,
Apellido_Dueno VARCHAR2(50) NOT NULL,
CorreoElectronico VARCHAR2(50) UNIQUE,
Contrasena VARCHAR2(8) NOT NULL,
Telefono VARCHAR2(15) NOT NULL,
Direccion VARCHAR2(100) NOT NULL
);

Create table Rol(
UUID_rol VARCHAR2(50) primary key,
Nombre VARCHAR2(20) NOT NULL
);


Create table CategoriaRepuesto(
UUID_categoria VARCHAR2(50) primary key,
Nombre VARCHAR2(25) NOT NULL
);


Create table Usuario(
UUID_usuario VARCHAR2(50) PRIMARY KEY,
UUID_rol VARCHAR2(50) NOT NULL,
Nombre VARCHAR2(50) NOT NULL,
Contrasena VARCHAR2(8) NOT NULL,

CONSTRAINT fk_rol FOREIGN KEY (UUID_rol) REFERENCES Rol(UUID_rol)
);

Create table EstadoAsignarOrden(
UUID_estado Varchar2(50) PRIMARY KEY,
Nombre VARCHAR2(20) NOT NULL
);

Create table Cliente (
Dui_cliente VARCHAR2(10) PRIMARY KEY,
Nombre VARCHAR2(50) NOT NULL,
Apellido VARCHAR2(50) NOT NULL,
Correo_Electronico VARCHAR2(50) UNIQUE,
Telefono VARCHAR2(8) NOT NULL
);

Create table Marca(
UUID_marca VARCHAR2(50) PRIMARY KEY,
Nombre VARCHAR2(50) NOT NULL,
Descripcion VARCHAR2(200) NOT NULL
);

Create table Proveedor(
Dui_proveedor VARCHAR2(10) PRIMARY KEY,
Nombre VARCHAR2(50) NOT NULL,
Apellido VARCHAR2(50) NOT NULL,
Telefono VARCHAR2(9) NOT NULL,
Correo_Electronico VARCHAR2(50) UNIQUE,
Direccion VARCHAR2(200) NOT NULL
);

Create table Servicio(
UUID_servicio VARCHAR2(50) PRIMARY KEY,
Nombre VARCHAR2(50) NOT NULL,
Descripcion VARCHAR2(50) NOT NULL,
Precio NUMBER(10, 2) CHECK (Precio > 0)
);

Create table Producto(
UUID_producto vARCHAR2(50) PRIMARY KEY,
Nombre VARCHAR2(50) NOT NULL,
ImagenProducto BLOB
);


CREATE TABLE Repuesto (
UUID_repuesto VARCHAR2(50) PRIMARY KEY,
UUID_categoria VARCHAR2(50) NOT NULL,
Nombre VARCHAR2(100) NOT NULL,
Descripcion VARCHAR2(255),
ImagenRepuesto BLOB,
CompatibilidadCarro VARCHAR2(255),

CONSTRAINT fk_categoria_repuesto FOREIGN KEY (UUID_categoria) REFERENCES CategoriaRepuesto(UUID_categoria)
);


Create table Modelo(
UUID_modelo VARCHAR2(50)PRIMARY KEY,
UUID_marca VARCHAR2(50) NOT NULL,
Nombre VARCHAR2(20) NOT NULL,

CONSTRAINT fk_marca FOREIGN KEY (UUID_marca) REFERENCES Marca(UUID_marca)
);


Create table Empleado(
Dui_empleado VARCHAR2(10) PRIMARY KEY,
UUID_usuario VARCHAR2(50) NOT NULL,
Nombre VARCHAR2(100) NOT NULL,
Apellido VARCHAR2(100) NOT NULL,
ImagenEmpleado BLOB,
FechaNacimiento DATE NOT NULL,
CorreoElectronico VARCHAR2(50) UNIQUE,
Telefono VARCHAR2(9) NOT NULL,

CONSTRAINT fk_usuario FOREIGN KEY (UUID_usuario) REFERENCES Usuario(UUID_usuario)
);

Create table Carro(
Placa_carro VARCHAR2(8) PRIMARY KEY,
Dui_cliente VARCHAR2(10) NOT NULL,
UUID_modelo VARCHAR2(50) NOT NULL,
Color VARCHAR2(15) NOT NULL,
Año Varchar2(5) NOT NULL,
ImagenCarro BLOB,
FechaRegistro DATE NOT NULL,
Descripcion VARCHAR2(200) NOT NULL,

CONSTRAINT fk_cliente FOREIGN KEY (Dui_cliente) REFERENCES Cliente(Dui_cliente),
CONSTRAINT fk_modelo FOREIGN KEY (UUID_modelo) REFERENCES Modelo(UUID_modelo)
);

Create table HistorialCarro(
UUID_historialCarro Varchar2(50) PRIMARY KEY,
Placa_carro VARCHAR2(8) NOT NULL,
Descripcion VARCHAR2(150) NOT NULL,

CONSTRAINT fk_carro FOREIGN KEY (Placa_carro) REFERENCES Carro(Placa_carro)
);


Create table AsignarOrden(
UUID_AsignarOrden Varchar2(50) PRIMARY KEY,
Placa_carro VARCHAR2(8) NOT NULL,
Dui_empleado VARCHAR2(10) NOT NULL,
UUID_servicio Varchar2(50) NOT NULL,
UUID_estado Varchar2(50) NOT NULL,
FechaAsignacion DATE NOT NULL,
FechaFinalizacion DATE NOT NULL,
Descripcion VARCHAR2(150) NOT NULL,

CONSTRAINT fk_carro1 FOREIGN KEY (Placa_carro) REFERENCES Carro(Placa_carro),
CONSTRAINT fk_empleado FOREIGN KEY (Dui_empleado) REFERENCES Empleado(Dui_empleado),
CONSTRAINT fk_servicio FOREIGN KEY (UUID_servicio) REFERENCES Servicio(UUID_servicio),
CONSTRAINT fk_estado FOREIGN KEY (UUID_estado) REFERENCES EstadoAsignarOrden(UUID_estado)
);

Create table Cita (
UUID_cita Varchar2(50) PRIMARY KEY,
Fecha_cita DATE NOT NULL,
Descripcion VARCHAR2(250) NOT NULL
);

Create table DetalleCita(
UUID_DetalleCita Varchar2(50) PRIMARY KEY,
UUID_cita Varchar2(50) NOT NULL,
Dui_cliente VARCHAR2(10) NOT NULL,
Dui_empleado VARCHAR2(10) NOT NULL,
Descripcion VARCHAR2(250) NOT NULL,

CONSTRAINT fk_cita1 FOREIGN KEY (UUID_cita) REFERENCES Cita(UUID_cita),
CONSTRAINT fk_cliente1 FOREIGN KEY (Dui_cliente) REFERENCES Cliente(Dui_cliente),
CONSTRAINT fk_empleado1 FOREIGN KEY (Dui_empleado) REFERENCES Empleado(Dui_empleado)
);

Create table Factura(
UUID_factura VARCHAR2(250) PRIMARY KEY,
Dui_cliente VARCHAR2(10) NOT NULL,
Dui_empleado VARCHAR2(10) NOT NULL,
FechaEmision DATE NOT NULL,
FechaVencimiento DATE NOT NULL,

CONSTRAINT fk_cliente2 FOREIGN KEY (Dui_cliente) REFERENCES Cliente(Dui_cliente),
CONSTRAINT fk_empleado2 FOREIGN KEY (Dui_empleado) REFERENCES Empleado(Dui_empleado)
);


Create table DetalleServicio(
UUID_DetalleServicio Varchar2(50) PRIMARY KEY,
UUID_factura Varchar2(50) NOT NULL,
UUID_servicio Varchar2(50) NOT NULL,
Total NUMBER (10,2) CHECK (Total > 0),

CONSTRAINT fk_factura_detalle FOREIGN KEY (UUID_factura) REFERENCES Factura(UUID_factura),
CONSTRAINT fk_servicio_detalle FOREIGN KEY (UUID_servicio) REFERENCES Servicio(UUID_servicio)
);


Create table DetalleProducto(
UUID_DetalleProducto Varchar2(50) PRIMARY KEY,
UUID_factura Varchar2(50) NOT NULL,
UUID_producto Varchar2(50) NOT NULL,
Cantidad NUMBER CHECK (Cantidad > 0)NOT NULL,
Total NUMBER (10,2) CHECK (Total > 0),

CONSTRAINT fk_factura1 FOREIGN KEY (UUID_factura) REFERENCES Factura(UUID_factura),
CONSTRAINT fk_producto1 FOREIGN KEY (UUID_producto) REFERENCES Producto(UUID_producto)
); 


Create table DetalleRepuesto(
UUID_DetalleProducto Varchar2(50) PRIMARY KEY,
UUID_factura Varchar2(50) NOT NULL,
UUID_repuesto Varchar2(50) NOT NULL,
Cantidad NUMBER NOT NULL,
Total NUMBER (10,2) CHECK (Total > 0),

CONSTRAINT fk_factura2 FOREIGN KEY (UUID_factura) REFERENCES Factura(UUID_factura),
CONSTRAINT fk_repuesto1 FOREIGN KEY (UUID_repuesto) REFERENCES Repuesto(UUID_repuesto)
); 

Create table Producto_Proveedor(
UUID VARCHAR2(50) NOT NULL,
UUID_producto VARCHAR2(50) NOT NULL,
Dui_proveedor VARCHAR2(10) NOT NULL,
Precio NUMBER(10, 2) NOT NULL CHECK (Precio > 0),
Cantidad NUMBER(10, 2) NOT NULL CHECK (Precio > 0) ,
FechaSuministro DATE NOT NULL,

CONSTRAINT fk_producto_proveedor FOREIGN KEY (UUID_producto) REFERENCES Producto(UUID_producto),
CONSTRAINT fk_proveedor_producto FOREIGN KEY (Dui_proveedor) REFERENCES Proveedor(Dui_proveedor)
);

Create table Repuesto_Proveedor(
UUID VARCHAR2(50) NOT NULL,
UUID_repuesto VARCHAR2(50) NOT NULL,
Dui_proveedor VARCHAR2(10) NOT NULL,
Precio NUMBER(10, 2) NOT NULL CHECK (Precio > 0),
Cantidad NUMBER(10, 2) NOT NULL CHECK (Precio > 0) ,
FechaSuministro DATE NOT NULL,

CONSTRAINT fk_repuesto_proveedor FOREIGN KEY (UUID_repuesto) REFERENCES Repuesto(UUID_repuesto),
CONSTRAINT fk_proveedor_repuesto FOREIGN KEY (Dui_proveedor) REFERENCES Proveedor(Dui_proveedor)
);


CREATE OR REPLACE TRIGGER Trig_validar_fecha_nacimiento
BEFORE INSERT OR UPDATE ON Empleado
FOR EACH ROW
BEGIN
    -- Validar que la FechaNacimiento sea menor a la fecha actual
    IF :NEW.FechaNacimiento > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'La Fecha de Nacimiento no puede ser mayor a la fecha actual.');
    END IF;

    -- Validar que la edad sea al menos 18 años
    IF ADD_MONTHS(:NEW.FechaNacimiento, 12 * 18) > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20002, 'El empleado debe tener al menos 18 años.');
    END IF;
END;



CREATE OR REPLACE TRIGGER Trig_validar_fecha_registro
BEFORE INSERT OR UPDATE ON Carro
FOR EACH ROW
BEGIN
    IF :NEW.FechaRegistro <> SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'La Fecha de Registro debe ser igual a la fecha actual.');
    END IF;
END;



CREATE OR REPLACE TRIGGER trig_validar_fecha_asignacion
BEFORE INSERT OR UPDATE ON AsignarOrden
FOR EACH ROW
BEGIN
    IF TRUNC(:NEW.FechaAsignacion) != TRUNC(SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20001, 'La Fecha de Asignación debe ser igual a la fecha actual.');
    END IF;
END;


CREATE OR REPLACE TRIGGER TRIG_VALIDAR_FECHA_FINALIZACION
BEFORE INSERT OR UPDATE ON AsignarOrden
FOR EACH ROW
DECLARE
    v_fecha_actual DATE;
BEGIN
    v_fecha_actual := TRUNC(SYSDATE);
    
    IF :NEW.FechaFinalizacion <= v_fecha_actual + 1 THEN
        RAISE_APPLICATION_ERROR(-20002, 'La Fecha de Finalización debe ser al menos un día después de la fecha actual.');
    END IF;
END;


CREATE OR REPLACE TRIGGER trig_fecha_cita
BEFORE INSERT OR UPDATE ON Cita
FOR EACH ROW
BEGIN
    IF TRUNC(:NEW.Fecha_cita) <> TRUNC(SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20003, 'La Fecha de la Cita debe ser igual a la fecha actual.');
    END IF;
END;


CREATE OR REPLACE TRIGGER trig_validar_fecha_factura
BEFORE INSERT OR UPDATE ON Factura
FOR EACH ROW
BEGIN
    IF :NEW.FechaEmision != SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'La Fecha de Emisión debe ser igual al SYSDATE.');
    END IF;
    
    IF :NEW.FechaVencimiento <= SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20002, 'La Fecha de Vencimiento debe ser mayor al SYSDATE.');
    END IF;
END;


CREATE OR REPLACE TRIGGER trig_verifi_fecha_actual
BEFORE INSERT OR UPDATE ON Producto_Proveedor
FOR EACH ROW
DECLARE
    fecha_actual DATE;
BEGIN
    fecha_actual := SYSDATE;  
    
    IF :NEW.FechaIngreso <> fecha_actual THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de ingreso debe ser la fecha actual.');
    END IF;
END;

CREATE OR REPLACE TRIGGER trig_verifica_fecha_actual
BEFORE INSERT OR UPDATE ON Repuesto_Proveedor
FOR EACH ROW
DECLARE
    fecha_actual DATE;
BEGIN
    fecha_actual := SYSDATE;  
    
    IF :NEW.FechaIngreso <> fecha_actual THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de ingreso debe ser la fecha actual.');
    END IF;
END;


INSERT INTO Taller (Codigo_Taller, Nombre_Dueno, Apellido_Dueno, CorreoElectronico, Contrasena, Telefono, Direccion)
VALUES ('TallerDisp', 'Fernando', 'Merino', 'fernando.merino@gmail.com', 'merino12', '23473411', 'Mexicanos Calle Sur');


INSERT ALL
    INTO Rol (UUID_rol, Nombre) VALUES (SYS_GUID(), 'Administrador')
    INTO Rol (UUID_rol, Nombre) VALUES (SYS_GUID(), 'Empleado')
SELECT * FROM dual;


INSERT ALL
  INTO CategoriaRepuesto (UUID_categoria, Nombre) VALUES (SYS_GUID(), 'Motor')
  INTO CategoriaRepuesto (UUID_categoria, Nombre) VALUES (SYS_GUID(), 'Frenos')
  INTO CategoriaRepuesto (UUID_categoria, Nombre) VALUES (SYS_GUID(), 'Transmisión')
  INTO CategoriaRepuesto (UUID_categoria, Nombre) VALUES (SYS_GUID(), 'Suspensión')
  INTO CategoriaRepuesto (UUID_categoria, Nombre) VALUES (SYS_GUID(), 'Eléctrico')
SELECT * FROM dual;
INSERT ALL
    INTO Usuario (UUID_usuario, UUID_rol, Nombre, Contrasena) 
    VALUES (SYS_GUID(),'BA661275AA5A48DBB713F4ADD3DCD6C0', 'Mario', 'mario123')
    INTO Usuario (UUID_usuario, UUID_rol, Nombre, Contrasena)
    VALUES (SYS_GUID(), 'BA661275AA5A48DBB713F4ADD3DCD6C0', 'Rebeca', 'rebe1234')
    INTO Usuario (UUID_usuario, UUID_rol, Nombre, Contrasena) 
    VALUES (SYS_GUID(), 'F1BB4874EFF2489BB7DA0A32FF0DDE51', 'Fatima', 'fati1234')
    INTO Usuario (UUID_usuario, UUID_rol, Nombre, Contrasena) 
    VALUES (SYS_GUID(), 'F1BB4874EFF2489BB7DA0A32FF0DDE51', 'Juan', 'juan1234')
    INTO Usuario (UUID_usuario, UUID_rol, Nombre, Contrasena) 
    VALUES (SYS_GUID(), 'F1BB4874EFF2489BB7DA0A32FF0DDE51', 'Maria', 'maria123')
SELECT * FROM dual;

INSERT ALL
    INTO EstadoAsignarOrden (UUID_estado, Nombre)
    VALUES (SYS_GUID(), 'Sin comenzar')
    INTO EstadoAsignarOrden (UUID_estado, Nombre) 
    VALUES (SYS_GUID(), 'En proceso')
    INTO EstadoAsignarOrden (UUID_estado, Nombre) 
    VALUES (SYS_GUID(), 'Terminado')
SELECT * FROM dual;

INSERT ALL
    INTO Cliente (Dui_cliente, Nombre, Apellido, Correo_Electronico, Telefono) 
    VALUES ('34572369-9', 'Carlos', 'Goncho', 'goncho@gmail.com', '34598115')
    INTO Cliente (Dui_cliente, Nombre, Apellido, Correo_Electronico, Telefono) 
    VALUES ('09134582-1', 'Lautaro', 'Martin', 'martin@gmail.com', '12056923')
    INTO Cliente (Dui_cliente, Nombre, Apellido, Correo_Electronico, Telefono) 
    VALUES ('45678901-2', 'Lionel', 'Messi', 'messi@gmail.com', '10493682')
    INTO Cliente (Dui_cliente, Nombre, Apellido, Correo_Electronico, Telefono) 
    VALUES ('21895798-7', 'Paulo', 'Dybala', 'dybala@gmail.com', '23489679')
    INTO Cliente (Dui_cliente, Nombre, Apellido, Correo_Electronico, Telefono) 
    VALUES ('09243865-3', 'Luis', 'De la Fuente', 'luis@gmail.com', '93082462')
SELECT * FROM dual;


INSERT ALL
    INTO Marca (UUID_marca, Nombre, Descripcion) 
    VALUES (SYS_GUID(), 'Toyota', 'Marca japonesa conocida por su calidad en carros')
    INTO Marca (UUID_marca, Nombre, Descripcion) 
    VALUES (SYS_GUID(), 'Honda', 'Marca japonesa destacada por sus motores de buena calidad.')
    INTO Marca (UUID_marca, Nombre, Descripcion) 
    VALUES (SYS_GUID(), 'Ford', 'Marca americana reconocida por sus camionetas robustas')
    INTO Marca (UUID_marca, Nombre, Descripcion) 
    VALUES (SYS_GUID(), 'Chevrolet', 'Marca americana que ofrece una amplia variedad de vehículos.')
    INTO Marca (UUID_marca, Nombre, Descripcion) 
    VALUES (SYS_GUID(), 'Volkswagen', 'Marca alemana conocida por su ingeniería y modelos como el Golf y el Beetle.')
SELECT * FROM dual;


INSERT ALL
    INTO Proveedor (Dui_proveedor, Nombre, Apellido, Telefono, Correo_Electronico, Direccion) 
    VALUES ('25619278-9', 'Carlos', 'Alcaraz', '12835689', 'carlos.alcaraz@gmail.com', 'Bulevar Los Proceres')
    INTO Proveedor (Dui_proveedor, Nombre, Apellido, Telefono, Correo_Electronico, Direccion) 
    VALUES ('56835574-1', 'Laura', 'Bonilla', '01923578', 'laura.bonilla@gmail.com', 'Cabañas avenida sur')
    INTO Proveedor (Dui_proveedor, Nombre, Apellido, Telefono, Correo_Electronico, Direccion) 
    VALUES ('23772454-2', 'Josefin', 'Martinez', '12938056', 'josefin.martinez@gmail.com', 'La Libertad avenida norte')
    INTO Proveedor (Dui_proveedor, Nombre, Apellido, Telefono, Correo_Electronico, Direccion) 
    VALUES ('68242514-0', 'David', 'Lopez', '24572313', 'david.lopez@gmail.com', 'Calle San francisco')
    INTO Proveedor (Dui_proveedor, Nombre, Apellido, Telefono, Correo_Electronico, Direccion) 
    VALUES ('34583246-3', 'Luis', 'Enrique', '23388572', 'luis.enrique@gmail.com', 'Las Arboledas')
SELECT * FROM dual;


INSERT ALL
    INTO Servicio (UUID_servicio, Nombre, Descripcion, Precio) 
    VALUES (SYS_GUID(), 'Cambio de Aceite', 'Cambio de aceite de motor', 25.99)
    INTO Servicio (UUID_servicio, Nombre, Descripcion, Precio) 
    VALUES (SYS_GUID(), 'Alineación y Balanceo', 'Alineación y balanceo de ruedas', 47.99)
    INTO Servicio (UUID_servicio, Nombre, Descripcion, Precio) 
    VALUES (SYS_GUID(), 'Revisión de Frenos', 'Inspección y ajuste de frenos', 29.99)
    INTO Servicio (UUID_servicio, Nombre, Descripcion, Precio) 
    VALUES (SYS_GUID(), 'Cambio de Batería', 'Reemplazo de batería del vehículo', 79.99)
    INTO Servicio (UUID_servicio, Nombre, Descripcion, Precio) 
    VALUES (SYS_GUID(), 'Diagnóstico Completo', 'Diagnóstico completo del vehículo', 109.99)
SELECT * FROM dual;


INSERT ALL
    INTO Producto (UUID_producto, Nombre, ImagenProducto, CantidadDisponible, Precio) 
    VALUES (SYS_GUID(),'Aceite de motor', EMPTY_BLOB(), 50, 15.99)
    INTO Producto (UUID_producto, Nombre, ImagenProducto, CantidadDisponible, Precio) 
    VALUES (SYS_GUID(), 'Filtro de aire', EMPTY_BLOB(), 30, 9.99)
    INTO Producto (UUID_producto,Nombre, ImagenProducto, CantidadDisponible, Precio) 
    VALUES (SYS_GUID(), 'Batería de coche', EMPTY_BLOB(), 20, 79.99)
    INTO Producto (UUID_producto, Nombre, ImagenProducto, CantidadDisponible, Precio) 
    VALUES (SYS_GUID(), 'Pastillas de freno', EMPTY_BLOB(), 40, 26.99)
    INTO Producto (UUID_producto, Nombre, ImagenProducto, CantidadDisponible, Precio) 
    VALUES (SYS_GUID(), 'Neumático', EMPTY_BLOB(), 25, 59.99)
SELECT * FROM dual;

INSERT ALL
  INTO Repuesto (UUID_repuesto, UUID_categoria, Nombre, Descripcion, Precio, Cantidad, CompatibilidadCarro, FechaIngreso)
  VALUES (SYS_GUID(), 'F5C5FE343B784909BE3D14A6E455E054', 'Filtro de Aceite', 'Filtro de aceite para motores estándar', 17.99, 10, 'Varios modelos', SYSDATE)
  INTO Repuesto (UUID_repuesto, UUID_categoria, Nombre, Descripcion, Precio, Cantidad, CompatibilidadCarro, FechaIngreso)
  VALUES (SYS_GUID(), 'A640FE058D044BAA85CCE93BBBFCDC52', 'Pastillas de Freno', 'Pastillas de freno de alto rendimiento', 39.99, 20, 'Varios modelos', SYSDATE)
  INTO Repuesto (UUID_repuesto, UUID_categoria, Nombre, Descripcion, Precio, Cantidad, CompatibilidadCarro, FechaIngreso)
  VALUES (SYS_GUID(), 'F3A05BC5CF564A54818DE4FDDF8563AC', 'Batería de Coche', 'Batería de 12V para automóviles', 89.99, 30, 'Compatibilidad amplia', SYSDATE)
  INTO Repuesto (UUID_repuesto, UUID_categoria, Nombre, Descripcion, Precio, Cantidad, CompatibilidadCarro, FechaIngreso)
  VALUES (SYS_GUID(), '01B90BE3597E4F249BBAAFE9ACDBFB80', 'Amortiguador', 'Amortiguador para suspensión delantera', 129.50, 20, 'Varios modelos', SYSDATE)
  INTO Repuesto (UUID_repuesto, UUID_categoria, Nombre, Descripcion, Precio, Cantidad, CompatibilidadCarro, FechaIngreso)
  VALUES (SYS_GUID(), '0B19CB1D04324264939B8390A15FC79D', 'Lámpara LED', 'Lámpara LED de alto brillo para faros', 19.95, 20, 'Varios modelos', SYSDATE)
SELECT * FROM dual;

INSERT ALL
    INTO Modelo (UUID_modelo, UUID_marca, Nombre) 
    VALUES (SYS_GUID(), '0A95783196C64FE7AB662DBD8B58F1C1', 'Sedán')
    INTO Modelo (UUID_modelo, UUID_marca, Nombre) 
    VALUES (SYS_GUID(), '0A846F6EA48B4D68A49022BF7AACB948', 'CR-V Hybrid')
    INTO Modelo (UUID_modelo, UUID_marca, Nombre) 
    VALUES (SYS_GUID(), '2A01F2F92CC340EDB91DC1107B9FA825', 'EDGE ST')
    INTO Modelo (UUID_modelo, UUID_marca, Nombre) 
    VALUES (SYS_GUID(), '26C32CCE329A407FB7CF1EC51E9C1591', 'Montana')
    INTO Modelo (UUID_modelo, UUID_marca, Nombre) 
    VALUES (SYS_GUID(), '0991514DB30A4CC6B460BB57B8895316', 'Nuevo Taigun')
SELECT * FROM dual;


INSERT ALL
    INTO Empleado (Dui_empleado, UUID_usuario, Nombre, Apellido, ImagenEmpleado, FechaNacimiento, CorreoElectronico, Telefono)
    VALUES ('4386236-0', 'D85505BD87E343968F1858A3F8D01444', 'Mario', 'Garcia', EMPTY_BLOB(), TO_DATE('2005-05-15', 'YYYY-MM-DD'), 'mario.garcia@gmail.com', '83462396')
    INTO Empleado (Dui_empleado, UUID_usuario, Nombre, Apellido, ImagenEmpleado, FechaNacimiento, CorreoElectronico, Telefono)
    VALUES ('23473414-1', '3466DA0110A74E32B7D4CC77EB5B6A1B', 'Rebeca', 'Zelaya', EMPTY_BLOB(), TO_DATE('1985-08-20', 'YYYY-MM-DD'), 'rebeca.zelaya@gmail.com', '28976122')
    INTO Empleado (Dui_empleado, UUID_usuario, Nombre, Apellido, ImagenEmpleado, FechaNacimiento, CorreoElectronico, Telefono)
    VALUES ('52722346-2', '2AEFF25B7A3C42DA9430A5FFEDBAEF08', 'Fatima', 'Juarez', EMPTY_BLOB(), TO_DATE('1992-03-10', 'YYYY-MM-DD'), 'fatima.juarez@gmail.com', '09348267')
    INTO Empleado (Dui_empleado, UUID_usuario, Nombre, Apellido, ImagenEmpleado, FechaNacimiento, CorreoElectronico, Telefono)
    VALUES ('34583434-3', '8F38DDD5526542D2B194FEBAB2611EBE', 'Juan', 'Lopez', EMPTY_BLOB(), TO_DATE('1988-11-25', 'YYYY-MM-DD'), 'juan.lopez@gmail.com', '90283167')
    INTO Empleado (Dui_empleado, UUID_usuario, Nombre, Apellido, ImagenEmpleado, FechaNacimiento, CorreoElectronico, Telefono)
    VALUES ('53423346-4', '4A939E24836D42978ADA08D972A2B027', 'Maria', 'Dominguez', EMPTY_BLOB(), TO_DATE('1995-07-03', 'YYYY-MM-DD'), 'maria.dominguez@gmail.com', '29086126')
SELECT * FROM dual;


INSERT ALL
    INTO Carro (Placa_carro, Dui_cliente, UUID_modelo, Color, Año, ImagenCarro, FechaRegistro, Descripcion)
    VALUES ('ABC1234', '34572369-9', '0C2C775A94F34BFD84FF3327223B509C', 'Gris', '2020', EMPTY_BLOB(), SYSDATE, 'Carro deportivo')
    INTO Carro (Placa_carro, Dui_cliente, UUID_modelo, Color, Año, ImagenCarro, FechaRegistro, Descripcion)
    VALUES ('XYZ5678', '09134582-1', '7F248412C5B444BF9E269CED62876201', 'Negro', '2019', EMPTY_BLOB(), SYSDATE, 'Carro familiar')
    INTO Carro (Placa_carro, Dui_cliente, UUID_modelo, Color, Año, ImagenCarro, FechaRegistro, Descripcion)
    VALUES ('DEF9012', '45678901-2', 'A51030DEA8FA437AB6DE2757F7098FF1', 'Blanco', '2021', EMPTY_BLOB(), SYSDATE, 'Carro urbano')
    INTO Carro (Placa_carro, Dui_cliente, UUID_modelo, Color, Año, ImagenCarro, FechaRegistro, Descripcion)
    VALUES ('GHI3456', '21895798-7', '661218BDCB2E419F9BCB2B5A6980FD9E', 'Azul', '2017', EMPTY_BLOB(), SYSDATE, 'Carro SUV')
    INTO Carro (Placa_carro, Dui_cliente, UUID_modelo, Color, Año, ImagenCarro, FechaRegistro, Descripcion)
    VALUES ('JKL7890', '09243865-3', '5980B476DF3446A5953AE825A8F65D85', 'Rojo', '2020', EMPTY_BLOB(), SYSDATE, 'Carro eléctrico')
SELECT * FROM dual;


INSERT ALL
  INTO HistorialCarro (UUID_historialCarro, Placa_carro, Descripcion)
  VALUES (SYS_GUID(), 'ABC1234', 'Revisión de motor')
  INTO HistorialCarro (UUID_historialCarro, Placa_carro, Descripcion)
  VALUES (SYS_GUID(), 'XYZ5678', 'Cambio de aceite')
  INTO HistorialCarro (UUID_historialCarro, Placa_carro, Descripcion)
  VALUES (SYS_GUID(), 'DEF9012', 'Alineación y balanceo')
  INTO HistorialCarro (UUID_historialCarro, Placa_carro, Descripcion)
  VALUES (SYS_GUID(), 'GHI3456', 'Reparación de frenos')
  INTO HistorialCarro (UUID_historialCarro, Placa_carro, Descripcion)
  VALUES (SYS_GUID(), 'JKL7890', 'Cambio de llantas')
SELECT * FROM dual;


select * from Servicio;
select * from eSTADoAsignarOrden;

insert into AsignarOrden(UUID_AsignarOrden, Placa_carro, Dui_empleado, UUID_servicio, UUID_estado, FechaAsignacion, FechaFinalizacion, Descripcion)
values
(SYS_GUID(), 'ABC1234', '4386236-0', 'CB3D9FD98F244D03982E9961E416B74C', '7CABFFC6B78E44B286E78EE76915ED08', TO_DATE('2024-06-22', 'YYYY-MM-DD'), 
TO_DATE('2024-06-24', 'YYYY-MM-DD'), 'Orden de mantenimiento preventivo');

INSERT ALL
  INTO AsignarOrden (UUID_AsignarOrden, Placa_carro, Dui_empleado, UUID_servicio, UUID_estado, FechaAsignacion, FechaFinalizacion, Descripcion)
  VALUES (SYS_GUID(), 'XYZ5678','23473414-1', 'D9C7ECD645FF4F79B04758D362E9990A','7CABFFC6B78E44B286E78EE76915ED08', SYSDATE, SYSDATE + INTERVAL '2' DAY, 'Cambio de aceite')
  INTO AsignarOrden (UUID_AsignarOrden, Placa_carro, Dui_empleado, UUID_servicio, UUID_estado, FechaAsignacion, FechaFinalizacion, Descripcion)
  VALUES (SYS_GUID(), 'DEF9012', '52722346-2', '3F021301A94C42A8B7D9CC9784578AF0','816F4030D3B24751B34F12229C979BC8', SYSDATE, SYSDATE + INTERVAL '2' DAY, 'Alineación y balanceo')
  INTO AsignarOrden (UUID_AsignarOrden, Placa_carro, Dui_empleado, UUID_servicio, UUID_estado, FechaAsignacion, FechaFinalizacion, Descripcion)
  VALUES (SYS_GUID(), 'GHI3456', '34583434-3', '458CFE3F7C3541198ED4B94C92696FF5','816F4030D3B24751B34F12229C979BC8' ,SYSDATE, SYSDATE + INTERVAL '3' DAY, 'Reparación de frenos')
  INTO AsignarOrden (UUID_AsignarOrden, Placa_carro, Dui_empleado, UUID_servicio, UUID_estado, FechaAsignacion, FechaFinalizacion, Descripcion)
  VALUES (SYS_GUID(), 'JKL7890', '53423346-4', 'C1306D37D98B4E198202A390D396C507','6A587D3F4D9646CB88EF6E8FAEF1D5F4',SYSDATE, SYSDATE + INTERVAL '4' DAY, 'Cambio de llantas')
SELECT * FROM dual;


INSERT ALL
  INTO Cita (UUID_cita, Fecha_cita, Descripcion)
  VALUES (SYS_GUID(), SYSDATE, 'Primera cita del taller')
  INTO Cita (UUID_cita, Fecha_cita, Descripcion)
  VALUES (SYS_GUID(), TO_DATE('2024-06-22', 'YYYY-MM-DD'), 'Segunda cita del taller')
  INTO Cita (UUID_cita, Fecha_cita, Descripcion)
  VALUES (SYS_GUID(), SYSDATE, 'Tercera cita del taller')
  INTO Cita (UUID_cita, Fecha_cita, Descripcion)
  VALUES (SYS_GUID(), SYSDATE, 'Cuarta cita del taller')
  INTO Cita (UUID_cita, Fecha_cita, Descripcion)
  VALUES (SYS_GUID(), SYSDATE, 'Quinta cita del taller')
SELECT * FROM dual;

INSERT ALL
  INTO DetalleCita (UUID_DetalleCita, UUID_cita, Dui_cliente, Dui_empleado, Descripcion)
  VALUES (SYS_GUID(), '3A2933C6534D4B75AED165F040D97059', '34572369-9', '4386236-0', 'El cliente nos expueso los cambios que se le harian a su carro')
  INTO DetalleCita (UUID_DetalleCita, UUID_cita, Dui_cliente, Dui_empleado, Descripcion)
  VALUES (SYS_GUID(), '2E179915177E4DFD82424EC52AC1EACD', '09134582-1', '23473414-1', 'El cliente nos expueso los cambios que se le harian a su camioneta')
  INTO DetalleCita (UUID_DetalleCita, UUID_cita, Dui_cliente, Dui_empleado, Descripcion)
  VALUES (SYS_GUID(), '364D29CF58A0496CA788CC396DE62D5D', '45678901-2', '52722346-2', 'El cliente nos expueso los cambios que se le harian a su microbus')
  INTO DetalleCita (UUID_DetalleCita, UUID_cita, Dui_cliente, Dui_empleado, Descripcion)
  VALUES (SYS_GUID(), '7864A7197D29444C9FE66E69634DF78E', '21895798-7', '34583434-3', 'El cliente nos expueso los cambios que se le harian a su carro')
  INTO DetalleCita (UUID_DetalleCita, UUID_cita, Dui_cliente, Dui_empleado, Descripcion)
  VALUES (SYS_GUID(), 'C5F2907918D6406187B26FE3E63A156F', '09243865-3', '53423346-4', 'El cliente nos expueso los cambios que se le harian a su camioneta')
SELECT * FROM dual;



INSERT ALL
  INTO Factura (UUID_factura, Dui_cliente, Dui_empleado, FechaEmision, FechaVencimiento)
  VALUES (SYS_GUID(), '34572369-9', '4386236-0', SYSDATE, SYSDATE + INTERVAL '5' DAY)
  INTO Factura (UUID_factura, Dui_cliente, Dui_empleado, FechaEmision, FechaVencimiento)
  VALUES (SYS_GUID(), '09134582-1', '23473414-1', SYSDATE, SYSDATE + INTERVAL '5' DAY)
  INTO Factura (UUID_factura, Dui_cliente, Dui_empleado, FechaEmision, FechaVencimiento)
  VALUES (SYS_GUID(), '45678901-2', '52722346-2', SYSDATE, SYSDATE + INTERVAL '5' DAY)
  INTO Factura (UUID_factura, Dui_cliente, Dui_empleado, FechaEmision, FechaVencimiento)
  VALUES (SYS_GUID(), '21895798-7', '34583434-3', SYSDATE, SYSDATE + INTERVAL '5' DAY)
  INTO Factura (UUID_factura, Dui_cliente, Dui_empleado, FechaEmision, FechaVencimiento)
  VALUES (SYS_GUID(), '09243865-3', '53423346-4', SYSDATE, SYSDATE + INTERVAL '5' DAY)
SELECT * FROM dual;


INSERT ALL
  INTO DetalleServicio (UUID_DetalleServicio, UUID_factura, UUID_servicio, Total)
  VALUES (SYS_GUID(), 'F2A52E4EB421410EA37584FEB2480B4B', '2CA40AF7FC8D4839AEC1709C52136C20', 150.00)
  INTO DetalleServicio (UUID_DetalleServicio, UUID_factura, UUID_servicio, Total)
  VALUES (SYS_GUID(), 'ECFE8DC8C502413A86D2DA9E1CA7F21A', '7D019742EAB04D7092287EE7262BDD7E', 80.00)
  INTO DetalleServicio (UUID_DetalleServicio, UUID_factura, UUID_servicio, Total)
  VALUES (SYS_GUID(), 'E42B944DDA2F4C00A98EB8DCDD2FD028', 'A6A9F27D28C541B1B5DC3C4CE7DB4666', 100.00)
  INTO DetalleServicio (UUID_DetalleServicio, UUID_factura, UUID_servicio, Total)
  VALUES (SYS_GUID(), 'AC12977D140B4155B4C8933E1DB9EB5C', '9AE58FA41EC846888D5C4E3BFFD56182', 200.00)
  INTO DetalleServicio (UUID_DetalleServicio, UUID_factura, UUID_servicio, Total)
  VALUES (SYS_GUID(), 'E63A7EB3F1674F7996110A1C9FD615EC', '389AF39CEB12439FB81E7E208E6DEC90', 170.00)
SELECT * FROM dual;


INSERT ALL
    INTO DetalleProducto (UUID_DetalleProducto, UUID_factura, UUID_producto, Cantidad, Total)
        VALUES (SYS_GUID(), 'F2A52E4EB421410EA37584FEB2480B4B', 'A6D9E135690D4E73854FA5A828D5B127', 2, 250.00)
    INTO DetalleProducto (UUID_DetalleProducto, UUID_factura, UUID_producto, Cantidad, Total)
        VALUES (SYS_GUID(), 'ECFE8DC8C502413A86D2DA9E1CA7F21A', 'AB3E97A77EAA4FA3B6470E6F502BAA27', 1, 150.00)
    INTO DetalleProducto (UUID_DetalleProducto, UUID_factura, UUID_producto, Cantidad, Total)
        VALUES (SYS_GUID(), 'E42B944DDA2F4C00A98EB8DCDD2FD028', '23A287B99593495D8D9CB39C72E29D4D', 3, 400.00)
    INTO DetalleProducto (UUID_DetalleProducto, UUID_factura, UUID_producto, Cantidad, Total)
        VALUES (SYS_GUID(), 'AC12977D140B4155B4C8933E1DB9EB5C', 'A2ADB95A10164BD9AFC9DC70E88E579F', 2, 300.00)
    INTO DetalleProducto (UUID_DetalleProducto, UUID_factura, UUID_producto, Cantidad, Total)
        VALUES (SYS_GUID(), 'E63A7EB3F1674F7996110A1C9FD615EC', '175786D138994392A0A24EF4F40D14D2', 1, 180.00)
SELECT * FROM dual;



select * from AsignarOrden;

SELECT AsignarOrden.Placa_carro AS "Placa de carro", Empleado.Nombre AS "Carro asignado a:",  Servicio.Nombre AS "Servicio a realizar", 
EstadoAsignarOrden.Nombre AS "Estado de la tarea", AsignarOrden.FechaAsignacion AS "Fecha de Asignacion", AsignarOrden.FechaFinalizacion AS "Fecha de Finalizacion", 
AsignarOrden.Descripcion 
FROM AsignarOrden
INNER JOIN Empleado
ON AsignarOrden.Dui_empleado = Empleado.Dui_empleado
INNER JOIN Servicio
ON AsignarOrden.UUID_servicio = Servicio.UUID_servicio
INNER JOIN EstadoAsignarOrden 
ON AsignarOrden.UUID_estado = EstadoAsignarOrden.UUID_estado;


SELECT Carro.Placa_Carro AS "Placa de carro", Modelo.Nombre AS Modelo
FROM Carro
INNER JOIN Modelo
ON Carro.UUID_Modelo = Modelo.UUID_Modelo;


SELECT Carro.Placa_Carro AS "Placa de carro", Cliente.Nombre AS "Dueño"
FROM Carro
INNER JOIN Cliente
ON Carro.Dui_Cliente = Cliente.Dui_Cliente;

SELECT Carro.Placa_Carro, Cliente.Nombre AS Dueño, Modelo.Nombre AS Modelo, Color, Año, ImagenCarro, FechaRegistro, Descripcion
FROM Carro
INNER JOIN Cliente
ON Carro.Dui_Cliente = Cliente.Dui_Cliente
INNER JOIN Modelo
ON Carro.UUID_Modelo = Modelo.UUID_Modelo;
