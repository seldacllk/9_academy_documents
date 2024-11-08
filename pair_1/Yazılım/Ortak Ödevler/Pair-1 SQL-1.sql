select * from products p 

/* 1  */ select product_name, quantity_per_unit from products p

/* 2  */ select product_id, product_name from products p where discontinued = 0

/* 3  */ select product_id, product_name, discontinued from products p where discontinued = 1

/* 4  */ select product_id, product_name, unit_price from products p where unit_price < 20

/* 5  */ select product_id, product_name, unit_price from products p where unit_price<25 and unit_price>15

/* 6 */ select product_name, units_on_order, units_in_stock from products p where  units_in_stock < units_on_order

/* 7 */ select * from products p where product_name like 'A%'

/* 8 */ select * from products p where product_name like '%i'

/* 9 */ select product_name, unit_price, (unit_price+(unit_price*0.18)) as "UnitPriceKDV" from products p

/* 10*/ select COUNT(*) as "UnitPriceCount" from products p where unit_price > 30

/* 11*/ select lower(product_name), unit_price from products p order by unit_price desc

/* 12*/ select first_name || ' ' || last_name as "Employee Name Surname" from employees e 

/* 13*/ select COUNT(*) from suppliers s where region is null  

/* 14*/ select COUNT(*) from suppliers s where region is not null

/* 15*/ select 'TR' || ' ' || upper(product_name) from products p 

/* 16*/ select 'TR' || ' ' || upper(product_name) from products p where unit_price < 20

/* 17*/ select product_name , unit_price from products order by unit_price DESC LIMIT 1;

/* 18*/ select product_name , unit_price from products order by unit_price DESC LIMIT 10;

/* 19*/ select * from products p where p.unit_price > (select avg(unit_price) FROM products p)

/* 20*/ select sum(units_in_stock*unit_price) from products p 

/* 21*/ 
select discontinued, count(*) AS product_count from products 
group by discontinued 
having discontinued IN (0, 1);

/* 22*/ 
select p.product_name, c.category_name 
from products p 
inner join categories c on p.category_id  = c.category_id 

/* 23*/ 
select c.category_name, avg(p.unit_price) 
from categories c 
inner join products p on p.category_id  = c.category_id 
group by c.category_name 

/* 24*/ 
select p.product_name , p.unit_price, c.category_name 
from products p 
inner join categories c on p.category_id  = c.category_id 
order by unit_price DESC LIMIT 1;

select * from order_details od  

/* 25*/ select od.product_id ,p.product_name, c.category_name , s.company_name, sum(od.quantity)  
from products p 
inner join order_details od on p.product_id = od.product_id 
inner join categories c on p.category_id = c.category_id 
inner join suppliers s on p.supplier_id = s.supplier_id 
group by od.product_id, p.product_name, c.category_name , s.company_name
order by sum(od.quantity) DESC LIMIT 1;


/* 26*/ select p.product_id , p.product_name , s.company_name , s.phone  
from products p 
inner join suppliers s on p.supplier_id = s.supplier_id 
where p.units_in_stock = 0 

/* 27*/ 
select
    o.ship_address, e.first_name , e.last_name 
from
    orders o
inner join employees e on o.employee_id = e.employee_id 
where
    DATE_PART('year', o.order_date) = 1998
    and DATE_PART('month', o.order_date) = 3 
   
/* 28*/ 
select count(*) 
from orders o 
where DATE_PART('year', o.order_date) = 1997
and DATE_PART('month', o.order_date) = 2 
    
    
/* 29*/ 
select count(*)  
from orders o
where DATE_PART('year', o.order_date) = 1998 
and o.ship_city = 'London'
    


/* 30*/ 
select distinct 
    c.contact_name, c.phone  
from
    orders o 
inner join customers c on o.customer_id = c.customer_id 
where
    DATE_PART('year', o.order_date) = 1997
    
    
/* 31*/ 
    select * from orders o 
    where freight > 40
    
    
/* 32*/ 
    select o.ship_city , c.company_name from orders o 
    inner join customers c on c.customer_id = o.customer_id 
    where freight > 40
    
