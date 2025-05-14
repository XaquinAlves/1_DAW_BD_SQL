START TRANSACTION;
INSERT INTO norm_juego (nombre, precio_juego)
VALUES ('Alan Wake 2', 80);
SET @id_juego = LAST_INSERT_ID();
INSERT INTO norm_logro (nombre_logro, valor, id_juego)
VALUES ('Bienvenido a Salt Lake City', 5, @id_juego);
INSERT INTO norm_rel_logro_jugador (id_jugador, id_logro, fecha_obtencion)