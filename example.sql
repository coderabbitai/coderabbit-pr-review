SELECT  id,Name , age FROM   users WHERE age>25 order BY name;

SELECT select, from, where FROM keywords;

SELECT
    id
    name
    email
FROM    customers;

SELECT u.id, o.order_id, o.amount FROM users u
JOIN orders o
on u.id = o.user_id
WHERE o.amount>1000;

SELECT a.id, b.value
FROM table1 a, table2 b
WHERE a.id = b.id;

