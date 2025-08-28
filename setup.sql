CREATE TABLE estudiante (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(20),
    matricula VARCHAR(4) UNIQUE,
    carrera VARCHAR(20) 
);

CREATE TABLE libro (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(100),
    autor VARCHAR(100),
    anio_publicacion INT,
    isbn VARCHAR(20) UNIQUE
);

CREATE TABLE prestamo (
    id SERIAL PRIMARY KEY,
    estudiante_id INT REFERENCES estudiante(id),
    libro_id INT REFERENCES libro(id),
    fecha_prestamo DATE,
    fecha_devolucion DATE,
    estado VARCHAR(20) CHECK (estado IN ('activo', 'devuelto'))
);

SELECT libro.titulo, estudiante.nombre, prestamo.fecha_prestamo
FROM prestamo
JOIN libro ON prestamo.libro_id = libro.id
JOIN estudiante ON prestamo.estudiante_id = estudiante.id
WHERE prestamo.estado = 'activo';


SELECT DISTINCT estudiante.nombre
FROM prestamo
JOIN estudiante ON prestamo.estudiante_id = estudiante.id
WHERE prestamo.estado = 'devuelto';


SELECT DISTINCT estudiante.nombre
FROM prestamo
JOIN estudiante ON prestamo.estudiante_id = estudiante.id
WHERE prestamo.estado = 'devuelto';

SELECT titulo
FROM libro
WHERE id NOT IN (
    SELECT libro_id FROM prestamo
);
