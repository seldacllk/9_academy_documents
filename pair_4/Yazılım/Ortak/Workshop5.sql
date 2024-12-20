--1. Product isimlerini (`ProductName`) ve birim başına miktar (`QuantityPerUnit`) değerlerini almak için sorgu yazın.
   select p.product_name as "ProductName", p.quantity_per_unit as "QuantityPerUnit" from products p

--2. Ürün Numaralarını (`ProductID`) ve Product isimlerini (`ProductName`) değerlerini almak için sorgu yazın. Artık satılmayan ürünleri (`Discontinued`) filtreleyiniz.
   select p.product_id as "ProductID", p.product_name as "ProductName" from products p 
   where p.discontinued = 1

--3. Durdurulan Ürün Listesini, Ürün kimliği ve ismi (`ProductID`, `ProductName`) değerleriyle almak için bir sorgu yazın.
   select p.product_id as "ProductID", p.product_name as "ProductName" from products p 
   where p.discontinued = 0

--4. Ürünlerin maliyeti 20dan az olan Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
   select p.product_id as "ProductID", p.product_name as "ProductName", p.unit_price as "UnitPrice" from products p 
   where p.unit_price < 20
   

--5. Ürünlerin maliyetinin 15 ile 25 arasında olduğu Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
   select p.product_id as "ProductID", p.product_name as "ProductName", p.unit_price as "UnitPrice" from products p 
   where p.unit_price between 15 and 25

--6. Ürün listesinin (`ProductName`, `UnitsOnOrder`, `UnitsInStock`) stoğun siparişteki miktardan az olduğunu almak için bir sorgu yazın.
   select  p.product_name as ProductName,p.units_on_order as UnitsOnOrder, p.units_in_stock as UnitsInStock from products p 
   where p.units_in_stock < p.units_on_order

--7. İsmi `a` ile başlayan ürünleri listeleyeniz.
   select p.product_name from products p where p.product_name like 'a%'

--8. İsmi `i` ile biten ürünleri listeleyeniz.
   select p.product_name from products p where p.product_name like '%i'

--9. Ürün birim fiyatlarına %18’lik KDV ekleyerek listesini almak (ProductName, UnitPrice, UnitPriceKDV) için bir sorgu yazın.
   select p.product_name as "ProductName", p.unit_price as "UnitPrice", (p.unit_price * 1.18) as "UnitPriceKDV" from products p 

--10. Fiyatı 30 dan büyük kaç ürün var?
    select count(*) from products p where p.unit_price > 30  
    
--11. Ürünlerin adını tamamen küçültüp fiyat sırasına göre tersten listele
    select lower(p.product_name) from products p order by p.unit_price desc 

--12. Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır
    select e.first_name  || ' ' || e.last_name from employees e 

--13. Region alanı NULL olan kaç tedarikçim var?
    select count(*) from suppliers where region is null  

--14. a.Null olmayanlar?
    select count(*) from suppliers where region is not null 
    
--15. Ürün adlarının hepsinin soluna TR koy ve büyültüp olarak ekrana yazdır.
    select 'TR ' || upper(p.product_name) from products p  
    
--16. a.Fiyatı 20den küçük ürünlerin adının başına TR ekle
    select 'TR ' || p.product_name from products p 
    where p.unit_price < 20

--17. En pahalı ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
    select p.product_name as "ProductName", p.unit_price as "UnitPrice" from products p 
    order by p.unit_price desc
    limit 1
    
--18. En pahalı on ürünün Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
    select p.product_name as "ProductName", p.unit_price as "UnitPrice" from products p 
    order by p.unit_price desc
    limit 10
    
--19. Ürünlerin ortalama fiyatının üzerindeki Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
    select p.product_name as "ProductName", p.unit_price as "UnitPrice" from products p 
    where p.unit_price > (select avg(p.unit_price) from products p) 

--20. Stokta olan ürünler satıldığında elde edilen miktar ne kadardır.
    select SUM(p.unit_price * p.units_in_stock) as "TotalValue" from products p 
    
--21. Mevcut ve Durdurulan ürünlerin sayılarını almak için bir sorgu yazın.
    select count(*) from products p
    where p.units_in_stock > 0 and 
    p.discontinued = 1 
        
--22. Ürünleri kategori isimleriyle birlikte almak için bir sorgu yazın.
    select p.product_name "ProductName", c.category_name "CategoryName" from products p 
    inner join categories c on p.category_id = c.category_id

--23. Ürünlerin kategorilerine göre fiyat ortalamasını almak için bir sorgu yazın.
    select c.category_name "CategoryName", avg(p.unit_price) as "AveragePrice" from products p 
    inner join categories c on p.category_id = c.category_id
    group by c.category_name

