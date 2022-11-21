

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
VALUES ('maria@gmail.com', 'maria', 'castaneda', 'usuario');

CREATE TABLE posts (id SERIAL, titulo VARCHAR, contenido TEXT, fecha_creacion TIMESTAMP, fecha_actualizacion TIMESTAMP, destacado BOOLEAN, usuario_id BIGINT);

INSERT INTO posts(titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
VALUES ('cocina', 'verduras', '2022-11-08','2022-11-18', 'true', 1);
INSERT INTO posts(titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
VALUES ('deportes', 'natacion', '2022-11-09','2022-11-19', 'false', 1);
INSERT INTO posts(titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
VALUES ('informatica', 'software', '2022-11-10','2022-11-20', 'false', 4);
INSERT INTO posts(titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
VALUES ('animales', 'perros', '2022-11-11','2022-11-21', 'false', 4);
INSERT INTO posts(titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
VALUES ('universo', 'saturno', '2022-11-12','2022-11-22', 'true', NULL);

CREATE TABLE comentarios (id SERIAL, contenido TEXT, fecha_creacion TIMESTAMP, usuario_id BIGINT, post_id BIGINT)

INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, post_id) 
VALUES ('cebolla', '2022-12-08', 1 , 1);
INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, post_id) 
VALUES ('zapallo', '2022-12-09', 2 , 1);
INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, post_id) 
VALUES ('lentejas', '2022-12-10', 3 , 1);
INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, post_id) 
VALUES ('voley', '2022-12-11', 1 , 2);
INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, post_id) 
VALUES ('futbol', '2022-12-12', 1 , 2);

2.- CRUZA LOS DATOS DE LA TABLA USUARIS Y POSTS MOSTRANDO LAS SIGUIENTES COLUMNAS. NOMBRE E EMAIL DEL USUARIO JUNTO AL TITULO Y CONTENIDO DEL POST.

SELECT usuarios.nombre, usuarios.email, posts.titulo, posts.contenido 
FROM usuarios
INNER JOIN posts ON usuarios.id=posts.usuario_id;

3.- MUESTRA EL ID, TITULO, Y CONTENIDO DE LOS POSTS DE LOS ADMINISTRADORES. EL ADMINISTRADOR PUEDE SER CUALQUIER ID Y DEBE SER SELECCIONADO DINAMINACAMENTE.

SELECT usuarios.id, posts.titulo, posts.contenido 
FROM usuarios
INNER JOIN posts ON usuarios.id=posts.usuario_id
WHERE usuarios.rol = 'administrador';

4.- CUENTA LA CANTIDAD DE POSTS DE CADA USUARIO. LA TABLA RESULTANTE DEBE MOSTRAR EL ID E EMAIL DEL USUARIO JUNTO CON LA CANTIDAD DE POSTS DE CADA USUARIO.

SELECT usuarios.id, usuarios.email,
count(posts.usuario_id) 
FROM usuarios 
LEFT JOIN posts ON usuarios.id = posts.usuario_id
GROUP BY posts.usuario_id, usuarios.id, usuarios.email;

5.- MUESTRA EL EMAIL DEL USUARIO QUE HA CREADO MAS POSTS. AQUI LA TABLA RESULTANTE TIENE UN UNICO REGISTRO Y MUESTRA SOLO EMAIL.

SELECT usuarios.email 
from usuarios  
join posts  
on usuarios.id = posts.usuario_id 
group by usuarios.email 
order by count(posts.id) 
desc;

6.- Muestra la fecha del último post de cada usuario.

SELECT nombre, MAX(fecha_creacion) 
from (SELECT posts.contenido, posts.fecha_creacion, usuarios.nombre from usuarios  join posts  on usuarios.id = posts.usuario_id) 
as resultado 
group by nombre;

7.-  Muestra el título y contenido del post (artículo) con más comentarios. 

SELECT titulo, contenido 
from posts p join (SELECT post_id, count(post_id) FROM comentarios group by post_id order by count(post_id) desc limit 1) 
as resultado on p.id = resultado.post_id;

8.- Muestra en una tabla el título de cada post, el contenido de cada post y el contenido de cada comentario asociado a los posts mostrados, junto con el email del usuario
que lo escribió.

SELECT posts.titulo, posts.contenido, comentarios.contenido, usuarios.email
FROM comentarios 
JOIN posts ON comentarios.post_id = posts.id
JOIN usuarios  ON usuarios.id = comentarios.usuario_id
ORDER BY posts.id;

9.-  Muestra el contenido del último comentario de cada usuario.

SELECT comentarios.fecha_creacion, comentarios.contenido, comentarios.usuario_id 
FROM comentarios
JOIN (SELECT max(comentarios.id) AS filtro_id
FROM comentarios GROUP BY usuario_id) AS max_total
ON comentarios.id = max_total.filtro_id
ORDER BY comentarios.usuario_id;

10.- . Muestra los emails de los usuarios que no han escrito ningún comentario.

SELECT usuarios.email 
from usuarios 
left join comentarios  
on usuarios.id = comentarios.usuario_id 
group by usuarios.email 
HAVING count(comentarios.id) = 0;
