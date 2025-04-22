DROP DATABASE IF EXISTS bd_peliculas;
CREATE DATABASE bd_peliculas CHARACTER SET=utf8mb4 COLLATE utf8mb4_unicode_520_ci;
USE bd_peliculas;

CREATE TABLE peliculas(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    director VARCHAR(100) NOT NULL
)ENGINE = InnoDB;

INSERT INTO peliculas (titulo, director) VALUES
('El Padrino', 'Francis Ford Coppola'),
('El Padrino II', 'Francis Ford Coppola'),
('El Padrino III', 'Francis Ford Coppola'),
('La lista de Schindler', 'Steven Spielberg'),
('El silencio de los corderos', 'Jonathan Demme'),
('El imperio contraataca', 'Irvin Kershner'),
('Cadena perpetua', 'Frank Darabont'),
('El viaje de Chihiro', 'Hayao Miyazaki'),
('Los siete samurais', 'Akira Kurosawa'),
('El club de la lucha', 'David Fincher');