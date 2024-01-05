-- Se requiere diseñar una base de datos para un sistema que se implementará en un gimnasio, tomando en cuanta los requerimientos que se mencionan más adelante.

-- 1. Se deberá tener el registro de los usuarios que se inscriben en el gimnasio, para lo cual se requiere un identificador único de usuario, nombre completo, fecha de nacimiento, estatura, peso, un correo electrónico para enviarle promociones, la fecha de inscripción al gimnasio, su número de teléfono, el número de teléfono de un contacto a quien llamarle en caso de un incidente y una lista de padecimientos que tenga. 
-- 2. El gimnasio maneja tres tipos de inscripción: mensual, semestral y anual.
-- 3. Se registrarán los datos de inscripción de los usuarios: fecha inicial y final de la inscripción, el tipo de inscripción elegida y el monto del pago que debe realizar cada periodo. 
-- 4. Por cada inscripción el cliente realizará uno o varios pagos de los cuales se le enviará un recibo. El recibo de pago debe tener la fecha del pago, la descripción del concepto por el cual está pagando, la forma de pago, el monto del pago y el nombre del empleado que lo atendió.
-- 5. Es necesario saber cuáles son los usuarios que están activos en determinado momento para hacer uso de las instalaciones del gimnasio y quienes ya no lo están.
-- 6. El gimnasio ofrece clases de varias disciplinas, las cuales se registrarán con una clave y una descripción.
-- 7. Se necesita tener el registro de los instructores, para lo cual se requiere un identificador único, nombre completo, fecha de nacimiento, dirección, número de teléfono y también las diferentes disciplinas en las que está certificado para después programar las clases que va a impartir.
-- 8. Los instructores pueden impartir varias clases. Para registrar una clase se necesita el nombre de la clase, la fecha, la hora y el lugar en que se ofrecerá.
-- 9. Los usuarios deben registrar asistencia a las clases que se ofrecen en el gimnasio y pueden tomar un número ilimitado de clases.
-- 10. Los usuarios pueden solicitar la atención personalizada de un instructor lo cual generará un cobro extra.

--SCRIPT

--Usuario
CREATE TABLE Usuario
(
UsuarioID INT PRIMARY KEY
,
NombreCompleto VARCHAR
(50),
FechaNacimiento DATE
,
Estatura FLOAT
,
Peso FLOAT
,
Email VARCHAR
(50),
FechaInscripcion DATE
,
NumeroTelefono VARCHAR
(10),
NumTelefonoContacto VARCHAR
(10),
ListaPadecimientos VARCHAR
(50)
)
;

--Inscripcion
CREATE TABLE Inscripcion (
InscripcionID INT PRIMARY KEY,
FK_UsuarioID INT,
FechaInicial DATE,
FechaFinal DATE,
TipoInscripcion INT,
MontoPago DECIMAL(10, 2),
FOREIGN KEY (FK_UsuarioID) REFERENCES Usuario(UsuarioID)
);

--Pago
CREATE TABLE Pago (
PagoID INT PRIMARY KEY,
FK_InscripcionID INT,
FechaPago DATE,
DescripcionConcepto VARCHAR(100),
FormaPago VARCHAR(50),
MontoPago DECIMAL(10, 2),
NombreEmpleado VARCHAR(50),
FOREIGN KEY (FK_InscripcionID) REFERENCES Inscripcion(InscripcionID)
);

--Clase
CREATE TABLE Clase (
ClaseID INT PRIMARY KEY,
DescripcionClase VARCHAR(50)
);

--Instructor
CREATE TABLE Instructor (
InstructorID INT PRIMARY KEY,
NombreCompleto VARCHAR(100),
FechaNacimiento DATE,
Direccion VARCHAR(50),
NumeroTelefono VARCHAR(20),
NumeroDisciplinas INT
);

--Clase_Instructor
CREATE TABLE Clase_Instructor (
FK_ClaseID INT,
FK_InstructorID INT,
FechaClase DATETIME,
Lugar VARCHAR(50),
PRIMARY KEY (FK_ClaseID, FK_InstructorID),
FOREIGN KEY (FK_ClaseID) REFERENCES Clase(ClaseID),
FOREIGN KEY (FK_InstructorID) REFERENCES Instructor(InstructorID)
);

--Usuario_Clase
CREATE TABLE Usuario_Clase (
FK_UsuarioID INT,
FK_ClaseID INT,
EsActivo BIT,
Asistencia INT,
AtencionPersonal BIT,
6
PRIMARY KEY (FK_UsuarioID, FK_ClaseID),
FOREIGN KEY (FK_UsuarioID) REFERENCES Usuario(UsuarioID),
FOREIGN KEY (FK_ClaseID) REFERENCES Clase(ClaseID)
);

-- QUERIES

SELECT * FROM Usuario;

SELECT * FROM Inscripcion;

SELECT * FROM Pago;

SELECT * FROM Clase;

SELECT * FROM Instructor;

SELECT * FROM Clase_Instructor;

SELECT * FROM Usuario_Clase;


