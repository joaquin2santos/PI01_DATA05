-- crear la base de datos proyecto

DROP DATABASE if EXISTS proyecto;
CREATE DATABASE   proyecto;
USE  proyecto;


-- crear la tabla para ingestar los csv 
-- amazon
DROP TABLE IF EXISTS pelis_amazon;
CREATE TABLE pelis_amazon(
		IdMovie  VARCHAR(5),
        Type		VARCHAR(50),
        Title		VARCHAR(150),	
        Director	TEXT,
        Cast		TEXT,
        Country  VARCHAR(150),
        Date_Added  VARCHAR(50),
        Release_Year  INT,
        rating		VARCHAR(50),
        Duration		VARCHAR(50),
        Listed_In   VARCHAR(150),
        Description 	TEXT
        ) ENGINE= InnoDB DEFAULT CHARSET= utf8mb4 COLLATE= utf8mb4_spanish_ci;

-- carga amazon
LOAD DATA  INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Amazon_prime_titles.csv'
INTO TABLE pelis_amazon FIELDS TERMINATED BY',' ENCLOSED BY '\"' ESCAPED BY ''
LINES TERMINATED BY '\r\n' IGNORE 1 LINES; 

-- chequear  duplicados 
SELECT DISTINCT type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description FROM pelis_amazon;
SELECT  type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description FROM pelis_amazon;



-- tabla disney 
DROP TABLE IF EXISTS pelis_disney;
CREATE TABLE pelis_disney(
		IdMovie  VARCHAR(5),
        Type		VARCHAR(50),
        Title		VARCHAR(150),	
        Director	TEXT,
        Cast		TEXT,
        Country  VARCHAR(150),
        Date_Added  VARCHAR(50),
        Release_Year  INT,
        rating		VARCHAR(50),
        Duration		VARCHAR(50),
        Listed_In   VARCHAR(150),
        Description 	TEXT
        ) ENGINE= InnoDB DEFAULT CHARSET= utf8mb4 COLLATE= utf8mb4_spanish_ci;
-- carga disney
LOAD DATA  INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\disney_plus_titles.csv'
INTO TABLE pelis_disney FIELDS TERMINATED BY',' ENCLOSED BY '\"' ESCAPED BY ''
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

-- chequear  duplicados 
SELECT DISTINCT type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description FROM pelis_disney;
SELECT  type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description FROM pelis_disney;

-- tabla hulu
DROP TABLE IF EXISTS pelis_hulu;
CREATE TABLE pelis_hulu(
		IdMovie  VARCHAR(5),
        Type		VARCHAR(50),
        Title		VARCHAR(150),	
        Director	TEXT,
        Cast		TEXT,
        Country  VARCHAR(150),
        Date_Added  VARCHAR(50),
        Release_Year  INT,
        rating		VARCHAR(50),
        Duration		VARCHAR(50),
        Listed_In   VARCHAR(150),
        Description 	TEXT
        ) ENGINE= InnoDB DEFAULT CHARSET= utf8mb4 COLLATE= utf8mb4_spanish_ci;
-- carga  hulu 
LOAD DATA  INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\hulu_titles.csv'
INTO TABLE pelis_hulu FIELDS TERMINATED BY',' ENCLOSED BY '\"' ESCAPED BY ''
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

-- chequear  duplicados 
SELECT DISTINCT type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description FROM pelis_hulu;
SELECT  type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description FROM pelis_hulu;


-- carga de netlix convertido de json a csv en python 
DROP TABLE IF EXISTS pelis_netflix;
CREATE TABLE pelis_netflix(
		IdMovie  VARCHAR(5),
        Type		VARCHAR(50),
        Title		VARCHAR(150),	
        Director	TEXT,
        Cast		TEXT,
        Country  VARCHAR(150),
        Date_Added  VARCHAR(50),
        Release_Year  INT,
        rating		VARCHAR(50),
        Duration		VARCHAR(50),
        Listed_In   VARCHAR(150),
        Description 	TEXT
        ) ENGINE= InnoDB DEFAULT CHARSET= utf8mb4 COLLATE= utf8mb4_spanish_ci;

-- carga netflix

LOAD DATA  INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\netflix_titles3.csv'
INTO TABLE pelis_netflix FIELDS TERMINATED BY',' ENCLOSED BY '\"' ESCAPED BY ''
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

