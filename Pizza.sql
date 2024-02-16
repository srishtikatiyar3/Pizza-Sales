USE pizza_sales;

--KPIs
--1) TOTAL REVENUE
select round(sum(quantity*price),2) as [Total Revenue]
from order_details as o
join pizzas as p
on o.pizza_id= p.pizza_id;

--2)AVERAGE ORDER VALUE
select round(sum(quantity*price)/count(distinct order_id),2) as [Average Order Value]
from order_details as o
join pizzas as p
on o.pizza_id= p.pizza_id;

--3)TOTAL PIZZAS SOLD
select sum(quantity) as [Total Pizzas Sold]
from order_details;

--4)TOTAL ORDERS
select count(distinct order_id) as [Total Orders]
from order_details;

--5)AVERAGE PIZZA PER ORDER
select sum(quantity)/count(distinct order_id) as [Average Pizzas Per Order]
from order_details;

--QUESTION

--Q1)Dailty trends for total orders
select FORMAT(date,'dddd') as DayOfWeek ,
count(distinct order_id) as [Total Orders]
from orders
group by format(date,'dddd')
order by [Total Orders] desc;


--Q2)Hourly trends for toal orders
select DATEPART(HOUR,time) as [Hour],
count(distinct order_id) as [Total Orders]
from orders
group by DATEPART(HOUR,time)
order by [Total Orders] desc;


--Q3)Percentage of sales by pizza category
select category, 
sum(quantity*price) as revenue,
round(sum(quantity*price)*100/(
select sum(quantity*price)
from pizzas as p2
join order_details as od2
on p2.pizza_id=od2.pizza_id),2) as [Percentage Sales]
from pizzas as p
join pizza_types as pt
on p.pizza_type_id=pt.pizza_type_id
join order_details as od
on p.pizza_id=od.pizza_id
group by category
order by [Percentage Sales] desc ;

--Q4)Percentage of sales by pizza size
select size, 
sum(quantity*price) as revenue,
round(sum(quantity*price)*100/(
select sum(quantity*price)
from pizzas as p2
join order_details as od2
on p2.pizza_id=od2.pizza_id),2) as [Percentage Sales]
from pizzas as p
join order_details as od
on p.pizza_id=od.pizza_id
group by size
order by [Percentage Sales] desc ;


--Q5)Total pizzas sold by pizza catgory
select category,sum(quantity) as [Quantity Sold]
from pizzas as p
join pizza_types as pt
on p.pizza_type_id=pt.pizza_type_id
join order_details as od
on p.pizza_id=od.pizza_id
group by category
order by sum(quantity) desc;



--Q6)Top 5 best sellers by pizzas sold
select top 5 name, sum(quantity) as[Quantity Sold]
from pizzas as p
join pizza_types as pt
on p.pizza_type_id=pt.pizza_type_id
join order_details as od
on p.pizza_id=od.pizza_id
group by name
order by [Quantity Sold] desc;


--Q7)Bottom 5 worst sellers by pizzas sold
select top 5 name, sum(quantity) as[Quantity Sold]
from pizzas as p
join pizza_types as pt
on p.pizza_type_id=pt.pizza_type_id
join order_details as od
on p.pizza_id=od.pizza_id
group by name
order by [Quantity Sold] ;





