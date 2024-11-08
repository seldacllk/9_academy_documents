1- select categoryid, count(*) as ProductCount from Products GROUP by categoryid

2- select productname,unitprice from Products ORDER BY unitprice DESC 
limit 5 ; 

3- select supplierid, AVG(unitprice) as AvaragePrice From Products
group by supplierid

4- select categoryid, AVG(unitprice) as AvagagePrice
from Products
where unitprice > 100 

5- select orderid , unitprice * quantity as Totalvalue 
from Order Details
having TotalValue > 1000

6- SELECT *
from Orders
order by shippeddate DESC LIMIT 10;

7- select AVG(unitprice) as Avagareprice
from Products

8- select SUM(unitsinstock) as TotalStock
from Products
where unitprice > 50;

9- SELECT MIN(orderdate) as OldestOrderDate from Orders

10- select employeeid, firstname, lastname,hiredate (strftime('%Y', 'now') - strftime('%Y', hiredate)) as Yearsworked 
from Employees

11- select orderid , ROUND(Sum(unitprice), 0) as totalunitprice from Order Details group by orderid
                           
12- SELECT COUNT(*) AS ProductsInStock from Products where unitsinstock > 0 ; 

13- SELECT MIN(unitprice) as MinPrice, Max(unitprice) as MaxPrice from Products ; 

14- select strftime('%Y', orderdate) as OrderYear, count (*) as OrderCount from Orders group by OrderYear ; 
                                                  
15- select CONCAT(FirstName, ' ', LastName) as FullName from Employees
                         
16- SELECT customerid, city, LENGTH(city) as CityNameLength FROM Customers
                        
17- select productid, productname, ROUND(unitprice, 2) as RoundedPrice from Products 

18- select count(*) as TotalOrders from Orders

19- SELECT categoryid, AVG(unitprice) as AvaragePrice from Products GROUP by categoryid

20- select (Count(*) * 100.0 / (select count(*) from Orders)) as PercentageNotShipped from Orders where shippeddate is NULL

21-SELECT ProductName, UnitPrice, UnitPrice * 1.10 AS IncreasedPrice
FROM Products
ORDER BY UnitPrice DESC
LIMIT 1;

22- SELECT ProductName, SUBSTRING(ProductName, 1, 3) AS FirstThreeChars
FROM Products;

23- select strftime('%y', orderdate) as OrderYear, strftime('%m', orderdate) as OrderMonth, count(*) as OrderCount from Orders
group by OrderYear, OrderMonth ; 

24- select orderid, productid, ROUND(SUM(unitprice * quantity), 2) as TotalOrderValue
from Order Details 
group by orderid, productid

25- select SUM(unitprice) as TotalPriceOfStock 
from Products
where unitsinstock = 0 ;