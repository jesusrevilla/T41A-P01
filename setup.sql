CREATE TABLE estudiante (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    carrera VARCHAR(50) NOT NULL
);

CREATE TABLE libro (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    anio_publicacion INT,
    isbn VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE prestamo (
    id SERIAL PRIMARY KEY,
    estudiante_id INT NOT NULL,
    libro_id INT NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE,
    estado VARCHAR(20) CHECK (estado IN ('activo', 'devuelto')),
    FOREIGN KEY (estudiante_id) REFERENCES estudiante (id),
    FOREIGN KEY (libro_id) REFERENCES libro (id)
);
INSERT INTO estudiante (nombre, matricula, carrera) VALUES
('Ana Torres', 'A001', 'Ingeniería'),
('Luis Gómez', 'A002', 'Derecho'),
('María López', 'A003', 'Medicina'),
('Carlos Ruiz', 'A004', 'Arquitectura'),
('Sofía Méndez', 'A005', 'Psicología');

INSERT INTO libro (titulo, autor, anio_publicacion, isbn) VALUES
('Cien años de soledad', 'Gabriel García Márquez', 1967, '978-0307474728'),
('El Principito', 'Antoine de Saint-Exupéry', 1943, '978-0156013987'),
('1984', 'George Orwell', 1949, '978-0451524935'),
('La Odisea', 'Homero', -800, '978-0140268867'),
('Rayuela', 'Julio Cortázar', 1963, '978-8437604947');


INSERT INTO prestamo (estudiante_id, libro_id, fecha_prestamo, fecha_devolucion, estado) VALUES
(1, 1, '2025-08-20', NULL, 'activo'),
(2, 2, '2025-08-15', '2025-08-22', 'devuelto'),
(3, 3, '2025-08-10', '2025-08-18', 'devuelto'),
(1, 4, '2025-08-25', NULL, 'activo'),
(4, 2, '2025-08-26', NULL, 'activo');

SELECT libro.titulo, estudiante.nombre, prestamo.fecha_prestamo
FROM prestamo
JOIN libro ON prestamo.libro_id = libro.id
JOIN estudiante ON prestamo.estudiante_id = estudiante.id
WHERE prestamo.estado = 'activo';

SELECT DISTINCT estudiante.nombre
FROM prestamo
JOIN estudiante ON prestamo.estudiante_id = estudiante.id
WHERE prestamo.estado = 'devuelto';

SELECT estudiante.nombre, COUNT(*) AS total_prestamos
FROM prestamo
JOIN estudiante ON prestamo.estudiante_id = estudiante.id
GROUP BY estudiante.nombre;

SELECT titulo
FROM Libro
WHERE id NOT IN (
    SELECT libro_id FROM prestamo
);
