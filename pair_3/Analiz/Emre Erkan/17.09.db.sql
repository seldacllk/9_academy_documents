
--SQL Workshop 1:
--Tedarikçi ID'si 1 ile 5 arasındaki ürünler:
--Tedarikçi ID'si 1, 2, 3, 4 veya 5 olan ürünleri listeleyin.
--Tedarikçi ID'si 1, 2, 4 veya 5 olan ürünler:
--Tedarikçi ID'si 1, 2, 4 veya 5 olan ürünleri listeleyin.
--Ürün adı 'Chang' veya 'Aniseed Syrup' olan ürünler:
--Ürün adı 'Chang' veya 'Aniseed Syrup' olan ürünleri listeleyin.
--Tedarikçi ID'si 3 olan veya birim fiyatı 10'dan büyük ürünler:
--Tedarikçi ID'si 3 olan veya birim fiyatı 10'dan büyük olan ürünleri listeleyin.
--Ürün adı ve birim fiyatı ile birlikte getirme:
--Ürün adı ve birim fiyatını içeren listeyi getirin.
--Büyük harfe dönüştürerek 'c' harfi içeren ürünler:
--Ürün adlarını büyük harfe dönüştürdükten sonra 'c' harfi içeren ürünleri listeleyin. (örneğin: 'Chai', 'Chocolate', vs.)
--'n' ile başlayan ve tek karakterli bir harf içeren ürünler:
--Ürün adı 'n' harfi ile başlayan ve içerisinde tek karakterli bir harf içeren ürünleri listeleyin. (örneğin: 'Naai, 'Nectar', vs.)
--Stok miktarı 50'den fazla olan ürünler:
--Stok miktarı 50'den fazla olan ürünleri listeleyin.
--Ürünlerin en yüksek ve en düşük birim fiyatları:
--En yüksek ve en düşük birim fiyatına sahip ürünleri listeleyin.
--Ürün adında 'Spice' kelimesi geçen ürünler:
--Ürün adında 'Spice' kelimesi geçen ürünleri listeleyin.

--Question 1
--SELECT * FROM Products 
--WHERE supplierid BETWEEN 1 AND 5

--Question 2
--SELECT * FROM Products 
--WHERE supplierid=1 or supplierid=2 or supplierid=4 or supplierid=5

--Question 3
--SELECT * FROM Products 
--where productname='Chang' or productname='Aniseed Syrup'

--Question 4
--SELECT * FROM Products 
--WHERE supplierid=3 or unitprice>10

--Question 5
--SELECT productname,unitprice FROM Products 

--Question 6
--SELECT UPPER(productname) FROM Products 
--WHERE productname LIKE ('%C%')

--Question 7
--SELECT * FROM products 
--WHERE productname LIKE 'n%' AND LENGTH(REPLACE(productname, 'n', '')) = LENGTH(productname) - 1

--Question 8
--SELECT * FROM Products 
--WHERE unitsinstock>50

--Question 9
--SELECT MAX(unitprice),MIN(unitprice) FROM Products 

--Question 10 
--SELECT * FROM Products 
--WHERE productname LIKE ('%Spice%')


