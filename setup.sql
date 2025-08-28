
-- ============================================
-- Reto SQL: Gestión de Biblioteca (versión simple)
-- ============================================

-- Limpieza (opcional si vas a re-ejecutar)
DROP INDEX IF EXISTS ux_prestamo_libro_activo;
DROP TABLE IF EXISTS prestamo;
DROP TABLE IF EXISTS libro;
DROP TABLE IF EXISTS estudiante;

-- ============== Parte 2: Tablas ==============

-- Estudiante
CREATE TABLE estudiante (
  id        SERIAL PRIMARY KEY,
  nombre    VARCHAR(100) NOT NULL,
  matricula VARCHAR(20)  NOT NULL UNIQUE,
  carrera   VARCHAR(100) NOT NULL
);

-- Libro
CREATE TABLE libro (
  id               SERIAL PRIMARY KEY,
  titulo           VARCHAR(200) NOT NULL,
  autor            VARCHAR(150) NOT NULL,
  anio_publicacion INT          NOT NULL,  
  isbn             VARCHAR(20)  NOT NULL UNIQUE
);

-- Préstamo
CREATE TABLE prestamo (
  id               SERIAL PRIMARY KEY,
  estudiante_id    INT NOT NULL REFERENCES estudiante(id),
  libro_id         INT NOT NULL REFERENCES libro(id),
  fecha_prestamo   DATE NOT NULL,
  fecha_devolucion DATE,
  estado           VARCHAR(10) NOT NULL CHECK (estado IN ('activo','devuelto'))
);

-- Regla: un libro solo puede estar prestado 1 vez a la vez (solo 1 'activo' por libro)
CREATE UNIQUE INDEX ux_prestamo_libro_activo
  ON prestamo (libro_id)
  WHERE estado = 'activo';

-- ============== Parte 3: Datos ==============

-- Estudiantes
INSERT INTO estudiante (nombre, matricula, carrera) VALUES
('Ana Torres', 'A001', 'Ingeniería'),
('Luis Gómez', 'A002', 'Derecho'),
('María López', 'A003', 'Medicina'),
('Carlos Ruiz', 'A004', 'Arquitectura'),
('Sofía Méndez', 'A005', 'Psicología');

-- Libros
INSERT INTO libro (titulo, autor, anio_publicacion, isbn) VALUES
('Cien años de soledad', 'Gabriel García Márquez', 1967, '978-0307474728'),
('El Principito', 'Antoine de Saint-Exupéry', 1943, '978-0156013987'),
('1984', 'George Orwell', 1949, '978-0451524935'),
('La Odisea', 'Homero', -800, '978-0140268867'),
('Rayuela', 'Julio Cortázar', 1963, '978-8437604947');

-- Préstamos
INSERT INTO prestamo (estudiante_id, libro_id, fecha_prestamo, fecha_devolucion, estado) VALUES
(1, 1, '2025-08-20', NULL, 'activo'),
(2, 2, '2025-08-15', '2025-08-22', 'devuelto'),
(3, 3, '2025-08-10', '2025-08-18', 'devuelto'),
(1, 4, '2025-08-25', NULL, 'activo'),
(4, 2, '2025-08-26', NULL, 'activo');

-- ============== Parte 4: Consultas ==============

-- 1) Libros prestados actualmente (estado='activo')
SELECT l.titulo, e.nombre, p.fecha_prestamo
FROM prestamo p
JOIN libro l      ON p.libro_id = l.id
JOIN estudiante e ON p.estudiante_id = e.id
WHERE p.estado = 'activo';

-- 2) Estudiantes que han devuelto al menos un libro
SELECT DISTINCT e.nombre
FROM prestamo p
JOIN estudiante e ON p.estudiante_id = e.id
WHERE p.estado = 'devuelto';

-- 3) Cuántos libros se han prestado a cada estudiante
SELECT e.nombre, COUNT(*) AS total_prestamos
FROM prestamo p
JOIN estudiante e ON p.estudiante_id = e.id
GROUP BY e.nombre
ORDER BY total_prestamos DESC, e.nombre;

-- 4) Libros que nunca han sido prestados
SELECT l.titulo
FROM libro l
LEFT JOIN prestamo p ON p.libro_id = l.id
WHERE p.id IS NULL;
