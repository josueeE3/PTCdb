Create table Taller(
Codigo_Taller VARCHAR2(50) primary key,
Nombre_Dueno VARCHAR2(50) NOT NULL,
Apellido_Dueno VARCHAR2(50) NOT NULL,
CorreoElectronico VARCHAR2(50) UNIQUE,
Contrasena VARCHAR2(8) NOT NULL,
Telefono VARCHAR2(15) NOT NULL,
Direccion VARCHAR2(100) NOT NULL
);

Create table Rol(
Id_rol Number primary key,
Nombre VARCHAR2(20) NOT NULL
);


Create table Usuario(
UUID_usuario VARCHAR2(50) PRIMARY KEY,
UUID_taller Varchar2(50) NOT NULL,
UUID_rol VARCHAR2(50) NOT NULL,
Nombre VARCHAR2(50) NOT NULL,
Contrasena VARCHAR2(8) NOT NULL,

CONSTRAINT fk_rol FOREIGN KEY (Id_rol) REFERENCES Rol(Id_rol),
CONSTRAINT fk_taller_usuario FOREIGN KEY (UUID_taller) REFERENCES Taller(UUID_taller)
);


Create table EstadoAsignarOrden(
Id_estado Number PRIMARY KEY,
Nombre VARCHAR2(20) NOT NULL
);

Create table Cliente (
Dui_cliente VARCHAR2(10) PRIMARY KEY,
UUID_taller VARCHAR2(50) NOT NULL,
Nombre VARCHAR2(50) NOT NULL,
Apellido VARCHAR2(50) NOT NULL,
Correo_Electronico VARCHAR2(50) UNIQUE,
Telefono VARCHAR2(8) NOT NULL,

CONSTRAINT fk_taller_cliente FOREIGN KEY (UUID_taller) REFERENCES Taller(UUID_taller)
);

Create table Marca(
UUID_marca VARCHAR2(50) PRIMARY KEY,
Nombre VARCHAR2(50) NOT NULL,
Descripcion VARCHAR2(200) NOT NULL
);

Create table Proveedor(
Dui_proveedor VARCHAR2(10) PRIMARY KEY,
UUID_taller VARCHAR2(50) NOT NULL,
Nombre VARCHAR2(50) NOT NULL,
Apellido VARCHAR2(50) NOT NULL,
Telefono VARCHAR2(9) NOT NULL,
Correo_Electronico VARCHAR2(50) UNIQUE,
Direccion VARCHAR2(200) NOT NULL,

CONSTRAINT fk_taller_proveedor FOREIGN KEY (UUID_taller) REFERENCES Taller(UUID_taller)
);

Create table Servicio(
UUID_servicio VARCHAR2(50) PRIMARY KEY,
UUID_taller VARCHAR2(50) NOT NULL,
Nombre VARCHAR2(50) NOT NULL,
Descripcion VARCHAR2(50) NOT NULL,
Precio NUMBER(10, 2) CHECK (Precio > 0),

CONSTRAINT fk_taller_servicio FOREIGN KEY (UUID_taller) REFERENCES Taller(UUID_taller)
);

Create table Producto(
UUID_producto vARCHAR2(50) PRIMARY KEY,
Dui_proveedor VARCHAR2(10) NOT NULL,
UUID_taller VARCHAR2(50) NOT NULL,
Nombre VARCHAR2(50) NOT NULL,
ImagenCarro BLOB,
CantidadDisponible NUMBER NOT NULL CHECK (CantidadDisponible > 0),
Precio NUMBER(10, 2) NOT NULL CHECK (Precio > 0),

CONSTRAINT fk_proveedor FOREIGN KEY (Dui_proveedor) REFERENCES Proveedor(Dui_proveedor),
CONSTRAINT fk_taller_producto FOREIGN KEY (UUID_taller) REFERENCES Taller(UUID_taller)
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
UUID_taller VARCHAR2(50) NOT NULL,
Nombre VARCHAR2(100) NOT NULL,
Apellido VARCHAR2(100) NOT NULL,
ImagenEmpleado BLOB,
FechaNacimiento DATE NOT NULL CHECK (FechaNacimiento <= SYSDATE),
CorreoElectronico VARCHAR2(50) UNIQUE,
Telefono VARCHAR2(9) NOT NULL,

CONSTRAINT fk_usuario FOREIGN KEY (UUID_usuario) REFERENCES Usuario(UUID_usuario),
CONSTRAINT fk_taller_empleado FOREIGN KEY (UUID_taller) REFERENCES Taller(UUID_taller),

 CONSTRAINT check_edad_minima CHECK (FechaNacimiento <= TRUNC(SYSDATE) - INTERVAL '18' YEAR)
);


