-- Her kategorideki (CategoryID) ürün sayısını gösteren bir sorgu yazın.
SELECT CategoryID, COUNT(*) AS ProductCount FROM Products GROUP BY CategoryID;

--Birim fiyatı en yüksek 5 ürünü listeleyin.
SELECT ProductName, UnitPrice FROM Products ORDER BY UnitPrice DESC LIMIT 5;

--Her tedarikçinin sattığı ürünlerin ortalama fiyatını listeleyin.
SELECT SupplierID, AVG(UnitPrice) AS AveragePrice FROM Products GROUP BY SupplierID;

--"Products" tablosunda birim fiyatı 100'den büyük olan ürünlerin kategorilerini ve bu kategorilerdeki ortalama fiyatı listeleyin.
SELECT CategoryID, AVG(UnitPrice) AS AveragePrice FROM Products WHERE UnitPrice > 100 GROUP BY CategoryID;

--"OrderDetails" tablosunda birim fiyat ve miktar çarpımıyla toplam satış değeri 1000'den fazla olan siparişleri listeleyin.
SELECT * FROM OrderDetails WHERE (unitprice*quantity)>1000

--En son sevk edilen 10 siparişi listeleyin.
SELECT orderid,customerid,orderdate,shippeddate FROM Orders ORDER BY shippeddate LIMIT 10

--"Products" tablosundaki ürünlerin ortalama fiyatını hesaplayın.
SELECT AVG(unitprice) AS Average_Price FROM Products

-- "Products" tablosunda fiyatı 50’den büyük olan ürünlerin toplam stok miktarını hesaplayın.
SELECT SUM(UnitsInStock) AS TotalStock FROM Products WHERE UnitPrice > 50;

--"Orders" tablosundaki en eski sipariş tarihini bulun.
SELECT *,MIN(OrderDate) AS OldestOrderDate FROM Orders;

--"Employees" tablosundaki çalışanların kaç yıl önce işe başladıklarını gösteren bir sorgu yazın.
SELECT employeeid, firstname, lastname, (CURRENT_DATE-hiredate) AS years_with_company FROM Employees

--"OrderDetails" tablosundaki her bir sipariş için, birim fiyatın toplamını yuvarlayarak (ROUND) hesaplayın. 
SELECT order_id, ROUND(SUM(unit_price * quantity), 2) AS rounded_total_price FROM OrderDetails GROUP BY order_id;

--"Products" tablosunda stoğu bulunan (UnitsInStock) ürün sayısını gösteren bir COUNT sorgusu yazın 
SELECT COUNT(*) AS number_of_products_that_have_stock FROM Products WHERE UnitsInStock > 0;

--"Products" tablosundaki en düşük ve en yüksek fiyatları hesaplayın.
SELECT MIN(unit_price) AS lowest_price, MAX(unit_price) AS highest_price FROM Products

-- "Orders" tablosunda her yıl kaç sipariş alındığını listeleyin (YEAR() fonksiyonunu kullanarak).
SELECT STRFTIME('%Y', OrderDate) AS OrderYear, COUNT(*) AS OrderCount FROM Orders
GROUP BY OrderYear

-- Employees" tablosundaki çalışanların tam adını (FirstName + LastName) birleştirerek gösterin. 
SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM Employees;

--"Customers" tablosundaki şehir adlarının uzunluğunu (LENGTH) hesaplayın.
SELECT City, LENGTH(City) AS CityLength FROM Customers;

-- "Products" tablosundaki her ürünün fiyatını iki ondalık basamağa yuvarlayarak gösterin. 
SELECT ProductName, ROUND(unitprice, 2) AS RoundedPrice FROM Products;

--"Orders" tablosundaki tüm siparişlerin toplam sayısını bulun.
SELECT COUNT(*) AS TotalOrders FROM Orders;

-- "Products" tablosunda her kategorideki (CategoryID) ürünlerin ortalama fiyatını (AVG) hesaplayın. 
SELECT CategoryID, AVG(unitprice) AS AveragePrice FROM Products GROUP BY CategoryID;

-- "Orders" tablosunda sevk tarihi (ShippedDate) boş olan siparişlerin yüzdesini (COUNT ve toplam sipariş sayısını kullanarak) hesaplayın. 
SELECT (COUNT(CASE WHEN ShippedDate IS NULL THEN 1 END) * 100.0 / COUNT(*)) AS percentage FROM Orders;

-- "Products" tablosundaki en pahalı ürünün fiyatını bulun ve bir fonksiyon kullanarak fiyatı 10% artırın. 
SELECT MAX(unitprice) AS MaxPrice, MAX(unitprice) * 1.10 AS IncreasedPrice FROM Products;

--"Products" tablosundaki ürün adlarının ilk 3 karakterini gösterin (SUBSTRING).
SELECT ProductName, SUBSTRING(ProductName, 1, 3) AS FirstThreeCharacters
FROM Products;

--"Orders" tablosunda verilen siparişlerin yıl ve ay bazında kaç sipariş alındığını hesaplayın (YEAR ve MONTH fonksiyonları). 
SELECT strftime('%Y', orderdate) AS year, strftime('%m', orderdate) AS month, COUNT(*) AS TotalOrders
FROM Orders
GROUP by year, month

--"OrderDetails" tablosunda toplam sipariş değerini (UnitPrice * Quantity) hesaplayıp, bu değeri iki ondalık basamağa yuvarlayarak gösterin.
SELECT OrderID, ROUND(UnitPrice * Quantity, 2) AS TotalOrderValue FROM OrderDetails;

--"Products" tablosunda stokta olmayan (UnitsInStock = 0) ürünlerin fiyatlarını toplam fiyat olarak hesaplayın.
SELECT SUM(unitprice) AS TotalPriceOfOutOfStockProducts FROM Products WHERE UnitsInStock = 0;




