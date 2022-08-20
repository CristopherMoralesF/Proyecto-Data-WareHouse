USE FARMACIA_DW
GO

IF EXISTS(SELECT 'X'
            FROM sys.objects
			WHERE type = 'P' AND name = 'EXRACCION_DATOS_DW')
   DROP PROCEDURE EXRACCION_DATOS_DW
GO

DROP PROCEDURE IF EXISTS EXRACCION_DATOS_DW
GO

CREATE PROCEDURE EXRACCION_DATOS_DW AS
BEGIN
-----------------------------------------------------------------------------------------
-- Tabla: PERSONA
-----------------------------------------------------------------------------------------
   DECLARE
      @vERROR_DATOS       INTEGER,
      @VMENSAJE_ERROR     VARCHAR(4000)

      IF EXISTS (SELECT 'X'
                FROM INFORMATION_SCHEMA.TABLES 
				WHERE TABLE_TYPE='BASE TABLE' 
                AND TABLE_NAME='DIM_PERSONA')
		  IF EXISTS (SELECT 'X'
					FROM FARMACIA_SA.INFORMATION_SCHEMA.TABLES 
					WHERE TABLE_TYPE='BASE TABLE' 
					AND TABLE_NAME='PERSONA_SA')

		PRINT('Variables declaration')
	     BEGIN
		    DECLARE
               @vID_PERSONA				INTEGER,
		       @vNOMBRE_PERSONA			VARCHAR(50),
			   @vNOMBRE2_PERSONA		VARCHAR(50),
			   @vAPELLIDO1_PERSONA		VARCHAR(50),
			   @vAPELLIDO2_PERSONA		VARCHAR(50),
			   @vCEDULA					VARCHAR(50),
			   @vFECHA_NACIMIENTO		DATETIME
			DECLARE C_PERSONA CURSOR FOR
			   SELECT ID_PERSONA,
			          NOMBRE_PERSONA,
					  NOMBRE2_PERSONA,
					  APELLIDO1_PERSONA,
					  APELLIDO2_PERSONA,
					  CEDULA,
					  FECHA_NACIMIENTO
			    FROM FARMACIA_SA.dbo.PERSONA_SA SCTA
				
		    BEGIN
			  SET @VMENSAJE_ERROR = ''
			  SET @vERROR_DATOS   = 0
               
			   OPEN C_PERSONA
			   FETCH NEXT FROM C_PERSONA INTO @vID_PERSONA, @vNOMBRE_PERSONA,@vNOMBRE2_PERSONA,@vAPELLIDO1_PERSONA,@vAPELLIDO2_PERSONA,@vCEDULA,@vFECHA_NACIMIENTO
			   
			   WHILE @@FETCH_STATUS = 0
			   BEGIN
			      
				  SET @vERROR_DATOS = 0
			      
				  IF ISNUMERIC(@vID_PERSONA) = 0 OR @vID_PERSONA IS NULL
					BEGIN
						 SET @vERROR_DATOS = 1
						 PRINT('Error validación Id Persona')
					END
				  IF @vNOMBRE_PERSONA IS NULL OR LEN(@vNOMBRE_PERSONA) > 50 
					BEGIN
						SET @vERROR_DATOS = 1
						PRINT('Error validación nombre persona')
					END
					
				  IF LEN(@vNOMBRE2_PERSONA) > 50 
					BEGIN
				     SET @vERROR_DATOS = 1
					 PRINT('Error nombre 2 persona')
					END
					 
				  IF @vAPELLIDO1_PERSONA IS NULL OR LEN(@vAPELLIDO1_PERSONA) > 50 
				     BEGIN
						SET @vERROR_DATOS = 1
						PRINT('Error validación apellido 1')
					END

				  IF LEN(@vAPELLIDO2_PERSONA) > 50 
				     BEGIN
						SET @vERROR_DATOS = 1
						PRINT('Error validación apellido 2')
					END

				  IF @vCEDULA IS NULL OR LEN(@vCEDULA) > 50 OR LEN(@vCEDULA) < 9
				     BEGIN
						SET @vERROR_DATOS = 1
						PRINT('Error validación cedula')
					END

				  IF @vERROR_DATOS = 1
					BEGIN
						SET @VMENSAJE_ERROR = @VMENSAJE_ERROR + ' ERROR EN PERSONA: ' + CONVERT(VARCHAR(25),@vID_PERSONA)
						PRINT('Count error')
					END
				  ELSE
					BEGIN

						INSERT INTO FARMACIA_DW.DBO.DIM_PERSONA(ID_PERSONA, NOMBRE_PERSONA, NOMBRE2_PERSONA,APELLIDO1_PERSONA,APELLIDO2_PERSONA,CEDULA,FECHA_NACIMIENTO)
										VALUES (CONVERT(INTEGER,@vID_PERSONA), @vNOMBRE_PERSONA,@vNOMBRE2_PERSONA,@vAPELLIDO1_PERSONA,@vAPELLIDO2_PERSONA,@vCEDULA,@vFECHA_NACIMIENTO)
						PRINT('Insert Line')
					END

				  FETCH NEXT FROM C_PERSONA INTO @vID_PERSONA, @vNOMBRE_PERSONA,@vNOMBRE2_PERSONA,@vAPELLIDO1_PERSONA,@vAPELLIDO2_PERSONA,@vCEDULA,@vFECHA_NACIMIENTO

			   END
			   CLOSE C_PERSONA
			   DEALLOCATE C_PERSONA
	        END
		END
