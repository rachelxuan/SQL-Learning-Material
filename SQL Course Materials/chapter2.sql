   -- Chapter 2
	-- 1.Find products that are more expensive than Lettuce(id=3)
USE sql_inventory;
SELECT *
FROM products
WHERE 
unit_price>(
SELECT unit_price 
FROM products 
WHERE product_id=3);

	-- 2.1 In sql_hr database, Find employees whose earn more than average
USE sql_hr;
SELECT *
FROM employees e
WHERE salary>
(SELECT AVG (salary)
FROM employees e
);
	-- 2.2 Select employees whose salary is above the average in their office(correlated subquires)
 USE sql_hr;
 SELECT * 
 FROM employees e
 WHERE salary>
 (
 SELECT AVG(salary)
  FROM employees em
  WHERE em.office_id=e.office_id
);
    
	-- 3.Find customers who have ordered lettuce,Select customer_id, first_name; last name
		-- METHOD1
USE sql_store;
SELECT *
FROM customers
WHERE customer_id IN
( 
SELECT o.customer_id
FROM order_items oi
JOIN orders o using (order_id)
WHERE product_id=3
);
		-- METHOD 2
USE sql_store;
SELECT DISTINCT customer_id,first_name,last_name
FROM customers c
JOIN ORDERS o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE oi.product_id=3;
 
	-- 4.KEY WORD: ALL
 -- SELECT invoices larger than all invoices of client 3
 USE sql_invoicing;
 SELECT *
 FROM invoices
 WHERE invoice_total>ALL(
 SELECT invoice_total
 FROM invoices
 WHERE client_id=3);
 
	-- 5.KEY WORD: ANY
  -- SELECT clients with at least two invoices
   USE sql_invoicing;
   SELECT *
   FROM clients
   WHERE client_id= ANY(
   SELECT client_id
   FROM invoices
   GROUP BY client_id
   HAVING COUNT(*)>=2);
  
	-- 6. GET invoices that are larrger than the client's average invoice amount (selt correlated)
   USE sql_invoicing; 
    SELECT *
    FROM invoices i
    WHERE invoice_total>
    (SELECT AVG(invoice_total)
    FROM invoices
    WHERE client_id=i.client_id);
    
   	-- 7.SELECT clients that have an invocie(如果是have never been ordered 则是not in）
-- 方法1 
USE sql_invoicing;
    SELECT *
	FROM invoices
    WHERE client_id NOT IN (
    Select DISTINCT client_id
    FROM invoices i); 

-- 方法二(correlated subquires)
USE sql_invoicing;
    SELECT *
	FROM clinets c
    WHERE exists
    (SELECT client_id
    FROM invoices
    WHERE client_id=c.client_id); 
    
	-- USE sql_invoicing;
    SELECT *
    FROM clients
	LEFT JOIN invoices USING(client_id)
	WHERE invocies IS NULL; 

USE sql_store;
SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM customers;z

SELECT MONTH(NOW());
SELECT DAYNAME(NOW());
SELECT MONTHNAME(NOW());


USE sql_store;
SELECT *
FROM orders
WHERE YEAR(order_date)=YEAR(NOW());

USE sql_store;
SELECT DATE_FORMAT(NOW(),' %M %d %Y' );


SELECT DATE_ADD(NOW(),   INTERVAL '1' YEAR)

SELECT DATEDIFF( '2020-03-21', '2020-02-05'  );

USE  sql_store;
SELECT *
FROM orders;

SELECT
order_id,
order_date,
IF(YEAR(order_date)='2019',
'Active',
'Archived') AS category
FROM orders;

SELECT
		product_id,
		name,
		COUNT(*) as orders,
        IF(COUNT(*)>1,'many times','once') AS fren
FROM products
JOIN order_items USING(product_id)
GROUP BY product_id, name;

SELECT
		order_id,
		CASE
			WHEN YEAR(order_date)=YEAR(NOW()) THEN 'ACTIVE'
		    WHEN YEAR(order_date)=YEAR(NOW())-1 THEN 'LAST YEAR'
            WHEN YEAR(order_date)<YEAR(NOW())-1 THEN 'Archieved'
            ELSE'FUTURE'
            END AS category
		FROM orders;


