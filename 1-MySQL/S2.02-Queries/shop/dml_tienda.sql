SELECT nombre FROM tienda.producto;
SELECT nombre, precio FROM tienda.producto;
SELECT * FROM tienda.producto;
SELECT nombre, precio AS `precio (€)`, precio*1.09 AS `precio (USD)` FROM tienda.producto;
SELECT nombre AS `nombre del producto`, precio AS euros, precio*1.09 AS dólares FROM tienda.producto;
SELECT UPPER(nombre) AS nombre, precio FROM tienda.producto;
SELECT LOWER(nombre) AS nombre, precio FROM tienda.producto;
SELECT nombre, UPPER(SUBSTRING(nombre,1,2)) AS `iniciales` FROM tienda.fabricante;
SELECT nombre, ROUND(precio) AS `precio (€)` FROM tienda.producto;
SELECT nombre, TRUNCATE(precio, 0) AS `precio (€)` FROM tienda.producto;
SELECT codigo_fabricante FROM tienda.producto;
SELECT DISTINCT codigo_fabricante FROM tienda.producto;
SELECT nombre FROM tienda.fabricante ORDER BY nombre;
SELECT nombre FROM tienda.fabricante ORDER BY nombre DESC;
SELECT nombre, precio FROM tienda.producto ORDER BY nombre ASC, precio DESC; 
SELECT * FROM tienda.fabricante LIMIT 5;
SELECT * FROM tienda.fabricante LIMIT 2 OFFSET 3;
SELECT nombre, precio FROM tienda.producto ORDER BY precio ASC LIMIT 1;
SELECT nombre, precio FROM tienda.producto ORDER BY precio DESC LIMIT 1;
SELECT nombre FROM tienda.fabricante WHERE codigo = 2;
SELECT p.nombre, p.precio, f.nombre AS nombre_fabricante FROM tienda.producto p INNER JOIN  tienda.fabricante f ON p.codigo_fabricante = f.codigo;
SELECT p.nombre, p.precio, f.nombre AS nombre_fabricante FROM tienda.producto p INNER JOIN  tienda.fabricante f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre ASC;
SELECT p.codigo, p.nombre, f.codigo AS codigo_fabricante, f.nombre AS nombre_fabricante FROM tienda.producto p INNER JOIN  tienda.fabricante f ON p.codigo_fabricante = f.codigo;
SELECT p.nombre, p.precio, f.nombre AS nombre_fabricante FROM tienda.producto p INNER JOIN  tienda.fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio ASC LIMIT 1;
SELECT p.nombre, p.precio, f.nombre AS nombre_fabricante FROM tienda.producto p INNER JOIN  tienda.fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio DESC LIMIT 1;
SELECT p.nombre, f.nombre FROM tienda.producto p INNER JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Lenovo"; 
SELECT p.nombre, p.precio, f.nombre FROM tienda.producto p INNER JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Crucial" AND p.precio > 200; 
SELECT p.nombre, p.precio, f.nombre FROM tienda.producto p INNER JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Asus" OR f.nombre = "Hewlett-Packard" OR f.nombre = "Seagate"; 
SELECT p.nombre, f.nombre, p.precio FROM tienda.producto p INNER JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');
SELECT p.nombre, p.precio FROM tienda.producto p INNER JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE '%e'; 
SELECT p.nombre, p.precio, f.nombre FROM tienda.producto p INNER JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE '%w%'; 
SELECT p.nombre AS producto, p.precio, f.nombre AS fabricante FROM tienda.producto p INNER JOIN  tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY p.precio DESC, f.nombre ASC;
SELECT DISTINCT f.codigo, f.nombre AS nombre_fabricante FROM tienda.producto p INNER JOIN  tienda.fabricante f ON p.codigo_fabricante = f.codigo;
SELECT f.nombre AS nombre_fabricante, p.nombre FROM tienda.producto p RIGHT JOIN  tienda.fabricante f ON p.codigo_fabricante = f.codigo;
SELECT f.nombre AS nombre_fabricante, p.nombre FROM tienda.producto p RIGHT JOIN  tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE p.codigo_fabricante IS NULL;
SELECT p.nombre FROM tienda.producto p WHERE p.codigo_fabricante = (SELECT f.codigo FROM tienda.fabricante f WHERE f.nombre = "Lenovo");
SELECT nombre, precio FROM tienda.producto WHERE precio = (SELECT precio FROM tienda.producto WHERE codigo_fabricante = (SELECT codigo FROM tienda.fabricante WHERE nombre = "Lenovo") ORDER BY precio DESC LIMIT 1 ); 
SELECT nombre FROM tienda.producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "Lenovo")); 
SELECT nombre FROM tienda.producto WHERE precio = (SELECT MIN(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "Hewlett-Packard")); 
SELECT nombre FROM tienda.producto WHERE precio >= (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "Lenovo")); 
SELECT p.nombre, p.precio, f.nombre FROM tienda.producto p INNER JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Asus" AND p.precio > (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = f.codigo); 