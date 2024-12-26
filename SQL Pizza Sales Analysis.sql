USE PIZZA_SALES_PROJECT;

SELECT * FROM pizza_sales_project.pizza_types;

SELECT * FROM pizza_sales_project.orders;

SELECT * FROM pizza_sales_project.order_detail;

CREATE DATABASE PIZZA_SALES_PROJECT;
USE PIZZA_SALES_PROJECT;
CREATE TABLE ORDER_DETAIL(
ORDER_DETAIL_ID INT NOT NULL PRIMARY KEY,
ORDER_ID INT NOT NULL,
PIZZA_ID TEXT NOT NULL,
QUANTITY  INT NOT NULL);

----------------------------------------------------------------------------------------------------

--  Q.1. - Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(ORDER_DETAIL.QUANTITY * PIZZAS.PRICE),
            2) AS TOTAL_REVENUE
FROM
    ORDER_DETAIL
        JOIN
    PIZZAS ON ORDER_DETAIL.PIZZA_ID = PIZZAS.PIZZA_ID;
    
 ----------------------------------------------------------------------------------------------------
 
 -- Q.2.-  Retrieve the total number of orders placed.

SELECT 
    COUNT(ORDER_ID) AS TOTAL_ORDERS
FROM
    ORDERS;
    
 ----------------------------------------------------------------------------------------------------
 
 
 -- Q.3. -  Identify the highest-priced pizza.

SELECT 
    PIZZA_TYPES.NAME, PIZZAS.PRICE
FROM
    PIZZA_TYPES
        JOIN
    PIZZAS ON PIZZA_TYPES.PIZZA_TYPE_ID = PIZZAS.PIZZA_TYPE_ID
ORDER BY PIZZAS.PRICE DESC
LIMIT 1;
----------------------------------------------------------------------------------------------------
 
 -- Q.4. - Identify the most common pizza size ordered.

SELECT 
    PIZZAS.SIZE,
    COUNT(ORDER_DETAIL.ORDER_DETAIL_ID) AS ORDER_COUNT
FROM
    PIZZAS
        JOIN
    ORDER_DETAIL ON PIZZAS.PIZZA_ID = ORDER_DETAIL.PIZZA_ID
GROUP BY PIZZAS.SIZE
ORDER BY PIZZAS.SIZE ASC
LIMIT 1;
----------------------------------------------------------------------------------------------------


-- Q.5. -  List the top 5 most ordered pizza types 
-- along with their quantities.


SELECT 
    PIZZA_TYPES.NAME, SUM(ORDER_DETAIL.QUANTITY) AS QUANTITY
FROM
    PIZZAS
        JOIN
    PIZZA_TYPES ON PIZZAS.PIZZA_TYPE_ID = PIZZA_TYPES.PIZZA_TYPE_ID
        JOIN
    ORDER_DETAIL ON ORDER_DETAIL.PIZZA_ID = PIZZAS.PIZZA_ID
GROUP BY PIZZA_TYPES.NAME
ORDER BY QUANTITY DESC
LIMIT 5;

---------------------------------------------------------------------------------------------------------


-- Q.6. -  Join the necessary tables to find the 
-- total quantity of each pizza category ordered.

SELECT PIZZA_TYPES.CATEGORY,
SUM(ORDER_DETAIL.QUANTITY) AS QUANTITY
FROM PIZZA_TYPES JOIN PIZZAS
ON PIZZA_TYPES.PIZZA_TYPE_ID = PIZZAS.PIZZA_TYPE_ID
JOIN ORDER_DETAIL
ON ORDER_DETAIL.PIZZA_ID = PIZZAS.PIZZA_ID
GROUP BY PIZZA_TYPES.CATEGORY
ORDER BY  QUANTITY DESC;

---------------------------------------------------------------------------------------------------------

-- Q.7. - Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(ORDER_TIME), COUNT(ORDER_ID) AS ORDER_COUNT
FROM
    ORDERS
GROUP BY HOUR(ORDER_TIME)
ORDER BY ORDER_COUNT DESC;

--------------------------------------------------------------------------------------------


-- Q.8. - Join relevant tables to find the
-- category-wise distribution of pizzas.

SELECT CATEGORY, COUNT(NAME)
FROM PIZZA_TYPES
GROUP BY CATEGORY;
    
------------------------------------------------------------------------------------------------------

-- Q.9. -  Group the orders by date and calculate the
--  average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(QUANTITY), 2) AS ORDER_PER_DAY
FROM
    (SELECT 
        ORDERS.ORDER_DATE, SUM(ORDER_DETAIL.QUANTITY) AS QUANTITY
    FROM
        ORDERS
    JOIN ORDER_DETAIL ON ORDER_DETAIL.ORDER_ID = ORDERS.ORDER_ID
    GROUP BY ORDERS.ORDER_DATE) AS ORDER_QUANTITY;
    
    -----------------------------------------------------------------------------------------------------------
    
-- Q.10. - Determine the top 3 most ordered
--  pizza types based on revenue.

USE PIZZA_SALES_PROJECT;
SELECT PIZZA_TYPES.NAME,
       SUM(ORDER_DETAIL.QUANTITY * PIZZAS.PRICE) AS REVENUE
FROM PIZZA_TYPES 
JOIN PIZZAS ON PIZZA_TYPES.PIZZA_TYPE_ID = PIZZAS.PIZZA_TYPE_ID
JOIN ORDER_DETAIL ON ORDER_DETAIL.PIZZA_ID = PIZZAS.PIZZA_ID
GROUP BY PIZZA_TYPES.NAME
ORDER BY REVENUE DESC
LIMIT 3;

    
    
    
    
    
    









