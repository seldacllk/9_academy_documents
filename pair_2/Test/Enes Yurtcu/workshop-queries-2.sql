SELECT CategoryID, COUNT(*) AS "Ürün Sayısı" FROM Products GROUP BY CategoryID;--1-Her kategorideki (CategoryID) ürün sayısını gösteren bir sorgu yazın

SELECT * FROM Products ORDER BY UnitPrice DESC LIMIT 5;--2-Birim fiyatı en yüksek 5 ürünü listeleyin.

SELECT SupplierID, AVG(UnitPrice) AS "Ortalama Fiyat" FROM Products GROUP BY SupplierID;--3-Her tedarikçinin sattığı ürünlerin ortalama fiyatını listeleyin.

SELECT CategoryID, AVG(UnitPrice) AS "Ortalama Fiyat" FROM Products WHERE UnitPrice > 100 GROUP BY CategoryID;--4-"Products" tablosunda birim fiyatı 100'den büyük olan ürünlerin kategorilerini ve bu kategorilerdeki ortalama fiyatı listeleyin.

SELECT * FROM 'Order Details' WHERE UnitPrice * Quantity > 1000;--5-"OrderDetails" tablosunda birim fiyat ve miktar çarpımıyla toplam satış değeri 1000'den fazla olan siparişleri listeleyin.

SELECT * FROM Orders ORDER BY ShippedDate DESC LIMIT 10;--6-En son sevk edilen 10 siparişi listeleyin.

SELECT AVG(UnitPrice) AS "Ortalama Fiyat" FROM Products;--7-"Products" tablosundaki ürünlerin ortalama fiyatını hesaplayın.

SELECT SUM(UnitsInStock) AS "Toplam Stok" FROM Products WHERE UnitPrice > 50;--8-"Products" tablosunda fiyatı 50’den büyük olan ürünlerin toplam stok miktarını hesaplayın.

SELECT MIN(OrderDate) AS "En Eski Sipariş Tarihi" FROM Orders;--9-"Orders" tablosundaki en eski sipariş tarihini bulun.

SELECT FirstName, LastName, strftime('%Y', 'now') - strftime('%Y', HireDate) AS "Yıllık Tecrübe" FROM Employees;--10-"Employees" tablosundaki çalışanların kaç yıl önce işe başladıklarını gösteren bir sorgu yazın.

SELECT OrderID, ROUND(SUM(UnitPrice), 2) AS "Toplam Birim Fiyat" FROM 'Order Details' GROUP BY OrderID;--11-"OrderDetails" tablosundaki her bir sipariş için, birim fiyatın toplamını yuvarlayarak (ROUND) hesaplayın.

SELECT COUNT(*) AS "Stoktaki Ürün Sayısı" FROM Products WHERE UnitsInStock > 0;--12-"Products" tablosunda stoktaki (UnitsInStock) ürün sayısını gösteren bir COUNT sorgusu yazın.
SELECT MIN(UnitPrice) AS "En Düşük Fiyat", MAX(UnitPrice) AS "En Yüksek Fiyat" FROM Products;--13-"Products" tablosundaki en düşük ve en yüksek fiyatları hesaplayın.

SELECT strftime('%Y', OrderDate) AS "Yıl", COUNT(*) AS "Sipariş Sayısı" FROM Orders GROUP BY strftime('%Y', OrderDate);--14-"Orders" tablosunda her yıl kaç sipariş alındığını listeleyin (YEAR() fonksiyonunu kullanarak).
SELECT FirstName || ' ' || LastName AS "Tam Ad" FROM Employees;--15-"Employees" tablosundaki çalışanların tam adını (FirstName + LastName) birleştirerek gösterin.

SELECT City, LENGTH(City) AS "Şehir Adı Uzunluğu" FROM Customers;--16-"Customers" tablosundaki şehir adlarının uzunluğunu (LENGTH) hesaplayın.

SELECT ProductName, ROUND(UnitPrice, 2) AS "Yuvarlanmış Fiyat" FROM Products;--17-"Products" tablosundaki her ürünün fiyatını iki ondalık basamağa yuvarlayarak gösterin.

SELECT COUNT(*) AS "Toplam Sipariş Sayısı" FROM Orders;--18-"Orders" tablosundaki tüm siparişlerin toplam sayısını bulun.

SELECT CategoryID, AVG(UnitPrice) AS "Ortalama Fiyat" FROM Products GROUP BY CategoryID;--19-"Products" tablosunda her kategorideki (CategoryID) ürünlerin ortalama fiyatını (AVG) hesaplayın.

SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Orders)) AS "Sevk Edilmeyen Sipariş Yüzdesi" FROM Orders WHERE ShippedDate IS NULL;--20-"Orders" tablosunda sevk tarihi (ShippedDate) boş olan siparişlerin yüzdesini (COUNT ve toplam sipariş sayısını kullanarak) hesaplayın.

SELECT ProductName, UnitPrice, UnitPrice * 1.10 AS "Fiyat %10 Artışlı" FROM Products ORDER BY UnitPrice DESC LIMIT 1;--21-"Products" tablosundaki en pahalı ürünün fiyatını bulun ve bir fonksiyon kullanarak fiyatı 10% artırın.

SELECT ProductName, SUBSTRING(ProductName, 1, 3) AS "İlk 3 Karakter" FROM Products;--22-"Products" tablosundaki ürün adlarının ilk 3 karakterini gösterin (SUBSTRING).

SELECT strftime('%Y', OrderDate) AS "Yıl", strftime('%m', OrderDate) AS "Ay", COUNT(*) AS "Sipariş Sayısı" FROM Orders GROUP BY strftime('%Y', OrderDate), strftime('%m', OrderDate);--23-"Orders" tablosunda verilen siparişlerin yıl ve ay bazında kaç sipariş alındığını hesaplayın (YEAR ve MONTH fonksiyonları).

SELECT OrderID, ROUND(SUM(UnitPrice * Quantity), 2) AS "Toplam Sipariş Değeri" FROM 'Order Details' GROUP BY OrderID;--24-"OrderDetails" tablosunda toplam sipariş değerini (UnitPrice * Quantity) hesaplayıp, bu değeri iki ondalık basamağa yuvarlayarak gösterin.

SELECT SUM(UnitPrice) AS "Toplam Fiyat" FROM Products WHERE UnitsInStock = 0;--25-"Products" tablosunda stokta olmayan (UnitsInStock = 0) ürünlerin fiyatlarını toplam fiyat olarak hesaplayın.


SELECT * FROM Customers ;