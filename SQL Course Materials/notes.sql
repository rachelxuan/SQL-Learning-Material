#find products that are more expensive  than Lettuce(id=3)#

USE sql_store;
SELECT *
FROM products
WHERE unit_price >
	(select unit_price
			FROM products
			WHERE product_id=3);

#in sql_hr database: Find employees whose earn more than average
#Find the product that have never been ordered

USE sql_store;
SELECT *
FROM products
WHERE product_id NOT IN
		(SELECT DISTINCT product_id
			FROM 
			order_items);
            
#Find clients without invoices

USE sql_invoicing;
SELECT *
FROM clients
WHERE client_id NOT IN(
SELECT DISTINCT client_id
FROM invoices);

#Select invoices larger than all invoices of  client 3
#Method1

USE sql_invoicing;
SELECT *
FROM invoices
WHERE invoice_total>(
SELECT MAX(invoice_total)
FROM invoices
WHERE client_id=3);

#Method2*

USE sql_invoicing;
SELECT*
FROM invoices
WHERE invoice_total>ALL(
SELECT invoice_total
FROM invoices
WHERE client_id=3);
 
-- Select clients with at least two invoices
 -- Method1
 USE sql_invoicing;
 SELECT *
 FROM clients
 WHERE client_id IN(
    SELECT client_id
	FROM invoices
	GROUP BY client_id
	HAVING Count(*)>=2
    );
-- Method2
USE sql_invoicing;
 SELECT *
 FROM clients
 WHERE client_id=ANY(
	SELECT client_id
	FROM invoices
	GROUP BY client_id
	HAVING Count(*)>=2);

-- SELECT employees whose salary is above the average in their office
-- for each employee, calculate the avg salary for employee.office,then return the employee if salary>avg
USE sql_hr;
SELECT 
    e.office_id, e.salary
FROM
    employees e
WHERE
    e.salary >= (
					SELECT av
                    FROM 
						(
							SELECT AVG(salary) as av, s.office_id
							FROM employees s
							GROUP BY s.office_id
						) as sub
					WHERE e.office_id = sub.office_id
				 );
                 
--
USE sql_hr;
SELECT 
    e.office_id, e.salary
FROM
    employees e
WHERE
    e.salary >= (
					SELECT av
					 FROM	
                        (SELECT
								AVG(salary) AS av, e.office_id
								FROM employees e
								GROUP BY e.office_id
						) AS sub
                        WHERE c.office_id=e.office_id
                        );




-- correct answer

USE sql_hr;
SELECT office_id
FROM employees 
WHERE salary>=
		(
			SELECT AVG(salary) 
			FROM employees s
			WHERE s.office_id=employees.office_id
			);







