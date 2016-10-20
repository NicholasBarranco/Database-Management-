--NICHOLAS BARRANCO
--DATABASE MANAGEMENT
--LAB#6

--1
SELECT name, city
FROM customers
WHERE city IN(SELECT city
				FROM products
				GROUP BY city
				ORDER BY COUNT(products.city) DESC
				LIMIT 1);


-- 2
SELECT name, products.priceUSD
FROM products
WHERE priceUSD < (SELECT AVG (priceUSD)
                  FROM products)
			      ORDER BY products.name DESC;

--3
SELECT customers.name, orders.pid, orders.totalUSD
FROM orders INNER JOIN customers
	ON orders.cid = customers.cid
	ORDER BY orders.totalUSD ASC;


--4
SELECT customers.name, COALESCE(SUM(orders.qty), 0) AS "Total Ordered"
FROM orders RIGHT OUTER JOIN customers
	ON orders.cid = customers.cid GROUP BY customers.name
	ORDER BY SUM(orders.qty) ASC;

--5
SELECT DISTINCT customers.name, products.name, agents.name
FROM orders INNER JOIN customers
	ON orders.cid = customers.cid INNER JOIN products
	ON orders.pid = products.pid INNER JOIN agents
	ON orders.aid = agents.aid
WHERE agents.city = 'New York';


--6
SELECT ((orders.qty * products.priceUSD) * (1 - (customers.discount / 100))) AS "Dollar Check", orders.totalUSD
FROM orders, customers, products
	WHERE orders.cid = customers.cid 
	AND orders.pid = products.pid 
	AND ((orders.qty * products.priceUSD) * (1 - (customers.discount / 100))) != orders.totalUSD;