-----------------------------------------------------------------------------------------
-- Tabla: MEDICAMENTO.
-----------------------------------------------------------------------------------------
   IF EXISTS (SELECT 'X'
                FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_TYPE='BASE TABLE' 
                 AND TABLE_NAME='DIM_MEDICAMENTO')
      IF EXISTS (SELECT 'X'
                   FROM FARMACIA_SA.INFORMATION_SCHEMA.TABLES 
                  WHERE TABLE_TYPE='BASE TABLE' 
                    AND TABLE_NAME='MEDICAMENTO_SA')
	     BEGIN
		    DECLARE
               @vID_MEDICAMENTO				INTEGER,
		       @vNOMBRE_MEDICAMENTO			VARCHAR(50),
			   @vDESCRIP_MEDICAMENTO		VARCHAR(50),
			   @vFECHA_CADUCIDAD			DATETIME
			DECLARE C_MED CURSOR FOR
			   SELECT ID_MEDICAMENTO,
			          NOMBRE_MEDICAMENTO,
					  DESCRIP_MEDICAMENTO,
					  FECHA_CADUCIDAD
			     FROM FARMACIA_SA.dbo.MEDICAMENTO_SA SADATA
				 /*
				WHERE NOT EXISTS (SELECT 'X'
				                    FROM DIM_MEDICAMENTO DWDATA
								   WHERE DWDATA.ID_MEDICAMENTO != SADATA.ID_MEDICAMENTO)*/
		    BEGIN
			  SET @VMENSAJE_ERROR = ''
			  SET @vERROR_DATOS   = 0
               OPEN C_MED
			   FETCH NEXT FROM C_MED INTO @vID_MEDICAMENTO, @vNOMBRE_MEDICAMENTO,@vDESCRIP_MEDICAMENTO,@vFECHA_CADUCIDAD
			   WHILE @@FETCH_STATUS = 0
			   BEGIN
					SET @vERROR_DATOS = 0
					IF ISNUMERIC(@vID_MEDICAMENTO) = 0 OR @vID_MEDICAMENTO IS NULL
						SET @vERROR_DATOS = 1

					IF @vNOMBRE_MEDICAMENTO IS NULL OR LEN(@vNOMBRE_MEDICAMENTO) > 50 or LEN(@vNOMBRE_MEDICAMENTO) <= 2
						SET @vERROR_DATOS = 1

					IF @vDESCRIP_MEDICAMENTO IS NULL OR LEN(@vDESCRIP_MEDICAMENTO) > 50 or LEN(@vDESCRIP_MEDICAMENTO) <= 5
						SET @vERROR_DATOS = 1

					IF @vFECHA_CADUCIDAD IS NULL
						SET @vERROR_DATOS = 1

					IF @vERROR_DATOS = 1
						SET @VMENSAJE_ERROR = @VMENSAJE_ERROR + ' ERROR EN ESTADO DE CLIENTE: ' + @vID_MEDICAMENTO + ' NOMBRE:' + @vNOMBRE_MEDICAMENTO + ' DESCRIPCIÓN:' + @vDESCRIP_MEDICAMENTO
					ELSE
						INSERT INTO DIM_MEDICAMENTO(ID_MEDICAMENTO, NOMBRE_MEDICAMENTO,DESCRIP_MEDICAMENTO,FECHA_CADUCIDAD)
									VALUES (CONVERT(INTEGER,@vID_MEDICAMENTO), @vNOMBRE_MEDICAMENTO,@vDESCRIP_MEDICAMENTO,@vFECHA_CADUCIDAD)
					FETCH NEXT FROM C_MED INTO @vID_MEDICAMENTO, @vNOMBRE_MEDICAMENTO,@vDESCRIP_MEDICAMENTO,@vFECHA_CADUCIDAD
			   END
			   CLOSE C_MED
			   DEALLOCATE C_MED
	        END
		END
