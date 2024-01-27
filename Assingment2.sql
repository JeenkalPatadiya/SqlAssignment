--1).

SELECT
customer.cust_name,salesman.name,customer.city
FROM customer
INNER JOIN salesman ON customer.salesman_id = salesman.salesman_id
WHERE customer.city = salesman.city;

--2).

SELECT
order1.ord_no,order1.purch_amt,customer.cust_name,customer.city
FROM customer
INNER JOIN order1 ON order1.customer_id=customer.customer_id
WHERE order1.purch_amt BETWEEN 500 AND 2000;

--3).

SELECT 
customer.cust_name,customer.city,salesman.name,salesman.commission
FROM customer
INNER JOIN salesman ON customer.salesman_id=salesman.salesman_id;

--4).

SELECT
customer.cust_name,customer.city,salesman.commission
FROM customer
INNER JOIN salesman ON customer.salesman_id=salesman.salesman_id
INNER JOIN order1 ON salesman.salesman_id=order1.salesman_id
where salesman.commission>0.12;

--5).

SELECT
customer.cust_name,customer.city,salesman.name,salesman.city
FROM customer
INNER JOIN salesman ON customer.salesman_id=salesman.salesman_id
INNER JOIN order1 ON salesman.salesman_id=order1.salesman_id
where salesman.commission>0.12*order1.purch_amt and salesman.city != customer.city;

--6).

SELECT
order1.ord_no,order1.ord_date,order1.purch_amt,customer.cust_name,customer.grade,salesman.name,salesman.commission
FROM order1
LEFT JOIN customer ON order1.salesman_id=customer.salesman_id
LEFT JOIN salesman ON customer.salesman_id=salesman.salesman_id

--7).

SELECT
order1.ord_no,order1.ord_date,order1.purch_amt,customer.cust_name,customer.grade,salesman.name,salesman.commission,customer.city
FROM order1
INNER JOIN customer ON order1.salesman_id=customer.salesman_id
INNER JOIN salesman ON customer.salesman_id=salesman.salesman_id

--8).

SELECT
customer.cust_name,customer.city,salesman.name,customer.city
FROM customer
INNER JOIN salesman ON customer.salesman_id = salesman.salesman_id
ORDER BY customer.customer_id

--9).

SELECT
customer.cust_name,customer.city,customer.grade,salesman.name,salesman.city
FROM customer
INNER JOIN salesman ON customer.salesman_id = salesman.salesman_id
WHERE customer.grade<300
ORDER BY customer.customer_id

--10).

SELECT
customer.cust_name,customer.city,order1.ord_no,order1.ord_date,order1.purch_amt
FROM customer
RIGHT JOIN order1 ON customer.salesman_id=order1.salesman_id

--11).

SELECT
customer.cust_name,customer.city,order1.ord_no,order1.ord_date,order1.purch_amt,salesman.name,salesman.commission
FROM customer
LEFT JOIN salesman ON customer.salesman_id = salesman.salesman_id
LEFT JOIN order1 ON salesman.salesman_id=order1.salesman_id

--12).

SELECT
salesman.name,customer.cust_name
FROM
salesman 
LEFT JOIN customer on salesman.salesman_id=customer.salesman_id 
ORDER BY salesman.name

--13).

SELECT
salesman.name,customer.cust_name,customer.city,customer.grade,order1.ord_no,order1.ord_date,order1.purch_amt
FROM
salesman 
LEFT JOIN customer ON salesman.salesman_id=customer.salesman_id
LEFT JOIN order1 ON customer.salesman_id=order1.salesman_id

--14).

select
salesman.name,customer.cust_name,customer.city,customer.grade,order1.ord_no,order1.ord_date,order1.purch_amt
FROM
salesman
LEFT JOIN customer ON salesman.salesman_id=customer.salesman_id
LEFT JOIN order1 ON customer.customer_id=order1.customer_id
WHERE customer.grade IS NOT NULL AND order1.purch_amt >= 2000

--15).

select
salesman.name,customer.cust_name,customer.city,customer.grade,order1.ord_no,order1.ord_date,order1.purch_amt
FROM
salesman
LEFT JOIN customer ON salesman.salesman_id=customer.salesman_id
LEFT JOIN order1 ON customer.customer_id=order1.customer_id
WHERE customer.grade IS NOT NULL AND order1.purch_amt >= 2000

--16)

SELECT
customer.cust_name,customer.city,customer.grade,order1.ord_no,order1.ord_date,order1.purch_amt
FROM
customer FULL  JOIN  order1 
ON
customer.customer_id=order1.customer_id
WHERE customer.grade IS NOT NULL

--17).

SELECT * FROM
salesman
CROSS JOIN customer 

--18).

SELECT * FROM
salesman
CROSS JOIN customer
WHERE salesman.city IS NOT NULL

--19).

SELECT * FROM
salesman
CROSS JOIN customer
WHERE salesman.city IS NOT NULL
AND customer.grade IS NULL

--20).

SELECT * FROM
salesman
CROSS JOIN customer
WHERE salesman.city IS NOT NULL
AND salesman.city<>customer.city
AND customer.grade IS NOT NULL


