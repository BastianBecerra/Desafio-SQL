--Inicio script
Create DATABASE desafio_3_Bastian_Becerra_147;

--Tabla

CREATE TABLE usuarios(
    id SERIAL,
    email VARCHAR,
    nombre VARCHAR,
    apellido VARCHAR,
    rol VARCHAR
);

--Usuarios

INSERT INTO usuarios(email, nombre, apellido, rol) VALUES ('bastian@gmail.com', 'Bastian', 'Becerra', 'Administrador');

INSERT INTO usuarios(email, nombre, apellido, rol) VALUES ('daniel@gmail.com', 'Daniel', 'Becerra', 'Usuario');

INSERT INTO usuarios(email, nombre, apellido, rol) VALUES ('francisco@gmail.com', 'Francisco', 'Becerra', 'Usuario');

INSERT INTO usuarios(email, nombre, apellido, rol) VALUES ('diego@gmail.com', 'Diego', 'Becerra', 'Usuario');

INSERT INTO usuarios(email, nombre, apellido, rol) VALUES ('constanza@gmail.com', 'Constanza', 'Becerra', 'Usuario');

--Tabla Articulos

CREATE TABLE articulos(
    id SERIAL,
    titulo VARCHAR,
    contenido TEXT,
    fecha_creacion TIMESTAMP,
    fecha_actualizacion TIMESTAMP,
    destacado BOOLEAN,
    usuario_id BIGINT
);

--Contenido Articulos

INSERT INTO articulos (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id) VALUES ('Buenas!', 'Como se encuentran?', '07/01/2022', '05/08/2023', true, 1);

INSERT INTO articulos (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id) VALUES ('Feliz fiesta!', 'Feliz Dieciocho desde Portugal ', '28/09/2023', '05/08/2024', true, 2);

INSERT INTO articulos (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id) VALUES ('Hola a todoos!', 'Ya fueron a ver la final del mundial?', '29/11/2022', '05/12/2022', true, 3);

INSERT INTO articulos (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id) VALUES ('Ya vieron el juego nuevo!', 'Salio un nuevo juego de guerra se ve bueno', '26/02/2025', '16/07/2026', true, 4);

INSERT INTO articulos (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id) VALUES ('Ya terminaron el cuerso?', 'Como estan?, ya terminaron el curso que estaban realizando?', '31/03/2022', '16/05/2023', true);


--Comentarios

CREATE TABLE comentarios(
    id SERIAL,
    contenido TEXT,
    fecha_creacion TIMESTAMP,
    usuario_id BIGINT,
    post_id BIGINT
);

--Comentarios2
INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, post_id) VALUES ('Bien super!!!', '18/01/2023', 1, 1);

INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, post_id) VALUES ('Feliz Dieciocho tambien', '28/09/2025', 2, 1);

INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, post_id) VALUES ('No no logre ver la final!', '29/05/2024', 3, 1);

INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, post_id) VALUES ('No aun queda lo ultimo', '26/03/2023', 1, 2);

INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, post_id) VALUES ('Feliz Navidad', '25/12/2024', 2, 2);

--Parte 2

--Cruza los datos de la tabla usuarios y posts mostrando las siguientes columnas. nombre e email del usuario junto al título y contenido del post.

SELECT usuarios.nombre, usuarios.email, articulos.titulo, articulos.contenido FROM usuarios INNER JOIN articulos ON usuarios.id = articulos.usuario_id;

--Muestra el id, título y contenido de los posts de los administradores. El administrador puede ser cualquier id y debe ser seleccionado dinámicamente.

SELECT articulos.id, articulos.titulo, articulos.contenido FROM articulos INNER JOIN usuarios ON usuarios.id = articulos.usuario_id WHERE rol = 'Administrador';

--Cuenta la cantidad de posts de cada usuario. La tabla resultante debe mostrar el id e email del usuario junto con la cantidad de posts de cada usuario.
--Hint importante: Aquí hay diferencia entre utilizar inner join, left join o right join, prueba con todas y con eso determina cual es la correcta. No da lo mismo desde cual tabla partes.

SELECT usuarios.id, usuarios.email, count(articulos.id) FROM usuarios LEFT JOIN articulos ON usuarios.id = articulos.usuario_id GROUP BY usuarios.id, usuarios.email;

--Muestra el email del usuario que ha creado más posts. Aquí la tabla resultante tiene un único registro y muestra solo el email.

SELECT usuarios.email, count(articulos.id) AS contadorarticulos FROM usuarios INNER JOIN articulos ON usuarios.id = articulos.usuario_id GROUP BY usuarios.email ORDER BY contadorarticulos DESC LIMIT 1;

--Muestra la fecha del último post de cada usuario.

SELECT usuarios.nombre, MAX(articulos.fecha_creacion) AS ultimopost FROM usuarios INNER JOIN articulos ON usuarios.id = articulos.id GROUP BY usuarios.nombre

--Muestra el título y contenido del post (artículo) con más comentarios.

SELECT titulo, contenido FROM articulos JOIN (SELECT post_id, COUNT(post_id) FROM comentarios GROUP BY post_id ORDER BY count DESC LIMIT 1) AS c ON articulos.id = c.post_id;

