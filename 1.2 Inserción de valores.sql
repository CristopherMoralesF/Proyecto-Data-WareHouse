USE FARMACIA_ER
GO

/* INICIAR LA INSERCIÓN DE LOS VALORES DE CADA TABLA */


INSERT INTO FARMACIA VALUES
	(2,'Farmacia La Arboleda',2000,'Cartago, Guadalupe',12),
	(3,'Farmacia La Arboleda',3000,'San Jose, Curridabat',5),
	(4,'Farmacia La Arboleda',1000,'Heredia, San Francisco',8),
	(5,'Farmacia La Arboleda',2500,'Alajuela, Coyol',3)
GO

/*
-----> Cris comment: agregar valores distintos al archivo 1.1, si los valores son duplicados los scripts no corren por el PK y los FK <-----

INSERT INTO CATEGORIA_MEDICAMENTO VALUES 
	(1,'Analgésicos','Fármacos que tienen como finalidad aliviar el dolor físico'),
	(2,'Antialérgicos','Fármacos que tienen la finalidad de combatir los efectos negativos de las reacciones alérgicas'),
	(3,'Antiinflamatorios','Fármacos que tienen como finalidad reducir los efectos de la inflamación'),
	(4,'Antiinfecciosos','Este tipo de medicamentos están recetados para hacer frente a infecciones'),
	(5,'Antipiréticos','Este tipo de medicamentos que tienen la capacidad de reducir la fiebre')
GO
*/


INSERT INTO PROVEEDOR VALUES 
	(4, 'Pfizer', 3, '2020-02-23', 4),
	(5, 'Astrazeneca', 2, '2021-07-05', 6),
	(6, 'Johnson & Johnson', 4, '2019-10-17', 10),
	(7, 'gsk', 6, '2010-01-20', 6)
GO

INSERT INTO PERSONA VALUES
	(21,'Julian', 'Francisco','Miranda','Castillo',113543203,'1990-06-27'),
	(22,'Juan', 'Luis','Lopez','Rodriguez',524526384,'1987-03-18'),
	(23,'Raquel', 'Cristina','Mora','Cascante',112437656,'1997-04-18'),
	(24,'Krista', 'Isabell','Leon','Cascante',156095425,'1999-06-11'),
	(25,'Marta', 'Patricia','Calderon','Guardia',124826184,'2000-07-03'),
	(26,'Ronald', 'jose','Roman','Figueres',173455234,'1998-03-18'),
	(27,'Sofia', 'Lucia','Jimenez','Ortiz',162323384,'2001-05-04'),
	(28,'Ileana', '','Diaz','Fernandez',173527432,'1987-03-18'),
	(29,'Marina', '','Loza','Vindas',187365294,'1992-06-11'),
	(30,'Miranda', '','Aguilar','Mesa',163527532,'2000-12-20'),
	(31,'Fiorella', 'Milagro','Mata','Lobo',132743821,'1976-08-16'),
	(32,'Gabriel', 'Josue','Escalante','Abarca',189346278,'1984-05-27'),
	(33,'Fabian', 'Andres','Barquero','Phillips',143258756,'1993-11-17'),
	(34,'Valeria', '','Sancho','Leandro',173530954,'1995-05-12'),
	(35,'Natalia', '','Sancho','Leandro',173530955,'1995-05-12'),
	(36,'Fancy', '','Campos','Sanchez',165348723,'2000-09-29'),
	(37,'David', 'Alberto','Campos','Sanchez',183623483,'2000-02-18'),
	(38,'Raul', '','Salas','Piedra',173346955,'2002-03-18'),
	(39,'Mariana', 'Rebeca','Quesada','Vargas',239648942,'2003-01-30'),
	(40,'Sebastian', '','Valverde','Leandro',179838552,'1995-12-01'),
	(41,'Luis', 'Fernando','Meneses','Sancho',182632452,'1976-07-29'),
	(42,'Bryan', '','Fernandez','Castro',176230352,'1985-11-28'),
	(43,'Jose', '','Ubisco','Santamaria',179803552,'1984-08-17'),
	(44,'Carlos', '','Martinez','Mora',170938552,'1956-12-08'),
	(45,'Javier', 'Fabricio','Bosque','Lobo',179838507,'2002-08-16'),
	(46,'Rodolfo', '','Naranjo','Sevilla',179838501,'2003-02-23'),
	(47,'Fausto', '','Costa','Salvador',179830852,'2001-12-01'),
	(48,'Dominic', '','Castilla','Leon',179012552,'2003-04-27'),
	(49,'Pablo', 'Luciano','Castro','Mesa',189002852,'1959-12-01'),
	(50,'Steven', 'Ricardo','Guerra','Tenorio',179000552,'1959-11-14')
