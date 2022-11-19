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
VALUES ('futbol', '2022-12-11', 1 , 2);

SELECT usuarios.nombre, usuarios.email, posts.titulo, posts.contenido 
FROM usuarios
INNER JOIN posts ON usuarios.id=posts.usuario_id;

