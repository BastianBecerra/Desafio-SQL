CREATE TABLE peliculas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    anno INTEGER
);

CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    tag VARCHAR(32)
);

--Tabla intermedia con las llaves foraneas
CREATE TABLE peliculas_tags (
    pelicula_id INTEGER,
    tag_id INTEGER,
    FOREIGN KEY (pelicula_id) REFERENCES peliculas (id),
    FOREIGN KEY (tag_id) REFERENCES tags (id)
);

INSERT INTO peliculas (nombre, anno) VALUES ('El señor de los anillos', 2002);
INSERT INTO peliculas (nombre, anno) VALUES ('UP', 2009);
INSERT INTO peliculas (nombre, anno) VALUES ('Jurassic world', 2015);
INSERT INTO peliculas (nombre, anno) VALUES ('Interestelar', 2014);
INSERT INTO peliculas (nombre, anno) VALUES ('Rapidos y furiosos', 2001);
--
INSERT INTO tags (tag) VALUES ('Suspenso');
INSERT INTO tags (tag) VALUES ('Ciencia Ficcion');
INSERT INTO tags (tag) VALUES ('Aventura');
INSERT INTO tags (tag) VALUES ('Fantasia');
INSERT INTO tags (tag) VALUES ('Romance');

--Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe mostrar 0

SELECT peliculas.nombre, COUNT(peliculas_tags.tag_id) FROM peliculas LEFT JOIN peliculas_tags ON peliculas.id = peliculas_tags.pelicula_id GROUP BY peliculas.nombre;

--Parte 2

CREATE TABLE preguntas (
    id SERIAL PRIMARY KEY,
    pregunta VARCHAR(255),
    respuesta_correcta VARCHAR
);

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    edad INTEGER
);

--Tabla intermedia preguntas y usuarios
CREATE TABLE respuestas (
    id SERIAL PRIMARY KEY,
    respuesta VARCHAR(255),
    pregunta_id INTEGER,
    usuario_id INTEGER,
    FOREIGN KEY (pregunta_id) REFERENCES preguntas (id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
);

--Usuarios NOMBRE Y EDAD

INSERT INTO usuarios (nombre, edad) Values ('Bastian', 22);
INSERT INTO usuarios (nombre, edad) Values ('Daniel', 35);
INSERT INTO usuarios (nombre, edad) Values ('Francisco', 32);
INSERT INTO usuarios (nombre, edad) Values ('Diego', 29);
INSERT INTO usuarios (nombre, edad) Values ('Constanza', 28);

--Datos tabla pregunta
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('Cuantos meses tiene el año?','El año tiene 12 meses');
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('Quien gano la copa america de 2015?','La copa la gano Chile');
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('Donde se encuentra sudafrica?','En Africa');
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('En que año Universidad de Chile gano la copa sudamericana?','La gano en 2011');
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('En que año se descubrio AMERICA?','Se descubrio el 12 de octubre de 1492');

--Datos tabla respuesta (intermediaria)
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id) VALUES ('El año tiene 12 meses', 2, 1);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id) VALUES ('El año tiene 11 meses', 4, 1);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id) VALUES ('La copa la gano Chile', 3, 2);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id) VALUES ('Creo que la gano Argentina', 4, 2);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id) VALUES ('Lo siento no veo futbol', 1, 2);

--Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la pregunta)
SELECT usuarios.nombre, COUNT (preguntas.respuesta_correcta) FROM preguntas RIGHT JOIN respuestas ON respuestas.respuesta = preguntas.respuesta_correcta JOIN usuarios ON usuarios.id = respuestas.usuario_id GROUP BY usuario_id,usuarios.nombre;
--Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios tuvieron la respuesta correcta.
SELECT preguntas.pregunta, COUNT(respuestas.usuario_id) FROM respuestas RIGHT JOIN preguntas ON respuestas.pregunta_id = pregunta_id GROUP BY preguntas.pregunta;
--Crea una restricción que impida insertar usuarios menores de 18 años en la base de datos.

ALTER TABLE usuarios ADD CHECK (edad > 18);
--Altera la tabla existente de usuarios agregando el campo email con la restricción de único.

ALTER TABLE usuarios ADD email VARCHAR UNIQUE;