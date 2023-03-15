# PAIR PROGRAMMING CONSULTAR EN MÚLTIPLES TABLAS 3

/* En esta lección de pair vamos a continuar trabajando sobre la base de datos Northwind. 
Hoy ondremos en práctica sentencias como UNION, UNION ALL, INTERSECT o EXCEPT.
Para esta práctica te hará falta crear en algunos de los ejercicios una columna temporal. 
Para ver cómo funciona esta creación de columnas termporales prueba el siguguiente código.
*/ 

USE northwind;

SELECT  'Hola!'  AS tipo_nombre
FROM customers;

/* 1. Extraer toda la información sobre las compañias que tengamos en la BBDD:
Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores
que tenemos en la BBDD. Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del 
contacto, además de la relación (Proveedor o Cliente). 
Pero importante! No debe haber duplicados en nuestra respuesta. 
La columna Relationship no existe y debe ser creada como columna temporal. 
Para ello añade el valor que le quieras dar al campo y utilizada como alias Relationship.
Nota: Deberás crear esta columna temporal en cada instrucción SELECT.*/ 

-- clientes y proveedores
-- nombre empresa, nombre contacto, ciudad, relación??
-- sin duplicados

SELECT company_name, city, contact_name, "Cliente" AS RelationShip
FROM customers
UNION
SELECT company_name, city, contact_name, "Proveedor" AS RelationShip
FROM suppliers;

/* 2. Extraer todos los pedidos gestinados por "Nancy Davolio":
En este caso, nuestro jefe quiere saber cuantos pedidos ha gestionado "Nancy Davolio", 
una de nuestras empleadas. Nos pide todos los detalles tramitados por ella.*/

-- Nancy Davolio
-- número pedidos ** (PREGUNTAR)
-- todos los detalles tramitados por ella

SELECT *
FROM orders
WHERE employee_id IN
			(SELECT employee_id
			FROM employees
            WHERE first_name = "Nancy" AND last_name = "Davolio");

/* 3. Extraed todas las empresas que no han comprado en el año 1997
En este caso, nuestro jefe quiere saber cuántas empresas no han comprado en el año 1997.
Para extraer el año de una fecha, podemos usar el estamento year.*/ 
-- nombres empresa que no han comprado en 1997 --> NOT IN
-- trabajamos con las tablas: customers y orders

SELECT company_name
FROM customers
WHERE customer_id NOT IN
					(SELECT customer_id
                    FROM orders
                    WHERE YEAR(order_date) = 1997);

/* 4. Extraed toda la información de los pedidos donde tengamos "Konbu":
Estamos muy interesados en saber como ha sido la evolución de la venta de Konbu a lo largo del tiempo. 
Nuestro jefe nos pide que nos muestre todos los pedidos que contengan "Konbu".
En esta query tendremos que combinar conocimientos adquiridos en las lecciones anteriores
como por ejemplo el INNER JOIN.*/

-- tablas: orders details y products
-- toda la información *
-- producto: konbu
-- tabla madre: orders

SELECT *
FROM orders
INNER JOIN order_details
USING (order_id)
WHERE product_id in
				(SELECT product_id
                FROM products
                WHERE product_name = "Konbu");