/* 33*/ 
	select o.order_date, o.ship_city , upper(e.first_name || e.last_name)
	from orders o 
	inner join employees e on e.employee_id = o.employee_id 
	where DATE_PART('year', o.order_date) = 1997
	    
/* 34*/
	select distinct c.contact_name , REGEXP_REPLACE(c.phone , '[^0-9]', '', 'g') as phone
	from orders o 
	inner join customers c  on c.customer_id  = o.customer_id  
	where DATE_PART('year', o.order_date) = 1997	 
	    
	    
/* 35*/ 
	select o.order_date ,c.contact_name ,e.first_name ,e.last_name 
	from orders o 
	inner join employees e on e.employee_id = o.employee_id 
	inner join customers c  on c.customer_id = o.customer_id 
	
/* 36*/ 
	select * from orders o 		
	where required_date < shipped_date 
	    
/* 37*/ 
	select o.required_date ,o.shipped_date, c.company_name 
	from orders o 	
	inner join customers c  on c.customer_id = o.customer_id 
	where required_date < shipped_date 	  
	
	
/* 38*/ 	
	select p.product_name , c.category_name, od.quantity  
	from order_details od
    inner join products p on od.product_id  = p.product_id
    inner join categories c on p.category_id = c.category_id
	where od.order_id = 10248	
	
/* 39*/	
	select p.product_name, s.company_name  
	from order_details od
    inner join products p on od.product_id  = p.product_id
    inner join suppliers s on p.supplier_id = s.supplier_id 
	where od.order_id = 10248
	
	
/* 40*/	
	select p.product_name , od.quantity 
	from order_details od 
	inner join orders o on od.order_id = o.order_id 
	inner join products p on od.product_id  = p.product_id
	inner join employees e on e.employee_id = o.employee_id 
	where e.employee_id  = 3 and DATE_PART('year', o.order_date) = 1997	
	
/* 41*/	
	select e.employee_id ,e.first_name, e.last_name 
	from orders o 
	inner join order_details od on od.order_id = o.order_id 
	inner join employees e on e.employee_id = o.employee_id 
	where DATE_PART('year', o.order_date) = 1997 
	order by od.quantity DESC LIMIT 1
	
/* 42*/	
	select e.employee_id ,e.first_name, e.last_name, SUM(od.quantity) AS total_quantity
	from orders o 
	inner join order_details od on od.order_id = o.order_id 
	inner join employees e on e.employee_id = o.employee_id 
	where DATE_PART('year', o.order_date) = 1997 
	group by e.employee_id ,e.first_name, e.last_name 
	order by total_quantity DESC limit 1
	
/* 43*/	
	select p.unit_price, p.product_name , c.category_name  from products p 
	inner join categories c on c.category_id  = p.category_id 
	order by p.unit_price DESC limit 1
	
/* 44*/	
	select e.first_name , e.last_name , o.order_date ,o.order_id 
	from orders o 
	inner join employees e on e.employee_id = o.employee_id 
	order by o.order_date 
	
/* 45*/	
	select avg(od.unit_price*od.quantity), o.order_id  from orders o 
	inner join customers c on c.customer_id = o.customer_id 
	inner join order_details od on od.order_id = o.order_id
	GROUP BY o.order_id
	order by o.order_date DESC limit 5
	
	
/* 46*/		
	select p.product_name ,c.category_name ,count(*) 
	from order_details od 
    inner join products p on p.product_id =od.product_id 
    inner join orders o on o.order_id = od.order_id 
    inner join categories c on c.category_id = p.category_id
    where DATE_PART('month', o.order_date) = 1
    group by p.product_name ,c.category_name
    
 /* 47*/
    SELECT *
	FROM order_details
	WHERE quantity > (SELECT AVG(quantity) FROM order_details)

/* 48*/
	select p.product_name ,c.category_name ,s.company_name 
	from order_details od 
	inner join products p on p.product_id = od.product_id 
	inner join categories c on c.category_id  = p.category_id
	inner join suppliers s on s.supplier_id = p.supplier_id 
	WHERE quantity = (SELECT MAX(quantity) FROM order_details)
	
