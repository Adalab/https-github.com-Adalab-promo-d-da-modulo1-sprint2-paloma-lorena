# PAIR PROGRAMMING CON CTE's
USE northwind;

/*1. Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente 
y el nombre de la compañia de la tabla Customers.*/

-- cte  : customer_id, company_name
WITH cte1 AS(
			SELECT customer_id, company_name
            FROM customers)
            
	SELECT * FROM cte1;


/*2. Selecciona solo los de que vengan de "Germany"
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, 
pero solo queremos los que pertezcan a "Germany".*/

WITH cte1 AS(
			SELECT customer_id, company_name
            FROM customers
            WHERE country = "Germany")
            
	SELECT * FROM cte1;

/*3. Extraed el id de las facturas y su fecha de cada cliente.
En este caso queremos extraer todas las facturas que se han emitido a un cliente, 
su fecha, la compañia a la que pertenece.
NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name).*/
-- tablas: customers, orders
-- order_id, order_Date, company_name
-- union: customer_id -- JOIN

WITH cte2 AS(
			 SELECT customer_id, company_name
             FROM customers)
	
    SELECT order_id, order_date, company_name
    FROM orders
    NATURAL JOIN cte2;


/*4. Contad el número de facturas por cliente
Mejoremos la query anterior. En este caso queremos 
saber el número de facturas emitidas por cada cliente.*/
    
WITH cte2 AS(
			 SELECT customer_id, company_name
             FROM customers)
	
    SELECT COUNT(order_id) AS NumFacturas, company_name AS Cliente
    FROM orders
    NATURAL JOIN cte2
    GROUP BY company_name;

/*5. Cuál es la cantidad media pedida de todos los productos ProductID
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media.*/
-- AVG de cantidad de  cada producto
-- AVG(count(order_id) + quantity)
-- group by product_id

WITH cte5 AS(
			SELECT product_id, COUNT(order_id) AS NumPedidos
            FROM order_details
            GROUP BY product_id)
	
    SELECT o.product_id, AVG(cte5.NumPedidos + o.quantity), p.product_name
    FROM order_details AS o
	NATURAL JOIN cte5
    NATURAL JOIN products AS p
    GROUP BY o.product_id;

