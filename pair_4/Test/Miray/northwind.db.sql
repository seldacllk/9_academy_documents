--Tedarikçi ID'si 1 ile 5 arasındaki ürünler:
--Tedarikçi ID'si 1, 2, 3, 4 veya 5 olan ürünleri listeleyin.
SELECT * from Products
WHERE supplierid BETWEEN 1 and 5

--Ürün adı 'Chang' veya 'Aniseed Syrup' olan ürünler:
--Ürün adı 'Chang' veya 'Aniseed Syrup' olan ürünleri listeleyin.
SELECT * from Products
WHERE productname is 'Chang' or productname is 'Aniseed Syrup'

--Tedarikçi ID'si 3 olan veya birim fiyatı 10'dan büyük ürünler:
--Tedarikçi ID'si 3 olan veya birim fiyatı 10'dan büyük olan ürünleri listeleyin.
select * from Products
WHERE supplierid = 3 or unitprice > 10

--Ürün adı ve birim fiyatı ile birlikte getirme:
--Ürün adı ve birim fiyatını içeren listeyi getirin.
SELECT productname, unitprice from Products

--Büyük harfe dönüştürerek 'c' harfi içeren ürünler:
--Ürün adlarını büyük harfe dönüştürdükten sonra 'c' harfi içeren ürünleri listeleyin. (örneğin: 'Chai', 'Chocolate', vs.)
SELECT ProductName FROM Products
WHERE UPPER(ProductName) LIKE '%C%'

--'n' ile başlayan ve tek karakterli bir harf içeren ürünler:
--Ürün adı 'n' harfi ile başlayan ve içerisinde tek 'n' içeren ürünleri listeleyin. (örneğin: 'Naan', 'Nectar', vs.)
SELECT ProductName FROM Products
WHERE ProductName LIKE 'N%' AND LENGTH(ProductName) - LENGTH(REPLACE(ProductName, 'n', '')) = 1;

--Stok miktarı 50'den fazla olan ürünler:
--Stok miktarı 50'den fazla olan ürünleri listeleyin.
SELECT ProductName, UnitsInStock FROM Products
WHERE UnitsInStock > 50;

--Ürünlerin en yüksek ve en düşük birim fiyatları:
--En yüksek ve en düşük birim fiyatına sahip ürünleri listeleyin.
SELECT ProductName, UnitPrice FROM Products
ORDER BY UnitPrice DESC
LIMIT 1;

SELECT ProductName, UnitPrice FROM Products
ORDER BY UnitPrice
LIMIT 1;

--Ürün adında 'Spice' kelimesi geçen ürünler:
--Ürün adında 'Spice' kelimesi geçen ürünleri listeleyin.
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%Spice%';
