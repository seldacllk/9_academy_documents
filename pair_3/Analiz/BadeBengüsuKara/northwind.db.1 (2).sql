--SQL WORKSHOP 
--1  Tedarikçi ID'si 1 ile 5 arasındaki ürünler:
SELECT productid,productname, supplierid FROM Products WHERE supplierid BETWEEN 1 AND 5
--2  Tedarikçi ID'si 1, 2, 4 veya 5 olan ürünleri listeleyin.
SELECT productid,productname, supplierid FROM Products WHERE supplierid IN (1,2,4,5)
--3  Ürün adı 'Chang' veya 'Aniseed Syrup' olan ürünler:
SELECT productid,productname FROM Products WHERE productname='Chang' OR productname='Aniseed Syrup'
--4  Tedarikçi ID'si 3 olan veya birim fiyatı 10'dan büyük ürünler:
SELECT productid,productname FROM Products WHERE supplierid=3 OR unitprice>10
--5  Ürün adı ve birim fiyatı ile birlikte getirme:
SELECT (productname ||' - '||unitprice) AS 'ÜRÜN - BİRİM FİYAT'FROM Products
--6  Ürün adlarını büyük harfe dönüştürdükten sonra 'c' harfi içeren ürünleri listeleyin. (örneğin: 'Chai', 'Chocolate', vs.)
SELECT productname FROM PRODUCTS WHERE UPPER(productname) LIKE '%C%'
--7 'n' ile başlayan ve tek karakterli bir harf içeren ürünler:
Ürün adı 'n' harfi ile başlayan ve içerisinde tek karakterli bir harf içeren ürünleri listeleyin. (örneğin: 'Naai, 'Nectar', vs.)
SELECT productname FROM PRODUCTS WHERE productname LIKE 'N%'AND NOT productname LIKE '%N%'
--8 Stok miktarı 50'den fazla olan ürünler:
SELECT productname,unitsinstock FROM Products WHERE unitsinstock>50
--9  Ürünlerin en yüksek ve en düşük birim fiyatları:
SELECT productname,unitprice FROM PRODUCTS
WHERE unitprice=(SELECT MAX(unitprice) FROM Products) OR unitprice=(SELECT MIN(unitprice) FROM PRODUCTS)
--10   Ürün adında 'Spice' kelimesi geçen ürünleri listeleyin.
SELECT productname FROM Products WHERE productname LIKE '%Spice%'