-- chequear  duplicados 
SELECT DISTINCT type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description FROM pelis_netflix;
SELECT  type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description FROM pelis_netflix;

-- crear la tabla de peliculas general
DROP TABLE IF EXISTS peliculas;
CREATE TABLE peliculas (
		idmovie  INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        type		VARCHAR(50),
        title		VARCHAR(150),	
        director	TEXT,
        cast		TEXT,
        country  VARCHAR(200),
        date_added  VARCHAR(50),
        release_year  INT,
        rating		VARCHAR(50),
        duration		VARCHAR(50),
        listed_in   VARCHAR(150),
        description 	TEXT,
        plataforma VARCHAR (20)
        ) ENGINE= InnoDB DEFAULT CHARSET= utf8mb4 COLLATE= utf8mb4_spanish_ci;

-- cargar tablas de peliculas para quedar con el maestro de peliculas
INSERT INTO peliculas(type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description, plataforma)
SELECT  type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description, 'amazon' FROM pelis_amazon
UNION 
SELECT  type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description, 'disney' FROM pelis_disney
UNION 
SELECT  type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description, 'hulu' FROM pelis_hulu
UNION 
SELECT  type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description, 'netflix' FROM pelis_netflix;


-- sumar una columna para limpìar 'duration' 

ALTER TABLE peliculas DROP COLUMN  duration2 ;
ALTER TABLE peliculas   ADD COLUMN duration2 VARCHAR(15) AFTER duration;

--  activar permisos de update/delete SHOW VARIABLES LIKE "secure_file_priv";
SET SQL_SAFE_UPDATES = 0; -- SET SQL_SAFE_UPDATES = 1;

-- cargar valores en la columna copia, completar con valores faltantes que estaban en rating
UPDATE peliculas SET duration2 = duration;
UPDATE peliculas SET duration2 = rating WHERE rating LIKE '%min%' or rating LIKE '%Season%';
UPDATE peliculas SET duration2 = TRIM(REPLACE(duration2, ' Season',''));
UPDATE peliculas SET duration2 = TRIM(REPLACE(duration2, 's',''));
UPDATE peliculas SET duration2 = TRIM(REPLACE(duration2, ' min',''));
UPDATE peliculas SET duration2 = REPLACE(duration2, '',NULL) WHERE duration2 = ''; -- REEMPLAZAR ESPACIOS VACIOS CON NULL

-- cambiar el tipo de dato 
ALTER TABLE peliculas CHANGE COLUMN duration2 duration2 INT DEFAULT NULL;
 
-- dropear columna duracion original y reemplazar por la de tipo int 
ALTER TABLE peliculas DROP COLUMN duration;
ALTER TABLE peliculas CHANGE COLUMN duration2 duration INT DEFAULT NULL;

-- sumar  columnas extras para la consigna 2
ALTER TABLE peliculas DROP COLUMN type2;
ALTER TABLE peliculas ADD COLUMN type2 VARCHAR(50) AFTER type ;
ALTER TABLE peliculas DROP COLUMN type3;
ALTER TABLE peliculas ADD COLUMN type3 VARCHAR(50) AFTER type2;

-- cargar datos por separado. dropear type original
UPDATE peliculas SET  type2 = type WHERE type like('%TV Show%');
UPDATE peliculas SET  type3 = type WHERE type like('%Movie%');
ALTER TABLE peliculas DROP COLUMN type;

-- renombrar 
ALTER TABLE peliculas CHANGE COLUMN type2 type_TV VARCHAR(50);
ALTER TABLE peliculas CHANGE COLUMN type3 type_Movie VARCHAR(50);



-- prueba de querys para la api

-- consulta 1
SELECT    title, duration, release_year
FROM peliculas 
WHERE  type_Movie =('Movie') or type_TV = ('TV Show')  and plataforma =('hulu') and release_year= (2018)
ORDER BY duration DESC
LIMIT 1;

 -- consulta 2
SELECT  plataforma, COUNT(type_Movie) as movie, count(type_TV) as tvshow
FROM peliculas
where  plataforma = 'netflix';

-- consulta 3
SELECT  plataforma, COUNT(*) 
FROM ( SELECT * FROM peliculas WHERE listed_in like ('%comedy%') and plataforma = 'amazon') p;

-- consigna 4
SELECT plataforma, count(cast)as cantidad, release_year
FROM (SELECT * FROM peliculas WHERE cast like('%andrea libman%') and release_year =2018 and plataforma='netflix') p;
