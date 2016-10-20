--Nicholas Barranco
--DATABASE MANAGEMENT
--LAB #5

--1
SELECT city 
FROM agents INNER JOIN orders
 ON orders.aid = agents.aid
WHERE orders.cid = 'c006';


--2
SELECT DISTINCT orders.pid
FROM orders 
INNER JOIN agents
	ON orders.cid = agents.aid
INNER JOIN customers
	ON orders.cid = customers.cid
WHERE customers.city = 'Kyoto'
ORDER BY pid DESC;


--3
SELECT name
FROM customers 
WHERE cid NOT IN (SELECT cid
					FROM orders);


--4
SELECT name
FROM orders RIGHT OUTER JOIN customers
	ON orders.cid = customers.cid
	WHERE ordnum IS NULL;

--5
SELECT DISTINCT customers.name, agents.name
FROM orders
	INNER JOIN agents
			ON orders.aid = agents.aid
	INNER JOIN customers
			ON orders.cid = customers.cid
WHERE customers.city = agents.city;

--6
SELECT customers.name, agents.name, customers.city
FROM customers INNER JOIN agents
	ON customers.city = agents.city;
		
--7  
SELECT name, city
FROM customers
WHERE city IN (SELECT city
			   FROM products
			   GROUP BY city
			   ORDER BY COUNT(city)
					LIMIT 1);