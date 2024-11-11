-- 101. Hangi tedarikçi hangi ürünü sağlıyor ?
select p.product_name
from products p 
where p.supplier_id in (select s.supplier_id from suppliers s)

select p.product_name , s.company_name from products p 
inner join suppliers s on p.supplier_id = s.supplier_id

SELECT p.product_name, (SELECT s.company_name FROM suppliers s WHERE s.supplier_id = p.supplier_id) AS company_name
FROM products p

-- 102. Hangi sipariş hangi kargo şirketi ile ne zaman gönderilmiş..?
select o.order_id, o.order_date , s.company_name  from orders o
inner join shippers s on o.ship_via = s.shipper_id

select o.order_id, (select s.company_name from shippers s where o.ship_via = s.shipper_id) as "kargo şirketi" 
from orders o

-- 103. Hangi siparişi hangi müşteri verir..?
select o.order_id, (select c.company_name from customers c where o.customer_id = c.customer_id) from orders o

-- 104. Hangi çalışan, toplam kaç sipariş almış..?
select o.employee_id, count(o.order_id)  from orders o
group by o.employee_id

-- 105. En fazla siparişi kim almış..?
select o.employee_id, count(o.order_id) as "toplam sipariş"  from orders o
group by o.employee_id
order by "toplam sipariş" desc
limit 1

-- 106. Hangi siparişi, hangi çalışan, hangi müşteri vermiştir..?
select o.order_id , c.company_name , e.first_name || ' ' || e.last_name as "çalışan" from orders o 
inner join customers c on o.customer_id = c.customer_id 
inner join employees e on o.employee_id = e.employee_id 

-- 107. Hangi ürün, hangi kategoride bulunmaktadır..? Bu ürünü kim tedarik etmektedir..?
select p.product_name , 
	(select c.category_name from categories c where p.category_id = c.category_id),
	(select s.company_name from suppliers s where p.supplier_id = s.supplier_id) 
from products p

-- 108. Hangi siparişi hangi müşteri vermiş, hangi çalışan almış, hangi tarihte,
--hangi kargo şirketi tarafından gönderilmiş hangi üründen kaç adet alınmış, hangi fiyattan alınmış, 
--ürün hangi kategorideymiş bu ürünü hangi tedarikçi sağlamış
select 
o.order_id , 
c.company_name "müşteri",
e.first_name || ' ' || e.last_name as "çalışan",
o.order_date,
s.company_name "kargo şirketi",
od.quantity,
od.unit_price,
p.product_name,
s2.company_name as "tedarikçi"
from orders o 
inner join customers c on o.customer_id = c.customer_id 
inner join employees e on o.employee_id = e.employee_id 
inner join shippers s on o.ship_via = s.shipper_id 
inner join order_details od on o.order_id = od.order_id 
inner join products p on od.product_id = p.product_id
inner join suppliers s2 on p.supplier_id = s2.supplier_id 

-- 109. Altında ürün bulunmayan kategoriler
select * from categories c
left join products p on c.category_id = p.category_id
where p.category_id is null


-- 110. Manager ünvanına sahip tüm müşterileri listeleyiniz.
select c.company_name, c.contact_title  from customers c where c.contact_title like '%Manager%'

-- 111. FR ile başlayan 5 karekter olan tüm müşterileri listeleyiniz.
select c.company_name from customers c where c.company_name like 'Fr___%'

-- 112. (171) alan kodlu telefon numarasına sahip müşterileri listeleyiniz.
select c.company_name , c.phone  from customers c where c.phone like '(171)%'

-- 113. BirimdekiMiktar alanında boxes geçen tüm ürünleri listeleyiniz.
select * from products p where p.quantity_per_unit like '%boxes%'

-- 114. Fransa ve Almanyadaki (France,Germany) Müdürlerin (Manager) Adını ve Telefonunu listeleyiniz.(MusteriAdi,Telefon)
select c.contact_name , c.phone  from customers c where country in ('France', 'Germany') and contact_title like ('%Manager%')

-- 115. En yüksek birim fiyata sahip 10 ürünü listeleyiniz.
select  p.product_name , p.unit_price  from products p
order by p.unit_price desc
limit 10

-- 116. Müşterileri ülke ve şehir bilgisine göre sıralayıp listeleyiniz.
select c.company_name , c.country , c.city  from customers c 
group by c.company_name, c.country, c.city

-- 117. Personellerin ad,soyad ve yaş bilgilerini listeleyiniz.
select e.first_name , e.last_name , AGE(current_date, e.birth_date) as yaş from employees e 

-- 118. 35 gün içinde sevk edilmeyen satışları listeleyiniz.
select o.order_id from orders o 
where shipped_date - order_date > 35

-- 119. Birim fiyatı en yüksek olan ürünün kategori adını listeleyiniz. (Alt Sorgu)
select p.product_name, max(unit_price) from products p 
group by p.product_name 


select p.product_name, 
	(select c.category_name from categories c where p.category_id = c.category_id)
from products p 
where p.unit_price = (select max(p2.unit_price) from products p2)

-- 120. Kategori adında 'on' geçen kategorilerin ürünlerini listeleyiniz. (Alt Sorgu)
select * 
from products p 
where p.category_id in (select c.category_id 
                        from categories c 
                        where c.category_name like '%on%')

-- 121. Konbu adlı üründen kaç adet satılmıştır.
select sum(od.quantity) from order_details od 
where od.product_id = (select p.product_id 
						from products p
						where od.product_id = p.product_id and p.product_name = 'Konbu')

-- 122. Japonyadan kaç farklı ürün tedarik edilmektedir.
select distinct p.product_name  from products p
where p.supplier_id in (select s.supplier_id 
						from suppliers s 
						where p.supplier_id = s.supplier_id 
						and s.country = 'Japan')

-- 123. 1997 yılında yapılmış satışların en yüksek, en düşük ve ortalama nakliye ücretlisi ne kadardır?
select max(o.freight), min(o.freight), avg(o.freight)  from orders o
where extract (year from o.order_date) = 1997

-- 124. Faks numarası olan tüm müşterileri listeleyiniz.
select * from customers c 
where c.fax  is not null

-- 125. 1996-07-16 ile 1996-07-30 arasında sevk edilen satışları listeleyiniz. 
select * from orders o 
where o.order_date 
between '1996-07-16' and '1996-07-30'