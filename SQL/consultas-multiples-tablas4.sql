-- CONSULTAS EN MÚLTIPLES TABLAS 4 --

USE northwind; 

/*Es el turno de las subqueries. 
En este ejercicios os planteamos una serie de queries que nos permitirán conocer información
 de la base de datos, que tendréis que solucionar usando subqueries.*/
 
 /* 1. Extraed información de los productos "Beverages":
 En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para 
 identificar un tipo de producto. En concreto, tienen especial interés por los productos con 
 categoría "Beverages". 
 Devuelve el ID del producto, el nombre del producto y su ID de categoría.*/
 
 -- id product, nombre del producto e id categoría (tabla products)
 SELECT product_id, product_name, category_id
 FROM products;
 
   -- tabla categories que se filtre por el category name: Beverages
 
 SELECT category_id
 FROM categories
 WHERE category_name = "Beverages";
 
 -- query final:
 
SELECT product_id, product_name, category_id
 FROM products
 WHERE category_id = (SELECT category_id
						 FROM categories
						 WHERE category_name = "Beverages");

 
/* 2. Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor
ubicado en ese país:
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes,
entonces podría dirigirse a estos países para buscar proveedores adicionales.*/

-- lista países donde viven clientes, pero no proveedores
-- tablas: customers y suppliers

-- buscamos en qué paises sí hay proveedores para poder compararla con la otra lista donde no haya
SELECT country
FROM suppliers;

SELECT country
FROM customers;

# Query final

SELECT DISTINCT country
FROM customers
WHERE country NOT IN(SELECT country
						FROM suppliers);

/* 3. Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread":
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto 
"Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido.*/

-- clientes que compraron > 20 "Grandma's Boysenberry Spread" (Product ID 6)
-- order ID, nombre cliente

-- Aunque conocemos el id del producto, por habituarnos a situaciones en las que sea desconocido 
-- y haya que realizar varias subconsultas

SELECT product_id
FROM products
WHERE product_name = "Grandma's Boysenberry Spread"; 

SELECT order_id
FROM order_details
WHERE  product_id = 6 AND quantity > 20;

-- conexión por order_id:
SELECT customer_id
FROM orders
WHERE order_id IN (SELECT order_id
						FROM order_details
						WHERE  product_id = 6 AND quantity > 20);
-- nombre cliente:

SELECT company_name -- , orders.order_id
FROM customers
WHERE customer_id IN (SELECT customer_id
							FROM orders
							WHERE order_id IN (SELECT order_id
											FROM order_details
											WHERE  product_id = 6 AND quantity > 20));

SELECT customers.company_name, tabla1.order_id
FROM customers, (SELECT customer_id, order_id
							FROM orders
							WHERE order_id IN (SELECT order_id
											FROM order_details
											WHERE  product_id = 6 AND quantity > 20)) AS tabla1
WHERE customers.customer_id = tabla1.customer_id;

/* 4. Extraed los 10 productos más caros:
Nos siguen pidiendo más queries correlacionadas. 
En este caso queremos saber cuáles son los 10 productos más caros.*/

-- 10 productos a mayor precio

SELECT *
FROM products;

-- Valdría con esta query más simple
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC	
LIMIT 10;

-- Query compleja completa:

SELECT product_name, unit_price-- de forma simple con *
FROM (SELECT *
			FROM products) AS tabla1
ORDER BY unit_price DESC	
LIMIT 10;

/* BONUS 5. Qué producto es más popular:
Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró.*/

-- nombre producto
-- la cuenta de todas las veces que se ha comprado

-- Query básica, que devuelve lista con product_id más vendido
SELECT product_id, SUM(quantity)
FROM order_details
GROUP BY product_id
ORDER BY SUM(quantity) DESC
LIMIT 1;

-- Query compleja con tabla auxiliar en WHERE:

SELECT product_name, SUM(quantity)
FROM products
WHERE product_id IN (SELECT product_id, SUM(quantity)
					FROM order_details
					GROUP BY product_id)
ORDER BY SUM(quantity) DESC
LIMIT 1;

-- Query compleja con tabla auxiliar en FROM:

SELECT product_name, VentasTotales, product_id
FROM products, (SELECT product_id, SUM(quantity) AS VentasTotales
					FROM order_details
                    GROUP BY product_id) AS tablaSub

ORDER BY tablaSUb.SUM(quantity) DESC
LIMIT 1;