USE FARMACIA_DW
GO


/* 
	Execute stored procedure to move the information from the entity relationship model to the Staging Area
*/
SA_EXTRACCION


/*
Validate that all the tables contain data. 
*/

SELECT * FROM FARMACIA_SA.DBO.CATEGORIA_MEDICAMENTO_SA
GO

SELECT * FROM FARMACIA_SA.DBO.CLIENTES_SA
GO

SELECT * FROM FARMACIA_SA.DBO.DISTRIBUIDOR_SA
GO

SELECT * FROM FARMACIA_SA.DBO.EMPLEADO_SA
GO

SELECT * FROM FARMACIA_SA.DBO.FARMACIA_SA
GO

SELECT * FROM FARMACIA_SA.DBO.MEDICAMENTO_SA
GO

SELECT * FROM FARMACIA_SA.DBO.PERSONA_SA
GO

SELECT * FROM FARMACIA_SA.DBO.PRECAUCION_SA
GO

SELECT * FROM FARMACIA_SA.DBO.PROVEEDOR_SA
GO

SELECT * FROM FARMACIA_SA.DBO.RECETA_MEDICA_SA
GO

SELECT * FROM FARMACIA_SA.DBO.RECETA_X_MEDICAMENTOS_SA
GO