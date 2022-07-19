USE FARMACIA_ER
GO

/* INICIAR LA INSERCIÓN DE LOS VALORES DE CADA TABLA */

INSERT INTO FARMACIA
VALUES(1,'Farmacia La Arboleda',2000,'Cartago, Guadalupe',12);


INSERT INTO CATEGORIA_MEDICAMENTO
VALUES (1,'Analgésicos','Fármacos que tienen como finalidad aliviar el dolor físico');
INSERT INTO CATEGORIA_MEDICAMENTO
VALUES (2,'Antialérgicos','Fármacos que tienen la finalidad de combatir los efectos negativos de las reacciones alérgicas');
INSERT INTO CATEGORIA_MEDICAMENTO
VALUES (3,'Antiinflamatorios','Fármacos que tienen como finalidad reducir los efectos de la inflamación');
INSERT INTO CATEGORIA_MEDICAMENTO
VALUES (4,'Antiinfecciosos','Este tipo de medicamentos están recetados para hacer frente a infecciones');


INSERT INTO PROVEEDOR 
VALUES (1, 'Fischel',4,'2019-09-02',8);
INSERT INTO PROVEEDOR
VALUES (2, 'Farmanova',2,'2021-06-09',7);
INSERT INTO PROVEEDOR
VALUES (3, 'CEFA', 1, '2022-03-15', 6);


INSERT INTO PERSONA
VALUES(1,'Mariangel', '','Bustamante', 'Zúñiga',154895894,'1991-04-07');
INSERT INTO PERSONA
VALUES(2,'Fernanda', '','Fernández', 'Quiros',133082681,'1983-02-10');
INSERT INTO PERSONA
VALUES(3,'Juan','Carlos','López', 'Fernández',267875490,'1996-10-16');
INSERT INTO PERSONA
VALUES(4,'Roberto', '','Rodriguez', 'Salazar',348765894,'2001-09-29');
INSERT INTO PERSONA
VALUES(5,'Markel', '','Rosales', 'Villalobos',201574875,'1982-11-23');
INSERT INTO PERSONA
VALUES(6,'Jacqueline', '','Vera', 'Brenes',118516075,'1990-02-10');
INSERT INTO PERSONA
VALUES(7,'Denis', '','Vázquez', 'Gutiérrez',378571054,'1983-12-16');
INSERT INTO PERSONA
VALUES(8,'Sofía', '','Corrales','García',129061129,'1995-01-21');
INSERT INTO PERSONA
VALUES(9,'Jose', '','Castro','Alfaro',987667718,'1979-02-22');
INSERT INTO PERSONA
VALUES(10,'Jorge', '','López','Vega',805114074,'1980-01-11');
INSERT INTO PERSONA
VALUES(11,'Víctor', '','Araya','Aguilar',345829764,'1994-11-23');
INSERT INTO PERSONA
VALUES(12,'Rosa', '','Solano','Calderón',832899855,'1992-05-08');
INSERT INTO PERSONA
VALUES(13,'Andrea', '','Alvarado','Valverde',312862968,'1972-08-07');
INSERT INTO PERSONA
VALUES(14,'Álvaro', '','Chaves','Chavarría',575565762,'1991-07-09');
INSERT INTO PERSONA
VALUES(15,'David', '','Pérez','Castillo',362525060,'1990-04-18');
INSERT INTO PERSONA
VALUES(16,'Katherine', '','Morales','Salas',708243699,'1974-09-15');
INSERT INTO PERSONA
VALUES(17,'Edwin', '','Campos','Solís',924123449,'1987-07-25');
INSERT INTO PERSONA
VALUES(18,'Walter', '','Quesada','Granados',955721176,'1992-07-01');
INSERT INTO PERSONA
VALUES(19,'Diego', '','Gómez','Chinchilla',926531809,'1980-07-25');
INSERT INTO PERSONA
VALUES(20,'Jessica', '','Arias','Camacho',434083875,'1966-04-01');


INSERT INTO EMPLEADO
VALUES(1,1,'2011-06-09',1);
INSERT INTO EMPLEADO
VALUES(2,2,'2013-11-15',1);
INSERT INTO EMPLEADO
VALUES(3,3,'2016-10-29',1);
INSERT INTO EMPLEADO
VALUES(4,4,'2022-04-03',1);
INSERT INTO EMPLEADO
VALUES(5,5,'2012-01-11',1);
INSERT INTO EMPLEADO
VALUES(6,6,'2010-12-22',1);
INSERT INTO EMPLEADO
VALUES(7,7,'2013-08-01',1);


