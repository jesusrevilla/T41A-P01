CREATE TABLE libro(
  id SERIAL PRIMARY KEY,
  titulo text not null,
  autor text not null,
  anio_publicacion INTEGER not null,
  isbn text not null

);

CREATE TABLE estudiante(
  id SERIAL PRIMARY KEY,
  nombre text not null,
  matricula text not null,
  carrera text not null
);

CREATE TABLE prestamo(
  id_prestamo SERIAL PRIMARY KEY,
  estudiante_id INTEGER REFERENCES estudiante(id) not null,
  libro_id INTEGER REFERENCES libro(id) not null,
  fecha_prestamo DATE NOT NULL,
  fecha_devolucion DATE,
  estado varchar(16) 

);
