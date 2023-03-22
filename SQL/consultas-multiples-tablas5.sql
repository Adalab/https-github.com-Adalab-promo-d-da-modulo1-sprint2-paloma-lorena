-- CONSULTAS MULTIPLES TABLAS 5 --
USE northwind;

/* 1. Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. 
Para eso nos pide que lo hagamos con una query correlacionada.*/

-- Primero averiguamos cual es el ultimo pedido de cada empleado

SELECT DISTINCT o1.employee_id, o1.order_id, o1.order_date
FROM  orders AS o1
WHERE o1.order_date = (SELECT o2.order_date
						FROM orders AS o2
						WHERE o1.employee_id = o2.employee_id
						ORDER BY o2.order_date DESC
						LIMIT 1);

-- El employee_id 2 aparece dos veces porque hizo 2 pedidos el mismo día

/*2. Extraed el precio unitario máximo (unit_price) de cada producto vendido.
Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. 
De nuevo lo tendréis que hacer con queries correlacionadas.*/

SELECT product_id, MAX(unit_price)
FROM order_details
GROUP BY product_id;

SELECT DISTINCT o1.product_id, o1.unit_price
FROM order_details AS o1
WHERE o1.unit_price = (SELECT MAX(o2.unit_price)
						FROM order_details AS o2
                        WHERE o1.product_id = o2.product_id);
      
-- hacemos un natural join con products para tener tambien los nombres de los productos
SELECT DISTINCT o1.product_id, products.product_name, o1.unit_price
FROM order_details AS o1
NATURAL JOIN products
WHERE o1.unit_price = (SELECT MAX(o2.unit_price)
						FROM order_details AS o2
                        WHERE o1.product_id = o2.product_id);


/*3. Ciudades que empiezan con "A" o "B".
Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están 
afincadas en ciudades que empiezan por "A" o "B". Necesita que le devolvamos la ciudad, el nombre de la 
compañia y el nombre de contacto.*/

SELECT customer_id, company_name, contact_name, city
FROM customers
WHERE city LIKE 'A%' OR city LIKE 'B%';


/*4. Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior el número de total 
de pedidos que han hecho todas las ciudades que empiezan por "L".*/

SELECT customer_id, company_name, contact_name, city, COUNT(order_id)
FROM customers
NATURAL JOIN orders
WHERE city LIKE 'L%'
GROUP BY customer_id;

/*5. Todos los clientes cuyo "contact_title" no incluya "Sales".
Nuestro objetivo es extraer los clientes que no tienen el contacto "Sales" en su "contact_title". 
Extraer el nombre de contacto, su posisión (contact_title) y el nombre de la compañia.*/

SELECT contact_name, contact_title, company_name
FROM customers
WHERE contact_title NOT LIKE 'Sales%';

/*6. Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto.*/

SELECT contact_name
FROM customers
WHERE contact_name NOT LIKE '_a%';