--24. En pahalı ürünümün adı, fiyatı ve kategorisin adı nedir?
    select p.product_name "ProductName", p.unit_price "UnitPrice", c.category_name "CategoryName" from products p 
    inner join categories c on p.category_id = c.category_id
    order by p.unit_price
    desc limit 1

--25. En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı
     select p.product_name "ProductName", c.category_name "CategoryName", s.company_name "CompanyName" from products p 
     inner join categories c on p.category_id = c.category_id
     inner join suppliers s on p.supplier_id = s.supplier_id
     
--26. Stokta bulunmayan ürünlerin ürün listesiyle birlikte tedarikçilerin ismi ve iletişim numarasını (`ProductID`, `ProductName`, `CompanyName`, `Phone`) almak için bir sorgu yazın
     select p.product_id as "ProductID", p.product_name as "ProductName", s.company_name "CompanyName", s.phone "Phone" from products p 
     inner join suppliers s on p.supplier_id = s.supplier_id
       
--27. 1998 yılı mart ayındaki siparişlerimin adresi, siparişi alan çalışanın adı, çalışanın soyadı
    select o.ship_address "ShipAddress", e.first_name "FirstName", e.last_name "LastName" from orders o 
    inner join employees e on o.employee_id = e.employee_id
    where o.order_date between '1998-03-01' and '1998-03-31'
    
--28. 1997 yılı şubat ayında kaç siparişim var?
    select count(*) from orders o 
    where o.order_date between '1997-02-01' and '1997-02-28'

--29. London şehrinden 1998 yılında kaç siparişim var?
    select count(*) from orders o 
    where o.ship_city = 'London' and 
    (o.order_date between '1998-01-01' and '1998-12-31')

--30. 1997 yılında sipariş veren müşterilerimin contactname ve telefon numarası
    select c.contact_name , c.phone from customers c 
    inner join orders o on o.customer_id = c.customer_id 
    where (o.order_date between '1997-01-01' and '1997-12-31')
 
--31. Taşıma ücreti 40 üzeri olan siparişlerim
    select o.order_id from orders o 
    where o.freight > 40

--32. Taşıma ücreti 40 ve üzeri olan siparişlerimin şehri, müşterisinin adı
    select o.ship_city, c.contact_name from orders o 
    inner join customers c on o.customer_id = c.customer_id 
    where o.freight >= 40;
    
--33. 1997 yılında verilen siparişlerin tarihi, şehri, çalışan adı -soyadı ( ad soyad birleşik olacak ve büyük harf),
    select o.order_date, o.ship_city, upper(e.first_name  || ' ' || e.last_name) from orders o 
    inner join employees e on o.employee_id = e.employee_id
    where (o.order_date between '1997-01-01' and '1997-12-31')
 
--34. 1997 yılında sipariş veren müşterilerin contactname i, ve telefon numaraları ( telefon formatı 2223322 gibi olmalı )
    select c.contact_name, RIGHT(regexp_replace(c.phone, '[^0-9]', '', 'g'), 11) AS formatted_phone from customers c 
    inner join orders o on o.customer_id = c.customer_id 
    where (o.order_date between '1997-01-01' and '1997-12-31')

--35. Sipariş tarihi, müşteri contact name, çalışan ad, çalışan soyad
    select o.order_date , c.contact_name , e.first_name, e.last_name from orders o 
    inner join customers c on o.customer_id = c.customer_id 
    inner join employees e on o.employee_id = e.employee_id

--36. Geciken siparişlerim?
    select * from orders o 
    where o.shipped_date > o.required_date
 
--37. Geciken siparişlerimin tarihi, müşterisinin adı
    select o.order_date, c.contact_name from orders o
    inner join customers c on o.customer_id = c.customer_id
    where o.shipped_date > o.required_date
        
--38. 10248 nolu siparişte satılan ürünlerin adı, kategorisinin adı, adedi
    select p.product_name, c.category_name, od.quantity from order_details od 
    inner join products p on od.product_id = p.product_id
    inner join categories c on p.category_id = c.category_id
    where od.order_id =10248

--39. 10248 nolu siparişin ürünlerinin adı , tedarikçi adı
    select p.product_name, s.company_name from products p 
    inner join order_details od on p.product_id = od.product_id
    inner join suppliers s on p.supplier_id = s.supplier_id
    where od.order_id = 10248
    

--40. 3 numaralı ID ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti
    select p.product_name, od.quantity from orders o 
    inner join employees e on o.employee_id = o.employee_id
    inner join order_details od  on o.order_id = od.order_id
    inner join products p on od.product_id = p.product_id
    where e.employee_id = 3 and 
    EXTRACT(YEAR FROM o.order_date) = 1997
    
