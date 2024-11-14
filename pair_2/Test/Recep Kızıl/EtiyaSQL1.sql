--1)Tedarikçi ID'si 1 ile 5 arasındaki ürünler:
--Tedarikçi ID'si 1, 2, 3, 4 veya 5 olan ürünleri listeleyin.

SELECT * from Products WHERE supplierid IN (1,2,3,4,5)
--BİR DİĞER ÇÖZÜM 
SELECT * FROM Products WHERE supplierid BETWEEN 1 AND 5

--2) Tedarikçi ID'si 1, 2, 4 veya 5 olan ürünler:
---Tedarikçi ID'si 1, 2, 4 veya 5 olan ürünleri listeleyin.

SELECT * FROM Products where supplierid IN (1,2,4,5)

--3)Ürün adı 'Chang' veya 'Aniseed Syrup' olan ürünler:
---Ürün adı 'Chang' veya 'Aniseed Syrup' olan ürünleri listeleyin.

SELECT * FROM Products where productname = 'Chang' or productname = 'Aniseed Syrup' 

--4)Tedarikçi ID'si 3 olan veya birim fiyatı 10'dan büyük ürünler:
---Tedarikçi ID'si 3 olan veya birim fiyatı 10'dan büyük olan ürünleri listeleyin.

SELECT * from Products where supplierid = 3 OR unitprice>10

--5)Ürün adı ve birim fiyatı ile birlikte getirme:
---Ürün adı ve birim fiyatını içeren listeyi getirin.

SELECT productname, unitprice from Products

--6)Büyük harfe dönüştürerek 'c' harfi içeren ürünler:
--Ürün adlarını büyük harfe dönüştürdükten sonra 'c' harfi içeren ürünleri listeleyin. (örneğin: 'Chai', 'Chocolate', vs.)

SELECT UPPER(productname) from Products where UPPER(productname) LIKE '%C%'

--7)'n' ile başlayan ve tek karakterli bir harf içeren ürünler:
---Ürün adı 'n' harfi ile başlayan ve içerisinde tek karakterli bir harf içeren ürünleri listeleyin. (örneğin: 'Naai, 'Nectar', vs.)

SELECT * FROM Products WHERE productname LIKE 'N%' AND productname LIKE 'N_%'

--8)Stok miktarı 50'den fazla olan ürünler:
---Stok miktarı 50'den fazla olan ürünleri listeleyin.

SELECT * FROM Products WHERE unitsinstock>50

--9)Ürünlerin en yüksek ve en düşük birim fiyatları:
---En yüksek ve en düşük birim fiyatına sahip ürünleri listeleyin.

SELECT productname, unitprice FROM Products
WHERE unitprice = (SELECT MAX(unitprice) FROM Products)
   OR unitprice = (SELECT MIN(unitprice) FROM Products)
   
--10)Ürün adında 'Spice' kelimesi geçen ürünler:
---Ürün adında 'Spice' kelimesi geçen ürünleri listeleyin.

SELECT * FROM Products WHERE productname LIKE '%Spice%'