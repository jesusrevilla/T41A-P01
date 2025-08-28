 
 
CREATE TABLE ASISTENCIAS(
  id SERIAL PRIMARY KEY,
  matricula INTEGER NOT NULL,
  asistencia TIMESTAMP NOT NULL
);
 
CREATE TABLE INSCRIPCION(
  periodo TEXT NOT NULL,
  seccion TEXT NOT NULL,
  matricula INTEGER NOT NULL,
  alumno TEXT NOT NULL
);


CREATE TABLE tipos_datos(
  tipos_datos_id SERIAL PRIMARY KEY,
  caracter CHAR(1) NOT NULL,
  caracteres CHAR(3) NOT NULL,
  nombre VARCHAR(10) NOT NULL,
  comentarios TEXT NOT NULL
);

INSERT INTO tipos_datos (caracter,caracteres,nombre,comentarios)
  VALUES ('S','SLP','MAURICIO','COMENTARIO DE PRUEBA');
  
INSERT INTO tipos_datos (caracter,caracteres,nombre,comentarios)
  VALUES ('C','CUU','JUAN','COMENTARIO DE PRUEBA 2');

  
  
SELECT * FROM tipos_datos;

INSERT INTO tipos_datos (caracter,caracteres,nombre,comentarios)
  VALUES ('C','CU','PABLO','COMENTARIO DE PRUEBA 3');

SELECT * FROM tipos_datos;


CREATE TABLE tipos_numericos(
  tipos_numericos_id SERIAL PRIMARY KEY,
  entero INTEGER NOT NULL,
  dec DECIMAL(5,2) NOT NULL
);

INSERT INTO tipos_numericos VALUES (3,123, 123.56);

SELECT * FROM tipos_numericos;


CREATE TABLE tipo_tiempo(
  tipo_tiempo_id SERIAL PRIMARY KEY,
  tiempo TIME NOT NULL,
  fecha DATE NOT NULL,
  fecha_hora TIMESTAMP NOT NULL
);

INSERT INTO tipo_tiempo (tiempo, fecha, fecha_hora)
  VALUES (CURRENT_TIME, CURRENT_DATE, CURRENT_TIMESTAMP);


SELECT * FROM tipo_tiempo
