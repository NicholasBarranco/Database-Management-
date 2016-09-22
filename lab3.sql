--Nicholas Barranco
--LAB #3
--DATABASE MANAGEMENT


SELECT ordnum, totalusd
FROM orders;

SELECT name, city
FROM agents
WHERE name = 'Smith'

SELECT pid, name, priceusd
FROM products
WHERE quantity > 201000;

SELECT name, city
FROM customers
WHERE city = 'Duluth';

SELECT name
FROM agents
WHERE city <> ('Duluth') 
AND city <> ('New York');

SELECT *
FROM products
WHERE city <> ('Dallas') 
AND city <> ('Duluth')
AND priceUSD >= 1.00;

SELECT *
FROM orders
WHERE mon = ('feb') 
OR mon = ('mar');

SELECT *
FROM orders
WHERE mon = ('feb') 
AND totalusd >= 600.00;

SELECT *
FROM orders
WHERE cid = 'c005';