--41. 1997 yılında bir defasinda en çok satış yapan çalışanımın ID,Ad soyad
    select e.employee_id, e.first_name, e.last_name from employees e 
    inner join orders o on e.employee_id = o.employee_id
    inner join order_details od on o.order_id = od.order_id
    where EXTRACT(YEAR FROM o.order_date) = 1997
    order by od.quantity desc
    limit 1
    
    
--42. 1997 yılında en çok satış yapan çalışanımın ID,Ad soyad ****
    select e.employee_id, e.first_name, e.last_name from employees e 
    inner join orders o on e.employee_id = o.employee_id
    inner join order_details od on o.order_id = od.order_id
    where EXTRACT(YEAR FROM o.order_date) = 1997
    group by e.employee_id
    order by sum(od.quantity) desc
    limit 1 

--43. En pahalı ürünümün adı,fiyatı ve kategorisin adı nedir?
    select p.unit_price, p.product_name, c.category_name from products p 
    inner join categories c on p.category_id = c.category_id
    order by p.unit_price desc 
    limit 1

--44. Siparişi alan personelin adı,soyadı, sipariş tarihi, sipariş ID. Sıralama sipariş tarihine göre
      select e.first_name, e.last_name, o.order_date, o.order_id from orders o 
      inner join employees e on o.employee_id = e.employee_id
      order by o.order_date

--45. SON 5 siparişimin ortalama fiyatı ve orderid nedir?
      select o.order_id, avg(od.unit_price * od.quantity) from order_details od
      inner join orders o on o.order_id = od.order_id
      group by o.order_id
      order by o.order_date desc
      limit 5
         
--46. Ocak ayında satılan ürünlerimin adı ve kategorisinin adı ve toplam satış miktarı nedir?
      select p.product_name, c.category_name, sum(od.quantity) from order_details od 
      inner join products p on od.product_id = p.product_id
      inner join categories c on p.category_id = c.category_id
      inner join orders o on od.order_id = o.order_id
      where extract(month from o.order_date) = 1
      group by p.product_name, c.category_name
    
--47. Ortalama satış miktarımın üzerindeki satışlarım nelerdir?
      select o.order_id , od.quantity  from orders o
      inner join order_details od on o.order_id = od.order_id
      where od.quantity > (select avg(od2.quantity)  from order_details od2)
        

--48. En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı
      select p.product_name, c.category_name, s.company_name, sum(od.quantity) as "total" from order_details od 
      inner join products p on od.product_id = p.product_id
      inner join categories c on p.category_id = c.category_id
      inner join suppliers s on p.supplier_id = s.supplier_id
      group by p.product_name, c.category_name, s.company_name
      order by "total" desc 
      limit 1

--49. Kaç ülkeden müşterim var
     select count(distinct c.country) from customers c
     
--50. 3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?
     select sum(od.unit_price * od.quantity) from orders o 
     join order_details od on o.order_id = od.order_id
     where o.employee_id = 3 and 
     o.order_date >= '1998-01-01'

--63. Hangi ülkeden kaç müşterimiz var
     select c.country, count(*) from customers c 
     group by c.country
     
--65. 10 numaralı ID ye sahip ürünümden son 3 ayda ne kadarlık ciro sağladım?
     select sum(od.unit_price * od.quantity) from order_details od 
     join orders o on od.order_id = o.order_id
     where od.product_id = 10 and o.order_date >= '1998-02-06'

--66. Hangi çalışan şimdiye kadar toplam kaç sipariş almış..?
     select o.employee_id, count(o.order_id) from orders o 
     group by o.employee_id

--67. 91 müşterim var. Sadece 89’u sipariş vermiş. Sipariş vermeyen 2 kişiyi bulun
     select c.customer_id, c.company_name from customers c 
     left join orders o on c.customer_id = o.customer_id
     where o.order_id is null
    
--68. Brazil’de bulunan müşterilerin Şirket Adı, TemsilciAdi, Adres, Şehir, Ülke bilgileri
      select c.company_name, c.contact_name, c.address, c.city, c.country from customers c 
      where c.country = 'Brazil'
  
--69. Brezilya’da olmayan müşteriler
      select c.company_name, c.contact_name, c.address, c.city, c.country from customers c 
      where c.country != 'Brazil'

--70. Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
      select c.company_name, c.contact_name, c.address, c.city, c.country from customers c 
      where c.country in ('Spain', 'France', 'Germany')
      
--71. Faks numarasını bilmediğim müşteriler
    select * from customers c 
    where c.fax is null 

