--1)Her kategorideki (CategoryID) ürün sayısını gösteren bir sorgu yazın.
SELECT categoryid, count(*) AS product_quantity from Products
GROUP BY categoryid

--2)Birim fiyatı en yüksek 5 ürünü listeleyin.
SELECT productname, unitprice from Products 
ORDER BY unitprice desc 
LIMIT 5

--3)Her tedarikçinin sattığı ürünlerin ortalama fiyatını listeleyin.
SELECT supplierid, productname, AVG(unitprice) as average_price from products
group by supplierid

--4)"Products" tablosunda birim fiyatı 100'den büyük olan ürünlerin kategorilerini ve bu kategorilerdeki ortalama fiyatı listeleyin.
select categoryid, productname, AVG(unitprice) as average_price from products
where unitprice>100
GROUP by categoryid

--5)"OrderDetails" tablosunda birim fiyat ve miktar çarpımıyla toplam satış değeri 1000'den fazla olan siparişleri listeleyin.
SELECT * from Order Details where unitprice * quantity > 1000

--6)En son sevk edilen 10 siparişi listeleyin.
SELECT * FROM Orders WHERE ShippedDate IS NOT NULL
ORDER BY ShippedDate DESC
LIMIT 10

--7)"Products" tablosundaki ürünlerin ortalama fiyatını hesaplayın.
select AVG(unitprice) AS average_price from Products

--8)"Products" tablosunda fiyatı 50’den büyük olan ürünlerin toplam stok miktarını hesaplayın.
select SUM(unitsinstock) AS total_stock from Products 
WHERE unitprice >50 

--9)"Orders" tablosundaki en eski sipariş tarihini bulun.
SELECT MIN(orderdate) as oldest_order from orders

--10)"Employees" tablosundaki çalışanların kaç yıl önce işe başladıklarını gösteren bir sorgu yazın.
--sqlite için:
SELECT employeeid, firstname, lastname, (strftime('%Y', 'now') - strftime('%Y', HireDate)) AS YearsWorked from Employees

--diğer çözüm:
SELECT EmployeeID, FirstName, LastName, DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsWorked FROM Employees

--11)"OrderDetails" tablosundaki her bir sipariş için, birim fiyatın toplamını yuvarlayarak (ROUND) hesaplayın.
SELECT OrderID, ROUND(SUM(UnitPrice), 0) AS TotalUnitPrice FROM OrderDetails
GROUP BY OrderID

--12)"Products" tablosunda stoktaki (UnitsInStock) ürün sayısını gösteren bir COUNT sorgusu yazın.
select count(*) ProductsInStock from Products WHERE unitsinstock>0

--13)"Products" tablosundaki en düşük ve en yüksek fiyatları hesaplayın.
SELECT MIN(UnitPrice) AS LowestPrice, MAX(UnitPrice) AS HighestPrice FROM Products

--14)"Orders" tablosunda her yıl kaç sipariş alındığını listeleyin (YEAR() fonksiyonunu kullanarak).
SELECT strftime('%Y', OrderDate) AS Years, COUNT(*) AS OrderCount FROM Orders
GROUP BY Years

--15)"Employees" tablosundaki çalışanların tam adını (FirstName + LastName) birleştirerek gösterin.
--birinci çözüm: 
SELECT FirstName || ' ' || LastName AS FullName FROM Employees

--ikinci çözüm:
select CONCAT(FirstName, ' ', LastName) AS FullName FROM Employees

--16)"Customers" tablosundaki şehir adlarının uzunluğunu (LENGTH) hesaplayın.
SELECT city, LENGTH(city) as CityLength from Customers

--17)"Products" tablosundaki her ürünün fiyatını iki ondalık basamağa yuvarlayarak gösterin.
SELECT ProductName, ROUND(UnitPrice, 2) AS RoundedPrice FROM Products

--18)"Orders" tablosundaki tüm siparişlerin toplam sayısını bulun.
SELECT COUNT(*) AS TotalOrderAmount from Orders

--19)"Products" tablosunda her kategorideki (CategoryID) ürünlerin ortalama fiyatını (AVG) hesaplayın.
SELECT categoryid, AVG(unitprice) as AveragePrice from Products
GROUP by categoryid

--20)"Orders" tablosunda sevk tarihi (ShippedDate) boş olan siparişlerin yüzdesini (COUNT ve toplam sipariş sayısını kullanarak) hesaplayın.
SELECT (COUNT(CASE WHEN ShippedDate IS NULL THEN 1 END) * 100.0 / COUNT(*)) AS PercentageWithoutShippedDate FROM Orders

--21)"Products" tablosundaki en pahalı ürünün fiyatını bulun ve bir fonksiyon kullanarak fiyatı 10% artırın.
SELECT MAX(UnitPrice) AS MaxPrice, MAX(UnitPrice) * 1.10 AS IncreasedPrice FROM Products

--22)"Products" tablosundaki ürün adlarının ilk 3 karakterini gösterin (SUBSTRING).
SELECT ProductName, substr(ProductName, 1, 3) AS FirstThreeCharactersOfProducts FROM Products

--23)"Orders" tablosunda verilen siparişlerin yıl ve ay bazında kaç sipariş alındığını hesaplayın (YEAR ve MONTH fonksiyonları).
SELECT strftime('%Y', OrderDate) AS OrderYear, strftime('%m', OrderDate) AS OrderMonth, COUNT(*) AS OrderCount FROM Orders
GROUP BY OrderYear, OrderMonth
ORDER BY OrderYear, OrderMonth

--24)"OrderDetails" tablosunda toplam sipariş değerini (UnitPrice * Quantity) hesaplayıp, bu değeri iki ondalık basamağa yuvarlayarak gösterin.
SELECT orderid, ROUND(UnitPrice * Quantity, 2) OrderAmount FROM OrderDetails

--25)"Products" tablosunda stokta olmayan (UnitsInStock = 0) ürünlerin fiyatlarını toplam fiyat olarak hesaplayın.
select SUM(unitprice) as TotalStockValue from Products WHERE unitsinstock = 0
