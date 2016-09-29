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
Select pid
from orders
where aid in (Select aid
              From orders
              where cid in (Select CID
              From customers
              where city = 'Kyoto')) 
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
--

-- name discounts and city of customers who ordered agents in dallas or new york
Select name, discount, city
from customers
WHERE city = 'Dallas'
AND city in (SELECT city
             FROM agents
             WHERE city = 'New York');

--Get all customers	who	have the same discount
--as that of any customers in Dallas or London
Select *
from customers
where city = 'Dallas = London' ;