INSERT INTO CLIENTES
VALUES(1,8,'2016-01-21');
INSERT INTO CLIENTES
VALUES(2,9,'2010-02-22');
INSERT INTO CLIENTES
VALUES(3,10,'2011-01-11');
INSERT INTO CLIENTES
VALUES(4,11,'2014-11-23');
INSERT INTO CLIENTES
VALUES(5,12,'2019-05-08');
INSERT INTO CLIENTES
VALUES(6,13,'2020-08-07');
INSERT INTO CLIENTES
VALUES(7,14,'2021-07-09');
INSERT INTO CLIENTES
VALUES(8,15,'2015-04-18');



INSERT INTO MEDICAMENTO
VALUES (1,'Paracetamol','Eficaz para el control del dolor leve o moderado causado por afecciones articulares',32,'2023-09-24',1,1);
INSERT INTO MEDICAMENTO
VALUES (2,'Vicoprofen','Medicamento utilizado para tratar los síntomas de dolor agudo',17,'2023-04-10',1,1);
INSERT INTO MEDICAMENTO
VALUES (3,'Cetirizina','Fármaco utilizado para el tratamiento de la alergia',20,'2023-06-03',2,1);
INSERT INTO MEDICAMENTO
VALUES (4,'Fenoprofeno','Es un fármaco antiinflamatorio no esteroideo',10,'2023-05-28',3,1);
INSERT INTO MEDICAMENTO
VALUES (5,'Amoxicilina','Tratamiento de las infecciones producidas por microorganismos sensibles su acción bactericida',15,'2023-10-09',4,1);


INSERT INTO DISTRIBUIDOR
VALUES(1,16,'2021-09-15',1,1);
INSERT INTO DISTRIBUIDOR
VALUES(2,17,'2017-07-25',2,2);
INSERT INTO DISTRIBUIDOR
VALUES(3,18,'2019-07-01',3,3);
INSERT INTO DISTRIBUIDOR
VALUES(4,19,'2020-07-25',1,4);
INSERT INTO DISTRIBUIDOR
VALUES(5,20,'2022-04-01',2,5);


INSERT INTO RECETA_MEDICA
VALUES(1,'1 comprimido cada 4-6 horas, según necesidad',2,1,'2016-01-21');
INSERT INTO RECETA_MEDICA
VALUES(2,'Una tableta cada 4 a 6 horas, según sea necesario. La dosis no debe exceder las 5 tabletas en un período de 24 horas',1,2,'2010-02-22');
INSERT INTO RECETA_MEDICA
VALUES(3,'Tomarse una vez al día, con o sin alimentos',2,3,'2011-01-11');
INSERT INTO RECETA_MEDICA
VALUES(4,'Tomar con un vaso completo de agua 3 ó 4 veces al día para la artritis, o cada 4 a 6 horas según sea necesario',3,4,'2014-11-23');
INSERT INTO RECETA_MEDICA
VALUES(5,'TomaR cada 12 horas (dos veces al día) o cada 8 horas (tres veces al día) con o sin alimentos',1,5,'2019-05-08');


INSERT INTO RECETA_X_MEDICAMENTOS
VALUES(1,1,1);
INSERT INTO RECETA_X_MEDICAMENTOS
VALUES(2,2,2);
INSERT INTO RECETA_X_MEDICAMENTOS
VALUES(3,3,3);
INSERT INTO RECETA_X_MEDICAMENTOS
VALUES(4,4,4);
INSERT INTO RECETA_X_MEDICAMENTOS
VALUES(5,5,5);


INSERT INTO PRECAUCION
VALUES (1,'Náusea, vómito, dolor epigástrico, somnolencia, ictericia, anemia hemolítica','2023-09-01',1);
INSERT INTO PRECAUCION
VALUES (2,'Urticaria, respiración dificultosa, hinchazón de la cara, los labios, fiebre, dolor de garganta','2023-04-01',2);
INSERT INTO PRECAUCION
VALUES (3,'Somnolencia, sequedad de boca, cefalea, mareo, fatiga, molestias gastrointestinales','2023-06-01',3);
INSERT INTO PRECAUCION
VALUES (4,'Cefalea, nerviosismo, transpiración, estreñimiento','2023-05-01',4);
INSERT INTO PRECAUCION
VALUES (5,'Náusea, vómitos, diarrea, dolor de cabeza','2023-10-01',5);
