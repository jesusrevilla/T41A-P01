CREATE TABLE estudiante (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(20),
    matricula VARCHAR(4),
    carrera VARCHAR(20)
);

CREATE TABLE libro (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(100),
    autor VARCHAR(100),
    anio_publicacion INT,
    isbn VARCHAR(20)
);

CREATE TABLE prestamo (
    id SERIAL PRIMARY KEY,
    estudiante_id INT REFERENCES estudiante(id),
    libro_id INT REFERENCES libro(id),
    fecha_prestamo DATE,
    fecha_devolucion DATE,
    estado VARCHAR(20) CHECK (estado IN ('activo', 'devuelto'))
);
