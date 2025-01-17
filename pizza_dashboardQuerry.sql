select * from pizzacsv
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales
select sum(quantity) as  Total_pizza_sold from pizzacsv
select count(distinct order_id) as Total_orders from pizzacsv
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizzacsv
--daily trends
select DATENAME(DW, order_date)as order_day, count(distinct order_id) as total_orders
from pizzacsv
group by DATENAME(DW, order_date)
--hourlu trends
select DATEPART(HOUR, order_time) as order_hours, count(distinct order_id) as Total_orders
from pizzacsv
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)
-- % of sales by pizza category

select pizza_category, (sum(total_price)*100)/(select sum(total_price) from pizzacsv) as Total_salesPerc
from pizzacsv
group by pizza_category
-- % of sales by pizza category(FILTERED= for january only)

select pizza_category,sum(total_price)as total_sale, (sum(total_price)*100)/(select sum(total_price) from pizzacsv where MONTH(order_date)=1) as Total_salesPerc
from pizzacsv
where MONTH(order_date)=1
group by pizza_category order by Total_salesPerc asc
--% of sales by pizza_size 
select pizza_size,sum(total_price)as total_sale, (sum(total_price)*100)/(select sum(total_price) from pizzacsv) as Total_salesPerc
from pizzacsv
group by pizza_size order by pizza_size asc
--% of sales by pizza_size upto 2 decimal
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizzacsv) AS DECIMAL(10,2)) AS PCT
FROM pizzacsv
GROUP BY pizza_size
ORDER BY pizza_size
--Total Pizzas Sold by Pizza Category
select pizza_category, sum(quantity)as total_quantity_sold
from pizzacsv
group by pizza_category
order by pizza_category asc
--Top 5 Best Sellers by Total Pizzas Sold
select top 5 pizza_name, SUM(quantity)as total_sold
from pizzacsv
group by pizza_name
order by total_sold desc 
--bottom 5 worst Sellers by Total Pizzas Sold
select top 5 pizza_name, SUM(quantity)as total_sold
from pizzacsv
group by pizza_name
order by total_sold asc 
