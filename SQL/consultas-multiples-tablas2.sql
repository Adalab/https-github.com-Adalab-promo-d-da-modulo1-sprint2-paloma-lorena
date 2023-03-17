-- CONSULTAS MULTIPLES TABLAS 2 --

USE northwind; 

/*1. Qué empresas tenemos en la BBDD Northwind:
Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas las empresas cliente,
 los ID de sus pedidos y las fechas. Los resultados deberán similares a la siguiente tabla:*/
  
 SELECT orders.order_id, customers.company_name, orders.order_date
	FROM orders
    LEFT JOIN customers
    ON orders.customer_id = customers.customer_id;
 
 /*2. Pedidos por cliente de UK:
Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos que ha realizado cada 
cliente del propio Reino Unido de cara a conocerlos mejor y poder adaptarse al mercado actual. Especificamente nos 
piden el nombre de cada compañía cliente junto con el número de pedidos.
La tabla resultante será:*/

SELECT customers.customer_id, customers.company_name, COUNT(orders.order_id)
	FROM customers
    LEFT JOIN orders
    ON orders.customer_id = customers.customer_id
    WHERE orders.ship_country = 'UK'
    GROUP BY customers.company_name, customers.customer_id;
 
 /*3. Empresas de UK y sus pedidos:
También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido (tengan pedidos o no) 
junto con los ID de todos los pedidos que han realizado, el nombre de contacto de cada empresa y la fecha del pedido.
Los resultados de la query deberán ser:*/

SELECT customers.company_name, orders.order_id, customers.contact_name, orders.order_date
	FROM customers
    LEFT JOIN orders
    ON orders.customer_id = customers.customer_id
    WHERE orders.ship_country = 'UK';
 
 /*4. Empleadas que sean de la misma ciudad:
Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla los datos de todas 
las empleadas y sus supervisoras. Concretamente nos piden: la ubicación, nombre, y apellido tanto de las empleadas como de las jefas. 
Investiga el resultado, ¿sabes decir quién es el director?
La tabla resultado de la query deberá ser:*/

SELECT E.city, E.first_name AS Nombre_empleado, E.last_name AS Apellido_empleado, J.city, J.first_name AS Nombre_jefe, J.last_name AS Apellido_jefe
FROM employees AS E, employees AS J
WHERE J.employee_id = E.reports_to;

-- El jefe de la empresa es Andrew Fuller, y el segudno al mando Steven Buchanan

 /*5. BONUS - BONUS: FULL OUTER JOIN Pedidos y empresas con pedidos asociados o no:
Selecciona todos los pedidos, tengan empresa asociada o no, y todas las empresas tengan pedidos asociados o no. Muestra el ID del pedido, 
el nombre de la empresa y la fecha del pedido (si existe). La tabala resultado deberá similar a:*/

SELECT orders.order_id, customers.company_name, orders.order_date
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id
WHERE orders.ship_country = 'UK'
UNION 
SELECT orders.order_id, customers.company_name, orders.order_date
FROM orders
RIGHT JOIN customers
ON orders.customer_id = customers.customer_id
WHERE orders.ship_country = 'UK';

-- Ponemos solo las de UK para probar a poner condiciones extra con el UNION