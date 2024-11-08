Select * from Products where supplierid between 1 and 5 

select * from Products where supplierid in (1,2,4,5)

select * from Products 
where  productname ='Chang' or productname = 'Aniseed Syrup'
                
select * from Products where supplierid = 3 or unitprice > 10

select productname, unitprice from Products

select * from Products where UPPER(productname) like '%C%' 

select * from Products where productname like 'N%'

select * from Products where unitsinstock > 50 

select min(unitprice), max(unitprice) from Products 

select * from Products where productname like '%Spice%'
