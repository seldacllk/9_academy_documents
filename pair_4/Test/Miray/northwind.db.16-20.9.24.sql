--sayfa 1, öğe sayısı 5
select * from Products
order by unitprice DESC
LIMIT 5
OFFSET 5 * 0

--sayfa 2, öğe sayısı 5
select * from Products
order by unitprice DESC
LIMIT 5
OFFSET 5 * 1

SELECT companyname, country, city from Customers
WHERE country is not NULL
order by country, city

select concat(firstname, ' ', lastname) as [İsim Soyisim] from Employees
order by [İsim Soyisim]

SELECT * from Products
order by 
  case when unitsinstock = 0 THEN 2
  	WHEN categoryid = 1 THEN 1
  	ELSE 0
  END, productname
  
-------////////////-------
SELECT productname, supplierid from Products
where EXISTS ( select 1 from Suppliers
              where Products.SupplierID = Suppliers.SupplierID and Suppliers.Country = 'USA')
--aynı sonuç, performans farkı              
SELECT productname, supplierid from Products
where supplierid in ( select supplierid from Suppliers
              where Suppliers.Country = 'USA')
              
SELECT p.ProductName, p.CategoryID, c.CategoryName from Products p              
 Join Categories c on c.CategoryID = p.CategoryID  
 where unitprice > (SELECT AVG(unitprice) from Products p2
                    WHERE p2.CategoryID = p.CategoryID)
          



