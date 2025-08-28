-- create
CREATE TABLE libro (
  id_libro SERIAL PRIMARY KEY,
  titulo VARCHAR(100) NOT NULL,
  autor VARCHAR(100) NOT NULL,
  anio_publicacion INTEGER NOT NULL,
  isbn VARCHAR(20) UNIQUE
);

CREATE TABLE estudiante (
  id_estudiante SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  matricula VARCHAR(5) UNIQUE NOT NULL,
  carrera VARCHAR(50) NOT NULL
);

CREATE TABLE prestamo (
  id_prestamo SERIAL PRIMARY KEY,
  -- id_libro SERIAL REFERENCES libro(id_libro),
  -- id_estudiante SERIAL REFERENCES estudiante(id_estudiante),
  id_estudiante INTEGER NOT NULL,
  id_libro INTEGER NOT NULL,
  fecha_prestamo DATE NOT NULL,
  fecha_devolucion DATE,
  estado VARCHAR(10) CHECK (estado IN ('activo', 'devuelto')) NOT NULL,
  -- estado BOOLEAN
  CONSTRAINT fk_estudiante FOREIGN KEY (id_estudiante)
    REFERENCES estudiante (id_estudiante)
    ON DELETE CASCADE,
  CONSTRAINT fk_libro FOREIGN KEY (id_libro)
    REFERENCES libro (id_libro)
    ON DELETE CASCADE
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
INSERT INTO prestamo (id_estudiante, id_libro, fecha_prestamo, fecha_devolucion, estado) VALUES
(1, 1, '2025-08-20', NULL, 'activo'),
(2, 2, '2025-08-15', '2025-08-22', 'devuelto'),
(3, 3, '2025-08-10', '2025-08-18', 'devuelto'),
(1, 4, '2025-08-25', NULL, 'activo'),
(4, 2, '2025-08-26', NULL, 'activo');

-- fetch 
SELECT * FROM libro;
SELECT * FROM estudiante;
SELECT * FROM prestamo;

-- 1. Mostrar todos los libros prestados actualmente (estado = 'activo')
SELECT libro.titulo, estudiante.nombre, prestamo.fecha_prestamo
FROM prestamo
JOIN libro ON prestamo.id_libro = libro.id_libro
JOIN estudiante ON prestamo.id_estudiante = estudiante.id_estudiante
WHERE prestamo.estado = 'activo';

-- 2. Listar los estudiantes que han devuelto al menos un libro
SELECT DISTINCT estudiante.nombre
FROM prestamo
JOIN estudiante ON prestamo.id_estudiante = estudiante.id_estudiante
WHERE prestamo.estado = 'devuelto';

-- 3. Mostrar cuántos libros ha prestado cada estudiante
SELECT estudiante.nombre, COUNT(*) AS total_prestamos
FROM prestamo
JOIN estudiante ON prestamo.id_estudiante = estudiante.id_estudiante
GROUP BY estudiante.nombre;

-- 4. Consultar los libros que nunca han sido prestados
SELECT titulo
FROM Libro
WHERE id_libro NOT IN (
    SELECT id_libro FROM prestamo
);
