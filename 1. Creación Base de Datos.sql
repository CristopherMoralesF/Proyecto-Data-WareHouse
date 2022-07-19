USE MASTER
GO

DROP DATABASE IF EXISTS FARMACIA_ER
GO

CREATE DATABASE FARMACIA_ER
GO 

USE FARMACIA_ER
GO

DROP TABLE IF EXISTS EMPLEADO
DROP TABLE IF EXISTS DISTRIBUIDOR
DROP TABLE IF EXISTS PROVEEDOR
DROP TABLE IF EXISTS RECETA_X_MEDICAMENTOS
DROP TABLE IF EXISTS RECETA_MEDICA
DROP TABLE IF EXISTS CLIENTES
DROP TABLE IF EXISTS PRECAUCION
DROP TABLE IF EXISTS PERSONA
DROP TABLE IF EXISTS MEDICAMENTO
DROP TABLE IF EXISTS CATEGORIA_MEDICAMENTO
DROP TABLE IF EXISTS FARMACIA
GO


CREATE TABLE CATEGORIA_MEDICAMENTO (
	ID_TIPO_MED					INT NOT NULL CONSTRAINT PK_TIPO_MED PRIMARY KEY,
	CATEGORIA_MED				VARCHAR(50) NOT NULL,
	DESCRIPCION_CATEGORIA_MED	VARCHAR(200) NOT NULL
)
GO

CREATE TABLE PROVEEDOR (
	ID_PROVEEDOR		INT NOT NULL CONSTRAINT PK_PROVEEDOR PRIMARY KEY, 
	NOMBRE_MARCA		VARCHAR(30) NOT NULL, 
	DURACION_ACUERDO	INT NOT NULL,
	FECHA_INICIO		DATE NOT NULL,
	MESES_DURACION		INT NOT NULL
)
GO

CREATE TABLE PERSONA (
	ID_PERSONA			INT NOT NULL CONSTRAINT PK_PERSONA PRIMARY KEY, 
	NOMBRE_PERSONA		VARCHAR(40) NOT NULL,
	NOMBRE2_PERSONA		VARCHAR(40),
	APELLIDO1_PERSONA	VARCHAR(40) NOT NULL,
	APELLIDO2_PERSONA	VARCHAR(40),
	CEDULA				INT NOT NULL,
	FECHA_NACIMIENTO	DATE NOT NULL
)
GO

CREATE TABLE FARMACIA (
	ID_FARMACIA			INT NOT NULL CONSTRAINT PK_FARMACIA PRIMARY KEY, 
	NOMBRE_FARMACIA		VARCHAR(30) NOT NULL,
	CAPACIDAD			INT NOT NULL,
	UBICACION			VARCHAR(50) NOT NULL, 
	AÑOS_EXISTENCIA		INT NOT NULL
)
GO

CREATE TABLE EMPLEADO (
	ID_EMPLEADO			INT NOT NULL CONSTRAINT PK_EMPLEADO PRIMARY KEY, 
	ID_PERSONA			INT NOT NULL, 
	FECHA_INICIO		DATE NOT NULL, 
	ID_FARMACIA			INT NOT NULL,
	CONSTRAINT FK_EMPLEADO_PERSONA  FOREIGN KEY (ID_PERSONA)  REFERENCES PERSONA  (ID_PERSONA),
	CONSTRAINT FK_EMPLEADO_FARMACIA FOREIGN KEY (ID_FARMACIA) REFERENCES FARMACIA (ID_FARMACIA)
)
GO

CREATE TABLE CLIENTES (
	ID_CLIENTES			INT NOT NULL CONSTRAINT PK_CLIENTES PRIMARY KEY, 
	ID_PERSONA			INT NOT NULL, 
	FECHA_INICIO		DATE NOT NULL,
	CONSTRAINT FK_CLIENTE_PERSONA FOREIGN KEY (ID_PERSONA) REFERENCES PERSONA (ID_PERSONA)
)
GO

