Her kategorideki (CategoryID) ürün sayısını gösteren bir sorgu yazın.
Birim fiyatı en yüksek 5 ürünü listeleyin.
Her tedarikçinin sattığı ürünlerin ortalama fiyatını listeleyin.
"Products" tablosunda birim fiyatı 100'den büyük olan ürünlerin kategorilerini ve bu kategorilerdeki ortalama fiyatı listeleyin.
"OrderDetails" tablosunda birim fiyat ve miktar çarpımıyla toplam satış değeri 1000'den fazla olan siparişleri listeleyin.
En son sevk edilen 10 siparişi listeleyin.
"Products" tablosundaki ürünlerin ortalama fiyatını hesaplayın.
"Products" tablosunda fiyatı 50’den büyük olan ürünlerin toplam stok miktarını hesaplayın.
"Orders" tablosundaki en eski sipariş tarihini bulun.
"Employees" tablosundaki çalışanların kaç yıl önce işe başladıklarını gösteren bir sorgu yazın.
"OrderDetails" tablosundaki her bir sipariş için, birim fiyatın toplamını yuvarlayarak (ROUND) hesaplayın.
"Products" tablosunda stoktaki (UnitsInStock) ürün sayısını gösteren bir COUNT sorgusu yazın.
"Products" tablosundaki en düşük ve en yüksek fiyatları hesaplayın.
"Orders" tablosunda her yıl kaç sipariş alındığını listeleyin (YEAR() fonksiyonunu kullanarak).
"Employees" tablosundaki çalışanların tam adını (FirstName + LastName) birleştirerek gösterin.
"Customers" tablosundaki şehir adlarının uzunluğunu (LENGTH) hesaplayın.
"Products" tablosundaki her ürünün fiyatını iki ondalık basamağa yuvarlayarak gösterin.
"Orders" tablosundaki tüm siparişlerin toplam sayısını bulun.
"Products" tablosunda her kategorideki (CategoryID) ürünlerin ortalama fiyatını (AVG) hesaplayın.
"Orders" tablosunda sevk tarihi (ShippedDate) boş olan siparişlerin yüzdesini (COUNT ve toplam sipariş sayısını kullanarak) hesaplayın.
"Products" tablosundaki en pahalı ürünün fiyatını bulun ve bir fonksiyon kullanarak fiyatı 10% artırın.
"Products" tablosundaki ürün adlarının ilk 3 karakterini gösterin (SUBSTRING).
"Orders" tablosunda verilen siparişlerin yıl ve ay bazında kaç sipariş alındığını hesaplayın (YEAR ve MONTH fonksiyonları).
"OrderDetails" tablosunda toplam sipariş değerini (UnitPrice * Quantity) hesaplayıp, bu değeri iki ondalık basamağa yuvarlayarak gösterin.
"Products" tablosunda stokta olmayan (UnitsInStock = 0) ürünlerin fiyatlarını toplam fiyat olarak hesaplayın.

--Q1
SELECT categoryid, COUNT(*) AS 'Ürün sayısı' FROM Products
GROUP BY categoryid;

--Q2
SELECT productname AS 'name', unitprice AS 'fiyat' FROM Products
Order BY unitprice DESC
LIMIT 5

--Q3
SELECT supplierid as 'supplier', avg(unitprice) as 'ortalama' FROM Products
GROUP by supplierid

--Q4
SELECT categoryid as 'kategori', avg(unitprice) FROM Products
WHERE unitprice>100
GROUP by categoryid

--Q5
SELECT * from OrderDetails
WHERE unitprice*quantity>1000

--Q6
SELECT orderid, shippeddate FROM Orders
WHERE shippeddate IS NOT NULL
ORDER BY shippeddate DESC
LIMIT 10

--Q7
SELECT COUNT(productid) as 'ürün adedi', avg(unitprice) as 'ortalama fiyat' FROM Products

--Q8
SELECT count(productid) as 'ürün adedi', sum(unitsinstock) as 'toplam stok' from Products
where unitprice>50

--Q9
SELECT orderid, min(shippeddate) as 'teslim tarihi' FROM Orders

--Q10
SELECT CONCAT(firstname, ' ', lastname) as 'kişi',hiredate AS 'alım tarihi', (strftime('%Y', 'now') - strftime('%Y', HireDate)) AS 'kaç yıldır' from Employees

--Q11
SELECT orderid, ROUND(SUM(UnitPrice * Quantity)) as 'birim fiyat' FROM OrderDetails
GROUP BY orderid

--Q12
SELECT COUNT(productid) as 'toplam ürün', sum(unitsinstock) 'toplam stok' from Products

--Q13
SELECT max(unitprice) as 'en yüksek fiyat', min(unitprice) as 'en düşük fiyat' FROM Products

--Q14
SELECT strftime('%Y', orderdate) AS yıl, COUNT(*) AS miktar FROM Orders
GROUP BY yıl;

--Q15
SELECT concat(firstname, ' ', lastname) as 'isim-soyisim' FROM Employees

--Q16
SELECT city, length(city) as uzunluk FROM Employees
GROUP by city

--Q17
SELECT productname as isim, round(unitprice,2) as fiyat from Products

--Q18
SELECT count(*) as 'toplam sipariş' FROM Orders

--Q19
SELECT categoryid, avg(unitprice) as ortalama FROM Products
GROUP by categoryid

--Q20
SELECT (COUNT(CASE WHEN ShippedDate IS NULL THEN 1 END) * 100.0 / COUNT(*)) AS yüzde FROM Orders;

--Q21
SELECT productid, productname, unitprice, max(unitprice)*1.10 as 'zamlı fiyat' from Products

--Q22
SELECT SUBSTR(productname,1,3) FROM Products

--Q23
SELECT strftime('%Y', orderdate) AS year, strftime('%m', orderdate) AS month, COUNT(*) AS sayı
FROM Orders
GROUP by year, month

--Q24
SELECT sum(ROUND(UnitPrice * Quantity)) as toplamdeğer FROM OrderDetails

--Q25
SELECT sum(unitprice) FROM Products
WHEre unitsinstock=0