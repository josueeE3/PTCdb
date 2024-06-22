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
ImagenProducto BLOB,
CantidadDisponible NUMBER NOT NULL CHECK (CantidadDisponible > 0),
Precio NUMBER(10, 2) NOT NULL CHECK (Precio > 0)
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
Cantidad NUMBER NOT NULL,
Total NUMBER (10,2) CHECK (Total > 0),

CONSTRAINT fk_factura1 FOREIGN KEY (UUID_factura) REFERENCES Factura(UUID_factura),
CONSTRAINT fk_producto1 FOREIGN KEY (UUID_producto) REFERENCES Producto(UUID_producto)
); 

Create table Producto_Proveedor(
UUID VARCHAR2(50) NOT NULL,
UUID_producto VARCHAR2(50) NOT NULL,
Dui_proveedor VARCHAR2(10) NOT NULL,

CONSTRAINT fk_producto_proveedor FOREIGN KEY (UUID_producto) REFERENCES Producto(UUID_producto),
CONSTRAINT fk_proveedor_producto FOREIGN KEY (Dui_proveedor) REFERENCES Proveedor(Dui_proveedor)
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




INSERT INTO Taller (Codigo_Taller, Nombre_Dueno, Apellido_Dueno, CorreoElectronico, Contrasena, Telefono, Direccion)
VALUES ('TallerDisp', 'Fernando', 'Merino', 'fernando.merino@gmail.com', 'merino12', '23473411', 'Mexicanos Calle Sur');
    


INSERT ALL
    INTO Rol (UUID_rol, Nombre) VALUES (SYS_GUID(), 'Administrador')
    INTO Rol (UUID_rol, Nombre) VALUES (SYS_GUID(), 'Empleado')
SELECT * FROM dual;

INSERT ALL
    INTO Usuario (UUID_usuario, UUID_rol, Nombre, Contrasena) 
    VALUES (SYS_GUID(),'5EBF7037244E471AB635FCA1576C93F7', 'Mario', 'mario123')
    INTO Usuario (UUID_usuario, UUID_rol, Nombre, Contrasena)
    VALUES (SYS_GUID(), '5EBF7037244E471AB635FCA1576C93F7', 'Rebeca', 'rebe1234')
    INTO Usuario (UUID_usuario, UUID_rol, Nombre, Contrasena) 
    VALUES (SYS_GUID(), '454095925E644BB5A3E6AEC634820A5E', 'Fatima', 'fati1234')
    INTO Usuario (UUID_usuario, UUID_rol, Nombre, Contrasena) 
    VALUES (SYS_GUID(), '454095925E644BB5A3E6AEC634820A5E', 'Juan', 'juan1234')
    INTO Usuario (UUID_usuario, UUID_rol, Nombre, Contrasena) 
    VALUES (SYS_GUID(), '454095925E644BB5A3E6AEC634820A5E', 'Maria', 'maria123')
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
    INTO Modelo (UUID_modelo, UUID_marca, Nombre) 
    VALUES (SYS_GUID(), '9371A4322C17459794A92DED7CEAF873', 'Sedán')
    INTO Modelo (UUID_modelo, UUID_marca, Nombre) 
    VALUES (SYS_GUID(), 'A5F21417E1E148C4BDDE883CAC42C5D4', 'CR-V Hybrid')
    INTO Modelo (UUID_modelo, UUID_marca, Nombre) 
    VALUES (SYS_GUID(), '300BA66469C746DB972E6BF6E6CBF0D4', 'EDGE ST')
    INTO Modelo (UUID_modelo, UUID_marca, Nombre) 
    VALUES (SYS_GUID(), '9FADED1CBBAA45F6BD28E8136AFC77E5', 'Montana')
    INTO Modelo (UUID_modelo, UUID_marca, Nombre) 
    VALUES (SYS_GUID(), 'AEB9978134214265AB13469A2837E875', 'Nuevo Taigun')
SELECT * FROM dual;

INSERT ALL
    INTO Empleado (Dui_empleado, UUID_usuario, Nombre, Apellido, ImagenEmpleado, FechaNacimiento, CorreoElectronico, Telefono)
    VALUES ('4386236-0', '31BF84383B7D4800ACAC0AEB9AD08DA7', 'Mario', 'Garcia', EMPTY_BLOB(), TO_DATE('2005-05-15', 'YYYY-MM-DD'), 'mario.garcia@gmail.com', '83462396')
    INTO Empleado (Dui_empleado, UUID_usuario, Nombre, Apellido, ImagenEmpleado, FechaNacimiento, CorreoElectronico, Telefono)
    VALUES ('23473414-1', '51345661202548BEBDFD39DC688A9211', 'Rebeca', 'Zelaya', EMPTY_BLOB(), TO_DATE('1985-08-20', 'YYYY-MM-DD'), 'rebeca.zelaya@gmail.com', '28976122')
    INTO Empleado (Dui_empleado, UUID_usuario, Nombre, Apellido, ImagenEmpleado, FechaNacimiento, CorreoElectronico, Telefono)
    VALUES ('52722346-2', 'F23287D8C4CB428FA23F5C2016326777', 'Fatima', 'Juarez', EMPTY_BLOB(), TO_DATE('1992-03-10', 'YYYY-MM-DD'), 'fatima.juarez@gmail.com', '09348267')
    INTO Empleado (Dui_empleado, UUID_usuario, Nombre, Apellido, ImagenEmpleado, FechaNacimiento, CorreoElectronico, Telefono)
    VALUES ('34583434-3', 'EAA844A5F7934266B8D47DAFE1319D2E', 'Juan', 'Lopez', EMPTY_BLOB(), TO_DATE('1988-11-25', 'YYYY-MM-DD'), 'juan.lopez@gmail.com', '90283167')
    INTO Empleado (Dui_empleado, UUID_usuario, Nombre, Apellido, ImagenEmpleado, FechaNacimiento, CorreoElectronico, Telefono)
    VALUES ('53423346-4', '3334798C2C7A40A1BDF382F4539DAABE', 'Maria', 'Dominguez', EMPTY_BLOB(), TO_DATE('1995-07-03', 'YYYY-MM-DD'), 'maria.dominguez@gmail.com', '29086126')
SELECT * FROM dual;

INSERT ALL
    INTO Carro (Placa_carro, Dui_cliente, UUID_modelo, Color, Año, ImagenCarro, FechaRegistro, Descripcion)
    VALUES ('ABC1234', '34572369-9', 'CDE9B87F74CD4F589714D55A6EFFB622', 'Gris', '2020', EMPTY_BLOB(), SYSDATE, 'Carro deportivo')
    INTO Carro (Placa_carro, Dui_cliente, UUID_modelo, Color, Año, ImagenCarro, FechaRegistro, Descripcion)
    VALUES ('XYZ5678', '09134582-1', '3C6FFD175E3A49E89C5257E1753D6EEA', 'Negro', '2019', EMPTY_BLOB(), SYSDATE, 'Carro familiar')
    INTO Carro (Placa_carro, Dui_cliente, UUID_modelo, Color, Año, ImagenCarro, FechaRegistro, Descripcion)
    VALUES ('DEF9012', '45678901-2', '33E26076129344D8A288A72688907CFE', 'Blanco', '2021', EMPTY_BLOB(), SYSDATE, 'Carro urbano')
    INTO Carro (Placa_carro, Dui_cliente, UUID_modelo, Color, Año, ImagenCarro, FechaRegistro, Descripcion)
    VALUES ('GHI3456', '21895798-7', 'D4F59522D63B497D945C37B57B7037E9', 'Azul', '2017', EMPTY_BLOB(), SYSDATE, 'Carro SUV')
    INTO Carro (Placa_carro, Dui_cliente, UUID_modelo, Color, Año, ImagenCarro, FechaRegistro, Descripcion)
    VALUES ('JKL7890', '09243865-3', 'B89D4CC811174F8D8DD038D484212C66', 'Rojo', '2020', EMPTY_BLOB(), SYSDATE, 'Carro eléctrico')
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



insert into AsignarOrden(UUID_AsignarOrden, Placa_carro, Dui_empleado, UUID_servicio, UUID_estado, FechaAsignacion, FechaFinalizacion, Descripcion)
values
(SYS_GUID(), 'ABC1234', '4386236-0', '2CA40AF7FC8D4839AEC1709C52136C20', '707B61092CE94BA7B5631057B2868700', TO_DATE('2024-06-21', 'YYYY-MM-DD'), 
TO_DATE('2024-06-23', 'YYYY-MM-DD'), 'Orden de mantenimiento preventivo');

INSERT ALL
  INTO AsignarOrden (UUID_AsignarOrden, Placa_carro, Dui_empleado, UUID_servicio, UUID_estado, FechaAsignacion, FechaFinalizacion, Descripcion)
  VALUES (SYS_GUID(), 'XYZ5678','23473414-1', '7D019742EAB04D7092287EE7262BDD7E','B375224C1D564E119BE99C19E52E40F6', SYSDATE, SYSDATE + INTERVAL '2' DAY, 'Cambio de aceite')
  INTO AsignarOrden (UUID_AsignarOrden, Placa_carro, Dui_empleado, UUID_servicio, UUID_estado, FechaAsignacion, FechaFinalizacion, Descripcion)
  VALUES (SYS_GUID(), 'DEF9012', '52722346-2', 'A6A9F27D28C541B1B5DC3C4CE7DB4666','B375224C1D564E119BE99C19E52E40F6', SYSDATE, SYSDATE + INTERVAL '2' DAY, 'Alineación y balanceo')
  INTO AsignarOrden (UUID_AsignarOrden, Placa_carro, Dui_empleado, UUID_servicio, UUID_estado, FechaAsignacion, FechaFinalizacion, Descripcion)
  VALUES (SYS_GUID(), 'GHI3456', '34583434-3', '9AE58FA41EC846888D5C4E3BFFD56182','C413443CA52D4DD7B6905DF065FDEC4A' ,SYSDATE, SYSDATE + INTERVAL '3' DAY, 'Reparación de frenos')
  INTO AsignarOrden (UUID_AsignarOrden, Placa_carro, Dui_empleado, UUID_servicio, UUID_estado, FechaAsignacion, FechaFinalizacion, Descripcion)
  VALUES (SYS_GUID(), 'JKL7890', '53423346-4', '389AF39CEB12439FB81E7E208E6DEC90','707B61092CE94BA7B5631057B2868700',SYSDATE, SYSDATE + INTERVAL '4' DAY, 'Cambio de llantas')
SELECT * FROM dual;


INSERT ALL
  INTO Cita (UUID_cita, Fecha_cita, Descripcion)
  VALUES (SYS_GUID(), SYSDATE, 'Primera cita del taller')
  INTO Cita (UUID_cita, Fecha_cita, Descripcion)
  VALUES (SYS_GUID(), TO_DATE('2024-06-21', 'YYYY-MM-DD'), 'Segunda cita del taller')
  INTO Cita (UUID_cita, Fecha_cita, Descripcion)
  VALUES (SYS_GUID(), SYSDATE, 'Tercera cita del taller')
  INTO Cita (UUID_cita, Fecha_cita, Descripcion)
  VALUES (SYS_GUID(), SYSDATE, 'Cuarta cita del taller')
  INTO Cita (UUID_cita, Fecha_cita, Descripcion)
  VALUES (SYS_GUID(), SYSDATE, 'Quinta cita del taller')
SELECT * FROM dual;


INSERT ALL
  INTO DetalleCita (UUID_DetalleCita, UUID_cita, Dui_cliente, Dui_empleado, Descripcion)
  VALUES (SYS_GUID(), 'BA52B7377184430A991F6106965761B0', '34572369-9', '4386236-0', 'El cliente nos expueso los cambios que se le harian a su carro')
  INTO DetalleCita (UUID_DetalleCita, UUID_cita, Dui_cliente, Dui_empleado, Descripcion)
  VALUES (SYS_GUID(), 'FD6FD08E50DA40A08CEE3E9520FF23A8', '09134582-1', '23473414-1', 'El cliente nos expueso los cambios que se le harian a su camioneta')
  INTO DetalleCita (UUID_DetalleCita, UUID_cita, Dui_cliente, Dui_empleado, Descripcion)
  VALUES (SYS_GUID(), '7441E5236CCC412EADDFD4F150B7B60B', '45678901-2', '52722346-2', 'El cliente nos expueso los cambios que se le harian a su microbus')
  INTO DetalleCita (UUID_DetalleCita, UUID_cita, Dui_cliente, Dui_empleado, Descripcion)
  VALUES (SYS_GUID(), 'E81CFD7727074BDD9E6D691D2D9BEFA9', '21895798-7', '34583434-3', 'El cliente nos expueso los cambios que se le harian a su carro')
  INTO DetalleCita (UUID_DetalleCita, UUID_cita, Dui_cliente, Dui_empleado, Descripcion)
  VALUES (SYS_GUID(), '418A49FB882142EAA69C9A99972F41E5', '09243865-3', '53423346-4', 'El cliente nos expueso los cambios que se le harian a su camioneta')
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