--72. Londra’da ya da Paris’de bulunan müşterilerim
    select * from customers c 
    where c.city in ('London', 'Paris')
--73. Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müşteriler
    select *from customers c 
    where c.city = 'México D.F.' and c.contact_title = 'Owner'

--74. C ile başlayan ürünlerimin isimleri ve fiyatları
    select p.product_name, p.unit_price from products p 
    where p.product_name like 'C%'
--75. Adı (FirstName) ‘A’ harfiyle başlayan çalışanların (Employees); Ad, Soyad ve Doğum Tarihleri
    select e.first_name, e.last_name, e.birth_date from employees e 
    where e.first_name like 'A%'

--76. İsminde ‘RESTAURANT’ geçen müşterilerimin şirket adları
     select c.company_name from customers c 
     where c.company_name like '%Restaurant%'
 
--77. 50$ ile 100$ arasında bulunan tüm ürünlerin adları ve fiyatları
      select p.product_name, p.unit_price from products p 
      where p.unit_price between 50 and 100
 
--78. 1 temmuz 1996 ile 31 Aralık 1996 tarihleri arasındaki siparişlerin (Orders), SiparişID (OrderID) ve SiparişTarihi (OrderDate) bilgileri
    select o.order_id, o.order_date from orders o 
    where o.order_date between '1996-07-01' and '1996-12-31'
    
--81. Müşterilerimi ülkeye göre sıralıyorum:
    select * from customers c 
    order by c.country

--82. Ürünlerimi en pahalıdan en ucuza doğru sıralama, sonuç olarak ürün adı ve fiyatını istiyoruz
    select p.product_name, p.unit_price from products p 
    order by p.unit_price desc 

--83. Ürünlerimi en pahalıdan en ucuza doğru sıralasın, ama stoklarını küçükten-büyüğe doğru göstersin sonuç olarak ürün adı ve fiyatını istiyoruz
    select p.product_name, p.unit_price from products p 
    order by p.unit_price desc, p.units_in_stock asc 
    
--84. 1 Numaralı kategoride kaç ürün vardır..?
    select count(*) from products p 
    where p.category_id = 1

--85. Kaç farklı ülkeye ihracat yapıyorum..?
    select count(distinct c.country) from customers c  
 
--86. a.Bu ülkeler hangileri..?
    select distinct c.country from customers c 

--87. En Pahalı 5 ürün
    select * from products p 
    order by p.unit_price desc  
    limit 5

--88. ALFKI CustomerID’sine sahip müşterimin sipariş sayısı..?
     select count(*) from orders o 
     where o.customer_id = 'ALFKI'

--89. Ürünlerimin toplam maliyeti
    select sum(p.unit_price) from products p  

--90. Şirketim, şimdiye kadar ne kadar ciro yapmış..?
    select sum(od.unit_price * od.quantity) from order_details od 

--91. Ortalama Ürün Fiyatım
    select avg(p.unit_price) from products p  

--92. En Pahalı Ürünün Adı
     select p.product_name from products p 
     order by p.unit_price desc 
     limit 1 
     
--93. En az kazandıran sipariş
    select od.order_id, sum(od.unit_price * od.quantity) AS total from order_details od 
    group by od.order_id
    order by total asc 
    limit 1
    
--94. Müşterilerimin içinde en uzun isimli müşteri
    select c.company_name, Max(CHAR_LENGTH(company_name)) from customers c 
    group by c.company_name 
    limit 1
 --95. Çalışanlarımın Ad, Soyad ve Yaşları
    select e.first_name, e.last_name, extract(year from AGE(e.birth_date)) from employees e 
 
--96. Hangi üründen toplam kaç adet alınmış..?
     select p.product_name, sum(od.quantity) from products p 
     inner join order_details od on p.product_id = od.product_id
     group by p.product_name
     
--97. Hangi siparişte toplam ne kadar kazanmışım..?
    select o.order_id, sum(od.unit_price * od.quantity) from orders o 
    inner join order_details od on o.order_id = od.order_id
    group by o.order_id

--98. Hangi kategoride toplam kaç adet ürün bulunuyor..?
   select c.category_name, count(p.product_id) from categories c 
   inner join products p on c.category_id = p.category_id
   group by c.category_name

--99. 1000 Adetten fazla satılan ürünler?
    select p.product_name, sum(od.quantity) from products p 
    inner join order_details od on p.product_id = od.product_id
    group by p.product_name
    having sum(od.quantity )> 1000

--100. Hangi Müşterilerim hiç sipariş vermemiş..? (edited) 
    select c.customer_id, c.company_name from customers c 
    left join orders o on c.customer_id = o.customer_id
    where o.order_id is null 
   