CREATE TABLE MEDICAMENTO (
	ID_MEDICAMENTO		INT NOT NULL CONSTRAINT PK_MEDICAMENTO PRIMARY KEY, 
	NOMBRE_MEDICAMENTO	VARCHAR(95) NOT NULL, 
	DESCRIP_MEDICAMENTO	VARCHAR(100) NOT NULL,
	CANTIDAD_ALMACEN	INT NOT NULL,
	FECHA_CADUCIDAD		DATE NOT NULL,
	ID_TIPO_MED			INT NOT NULL, 
	ID_FARMACIA			INT NOT NULL, 
	CONSTRAINT FK_MEDICAMENTO_CATEGORIA FOREIGN KEY (ID_TIPO_MED) REFERENCES CATEGORIA_MEDICAMENTO(ID_TIPO_MED),
	CONSTRAINT FK_MEDICAMENTO_FARMACIA FOREIGN KEY (ID_FARMACIA) REFERENCES FARMACIA(ID_FARMACIA) 
)
GO

CREATE TABLE DISTRIBUIDOR (
	ID_DISTRIBUIDOR		INT NOT NULL CONSTRAINT PK_DISTRIBUIDOR PRIMARY KEY, 
	ID_PERSONA			INT NOT NULL, 
	FECHA_INICIO		DATE NOT NULL, 
	ID_PROVEEDOR		INT NOT NULL, 
	ID_MEDICAMENTOS		INT NOT NULL, 
	CONSTRAINT FK_DISTRIBUIDOR_PERSONA FOREIGN KEY (ID_PERSONA) REFERENCES PERSONA(ID_PERSONA),
	CONSTRAINT FK_DISTRIBUIDOR_PROVEEDOR FOREIGN KEY (ID_PROVEEDOR) REFERENCES PROVEEDOR(ID_PROVEEDOR),
	CONSTRAINT FK_DISTRIBUIDOR_MEDICAMENTOS FOREIGN KEY (ID_MEDICAMENTOS) REFERENCES MEDICAMENTO(ID_MEDICAMENTO)
)
GO

CREATE TABLE RECETA_MEDICA (
	CODIGO_RECETA_MEDICA	INT NOT NULL CONSTRAINT PK_RECETA_MEDICA PRIMARY KEY, 
	DESCRIP_USO_MEDICO		VARCHAR(200) NOT NULL, 
	CANTIDAD				INT NOT NULL, 
	ID_CLIENTE				INT NOT NULL, 
	FECHA					DATE NOT NULL, 
	CONSTRAINT FK_RECETA_CLIENTE FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTES(ID_CLIENTES)
)
GO

CREATE TABLE RECETA_X_MEDICAMENTOS (
	CODIGO_RXM				INT NOT NULL CONSTRAINT PK_RXM PRIMARY KEY, 
	ID_MEDICAMENTO			INT NOT NULL,
	CODIGO_RECETA_MEDICA	INT NOT NULL,
	CONSTRAINT FK_RECETAMEDICAMENTOS_MEDICAMENTO FOREIGN KEY (ID_MEDICAMENTO) REFERENCES MEDICAMENTO(ID_MEDICAMENTO),
	CONSTRAINT FK_RECETAMEDICAMENTOS_RECETA FOREIGN KEY (CODIGO_RECETA_MEDICA) REFERENCES RECETA_MEDICA(CODIGO_RECETA_MEDICA)
)
GO

CREATE TABLE PRECAUCION (
	ID_PRECAUCION		INT NOT NULL CONSTRAINT PK_PRECAUCION PRIMARY KEY, 
	EFECTOS_SECUNDARIOS	VARCHAR(300) NOT NULL,
	FECHA_INDICACIÓN	DATE NOT NULL,
	ID_MEDICAMENTO		INT NOT NULL,
	CONSTRAINT FK_PRECAUCION_MEDICAMENTO FOREIGN KEY (ID_MEDICAMENTO) REFERENCES MEDICAMENTO(ID_MEDICAMENTO)
)
GO
