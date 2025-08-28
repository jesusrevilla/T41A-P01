CREATE TABLE estudiante(
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  matricula VARCHAR(4) NOT NULL,
  carrera VARCHAR(20) NOT NULL
);

CREATE TABLE libro(
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(30) NOT NULL,
  autor VARCHAR(50) NOT NULL,
  anio_publicacion INTEGER NOT NULL,
  isbn VARCHAR(14) NOT NULL
);

CREATE TABLE prestamo(
  prestamo_id SERIAL PRIMARY KEY,
  estudiante_id INTEGER REFERENCES estudiante(id) NOT NULL,
  libro_id INTEGER REFERENCES libro(id) NOT NULL,
  fecha_prestamo DATE NOT NULL,
  fecha_devolucion DATE,
  estado VARCHAR(8)
);