-----------------------------------------------------------------------------------------
-- Tabla: RECETA_MEDICA.
-----------------------------------------------------------------------------------------
IF EXISTS (SELECT 'X'
                FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_TYPE='BASE TABLE' 
                 AND TABLE_NAME='DIM_RECETA_MEDICA')
      IF EXISTS (SELECT 'X'
                   FROM FARMACIA_SA.INFORMATION_SCHEMA.TABLES 
                  WHERE TABLE_TYPE='BASE TABLE' 
                    AND TABLE_NAME='RECETA_MEDICA_SA')
	     BEGIN
		    DECLARE
               @vCODIGO_RECETA_MEDICA            INTEGER,
			   @vDESCRIP_USO_MEDICO				 VARCHAR(50)
			DECLARE C_RECM CURSOR FOR
			   SELECT CODIGO_RECETA_MEDICA,
			          DESCRIP_USO_MEDICO
			     FROM FARMACIA_SA.dbo.RECETA_MEDICA_SA SADATA
				 /*
				WHERE NOT EXISTS (SELECT 'X'
				                    FROM DIM_RECETA_MEDICA DWDATARM
								   WHERE DWDATARM.CODIGO_RECETA_MEDICA != SADATA.CODIGO_RECETA_MEDICA)*/
		    BEGIN
			  SET @VMENSAJE_ERROR = ''
			  SET @vERROR_DATOS   = 0
               OPEN C_RECM
			   FETCH NEXT FROM C_RECM INTO @vCODIGO_RECETA_MEDICA, @vDESCRIP_USO_MEDICO
			   WHILE @@FETCH_STATUS = 0
			   BEGIN
			      SET @vERROR_DATOS = 0
			      IF ISNUMERIC(@vCODIGO_RECETA_MEDICA) = 0 OR @vCODIGO_RECETA_MEDICA IS NULL
					 SET @vERROR_DATOS = 1

				  IF @vDESCRIP_USO_MEDICO IS NULL OR LEN(@vDESCRIP_USO_MEDICO) > 50 or LEN(@vDESCRIP_USO_MEDICO) <= 2
				     SET @vERROR_DATOS = 1

				  IF @vERROR_DATOS = 1
				     SET @VMENSAJE_ERROR = @VMENSAJE_ERROR + ' ERROR EN ESTADO DE CLIENTE: ' + @vCODIGO_RECETA_MEDICA + ' DESCRIPCIÓN:' + @vDESCRIP_USO_MEDICO
				  ELSE
			         INSERT INTO DIM_RECETA_MEDICA(CODIGO_RECETA_MEDICA, DESCRIP_USO_MEDICO)
					                VALUES (CONVERT(INTEGER,@vCODIGO_RECETA_MEDICA), @vDESCRIP_USO_MEDICO)
			      FETCH NEXT FROM C_RECM INTO @vCODIGO_RECETA_MEDICA, @vDESCRIP_USO_MEDICO
			   END
			   CLOSE C_RECM
			   DEALLOCATE C_RECM
	        END
		END


	-----------------------------------------------------------------------------------------
	-- Tabla: CATEGORIA MEDICAMENTO
	-----------------------------------------------------------------------------------------
	IF EXISTS (SELECT 'X'
		FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_TYPE = 'BASE TABLE'
		AND TABLE_NAME = 'DIM_CATEGORIA_MEDICAMENTO')
	IF EXISTS(SELECT 'X'
		FROM FARMACIA_SA.INFORMATION_SCHEMA.TABLES
		WHERE TABLE_TYPE = 'BASE TABLE'
		AND TABLE_NAME = 'CATEGORIA_MEDICAMENTO_SA')
	BEGIN
		DECLARE
			@vID_TIPO_MED				INTEGER, 
			@vCATEGORIA_MED				VARCHAR(100), 
			@vDESCRIPCION_CATEGORIA_MED	VARCHAR(100)
		DECLARE C_CAME CURSOR FOR
			SELECT 
				ID_TIPO_MED, 
				CATEGORIA_MED,
				DESCRIPCION_CATEGORIA_MED
			FROM FARMACIA_SA.DBO.CATEGORIA_MEDICAMENTO_SA SADATA
			/*
			WHERE NOT EXISTS (SELECT 'X'
							FROM DIM_CATEGORIA_MEDICAMENTO DWDATA
							WHERE DWDATA.ID_TIPO_MED != SADATA.ID_TIPO_MED)*/
			BEGIN
				SET @VMENSAJE_ERROR = ''
				SET @vERROR_DATOS = 0

				OPEN C_CAME
				FETCH NEXT FROM C_CAME INTO @vID_TIPO_MED, @vCATEGORIA_MED, @vDESCRIPCION_CATEGORIA_MED
				WHILE @@FETCH_STATUS = 0
				BEGIN
					SET @vERROR_DATOS = 0
					IF ISNUMERIC(@vID_TIPO_MED) = 0 OR @vID_TIPO_MED IS NULL
						SET @vERROR_DATOS = 1

					IF @vCATEGORIA_MED IS NULL OR LEN(@vCATEGORIA_MED) > 100 or LEN(@vCATEGORIA_MED) <= 2
				     SET @vERROR_DATOS = 1

					IF @vDESCRIPCION_CATEGORIA_MED IS NULL OR LEN(@vDESCRIPCION_CATEGORIA_MED) > 100 or LEN(@vDESCRIPCION_CATEGORIA_MED) <= 2
				     SET @vERROR_DATOS = 1

					IF @vERROR_DATOS = 1
				     SET @VMENSAJE_ERROR = @VMENSAJE_ERROR + ' ERROR EN CATEGORIA MEDICAMENTO: ' + @vID_TIPO_MED + ' DESCRIPCIÓN:' + @vDESCRIPCION_CATEGORIA_MED

					ELSE 
						INSERT INTO DIM_CATEGORIA_MEDICAMENTO (
							ID_TIPO_MED,
							CATEGORIA_MED,
							DESCRIPCION_CATEGORIA_MED
						) VALUES (
							CONVERT(INTEGER,@vID_TIPO_MED), 
							@vCATEGORIA_MED,
							@vDESCRIPCION_CATEGORIA_MED
						)
				
					FETCH NEXT FROM C_CAME INTO @vID_TIPO_MED, @vCATEGORIA_MED, @vDESCRIPCION_CATEGORIA_MED
				
				END
				CLOSE C_CAME
				DEALLOCATE C_CAME
			END
		END

	-----------------------------------------------------------------------------------------
	-- Tabla: FARMACIA
	-----------------------------------------------------------------------------------------
	IF EXISTS (SELECT 'X'
		FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_TYPE = 'BASE TABLE'
		AND TABLE_NAME = 'DIM_FARMACIA')
	IF EXISTS(SELECT 'X'
		FROM FARMACIA_SA.INFORMATION_SCHEMA.TABLES
		WHERE TABLE_TYPE = 'BASE TABLE'
		AND TABLE_NAME = 'FARMACIA_SA')
	BEGIN
		DECLARE
			@vID_FARMACIA			INTEGER, 
			@vNOMBRE_FARMACIA		VARCHAR(50), 
			@vUBICACION				VARCHAR(50)
		DECLARE C_FAR CURSOR FOR
			SELECT 
				ID_FARMACIA, 
				NOMBRE_FARMACIA,
				UBICACION
			FROM FARMACIA_SA.DBO.FARMACIA_SA SADATA
			/*
			WHERE NOT EXISTS (SELECT 'X'
							FROM DIM_FARMACIA DWDATA
							WHERE DWDATA.ID_FARMACIA != SADATA.ID_FARMACIA)*/
			BEGIN
				SET @VMENSAJE_ERROR = ''
				SET @vERROR_DATOS = 0

				OPEN C_FAR
				FETCH NEXT FROM C_FAR INTO @vID_FARMACIA, @vNOMBRE_FARMACIA, @vUBICACION
				WHILE @@FETCH_STATUS = 0
				BEGIN
					SET @vERROR_DATOS = 0
					IF ISNUMERIC(@vID_FARMACIA) = 0 OR @vID_FARMACIA IS NULL
						SET @vERROR_DATOS = 1

					IF @vNOMBRE_FARMACIA IS NULL OR LEN(@vNOMBRE_FARMACIA) > 50 or LEN(@vNOMBRE_FARMACIA) <= 2
				     SET @vERROR_DATOS = 1

					IF @vUBICACION IS NULL OR LEN(@vUBICACION) > 50 or LEN(@vUBICACION) <= 2
				     SET @vERROR_DATOS = 1

					IF @vERROR_DATOS = 1
				     SET @VMENSAJE_ERROR = @VMENSAJE_ERROR + ' ERROR EN CATEGORIA FARMACIA: ' + @vID_FARMACIA + ' NOMBRE:' + @vNOMBRE_FARMACIA

					ELSE 
						INSERT INTO DIM_FARMACIA (
							ID_FARMACIA,
							NOMBRE_FARMACIA,
							UBICACION
						) VALUES (
							CONVERT(INTEGER,@vID_FARMACIA), 
							@vNOMBRE_FARMACIA,
							@vUBICACION
						)
				
					FETCH NEXT FROM C_FAR INTO @vID_FARMACIA, @vNOMBRE_FARMACIA, @vUBICACION

				END
				CLOSE C_FAR
				DEALLOCATE C_FAR
			END
		END

	-----------------------------------------------------------------------------------------
	-- Tabla: PRECAUCION
	-----------------------------------------------------------------------------------------
	IF EXISTS (SELECT 'X'
		FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_TYPE = 'BASE TABLE'
		AND TABLE_NAME = 'DIM_PRECAUCION')
	IF EXISTS(SELECT 'X'
		FROM FARMACIA_SA.INFORMATION_SCHEMA.TABLES
		WHERE TABLE_TYPE = 'BASE TABLE'
		AND TABLE_NAME = 'PRECAUCION_SA')
	BEGIN
		DECLARE
			@vID_PRECAUCION			INTEGER, 
			@vEFECTOS_SECUNDARIOS	VARCHAR(255), 
			@vFECHA_INDICACION		DATETIME
		DECLARE C_PREC CURSOR FOR
			SELECT 
				ID_PRECAUCION, 
				EFECTOS_SECUNDARIOS,
				FECHA_INDICACIÓN		
			FROM FARMACIA_SA.DBO.PRECAUCION_SA SADATA
			/*
			WHERE NOT EXISTS (SELECT 'X'
							FROM DIM_PRECAUCION DWDATA
							WHERE DWDATA.ID_PRECAUCION != SADATA.ID_PRECAUCION)*/
			BEGIN
				SET @VMENSAJE_ERROR = ''
				SET @vERROR_DATOS = 0

				OPEN C_PREC
				FETCH NEXT FROM C_PREC INTO @vID_PRECAUCION, @vEFECTOS_SECUNDARIOS, @vFECHA_INDICACION
				WHILE @@FETCH_STATUS = 0
				BEGIN
					SET @vERROR_DATOS = 0
					IF ISNUMERIC(@vID_PRECAUCION) = 0 OR @vID_PRECAUCION IS NULL
						SET @vERROR_DATOS = 1

					IF @vEFECTOS_SECUNDARIOS IS NULL OR LEN(@vEFECTOS_SECUNDARIOS) > 255 or LEN(@vEFECTOS_SECUNDARIOS) <= 2
				     SET @vERROR_DATOS = 1

					IF @vFECHA_INDICACION IS NULL
				     SET @vERROR_DATOS = 1

					IF @vERROR_DATOS = 1
				     SET @VMENSAJE_ERROR = @VMENSAJE_ERROR + ' ERROR EN CATEGORIA PRECAUCION: ' + CONVERT(VARCHAR(25),@vID_PRECAUCION) + ' DESCRIPCIÓN:' + @vEFECTOS_SECUNDARIOS

					ELSE 
						INSERT INTO FARMACIA_DW.DBO.DIM_PRECAUCION (
							ID_PRECAUCION,
							EFECTOS_SECUNDARIOS,
							FECHA_INDICACION
						) VALUES (
							CONVERT(INTEGER,@vID_PRECAUCION), 
							@vEFECTOS_SECUNDARIOS,
							@vFECHA_INDICACION
						)
				
					FETCH NEXT FROM C_PREC INTO @vID_PRECAUCION, @vEFECTOS_SECUNDARIOS, @vFECHA_INDICACION

				END
				CLOSE C_PREC
				DEALLOCATE C_PREC
			END
		END

	-----------------------------------------------------------------------------------------
	-- Tabla: CLIENTE
	-----------------------------------------------------------------------------------------
	IF EXISTS (SELECT 'X'
		FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_TYPE = 'BASE TABLE'
		AND TABLE_NAME = 'DIM_CLIENTE')
	IF EXISTS(SELECT 'X'
		FROM FARMACIA_SA.INFORMATION_SCHEMA.TABLES
		WHERE TABLE_TYPE = 'BASE TABLE'
		AND TABLE_NAME = 'CLIENTES_SA')
	BEGIN
		DECLARE
			@vID_CLIENTE			INTEGER, 
			@vFECHA_INICIO		DATETIME
		DECLARE C_CLI CURSOR FOR
			SELECT 
				ID_CLIENTES, 
				FECHA_INICIO	
			FROM FARMACIA_SA.DBO.CLIENTES_SA SADATA
			/*
			WHERE NOT EXISTS (SELECT 'X'
							FROM DIM_CLIENTE DWDATA
							WHERE DWDATA.ID_CLIENTE != SADATA.ID_CLIENTES)*/
			BEGIN
				SET @VMENSAJE_ERROR = ''
				SET @vERROR_DATOS = 0

				OPEN C_CLI
				FETCH NEXT FROM C_CLI INTO @vID_CLIENTE, @vFECHA_INICIO
				WHILE @@FETCH_STATUS = 0
				BEGIN
					SET @vERROR_DATOS = 0
					IF ISNUMERIC(@vID_CLIENTE) = 0 OR @vID_CLIENTE IS NULL
						SET @vERROR_DATOS = 1

					IF @vFECHA_INICIO IS NULL
				     SET @vERROR_DATOS = 1

					IF @vERROR_DATOS = 1
				     SET @VMENSAJE_ERROR = @VMENSAJE_ERROR + ' ERROR EN CATEGORIA CLIENTE: ' + @vID_CLIENTE 

					ELSE 
						INSERT INTO DIM_CLIENTE (
							ID_CLIENTE,
							FECHA_INICIO
						) VALUES (
							CONVERT(INTEGER,@vID_CLIENTE), 
							@vFECHA_INICIO
						)
				
					FETCH NEXT FROM C_CLI INTO @vID_CLIENTE, @vFECHA_INICIO
				END
				CLOSE C_CLI
				DEALLOCATE C_CLI
			END
		END

	-----------------------------------------------------------------------------------------
	-- Tabla: DISTRIBUIDOR
	-----------------------------------------------------------------------------------------

	IF EXISTS (SELECT 'X'
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE = 'BASE TABLE'
			AND TABLE_NAME = 'DIM_DISTRIBUIDOR')
		IF EXISTS(SELECT 'X'
			FROM FARMACIA_SA.INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE = 'BASE TABLE'
			AND TABLE_NAME = 'DISTRIBUIDOR_SA')
		BEGIN
			DECLARE
				@vID_DISTRIBUIDOR				INTEGER, 
				@vFECHA_INICIO_DISTRIBUIDOR		DATETIME
			DECLARE C_DIS CURSOR FOR
				SELECT 
					ID_DISTRIBUIDOR, 
					FECHA_INICIO	
				FROM FARMACIA_SA.DBO.DISTRIBUIDOR_SA SADATA
				/*
				WHERE NOT EXISTS (SELECT 'X'
								FROM DIM_DISTRIBUIDOR DWDATA
								WHERE DWDATA.ID_DISTRIBUIDOR != SADATA.ID_DISTRIBUIDOR)*/
				BEGIN
					SET @VMENSAJE_ERROR = ''
					SET @vERROR_DATOS = 0

					OPEN C_DIS
					FETCH NEXT FROM C_DIS INTO @vID_DISTRIBUIDOR, @vFECHA_INICIO_DISTRIBUIDOR
					WHILE @@FETCH_STATUS = 0
					BEGIN
						SET @vERROR_DATOS = 0
						IF ISNUMERIC(@vID_DISTRIBUIDOR) = 0 OR @vID_DISTRIBUIDOR IS NULL
							SET @vERROR_DATOS = 1

						IF @vFECHA_INICIO_DISTRIBUIDOR IS NULL
						 SET @vERROR_DATOS = 1

						IF @vERROR_DATOS = 1
						 SET @VMENSAJE_ERROR = @VMENSAJE_ERROR + ' ERROR EN DISTRIBUIDOR: ' +CONVERT(VARCHAR(25),@vID_DISTRIBUIDOR)

						ELSE 
							INSERT INTO FARMACIA_DW.DBO.DIM_DISTRIBUIDOR (
								ID_DISTRIBUIDOR,
								FECHA_INICIO
							) VALUES (
								CONVERT(INTEGER,@vID_DISTRIBUIDOR), 
								@vFECHA_INICIO_DISTRIBUIDOR
							)
						
						PRINT(@vID_DISTRIBUIDOR)
						FETCH NEXT FROM C_DIS INTO @vID_DISTRIBUIDOR, @vFECHA_INICIO_DISTRIBUIDOR
					END
					CLOSE C_DIS
					DEALLOCATE C_DIS
				END
			END


	-----------------------------------------------------------------------------------------
	-- Tabla: EMPLEADO
	-----------------------------------------------------------------------------------------
	IF EXISTS (SELECT 'X'
		FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_TYPE = 'BASE TABLE'
		AND TABLE_NAME = 'DIM_EMPLEADO')
	IF EXISTS(SELECT 'X'
		FROM FARMACIA_SA.INFORMATION_SCHEMA.TABLES
		WHERE TABLE_TYPE = 'BASE TABLE'
		AND TABLE_NAME = 'EMPLEADO_SA')
	BEGIN
		DECLARE
			@vID_EMPLEADO				INTEGER, 
			@vFECHA_INICIO_EMPLEADO		DATETIME
		DECLARE C_EMP CURSOR FOR
			SELECT 
				ID_EMPLEADO, 
				FECHA_INICIO	
			FROM FARMACIA_SA.DBO.EMPLEADO_SA SADATA
			/*
			WHERE NOT EXISTS (SELECT 'X'
							FROM DIM_EMPLEADO DWDATA
							WHERE DWDATA.ID_EMPLEADO != SADATA.ID_EMPLEADO)*/
			BEGIN
				SET @VMENSAJE_ERROR = ''
				SET @vERROR_DATOS = 0

				OPEN C_EMP
				FETCH NEXT FROM C_EMP INTO @vID_EMPLEADO, @vFECHA_INICIO_EMPLEADO
				WHILE @@FETCH_STATUS = 0
				BEGIN
					SET @vERROR_DATOS = 0
					IF ISNUMERIC(@vID_EMPLEADO) = 0 OR @vID_EMPLEADO IS NULL
						SET @vERROR_DATOS = 1

					IF @vFECHA_INICIO_EMPLEADO IS NULL
				     SET @vERROR_DATOS = 1

					IF @vERROR_DATOS = 1
				     SET @VMENSAJE_ERROR = @VMENSAJE_ERROR + ' ERROR EN DISTRIBUIDOR: ' + @vID_EMPLEADO

					ELSE 
						INSERT INTO DIM_EMPLEADO(
							ID_EMPLEADO,
							FECHA_INICIO
						) VALUES (
							CONVERT(INTEGER,@vID_EMPLEADO), 
							@vFECHA_INICIO_EMPLEADO
						)
				
					FETCH NEXT FROM C_EMP INTO @vID_EMPLEADO, @vFECHA_INICIO_EMPLEADO

				END
				CLOSE C_EMP
				DEALLOCATE C_EMP
			END
		END
		
	-----------------------------------------------------------------------------------------
	-- Tabla: PROVEEDOR
	-----------------------------------------------------------------------------------------
	IF EXISTS (SELECT 'X'
		FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_TYPE = 'BASE TABLE'
		AND TABLE_NAME = 'DIM_PROVEEDOR')
	IF EXISTS(SELECT 'X'
		FROM FARMACIA_SA.INFORMATION_SCHEMA.TABLES
		WHERE TABLE_TYPE = 'BASE TABLE'
		AND TABLE_NAME = 'FARMACIA_SA')
	BEGIN
		DECLARE
			@vID_PROVEEDOR					INTEGER, 
			@vNOMBRE_MARCA					VARCHAR(50), 
			@vFECHA_INICIO_PROVEEDOR        DATETIME
		DECLARE C_PROV CURSOR FOR
			SELECT 
				ID_PROVEEDOR, 
				NOMBRE_MARCA,
				FECHA_INICIO
			FROM FARMACIA_SA.DBO.PROVEEDOR_SA SADATA
			/*
			WHERE NOT EXISTS (SELECT 'X'
							FROM DIM_PROVEEDOR DWDATA
							WHERE DWDATA.ID_PROVEEDOR != SADATA.ID_PROVEEDOR)*/
			BEGIN
				SET @VMENSAJE_ERROR = ''
				SET @vERROR_DATOS = 0

				OPEN C_PROV
				FETCH NEXT FROM C_PROV INTO @vID_PROVEEDOR, @vNOMBRE_MARCA, @vFECHA_INICIO_PROVEEDOR
				WHILE @@FETCH_STATUS = 0
				BEGIN
					SET @vERROR_DATOS = 0
					IF ISNUMERIC(@vID_PROVEEDOR) = 0 OR @vID_PROVEEDOR IS NULL
						SET @vERROR_DATOS = 1

					IF @vNOMBRE_MARCA IS NULL OR LEN(@vNOMBRE_MARCA) > 50 or LEN(@vNOMBRE_MARCA) <= 2
				     SET @vERROR_DATOS = 1

					IF @vFECHA_INICIO_PROVEEDOR IS NULL 
				     SET @vERROR_DATOS = 1

					IF @vERROR_DATOS = 1
				     SET @VMENSAJE_ERROR = @VMENSAJE_ERROR + ' ERROR EN CATEGORIA PROVEEDOR: ' + @vID_PROVEEDOR + ' NOMBRE:' + @vNOMBRE_MARCA

					ELSE 
						INSERT INTO DIM_PROVEEDOR (
							ID_PROVEEDOR,
							NOMBRE_MARCA,
							FECHA_INICIO
						) VALUES (
							CONVERT(INTEGER,@vID_PROVEEDOR), 
							@vNOMBRE_MARCA,
							@vFECHA_INICIO_PROVEEDOR
						)
				
					FETCH NEXT FROM C_PROV INTO @vID_PROVEEDOR, @vNOMBRE_MARCA, @vFECHA_INICIO_PROVEEDOR

				END
				CLOSE C_PROV
				DEALLOCATE C_PROV
			END
		END
	
	-----------------------------------------------------------------------------------------
	-- Tabla: HECHOS
	-----------------------------------------------------------------------------------------
	IF EXISTS (SELECT 'X'
		FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_TYPE = 'BASE TABLE'
		AND TABLE_NAME = 'FAC_FARMACIA')
	IF EXISTS(SELECT 'X'
		FROM FARMACIA_SA.INFORMATION_SCHEMA.TABLES
		WHERE TABLE_TYPE = 'BASE TABLE'
		AND TABLE_NAME = 'FARMACIA_SA')
	BEGIN
		DECLARE
			@vID_TIPO_MED_FAC		    VARCHAR(255), 
			@vID_PROVEEDOR_FAC		    VARCHAR(255), 
			@vID_PERSONA_FAC		    VARCHAR(255),
			@vID_FARMACIA_FAC		    VARCHAR(255),
			@vID_EMPLEADO_FAC		    VARCHAR(255),
			@vID_CLIENTE_FAC		    VARCHAR(255),
			@vID_MEDICAMENTO_FAC		VARCHAR(255),
			@vID_DISTRIBUIDOR_FAC		VARCHAR(255),
			@vCODIGO_RECETA_MEDICA_FAC  VARCHAR(255),
			@vID_PRECAUCION_FAC		    VARCHAR(255), 
			@vDURACION_ACUERDO_FAC	    VARCHAR(255),
			@vMESES_DURACION_FAC		VARCHAR(255),
			@vCAPACIDAD_FAC				VARCHAR(255),
			@vAÑOS_EXPERIENCIA_FAC		VARCHAR(255),
			@vCANTIDAD_ALMACEN_FAC		VARCHAR(255),
			@vCANTIDAD_FAC		        VARCHAR(255), 
			@FECHA_RECETA_MEDICA_FAC    VARCHAR(255),
			@vPrueba_FAC				decimal(20,2),
			@vFechaEntero_FAC			integer

		DECLARE C_FAC_FARM CURSOR FOR
			SELECT		CME.ID_TIPO_MED,
						PR.ID_PROVEEDOR,
						PS.ID_PERSONA,
						FA.ID_FARMACIA,
						EM.ID_EMPLEADO,
						CL.ID_CLIENTES,
						ME.ID_MEDICAMENTO,
						DS.ID_DISTRIBUIDOR,
						RC.CODIGO_RECETA_MEDICA,
						PRC.ID_PRECAUCION,
						PR.DURACION_ACUERDO,
						PR.MESES_DURACION,
						FA.CAPACIDAD,
						FA.AÑOS_EXISTENCIA,
						ME.CANTIDAD_ALMACEN,
						RC.CANTIDAD,
						RC.FECHA