Create table Carro(
Placa_carro VARCHAR2(8) PRIMARY KEY,
Dui_cliente VARCHAR2(10) NOT NULL,
UUID_modelo VARCHAR2(50) NOT NULL,
Color VARCHAR2(15) NOT NULL,
Año Varchar2(5) NOT NULL,
ImagenCarro BLOB,
FechaRegistro DATE DEFAULT SYSDATE,
Descripcion VARCHAR2(200) NOT NULL,

CONSTRAINT check_fecha_contratacion CHECK (FechaRegistro = TRUNC(SYSDATE)),
CONSTRAINT fk_cliente FOREIGN KEY (Dui_cliente) REFERENCES Cliente(Dui_cliente),
CONSTRAINT fk_modelo FOREIGN KEY (UUID_modelo) REFERENCES Modelo(UUID_modelo)
);

Create table HistorialCarro(
UUID_historialCarro Varchar2(50) PRIMARY KEY,
Placa_carro VARCHAR2(8) NOT NULL,
UUID_taller Varchar2(50) NOT NULL,

Descripcion VARCHAR2(150) NOT NULL,
CONSTRAINT fk_carro FOREIGN KEY (Placa_carro) REFERENCES Carro(Placa_carro),
CONSTRAINT fk_taller_historialCarro FOREIGN KEY (UUID_taller) REFERENCES Taller(UUID_taller)
);


Create table AsignarOrden(
UUID_AsignarOrden Varchar2(50) PRIMARY KEY,
Placa_carro VARCHAR2(8) NOT NULL,
Dui_empleado VARCHAR2(10) NOT NULL,
UUID_servicio Varchar2(50) NOT NULL,
Id_estado NUMBER NOT NULL,
FechaAsignacion DATE DEFAULT SYSDATE,
FechaFinalizacion DATE NOT NULL,
Descripcion VARCHAR2(150) NOT NULL,

CONSTRAINT fk_carro1 FOREIGN KEY (Placa_carro) REFERENCES Carro(Placa_carro),
CONSTRAINT fk_empleado FOREIGN KEY (Dui_empleado) REFERENCES Empleado(Dui_empleado),
CONSTRAINT fk_servicio FOREIGN KEY (UUID_servicio) REFERENCES Servicio(UUID_servicio),
CONSTRAINT fk_estado FOREIGN KEY (Id_estado) REFERENCES EstadoAsignarOrden(Id_estado),
CONSTRAINT check_fecha_asignacion CHECK ( FechaAsignacion = TRUNC(SYSDATE))
CONSTRAINT check_fecha_finalizacion CHECK (FechaFinalizacion > SYSDATE + INTERVAL '1' DAY
    )
);


Create table Cita (
UUID_cita Varchar2(50) PRIMARY KEY,
Fecha_cita DATE DEFAULT SYSDATE NOT NULL,
Descripcion VARCHAR2(250) NOT NULL,

CONSTRAINT check_fecha_cita CHECK (Fecha_cita = TRUNC(SYSDATE))
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
UUID_taller VARCHAR2(250) NOT NULL,
FechaEmision DATE DEFAULT SYSDATE,
FechaVencimiento date NOT NULL CHECK (FechaVencimiento > SYSDATE),

CONSTRAINT check_fecha_emision CHECK (FechaEmision = TRUNC(SYSDATE)),
CONSTRAINT fk_cliente2 FOREIGN KEY (Dui_cliente) REFERENCES Cliente(Dui_cliente),
CONSTRAINT fk_empleado2 FOREIGN KEY (Dui_empleado) REFERENCES Empleado(Dui_empleado),
CONSTRAINT fk_taller_factura FOREIGN KEY (UUID_taller) REFERENCES Taller(UUID_taller)

);



Create table DetalleServicio(
UUID_DetalleServicio Varchar2(50) PRIMARY KEY,
UUID_factura Varchar2(50) NOT NULL,
UUID_servicio Varchar2(50) NOT NULL,
UUID_historialCarro Varchar2(50) NOT NULL,
Total NUMBER (10,2) CHECK (Total > 0),

CONSTRAINT fk_factura FOREIGN KEY (UUID_factura) REFERENCES Factura(UUID_factura),
CONSTRAINT fk_servicio FOREIGN KEY (UUID_servicio) REFERENCES Servicio(UUID_servicio),
CONSTRAINT fk_historialcarro FOREIGN KEY (UUID_historialCarro) REFERENCES HistorialCarro(UUID_historialCarro)
);


Create table DetalleProducto(
UUID_DetalleProducto Varchar2(50) PRIMARY KEY,
UUID_factura Varchar2(50) NOT NULL,
UUID_producto Varchar2(50) NOT NULL,
UUID_HistorialCarro Varchar2(50) NOT NULL,
Cantidad NUMBER NOT NULL,
Total NUMBER (10,2) CHECK (Total > 0),

CONSTRAINT fk_factura1 FOREIGN KEY (UUID_factura) REFERENCES Factura(UUID_factura),
CONSTRAINT fk_producto1 FOREIGN KEY (UUID_producto) REFERENCES Producto(UUID_producto),
CONSTRAINT fk_historialcarro1 FOREIGN KEY (UUID_HistorialCarro) REFERENCES HistorialCarro(UUID_HistorialCarro)
); 


