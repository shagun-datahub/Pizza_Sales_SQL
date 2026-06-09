-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT pizza_types.category,
SUM(orders_details.quantity) AS quantity
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
JOIN orders_details
ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category ORDER BY quantity DESC;

-- Determine the distribution of orders by hour of the day.
select hour(order_time) AS hour, count(order_id) AS order_count FROM orders
group by hour(order_time);


-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT category, count(name) FROM pizza_types
group by category;


-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT round(avg(quantity),0) FROM ( 
SELECT orders.order_date, sum(orders_details.quantity) AS quantity
FROM orders JOIN orders_details
ON orders.order_id = orders_details.order_id
GROUP BY orders.order_date ) AS order_quantity;


-- Determine the top 3 most ordered pizza types based on revenue.
SELECT pizza_types.name, SUM( orders_details.quantity * pizzas.price ) AS revenue
FROM pizza_types JOIN pizzas
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN  orders_details
ON  orders_details.pizza_id = pizzas.pizza_id
group bY pizza_types.name ORDER BY revenue DESC limit 3;