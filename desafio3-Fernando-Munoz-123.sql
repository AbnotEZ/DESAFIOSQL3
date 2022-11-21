

REQUERIMIENTOS

1.- CREA Y AGREGA AL ENTREGABLE LAS CONSULTAS PARA COMPLETAR EL SETUP DE ACUERDO A LO PEDIDO.


CREATE DATABASE desafio3_fernando_munoz_958;


CREATE TABLE usuarios (id SERIAL, email VARCHAR(50), nombre VARCHAR(50), apellido VARCHAR(50), rol VARCHAR(50));

INSERT INTO usuarios(email, nombre, apellido, rol)
VALUES ('fernando@gmail.com', 'fernando', 'munoz', 'administrador');
INSERT INTO usuarios(email, nombre, apellido, rol)
VALUES ('valeria@gmail.com', 'valeria', 'pina', 'usuario');
INSERT INTO usuarios(email, nombre, apellido, rol)
VALUES ('renato@gmail.com', 'renato', 'munoz', 'usuario');
INSERT INTO usuarios(email, nombre, apellido, rol)
VALUES ('rafaella@gmail.com', 'rafaella', 'munoz', 'usuario');
INSERT INTO usuarios(email, nombre, apellido, rol)
VALUES ('maria@gmail.com', 'maria', 'cAStaneda', 'usuario');

CREATE TABLE posts (id SERIAL, titulo VARCHAR, cONtenido TEXT, fecha_creaciON TIMESTAMP, fecha_actualizaciON TIMESTAMP, destacado BOOLEAN, usuario_id BIGINT);

INSERT INTO posts(titulo, cONtenido, fecha_creaciON, fecha_actualizaciON, destacado, usuario_id)
VALUES ('cocina', 'verdurAS', '2022-11-08','2022-11-18', 'true', 1);
INSERT INTO posts(titulo, cONtenido, fecha_creaciON, fecha_actualizaciON, destacado, usuario_id)
VALUES ('deportes', 'nataciON', '2022-11-09','2022-11-19', 'false', 1);
INSERT INTO posts(titulo, cONtenido, fecha_creaciON, fecha_actualizaciON, destacado, usuario_id)
VALUES ('informatica', 'software', '2022-11-10','2022-11-20', 'false', 4);
INSERT INTO posts(titulo, cONtenido, fecha_creaciON, fecha_actualizaciON, destacado, usuario_id)
VALUES ('animales', 'perros', '2022-11-11','2022-11-21', 'false', 4);
INSERT INTO posts(titulo, cONtenido, fecha_creaciON, fecha_actualizaciON, destacado, usuario_id)
VALUES ('universo', 'saturno', '2022-11-12','2022-11-22', 'true', NULL);

CREATE TABLE comentarios (id SERIAL, cONtenido TEXT, fecha_creaciON TIMESTAMP, usuario_id BIGINT, post_id BIGINT)

INSERT INTO comentarios (cONtenido, fecha_creaciON, usuario_id, post_id) 
VALUES ('cebolla', '2022-12-08', 1 , 1);
INSERT INTO comentarios (cONtenido, fecha_creaciON, usuario_id, post_id) 
VALUES ('zapallo', '2022-12-09', 2 , 1);
INSERT INTO comentarios (cONtenido, fecha_creaciON, usuario_id, post_id) 
VALUES ('lentejAS', '2022-12-10', 3 , 1);
INSERT INTO comentarios (cONtenido, fecha_creaciON, usuario_id, post_id) 
VALUES ('voley', '2022-12-11', 1 , 2);
INSERT INTO comentarios (cONtenido, fecha_creaciON, usuario_id, post_id) 
VALUES ('futbol', '2022-12-12', 1 , 2);

2.- CRUZA LOS DATOS DE LA TABLA USUARIS Y POSTS MOSTRANDO LAS SIGUIENTES COLUMNAS. NOMBRE E EMAIL DEL USUARIO JUNTO AL TITULO Y CONTENIDO DEL POST.

SELECT usuarios.nombre, usuarios.email, posts.titulo, posts.cONtenido 
FROM usuarios
INNER JOIN posts ON usuarios.id=posts.usuario_id;

3.- MUESTRA EL ID, TITULO, Y CONTENIDO DE LOS POSTS DE LOS ADMINISTRADORES. EL ADMINISTRADOR PUEDE SER CUALQUIER ID Y DEBE SER SELECCIONADO DINAMINACAMENTE.

SELECT usuarios.id, posts.titulo, posts.cONtenido 
FROM usuarios
JOIN posts ON usuarios.id=posts.usuario_id
WHERE usuarios.rol = 'administrador';

4.- CUENTA LA CANTIDAD DE POSTS DE CADA USUARIO. LA TABLA RESULTANTE DEBE MOSTRAR EL ID E EMAIL DEL USUARIO JUNTO CON LA CANTIDAD DE POSTS DE CADA USUARIO.

SELECT usuarios.id, usuarios.email,
count(posts.usuario_id) 
FROM usuarios 
LEFT JOIN posts ON usuarios.id = posts.usuario_id
GROUP BY posts.usuario_id, usuarios.id, usuarios.email;

5.- MUESTRA EL EMAIL DEL USUARIO QUE HA CREADO MAS POSTS. AQUI LA TABLA RESULTANTE TIENE UN UNICO REGISTRO Y MUESTRA SOLO EMAIL.

SELECT usuarios.email 
FROM usuarios  
JOIN posts  
ON usuarios.id = posts.usuario_id 
GROUP BY usuarios.email 
ORDER BY count(posts.id) 
DESC;

6.- Muestra la fecha del último post de cada usuario.

SELECT nombre, MAX(fecha_creaciON) 
FROM (SELECT posts.cONtenido, posts.fecha_creaciON, usuarios.nombre FROM usuarios  JOIN posts  ON usuarios.id = posts.usuario_id) 
AS resultado 
GROUP BY nombre;

7.-  Muestra el título y cONtenido del post (artículo) cON más comentarios. 

SELECT titulo, cONtenido 
FROM posts p JOIN (SELECT post_id, count(post_id) FROM comentarios GROUP BY post_id ORDER BY count(post_id) DESC limit 1) 
AS resultado ON p.id = resultado.post_id;

8.- Muestra en una tabla el título de cada post, el cONtenido de cada post y el cONtenido de cada comentario ASociado a los posts mostrados, junto cON el email del usuario
que lo escribió.

SELECT posts.titulo, posts.cONtenido, comentarios.cONtenido, usuarios.email
FROM comentarios 
JOIN posts ON comentarios.post_id = posts.id
JOIN usuarios  ON usuarios.id = comentarios.usuario_id
ORDER BY posts.id;

9.-  Muestra el cONtenido del último comentario de cada usuario.

SELECT comentarios.fecha_creaciON, comentarios.cONtenido, comentarios.usuario_id 
FROM comentarios
JOIN (SELECT MAX(comentarios.id) AS filtro_id
FROM comentarios GROUP BY usuario_id) AS max_total
ON comentarios.id = max_total.filtro_id
ORDER BY comentarios.usuario_id;

10.- . Muestra los emails de los usuarios que no han escrito ningún comentario.

SELECT usuarios.email 
FROM usuarios 
LEFT JOIN comentarios  
ON usuarios.id = comentarios.usuario_id 
GROUP BY usuarios.email 
HAVING COUNT(comentarios.id) = 0;
