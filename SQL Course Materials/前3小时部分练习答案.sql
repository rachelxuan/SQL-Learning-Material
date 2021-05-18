USE sql_invoicing;
CREATE TABLE invoices_archived_4 AS
	SELECT 
		i.invoice_id,
		i.number,
		c.name AS client,
		i.invoice_total,
		i.payment_total,
		i.invoice_date,
		i.payment_date,
		i.due_date
	FROM invoices i
	JOIN clients c
	USING (client_id)
	WHERE i.payment_date IS NOT NULL;

UPDATE invoices
SET invoice_total=148,payment_total=invoice_total*0.5,payment_date=due_date
WHERE client_id IN(3,4);

USE sql_store;
UPDATE customers
set points=points+50
WHERE birth_date<'1990-01-01';

USE sql_invoicing;
DROP TABLE invoices_archived_2,invoices_archived_3;