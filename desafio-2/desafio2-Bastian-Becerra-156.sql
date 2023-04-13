-- Paso 1 Creacion de tabla
CREATE DATABASE desafio2_Bastian_Becerra_636

\c desafio2_Bastian_Becerra_636

CREATE TABLE IF NOT EXISTS INSCRITOS(cantidad INT, fecha DATE, fuente
VARCHAR);

INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 44, '01/01/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 56, '01/01/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 39, '01/02/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 81, '01/02/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/03/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 91, '01/03/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 48, '01/04/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 45, '01/04/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 55, '01/05/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 33, '01/05/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 18, '01/06/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/06/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 34, '01/07/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 24, '01/07/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 83, '01/08/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 99, '01/08/2021', 'Página' );

--Para ver que la tabla este bien hecha

SELECT * FROM INSCRITOS;

--¿Cuántos registros hay?

SELECT COUNT (*) FROM INSCRITOS;

--¿Cuántos inscritos hay en total?

SELECT SUM(cantidad) FROM INSCRITOS;

--¿Cuál o cuáles son los registros de mayor antigüedad?

SELECT * FROM INSCRITOS WHERE fecha = (SELECT fecha FROM INSCRITOS ORDER BY fecha ASC LIMIT 1);

--¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante)

SELECT fecha, SUM(cantidad) FROM INSCRITOS GROUP BY fecha

--¿Cuántos inscritos hay por fuente?

SELECT fuente, SUM(cantidad) FROM INSCRITOS GROUP BY fuente;

--¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se inscribieron en ese día?

SELECT fecha, SUM(cantidad) FROM INSCRITOS GROUP BY fecha ORDER BY SUM(cantidad) DESC LIMIT 1;

--¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog y cuántas personas fueron?

SELECT fecha, SUM(cantidad) FROM INSCRITOS  WHERE fuente = 'Blog' GROUP BY fecha ORDER BY SUM(cantidad) DESC LIMIT 1;

--¿Cuántas personas en promedio se inscriben en un día?

SELECT AVG(cantidad) FROM INSCRITOS;

--¿Qué días se inscribieron más de 50 personas?

SELECT AVG(cantidadtotal) FROM (SELECT fecha, sum(cantidad) AS cantidadtotal FROM INSCRITOS GROUP BY fecha) AS columnadesauma;

--¿Cuántas personas se registraron en promedio cada día a partir del tercer día?

SELECT AVG(cantidadtotal) FROM (SELECT fecha, sum(cantidad) AS cantidadtotal FROM INSCRITOS GROUP BY fecha) AS sumadecolumnas WHERE fecha >= '01/03/2021'