CREATE TABLE libro (
  id SERIAL PRIMARY KEY,
  titulo TEXT,
  autor TEXT,
  anio_publicacion INTEGER,
  isbn TEXT
);
CREATE TABLE estudiante(
  id SERIAL PRIMARY KEY,
  nombre TEXT,
  matricula TEXT,
  carrera TEXT
);
CREATE TABLE prestamo(
  estudiante_id INT,
  libro_id INT,
  fecha_prestamo DATE,
  fecha_devolucion DATE,
  estado TEXT,
  FOREIGN KEY (estudiante_id) REFERENCES estudiante(id),
  FOREIGN KEY (libro_id) REFERENCES libro(id)
);
-- Insertar estudiantes
INSERT INTO estudiante (nombre, matricula, carrera) VALUES
('Ana Torres', 'A001', 'Ingeniería'),
('Luis Gómez', 'A002', 'Derecho'),
('María López', 'A003', 'Medicina'),
('Carlos Ruiz', 'A004', 'Arquitectura'),
('Sofía Méndez', 'A005', 'Psicología');

-- Insertar libros
INSERT INTO libro (titulo, autor, anio_publicacion, isbn) VALUES
('Cien años de soledad', 'Gabriel García Márquez', 1967, '978-0307474728'),
('El Principito', 'Antoine de Saint-Exupéry', 1943, '978-0156013987'),
('1984', 'George Orwell', 1949, '978-0451524935'),
('La Odisea', 'Homero', -800, '978-0140268867'),
('Rayuela', 'Julio Cortázar', 1963, '978-8437604947');

-- Insertar préstamos

INSERT INTO prestamo (estudiante_id, libro_id, fecha_prestamo, fecha_devolucion, estado) VALUES
(1, 1, '2025-08-20', NULL, 'activo'),
(2, 2, '2025-08-15', '2025-08-22', 'devuelto'),
(3, 3, '2025-08-10', '2025-08-18', 'devuelto'),
(1, 4, '2025-08-25', NULL, 'activo'),
(4, 2, '2025-08-26', NULL, 'activo');

-- 1. Mostrar todos los libros prestados actualmente (estado = 'activo')
SELECT libro.titulo, estudiante.nombre, prestamo.fecha_prestamo
FROM prestamo
JOIN libro ON prestamo.libro_id = libro.id
JOIN estudiante ON prestamo.estudiante_id = estudiante.id
WHERE prestamo.estado = 'activo';

-- 2. Listar los estudiantes que han devuelto al menos un libro
SELECT DISTINCT estudiante.nombre
FROM prestamo
JOIN estudiante ON prestamo.estudiante_id = estudiante.id
WHERE prestamo.estado = 'devuelto';

-- 3. Mostrar cuántos libros ha prestado cada estudiante
SELECT estudiante.nombre, COUNT(*) AS total_prestamos
FROM prestamo
JOIN estudiante ON prestamo.estudiante_id = estudiante.id
GROUP BY estudiante.nombre;

-- 4. Consultar los libros que nunca han sido prestados
SELECT titulo
FROM Libro
WHERE id NOT IN (
    SELECT libro_id FROM prestamo
);

