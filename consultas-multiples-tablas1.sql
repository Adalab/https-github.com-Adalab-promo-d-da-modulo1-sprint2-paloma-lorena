# PAIR PROGRAMMING SPRINT 2
USE northwind; 
/*En esta lección de pair programming vamos a continuar trabajando sobre la base de datos Northwind.
l día de hoy vamos a realizar ejercicios en los que practicaremos las queries SQL a múltiples 
tablas usando los operadores CROSS JOIN, INNER JOIN y NATURAL JOIN. De esta manera podremos 
combinar los datos de diferentes tablas en las mismas bases de datos, para así realizar 
consultas mucho mas complejas.*/

/* 1. Pedidos por empresa en UK:
Desde las oficinas de UK nos han pedido con urgencia que realicemos una consulta a la 
base de datos con la que podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK. 
Nos piden el ID  del cliente y el nombre de la empresa y el número de pedidos.*/

SELECT customers.customer_id, customers.company_name, COUNT(orders.order_id) AS NumPedidos
FROM customers
CROSS JOIN orders
WHERE customers.customer_id = orders.customer_id AND country = "UK"
GROUP BY  (customers.customer_id);


/* 2.Productos pedidos por empresa en UK por año: 
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y 
han decidido pedirnos una serie de consultas adicionales. La primera de ellas consiste en una query 
que nos sirva para conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año. 
Nos piden concretamente conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. 
Para ello hará falta hacer 2 joins.*/

-- customer - orders (customer_id)
-- orders - order details (order_id)

SELECT customers.company_name, YEAR(orders.order_date), SUM(order_details.quantity) NumObjetos
FROM orders
CROSS JOIN customers
CROSS JOIN order_details
WHERE customers.customer_id = orders.customer_id AND orders.order_id = order_details.order_id AND ship_country = "UK"
GROUP BY customers.company_name, YEAR(orders.order_date);
 
#orders.ship_country
#no puede ser country, porque está en la tabla customers
#CREACIÓN TABLAS TEMPORALES

SELECT orders.order_id, YEAR(orders.order_date), SUM(order_details.quantity)
FROM orders
INNER JOIN order_details
ON orders.order_id = order_details.order_id AND ship_country = "UK";

SELECT order_id, SUM(quantity) 
FROM order_details
NATURAL JOIN orders
WHERE ship_country = 'UK'
GROUP BY order_id;

 /* 3.Mejorad la query anterior:
 Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de 
 la cantidad de dinero que han pedido por esa cantidad de objetos, teniendo en cuenta los descuentos, etc. 
 Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 
 15% nos sale como 0.15.*/

SELECT customers.company_name, YEAR(orders.order_date), SUM(order_details.quantity) NumObjetos, SUM(order_details.unit_price * order_details.quantity) AS DineroTotal
FROM orders
CROSS JOIN customers
CROSS JOIN order_details
WHERE customers.customer_id = orders.customer_id AND orders.order_id = order_details.order_id AND ship_country = "UK"
GROUP BY customers.company_name, YEAR(orders.order_date);


 /* 4. BONUS: Pedidos que han realizado cada compañía y su fecha:
 Después de estas solicitudes desde UK y graciasa a la utilidad de os resultados que se han obtenido,
 desde la central nos han pedido una consulta que indique el nombre de cada compaía cliente 
 junto con cada pedido que han realizado y su fecha.*/


 /* 5. BONUS: Tipos de producto vendidos:
 Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la categoría 
 y el nombre del producto, y el total de dinero por el que se ha vendido cada tipo de producto 
 (teniendo en cuenta los descuentos).
 PISTA: Necesitaréis usar 3 joints.*/
 
 
 
