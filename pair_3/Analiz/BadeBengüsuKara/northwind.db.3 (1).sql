--SQL WORKSHOP 2
--1  Her kategorideki (CategoryID) ürün sayısını gösteren bir sorgu yazın.
SELECT COUNT(DISTINCT(productid)) AS 'NUMBER OF PRODUCTS' , categoryid AS 'CATEGORY 'FROM Products
GROUP BY categoryid
--2  Birim fiyatı en yüksek 5 ürünü listeleyin.
SELECT productname AS 'PRODUCT NAME', unitprice 'UNIT PRICE' FROM Products
ORDER BY unitprice desc LIMIT 5
--3  Her tedarikçinin sattığı ürünlerin ortalama fiyatını listeleyin.
SELECT supplierid 'SUPPLIER', ROUND(AVG(unitprice),3) AS 'AVERAGE PRICE' FROM Products
GROUP BY supplierid ORDER BY AVG(unitprice) DESC
--4  "Products" tablosunda birim fiyatı 100'den büyük olan ürünlerin kategorilerini ve bu kategorilerdeki ortalama fiyatı listeleyin.
SELECT categoryid, ROUND(AVG(unitprice),3) AS 'AVERAGE PRICE' FROM Products
WHERE unitprice>100
GROUP BY categoryid
--5  "OrderDetails" tablosunda birim fiyat ve miktar çarpımıyla toplam satış değeri 1000'den fazla olan siparişleri listeleyin.
SELECT *,(quantity*unitprice) AS 'TOTAL PRICE' FROM 'Order Details'
WHERE (quantity*unitprice)>1000 ORDER BY (quantity*unitprice) DESC
--6  En son sevk edilen 10 siparişi listeleyin.
SELECT * FROM Orders WHERE shippeddate IS NOT NULL
ORDER BY shippeddate DESC LIMIT 10
--7  "Products" tablosundaki ürünlerin ortalama fiyatını hesaplayın.
SELECT ROUND(AVG(unitprice),4) AS 'AVERAGE PRICE' FROM Products
--8  "Products" tablosunda fiyatı 50’den büyük olan ürünlerin toplam stok miktarını hesaplayın.
SELECT  SUM(unitsinstock) AS 'TOTAL STOCK OF PRODUCTS WHOSE PRICE ARE MORE THAN 50 'FROM Products WHERE unitprice >50
--9  "Orders" tablosundaki en eski sipariş tarihini bulun.
SELECT shippeddate FROM Orders WHERE shippeddate IS NOT NULL
ORDER BY shippeddate ASC LIMIT 1
--10  "Employees" tablosundaki çalışanların kaç yıl önce işe başladıklarını gösteren bir sorgu yazın.
SELECT employeeid,firstname||' '||lastname AS 'FULL NAME',CAST(strftime('%Y', 'now') - strftime('%Y', hiredate) AS INTEGER) AS 'YEAR DIFFERENCE'
FROM Employees
--11  "OrderDetails" tablosundaki her bir sipariş için, birim fiyatın toplamını yuvarlayarak (ROUND) hesaplayın.
SELECT orderid,ROUND(SUM((unitprice*quantity)-(discount*quantity))) AS 'ROUNDED TOTAL PRICE' FROM 'Order Details'
GROUP BY orderid ORDER BY ROUND(SUM((unitprice*quantity)-(discount*quantity))) ASC
--12  "Products" tablosunda stoktaki (UnitsInStock) ürün sayısını gösteren bir COUNT sorgusu yazın.
SELECT SUM(unitsinstock) 'ALL PRODUCTS IN STOCK' FROM Products
--13  "Products" tablosundaki en düşük ve en yüksek fiyatları hesaplayın.
SELECT productid,productname, unitprice FROM Products
WHERE unitprice=(select MAX(unitprice) from Products) OR unitprice=(select MIN(unitprice) from Products)
--14  "Orders" tablosunda her yıl kaç sipariş alındığını listeleyin (YEAR() fonksiyonunu kullanarak).
select strftime('%Y',orderdate) as 'YEAR', COUNT(orderid) AS 'NUMBER OF ORDERS' FROM Orders
GROUP BY strftime('%Y',orderdate)
--15  "Employees" tablosundaki çalışanların tam adını (FirstName + LastName) birleştirerek gösterin.
SELECT firstname|| ' '|| lastname AS 'FULL NAME' FROM Employees
--16  "Customers" tablosundaki şehir adlarının uzunluğunu (LENGTH) hesaplayın.
SELECT city,LENGTH(city) AS 'LENGTH' FROM Customers
--17  "Products" tablosundaki her ürünün fiyatını iki ondalık basamağa yuvarlayarak gösterin.
SELECT productid,productname,ROUND(unitprice,2) AS 'ROUNDED PRICE' FROM Products
--18  "Orders" tablosundaki tüm siparişlerin toplam sayısını bulun.
SELECT COUNT(orderid) AS 'TOTAL ORDER NUMBER' FROM Orders
--19  "Products" tablosunda her kategorideki (CategoryID) ürünlerin ortalama fiyatını (AVG) hesaplayın.
SELECT ROUND(AVG(unitprice),3) AS 'AVERAGE PRICE', categoryid 'CATEGORY ID'
FROM PRODUCTS GROUP BY categoryid
--20  "Orders" tablosunda sevk tarihi (ShippedDate) boş olan siparişlerin yüzdesini (COUNT ve toplam sipariş sayısını kullanarak) hesaplayın.
SELECT (SELECT count(orderid) FROM Orders WHERE orderdate IS NULL)  / 
(SELECT count(orderid) FROM Orders) AS 'PERCENTAGE OF ORDERS THAT DONT HAVE ORDER DATE'
--21  "Products" tablosundaki en pahalı ürünün fiyatını bulun ve bir fonksiyon kullanarak fiyatı 10% artırın.
SELECT productname,(unitprice*1.1) FROM Products where unitprice=(select max(unitprice) from products)
--22  "Products" tablosundaki ürün adlarının ilk 3 karakterini gösterin (SUBSTRING).
select productname 'PRODUCT NAME',substring(productname,1,3) 'FIRST THREE LETTERS' FROM Products
--23  "Orders" tablosunda verilen siparişlerin yıl ve ay bazında kaç sipariş alındığını hesaplayın (YEAR ve MONTH fonksiyonları).
SELECT strftime('%Y',orderdate) AS 'YEAR',strftime('%m',orderdate) AS 'MONTH',COUNT(orderid) 'NUMBER OF ORDERS' 
FROM Orders GROUP BY strftime('%Y',orderdate),strftime('%m',orderdate)
--24  "OrderDetails" tablosunda toplam sipariş değerini (UnitPrice * Quantity) hesaplayıp, bu değeri iki ondalık basamağa yuvarlayarak gösterin.
SELECT orderid, ROUND((UnitPrice * Quantity),2) AS 'TOTAL PRICE' FROM 'Order Details' GROUP BY orderid
--25  "Products" tablosunda stokta olmayan (UnitsInStock = 0) ürünlerin fiyatlarını toplam fiyat olarak hesaplayın.
SELECT SUM(unitprice) 'TOTAL PRICE OF PRODUCTS WITHOUT STOCK' FROM Products WHERE unitsinstock=0