GO

INSERT INTO EMPLEADO VALUES
	(8,8,'2017-05-01',2),
	(9,9,'2017-05-01',2),
	(10,10,'2018-10-03',2),
	(11,11,'2019-02-01',2),
	(12,12,'2018-08-10',2),
	(13,13,'2017-05-01',2),
	(14,14,'2014-05-01',3),
	(15,15,'2014-02-01',3),
	(16,16,'2014-06-04',3),
	(17,17,'2015-01-10',3),
	(18,18,'2019-01-01',4),
	(19,19,'2019-03-02',4),
	(20,20,'2019-01-04',4),
	(21,21,'2020-05-06',4)
GO

INSERT INTO CLIENTES VALUES
	(9,22,'2015-04-18'),
	(10,23,'2015-04-18'),
	(11,24,'2015-04-18'),
	(12,25,'2015-04-18'),
	(13,26,'2015-04-18'),
	(14,27,'2015-04-18'),
	(15,28,'2015-04-18'),
	(16,29,'2015-04-18'),
	(17,30,'2015-04-18'),
	(18,31,'2015-04-18'),
	(19,32,'2015-04-18'),
	(20,33,'2015-04-18'),
	(21,34,'2015-04-18'),
	(22,35,'2015-04-18'),
	(23,36,'2015-04-18'),
	(24,37,'2015-04-18'),
	(25,38,'2015-04-18'),
	(26,39,'2015-04-18'),
	(27,40,'2015-04-18')
GO




INSERT INTO MEDICAMENTO VALUES 
	(6,'Dipirona','Es un potente analgésico',18,'2023-10-17',1,2),
	(7,'Nefopam','Se usa para tratar el dolor moderado a intenso.',13,'2023-08-02',1,2),
	(8,'Loratadina','Alivia los síntomas asociados a la rinitis alérgica',25,'2023-09-30',2,2)
GO

/*
-----> Cris comment: Al parecer no existe la FK 28 y  29, crearlas o cambiarlas en el query a partir de acá, todas las tablas tienen el mismo issue <-----
*/

INSERT INTO DISTRIBUIDOR VALUES
	(6,27,'2019-10-20',6,6),	
	(7,28,'2022-04-01',7,7),	
	(8,29,'2010-01-23',8,7)
GO


INSERT INTO RECETA_MEDICA VALUES
	(6,'Tomar de 1 a 2 g cada 8 horas',1,39,'2020-08-08'),
	(7,'Inicialmente, 60 mg pero puede variar de 30-90 mg tid. Máx.: 300 mg diarios',1,40,'2021-08-08'),
	(8,'Dos cucharaditas de LORATADINA (10 ml = 10 mg) una vez al día.',1,35,'2019-01-03')
GO

INSERT INTO RECETA_X_MEDICAMENTOS VALUES
	(6,6,6),
	(7,7,7),
	(8,8,8)
GO

INSERT INTO PRECAUCION VALUES 
	(1,'Náusea, vómito, dolor epigástrico, somnolencia, ictericia, anemia hemolítica','2023-09-01',1),
	(2,'Urticaria, respiración dificultosa, hinchazón de la cara, los labios, fiebre, dolor de garganta','2023-04-01',2),
	(3,'Somnolencia, sequedad de boca, cefalea, mareo, fatiga, molestias gastrointestinales','2023-06-01',3),
	(4,'Cefalea, nerviosismo, transpiración, estreñimiento','2023-05-01',4),
	(5,'Náusea, vómitos, diarrea, dolor de cabeza','2023-10-01',5)
GO


