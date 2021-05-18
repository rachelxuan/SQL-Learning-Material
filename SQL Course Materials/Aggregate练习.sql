UPDATE invoices
SET payment_total=10,
		payment_date='2020-3-15'
        Where invoice_id=1;

UPDATE invoices
SET payment_total=10,
		payment_date='2020-3-13'
        Where invoice_id=2;

UPDATE invoices
SET payment_total=10,
		payment_date='2020-3-13'
        Where invoice_id=3;

SELECT 
           (
				SELECT MAX(i.payment_date) 
				 FROM invoices i
				WHERE i.payment_date-CURDATE()<0
            ) AS column1,
            (

				SELECT COUNT(distinct invoice_id)
				FROM invoices i
				Where i.payment_date>CURDATE()
			) as column2;

SELECT
	'First half of 2019' AS date_range,
    SUM(invoice_total) AS total_sales,
	SUM(payment_total) AS total_payments,
    SUM(invoice_total-payment_total) AS what_we_expect
    From invoices
    Where invoice_date BETWEEN '2019-01-01' AND '2019-06-30';
    
 
 USE sql_store;
 SELECT
	c.customer_id,
	c.first_name,
	c.last_name,
	c.state,
	SUM(oi.quantity*oi.unit_price) AS total_sales
 FROM customers c
 JOIN orders o USING(customer_id)
 JOIN order_items oi USING(order_id)
WHERE state='VA'
Group By customer_id,c.first_name,c.last_name 
HAVING total_sales>100;

USE sql_invoicing; 
SELECT
pm.name,
SUM(amount) AS total
FROM payments p 
JOIN payment_methods pm
ON p.payment_method=payment_method_id
GROUP BY pm.name WITH ROLLUP


 
    
    

