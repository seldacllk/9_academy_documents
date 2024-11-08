--101. Hangi tedarikçi hangi ürünü sağlıyor ?
select s.company_name , p.product_name  from products p
inner join suppliers s on p.supplier_id = s.supplier_id 

--102. Hangi sipariş hangi kargo şirketi ile ne zaman gönderilmiş..?
select o.order_id , o.ship_name , o.shipped_date  from orders o 

--103. Hangi siparişi hangi müşteri verir..?
select c.company_name , o.order_id  from orders o
inner join customers c on o.customer_id = c.customer_id 

--104. Hangi çalışan, toplam kaç sipariş almış..?
select e.employee_id ,e.first_name , e.last_name , count(*) from employees e 
inner join orders o on e.employee_id = o.employee_id 
group by e.employee_id ,e.first_name , e.last_name

--105. En fazla siparişi kim almış..?
select e.employee_id ,e.first_name , e.last_name , count(*) as TotalOrder from employees e 
inner join orders o on e.employee_id = o.employee_id 
group by e.employee_id ,e.first_name , e.last_name
order by TotalOrder desc limit 1

--106. Hangi siparişi, hangi çalışan, hangi müşteri vermiştir..?
select o.order_id , e.first_name , e.last_name , c.company_name  from orders o 
inner join employees e on o.employee_id = e.employee_id 
inner join customers c on o.customer_id = c.customer_id 

--107. Hangi ürün, hangi kategoride bulunmaktadır..? Bu ürünü kim tedarik etmektedir..?
select p.product_name , c.category_name , s.company_name  from products p 
inner join categories c on p.category_id = c.category_id 
inner join suppliers s on p.supplier_id = s.supplier_id 

--108. Hangi siparişi hangi müşteri vermiş, hangi çalışan almış, hangi tarihte, 
--hangi kargo şirketi tarafından gönderilmiş hangi üründen kaç adet alınmış, hangi 
--fiyattan alınmış, ürün hangi kategorideymiş bu ürünü hangi tedarikçi sağlamış
select o.order_id , c.company_name , e.first_name , e.last_name , o.order_date , o.ship_name , od.quantity , od.unit_price , cat.category_name , s.company_name 
from order_details od 
inner join orders o on od.order_id = o.order_id 
inner join products p on od.product_id = p.product_id 
inner join categories cat on p.category_id = cat.category_id 
inner join suppliers s on p.supplier_id = s.supplier_id 
inner join employees e on o.employee_id = e.employee_id 
inner join customers c on o.customer_id = c.customer_id 

--109. Altında ürün bulunmayan kategoriler
insert into categories (category_id, category_name, description) values (9, 'deneme', 'deneme')

select * from categories c 
left join products p on c.category_id = p.category_id 
where p.category_id is null

--110. Manager ünvanına sahip tüm müşterileri listeleyiniz.
select * from customers c 
where c.contact_title  like '%Manager%'

--111. FR ile başlayan 5 karekter olan tüm müşterileri listeleyiniz.
select * from customers c 
where c.company_name like 'Fr___'

--112. (171) alan kodlu telefon numarasına sahip müşterileri listeleyiniz.
select * from customers c 
where c.phone like '(171)%'

--113. BirimdekiMiktar alanında boxes geçen tüm ürünleri listeleyiniz.
select * from products p 
where p.quantity_per_unit like '%boxes%'

--114. Fransa ve Almanyadaki (France,Germany) Müdürlerin (Manager) Adını ve Telefonunu listeleyiniz.(MusteriAdi,Telefon)
select c.contact_name , c.phone  from customers c 
where (c.country = 'France' or c.country = 'Germany')
and c.contact_title  like '%Manager%'

--115. En yüksek birim fiyata sahip 10 ürünü listeleyiniz.
select * from products p 
order by p.unit_price desc limit 10

--116. Müşterileri ülke ve şehir bilgisine göre sıralayıp listeleyiniz.
select * from customers c 
order by c.country , c.city 

--117. Personellerin ad,soyad ve yaş bilgilerini listeleyiniz.
select e.first_name , e.last_name , age(current_date , e.birth_date)  from employees e 

--118. 35 gün içinde sevk edilmeyen satışları listeleyiniz.
select * from orders o 
where o.shipped_date - o.order_date > 35

--119. Birim fiyatı en yüksek olan ürünün kategori adını listeleyiniz. (Alt Sorgu)
select category_name  from categories c
where category_id =(
	select category_id
	from products p
	where product_id =(
		select product_id
		from products p
		order by unit_price desc limit 1
))

--120. Kategori adında 'on' geçen kategorilerin ürünlerini listeleyiniz. (Alt Sorgu)
select * from products p
where p.category_id in
(select c.category_id  from categories c where c.category_name like '%on%')

--121. Konbu adlı üründen kaç adet satılmıştır.
select sum(od.quantity) from products p 
inner join order_details od on p.product_id = od.product_id 
where p.product_name = 'Konbu'

--122. Japonyadan kaç farklı ürün tedarik edilmektedir.
select distinct count(*) from products p 
inner join suppliers s on p.supplier_id = s.supplier_id 
where s.country = 'Japan'

--123. 1997 yılında yapılmış satışların en yüksek, en düşük ve ortalama nakliye ücretlisi ne kadardır?
select MAX(o.freight), MIN(o.freight), AVG(o.freight) from orders o 
where date_part('year', o.order_date) = 1997 

--124. Faks numarası olan tüm müşterileri listeleyiniz.
select * from customers c
where c.fax is not null

--125. 1996-07-16 ile 1996-07-30 arasında sevk edilen satışları listeleyiniz. 
select * from orders o 
where o.shipped_date between '1996-07-16' and '1996-07-30'