FROM FARMACIA_SA.dbo.MEDICAMENTO_SA ME INNER JOIN FARMACIA_SA.dbo.CATEGORIA_MEDICAMENTO_SA CME ON ME.ID_TIPO_MED = CME.ID_TIPO_MED 
					   INNER JOIN FARMACIA_SA.dbo.DISTRIBUIDOR_SA DS ON ME.ID_MEDICAMENTO = DS.ID_MEDICAMENTOS
					   INNER JOIN FARMACIA_SA.dbo.PROVEEDOR_SA PR ON DS.ID_PROVEEDOR = PR.ID_PROVEEDOR
					   INNER JOIN FARMACIA_SA.dbo.PERSONA_SA PS ON DS.ID_PERSONA = PS.ID_PERSONA
					   INNER JOIN FARMACIA_SA.dbo.FARMACIA_SA FA ON ME.ID_FARMACIA = FA.ID_FARMACIA
					   INNER JOIN FARMACIA_SA.dbo.EMPLEADO_SA EM ON PS.ID_PERSONA = EM.ID_PERSONA
					   INNER JOIN FARMACIA_SA.dbo.RECETA_X_MEDICAMENTOS_SA RXM ON ME.ID_MEDICAMENTO = RXM.ID_MEDICAMENTO
					   INNER JOIN FARMACIA_SA.dbo.RECETA_MEDICA_SA RC ON RXM.CODIGO_RECETA_MEDICA = RC.CODIGO_RECETA_MEDICA
					   INNER JOIN FARMACIA_SA.dbo.CLIENTES_SA CL ON RC.ID_CLIENTE = CL.ID_CLIENTES
					   INNER JOIN FARMACIA_SA.dbo.PRECAUCION_SA PRC ON ME.ID_MEDICAMENTO = PRC.ID_MEDICAMENTO
			BEGIN
				SET @VMENSAJE_ERROR = ''
				SET @vERROR_DATOS = 0

				OPEN C_FAC_FARM
				FETCH NEXT FROM C_FAC_FARM INTO @vID_TIPO_MED_FAC, @vID_PROVEEDOR_FAC, @vID_PERSONA_FAC, @vID_FARMACIA_FAC, @vID_EMPLEADO_FAC, @vID_CLIENTE_FAC, @vID_MEDICAMENTO_FAC, @vID_DISTRIBUIDOR_FAC, @vCODIGO_RECETA_MEDICA_FAC, @vID_PRECAUCION_FAC,  @vDURACION_ACUERDO_FAC, @vMESES_DURACION_FAC, @vCAPACIDAD_FAC, @vAÑOS_EXPERIENCIA_FAC, @vCANTIDAD_ALMACEN_FAC, @vCANTIDAD_FAC,  @FECHA_RECETA_MEDICA_FAC
				WHILE @@FETCH_STATUS = 0
				BEGIN
					SET @vERROR_DATOS = 0
					IF ISNUMERIC(@vID_TIPO_MED_FAC) = 0 OR @vID_TIPO_MED_FAC IS NULL
						SET @vERROR_DATOS = 1

					IF ISNUMERIC(@vID_PROVEEDOR_FAC) = 0 OR @vID_PROVEEDOR_FAC IS NULL
						SET @vERROR_DATOS = 1

					IF ISNUMERIC(@vID_PERSONA_FAC) = 0 OR @vID_PERSONA_FAC IS NULL
						SET @vERROR_DATOS = 1

					IF ISNUMERIC(@vID_FARMACIA_FAC) = 0 OR @vID_FARMACIA_FAC IS NULL
						SET @vERROR_DATOS = 1

					IF ISNUMERIC(@vID_EMPLEADO_FAC) = 0 OR @vID_EMPLEADO_FAC IS NULL
						SET @vERROR_DATOS = 1

					IF ISNUMERIC(@vID_CLIENTE_FAC) = 0 OR @vID_CLIENTE_FAC IS NULL
						SET @vERROR_DATOS = 1

					IF ISNUMERIC(@vID_MEDICAMENTO_FAC) = 0 OR @vID_MEDICAMENTO_FAC IS NULL
						SET @vERROR_DATOS = 1

					IF ISNUMERIC(@vID_DISTRIBUIDOR_FAC) = 0 OR @vID_DISTRIBUIDOR_FAC IS NULL
						SET @vERROR_DATOS = 1

					IF ISNUMERIC(@vCODIGO_RECETA_MEDICA_FAC) = 0 OR @vCODIGO_RECETA_MEDICA_FAC IS NULL
						SET @vERROR_DATOS = 1
	
					IF ISNUMERIC(@vID_PRECAUCION_FAC) = 0 OR @vID_PRECAUCION_FAC IS NULL
						SET @vERROR_DATOS = 1

					IF ISNUMERIC(@vDURACION_ACUERDO_FAC) = 0 OR @vDURACION_ACUERDO_FAC IS NULL
						SET @vERROR_DATOS = 1

					IF ISNUMERIC(@vMESES_DURACION_FAC) = 0 OR @vMESES_DURACION_FAC IS NULL
						SET @vERROR_DATOS = 1

					IF ISNUMERIC(@vCAPACIDAD_FAC) = 0 OR @vCAPACIDAD_FAC IS NULL
						SET @vERROR_DATOS = 1

					IF ISNUMERIC(@vAÑOS_EXPERIENCIA_FAC) = 0 OR @vAÑOS_EXPERIENCIA_FAC IS NULL
						SET @vERROR_DATOS = 1

					IF ISNUMERIC(@vCANTIDAD_ALMACEN_FAC) = 0 OR @vCANTIDAD_ALMACEN_FAC IS NULL
						SET @vERROR_DATOS = 1

					IF ISNUMERIC(@vCANTIDAD_FAC) = 0 OR @vCANTIDAD_FAC IS NULL
						SET @vERROR_DATOS = 1

					IF ISDATE(@FECHA_RECETA_MEDICA_FAC) = 0 OR @FECHA_RECETA_MEDICA_FAC IS NULL
						SET @vERROR_DATOS = 1
					ELSE 
						SET @vFechaEntero_FAC = CONVERT(INTEGER,REPLACE(@FECHA_RECETA_MEDICA_FAC,'-',''))

					IF @vERROR_DATOS= 1
						SET @VMENSAJE_ERROR = @VMENSAJE_ERROR + 'ERROR EN TRANSACCION: '+

			'Tipo medicamento: '+@vID_TIPO_MED_FAC +
			'Proveedor: '+@vID_PROVEEDOR_FAC+
			'Persona: '+ @vID_PERSONA_FAC+
			'Farmacia: '+@vID_FARMACIA_FAC+
			'Empleado: '+@vID_EMPLEADO_FAC+
			'Cliente: '+@vID_CLIENTE_FAC+
			'Medicamento: '+@vID_MEDICAMENTO_FAC+
			'Distribuidor: '+@vID_DISTRIBUIDOR_FAC+
			'Receta medica: '+@vCODIGO_RECETA_MEDICA_FAC+
			'Precaucion: '+@vID_PRECAUCION_FAC+
			'Duracion: '+@vDURACION_ACUERDO_FAC+
			'Meses de duracion: '+@vMESES_DURACION_FAC+
			'Capacidad: '+@vCAPACIDAD_FAC+
			'Años de experiencia: '+@vAÑOS_EXPERIENCIA_FAC+
			'Cantidad almacen: '+@vCANTIDAD_ALMACEN_FAC+
			'Cantidad: '+@vCANTIDAD_FAC+ 
			'Fecha: '+@FECHA_RECETA_MEDICA_FAC

					ELSE 
						INSERT INTO FAC_FARMACIA (
							ID_TIPO_MED, 
							ID_PROVEEDOR, 
							ID_PERSONA, 
							ID_FARMACIA, 
							ID_EMPLEADO, 
							ID_CLIENTE, 
							ID_MEDICAMENTO, 
							ID_DISTRIBUIDOR, 
							CODIGO_RECETA_MEDICA, 
							ID_PRECAUCION, 
							DURACION_ACUERDO, 
							MESES_DURACION, 
							CAPACIDAD, 
							ANOS_EXPERIENCIA, 
							CANTIDAD_ALMACEN, 
							CANTIDAD, 
							FECHA_RECETA_MEDICA
						) VALUES(
								CONVERT(INTEGER,@vID_TIPO_MED_FAC),
								CONVERT(INTEGER,@vID_PROVEEDOR_FAC), 
								CONVERT (INTEGER,@vID_PERSONA_FAC), 
								CONVERT (INTEGER,@vID_FARMACIA_FAC), 
								CONVERT (INTEGER,@vID_EMPLEADO_FAC), 
								CONVERT (INTEGER,@vID_CLIENTE_FAC), 
								CONVERT (INTEGER,@vID_MEDICAMENTO_FAC), 
								CONVERT (INTEGER,@vID_DISTRIBUIDOR_FAC), 
								CONVERT (INTEGER,@vCODIGO_RECETA_MEDICA_FAC),  
								CONVERT (INTEGER,@vID_PRECAUCION_FAC), 
								CONVERT (INTEGER,@vDURACION_ACUERDO_FAC), 
								CONVERT (INTEGER,@vMESES_DURACION_FAC), 
								CONVERT (INTEGER,@vCAPACIDAD_FAC), 
								CONVERT (INTEGER,@vAÑOS_EXPERIENCIA_FAC), 
								CONVERT (INTEGER,@vCANTIDAD_ALMACEN_FAC),
								CONVERT (INTEGER,@vCANTIDAD_FAC),
								@vFechaEntero_FAC
							)
					FETCH NEXT FROM C_FAC_FARM INTO @vID_TIPO_MED_FAC, @vID_PROVEEDOR_FAC, @vID_PERSONA_FAC, @vID_FARMACIA_FAC, @vID_EMPLEADO_FAC, @vID_CLIENTE_FAC, @vID_MEDICAMENTO_FAC, @vID_DISTRIBUIDOR_FAC, @vCODIGO_RECETA_MEDICA_FAC, @vID_PRECAUCION_FAC,  @vDURACION_ACUERDO_FAC, @vMESES_DURACION_FAC, @vCAPACIDAD_FAC, @vAÑOS_EXPERIENCIA_FAC, @vCANTIDAD_ALMACEN_FAC, @vCANTIDAD_FAC,  @FECHA_RECETA_MEDICA_FAC
				END
				CLOSE C_FAC_FARM
				DEALLOCATE C_FAC_FARM
			END
		END

	END
