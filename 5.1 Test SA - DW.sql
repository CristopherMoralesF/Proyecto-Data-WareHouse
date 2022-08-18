USE MASTER
GO

USE FARMACIA_DW; 
GO

EXRACCION_DATOS_DW

DELETE FROM FARMACIA_DW.DBO.DIM_CATEGORIA_MEDICAMENTO
DELETE FROM FARMACIA_DW.DBO.DIM_CLIENTE
DELETE FROM FARMACIA_DW.DBO.DIM_DISTRIBUIDOR
DELETE FROM FARMACIA_DW.DBO.DIM_DISTRIBUIDOR
DELETE FROM FARMACIA_DW.DBO.DIM_EMPLEADO
DELETE FROM FARMACIA_DW.DBO.DIM_FARMACIA
DELETE FROM FARMACIA_DW.DBO.DIM_MEDICAMENTO
DELETE FROM FARMACIA_DW.DBO.DIM_PERSONA
DELETE FROM FARMACIA_DW.DBO.DIM_PRECAUCION
DELETE FROM FARMACIA_DW.DBO.DIM_PROVEEDOR
DELETE FROM FARMACIA_DW.DBO.DIM_RECETA_MEDICA
DELETE FROM FARMACIA_DW.DBO.FAC_FARMACIA
GO

SELECT * FROM DIM_CATEGORIA_MEDICAMENTO
GO

SELECT * FROM DIM_CLIENTE
GO

SELECT * FROM DIM_DISTRIBUIDOR
GO

SELECT * FROM DIM_EMPLEADO
GO

SELECT * FROM DIM_FARMACIA
GO

SELECT * FROM DIM_FECHA
GO

SELECT * FROM DIM_MEDICAMENTO
GO

SELECT * FROM DIM_PERSONA
GO

SELECT * FROM DIM_PRECAUCION
GO

SELECT * FROM DIM_PROVEEDOR
GO

SELECT * FROM DIM_RECETA_MEDICA
GO

SELECT * FROM FAC_FARMACIA
GO