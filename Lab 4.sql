--Nicholas Barranco
--DATABASE MANAGEMENT
--LAB #4

--Displays the cities of agents whom booked an order for a customer whose cid was 'c006'.
SELECT city
FROM agents
WHERE aid in (SELECT aid
              FROM orders
              WHERE cid = 'c006');
			  
--Get the ids of products ordered through any agent	who	takes 
--at least one order from a	customer in Kyoto, sorted by pid from highest to lowest.
SELECT pid
FROM orders
WHERE aid in (SELECT aid
              FROM orders
              WHERE cid in (SELECT CID
                            FROM customers
                            WHERE city = 'Kyoto')) 
ORDER BY pid DESC;


--Shows IDs and names of customers who did not place an order through agent a03.
SELECT cid, name
FROM customers
WHERE cid in (SELECT cid
	      FROM orders
	      WHERE aid != 'a03');
		  
--Get the ids of customers who ordered both product p01 and p07.			  
SELECT DISTINCT cid
FROM Orders
WHERE pid = 'p01' 
AND cid in(SELECT cid
	   FROM Orders
	   WHERE pid = 'p07');
	   
--Shows ids of products that are not ordered by any customers who placed an order through agent a08 in order from high to lowest
SELECT pid
FROM products
WHERE pid not in (SELECT pid
                  FROM orders
				  WHERE cid in(SELECT cid
				               FROM orders
							   WHERE aid = 'a08'))
ORDER BY pid DESC;

-- name discounts and city of customers who ordered agents in dallas or new york
SELECT name, discount, city
FROM customers
WHERE cid in (SELECT cid
              FROM orders
			  WHERE aid in(SELECT aid
			               FROM agents
						   WHERE city in('Dallas', 'New York'));
						   
--Get all customers	who	have the same discount
--as that of any customers in Dallas or London
SELECT *
FROM customers
WHERE discount IN (SELECT discount
                   FROM customers
				   WHERE city in('London', 'Dallas');
				 