/* 49*/
	select count(distinct country) from customers c 
	
	
/** 50 TODO: **/
select p.product_name , od.quantity 
from order_details od 
inner join orders o on od.order_id = o.order_id 
inner join products p on od.product_id  = p.product_id
inner join employees e on e.employee_id = o.employee_id 
where e.employee_id  = 3  
order by DATE_PART('month', o.order_date) = 1 DESC limit 1

	
SELECT SUM(od.quantity) AS total_quantity_sold
FROM order_details od
INNER JOIN orders o ON od.order_id = o.order_id
INNER JOIN employees e ON e.employee_id = o.employee_id
WHERE e.employee_id = 3
  AND o.order_date >= '2023-01-01' 
  AND o.order_date < current_date 
  
  

/* 63*/
SELECT c.country, COUNT(c.customer_id) AS customer_count
FROM customers c
GROUP BY c.country
ORDER BY customer_count DESC;
  

/* 65*/
select * from

/* 66*/
select e.employee_id, count(o.order_id) from employees e 
inner join orders o on e.employee_id = o.employee_id 
group by e.employee_id 
ORDER BY count(o.order_id) desc

/* 67*/
select * from customers c  
left join orders o on c.customer_id  = o.customer_id
where o.order_id is null

/* 68*/
select c.company_name , c.contact_name , c.address ,c.city ,c.country  
from customers c
where c.country = 'Brazil'

/* 69*/
select *
from customers c
where c.country != 'Brazil'	 

/* 70*/
select *
from customers c
where c.country = 'Spain' or c.country = 'France' or c.country = 'Germany'	

	
/* 71*/	
select * from customers c 
where fax is null

/* 72*/
select *
from customers c
where c.city = 'London' or c.city = 'Paris'

/* 73*/
select *
from customers c
where c.city = 'México D.F.' and c.contact_title = 'Owner'

/* 74*/
select product_name, unit_price from products p 
where product_name like 'C%' 

/* 75*/
select first_name , last_name , birth_date from employees e 
where first_name like 'A%'

/* 76*/
select company_name from customers c 
where upper(company_name) like '%RESTAURANT%'

/* 77*/
select product_name , unit_price  from products p 
where unit_price between 50 and 100

/* 78*/
select order_id , order_date from orders o 
where order_date between '1996-07-01' and '1996-12-31'

/* 81*/
select * from customers c 
order by country 

/* 82*/
select product_name ,unit_price  from products p 
order by unit_price desc 

/* 83*/
select product_name ,unit_price from products p 
order by unit_price desc, units_in_stock 

/* 84*/
select count(*) from products p 
where p.category_id = 1

/* 85*/
select count(distinct country) from customers c 

/* 86*/
select distinct country from customers c

/* 87*/
select * from products p 
order by unit_price desc limit 5

/* 88*/
select count(*)  from customers c 
inner join orders o on o.customer_id = c.customer_id 
where c.customer_id = 'ALFKI'

/* 89*/
select sum(unit_price) as maliyet from products p 

/* 90*/
select sum(unit_price*quantity) as ciro from order_details od

/* 91*/
select avg(unit_price) as ortalama from products p 

/* 92*/
select product_name from products p
order by unit_price desc limit 1

/* 93*/
select min(unit_price*quantity) from order_details od

/* 94*/
select company_name from customers c 
order by length(company_name) desc limit 1

/* 95*/
select first_name , last_name , age(current_date ,birth_date)  from employees e 

/* 96*/
select p.product_name, count(*) from order_details od  
inner join products p on od.product_id = p.product_id
group by p.product_name

/* 97*/
select p.product_name, (p.unit_price*od.quantity) as price from  order_details od
inner join products p on od.product_id = p.product_id

/* 98*/
select category_id, count(*)  from products p
group by category_id  

/* 99*/
select p.product_name from products p 
inner join order_details od on od.product_id = p.product_id 
group by p.product_name 
having sum(od.quantity) > 1000

/*100*/
select * from customers c
left join orders o on c.customer_id = o.customer_id 
where o.order_id is null








