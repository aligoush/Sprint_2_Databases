SELECT nombre, apellido1, apellido2 FROM universidad.persona WHERE tipo = "alumno" ORDER BY apellido1, apellido2, nombre;
SELECT nombre, apellido1, apellido2 FROM universidad.persona WHERE tipo = "alumno" AND telefono IS NULL;
SELECT nombre, apellido1, apellido2 FROM universidad.persona WHERE tipo = "alumno" AND YEAR(fecha_nacimiento) = 1999;
SELECT nombre, apellido1, apellido2 FROM universidad.persona WHERE tipo = "profesor" AND telefono IS NULL AND nif LIKE '%K';
SELECT * FROM universidad.asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre FROM universidad.profesor pr INNER JOIN universidad.departamento d ON pr.id_departamento = d.id INNER JOIN universidad.persona p ON pr.id_profesor=p.id ORDER BY p.apellido1, p.apellido2, p.nombre;
SELECT a.nombre AS asignatura, c.anyo_inicio, c.anyo_fin FROM universidad.persona p, universidad.asignatura a , universidad.curso_escolar c, universidad.alumno_se_matricula_asignatura al WHERE al.id_alumno = p.id AND al.id_asignatura = a.id AND al.id_curso_escolar = c.id AND p.nif = "26902806M";
SELECT DISTINCT d.nombre AS departament FROM universidad.departamento d INNER JOIN universidad.profesor pr ON d.id = pr.id_departamento INNER JOIN universidad.asignatura a ON pr.id_profesor = a.id_profesor INNER JOIN universidad.grado g ON a.id_grado = g.id WHERE g.nombre = "Grado en Ingeniería Informática (Plan 2015)"; 
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2 FROM universidad.persona p INNER JOIN universidad.alumno_se_matricula_asignatura al ON p.id = al.id_alumno INNER JOIN universidad.curso_escolar c ON al.id_curso_escolar = c.id WHERE c.anyo_inicio = 2018 AND c.anyo_fin = 2019;
SELECT d.nombre AS departamento, p.apellido1, p.apellido2, p.nombre FROM universidad.persona p RIGHT JOIN universidad.profesor pr ON p.id = pr.id_profesor LEFT JOIN universidad.departamento d ON pr.id_departamento = d.id ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;
SELECT d.nombre AS departamento, p.apellido1, p.apellido2, p.nombre FROM universidad.persona p RIGHT JOIN universidad.profesor pr ON p.id = pr.id_profesor LEFT JOIN universidad.departamento d ON pr.id_departamento = d.id WHERE pr.id_departamento IS NULL;
SELECT d.nombre AS departamento FROM universidad.departamento d LEFT JOIN universidad.profesor pr ON d.id = pr.id_departamento WHERE pr.id_profesor IS NULL;
SELECT p.id, p.nombre, p.apellido1, p.apellido2 FROM universidad.persona p RIGHT JOIN universidad.profesor pr ON p.id = pr.id_profesor LEFT JOIN universidad.asignatura a ON pr.id_profesor = a.id_profesor WHERE a.id_profesor IS NULL;
SELECT a.nombre AS asignatura FROM universidad.asignatura a LEFT JOIN universidad.profesor pr ON a.id_profesor = pr.id_profesor WHERE a.id_profesor IS NULL ORDER BY a.nombre;
SELECT DISTINCT d.nombre AS departamento FROM universidad.departamento d LEFT JOIN universidad.profesor pr ON d.id = pr.id_departamento LEFT JOIN universidad.asignatura a ON a.id_profesor = pr.id_profesor WHERE a.curso IS NULL;
SELECT COUNT(id) FROM universidad.persona WHERE tipo = "alumno";
SELECT COUNT(id) FROM universidad.persona WHERE tipo = "alumno" AND YEAR(fecha_nacimiento) = 1999;
SELECT d.nombre AS departamento, COUNT(pr.id_profesor) AS profesores FROM universidad.departamento d RIGHT JOIN universidad.profesor pr ON d.id = pr.id_departamento GROUP BY d.id ORDER BY profesores DESC;
SELECT d.nombre AS departamento, COUNT(pr.id_profesor) AS profesores FROM universidad.departamento d LEFT JOIN universidad.profesor pr ON d.id = pr.id_departamento GROUP BY d.id ORDER BY profesores DESC;
SELECT g.nombre AS grado, COUNT(a.id) AS asignaturas from universidad.grado g LEFT JOIN universidad.asignatura a ON g.id = a.id_grado GROUP BY g.id ORDER BY asignaturas DESC;
SELECT g.nombre AS grado, COUNT(a.id) AS asignaturas from universidad.grado g LEFT JOIN universidad.asignatura a ON g.id = a.id_grado GROUP BY g.id HAVING asignaturas > 40 ORDER BY asignaturas DESC;
SELECT g.nombre AS grado, a.tipo AS tipo, SUM(a.creditos) AS créditos from universidad.grado g RIGHT JOIN universidad.asignatura a ON g.id = a.id_grado GROUP BY g.id, a.tipo ORDER BY créditos DESC;
SELECT c.anyo_inicio, COUNT(al.id_alumno) AS alumnos FROM universidad.curso_escolar c RIGHT JOIN universidad.alumno_se_matricula_asignatura al ON c.id = al.id_curso_escolar GROUP BY c.id;
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS asignaturas FROM universidad.persona p RIGHT JOIN universidad.profesor pr ON p.id = pr.id_profesor LEFT JOIN universidad.asignatura a ON pr.id_profesor = a.id_profesor GROUP BY pr.id_profesor ORDER BY asignaturas DESC; 
SELECT * FROM universidad.persona p WHERE p.tipo = "alumno" AND YEAR(p.fecha_nacimiento) = (SELECT MAX(YEAR(fecha_nacimiento)) FROM universidad.persona WHERE tipo = "alumno"); -- SELECT * FROM persona p WHERE tipo='alumno' ORDER BY fecha_nacimiento DESC LIMIT 1; 
SELECT p.id, p.nombre, p.apellido1, p.apellido2 FROM universidad.persona p RIGHT JOIN universidad.profesor pr ON p.id = pr.id_profesor LEFT JOIN universidad.asignatura a ON pr.id_profesor = a.id_profesor WHERE pr.id_departamento IS NOT NULL AND a.id_profesor IS NULL;
-- SELECT p.nombre, p.apellido1, p.apellido2 FROM universidad.persona p JOIN universidad.profesor pr ON p.id=pr.id_profesor JOIN universidad.departamento d ON pr.id_departamento=d.id LEFT JOIN universidad.asignatura asig ON pr.id_profesor=asig.id_profesor GROUP BY p.id HAVING COUNT(asig.id)=0;


