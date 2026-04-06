create database Project_2;
use Project_2;

CREATE TABLE SALESPEOPLE (
    SNUM INT PRIMARY KEY,
    SNAME VARCHAR(50),
    CITY VARCHAR(50),
    COMMISSION FLOAT
);


INSERT INTO SALESPEOPLE (SNUM, SNAME, CITY, COMMISSION) VALUES
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'San Jose', 0.13),
(1003, 'Axelrod', 'New York', 0.10),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rifkin', 'Barcelona', 0.15);


select*from salespeople;

CREATE TABLE CUSTOMERS (
    CNUM INT PRIMARY KEY,
    CNAME VARCHAR(50),
    CITY VARCHAR(50),
    RATING INT,
    SNUM INT,
    FOREIGN KEY (SNUM) REFERENCES SALESPEOPLE(SNUM)
);

INSERT INTO CUSTOMERS (CNUM, CNAME, CITY, RATING, SNUM) VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanni', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 300, 1002),
(2004, 'Grass', 'Berlin', 100, 1002),
(2006, 'Clemens', 'London', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004),
(2008, 'James', 'London', 200, 1007);

select*from Customers;

CREATE TABLE ORDERS (
    ONUM INT PRIMARY KEY,
    AMOUNT FLOAT,
    ODATE DATE,
    CNUM INT,
    SNUM INT,
    FOREIGN KEY (CNUM) REFERENCES CUSTOMERS(CNUM),
    FOREIGN KEY (SNUM) REFERENCES SALESPEOPLE(SNUM)
);

INSERT INTO ORDERS (ONUM, AMOUNT, ODATE, CNUM, SNUM) VALUES
(3001, 18.69, '1994-10-03', 2008, 1007),
(3002, 1900.10, '1994-10-03', 2007, 1004),
(3003, 767.19, '1994-10-03', 2001, 1001),
(3005, 5160.45, '1994-10-03', 2003, 1002),
(3006, 1098.16, '1994-10-04', 2008, 1007),
(3007, 75.75, '1994-10-05', 2004, 1002),
(3008, 4723.00, '1994-10-05', 2006, 1001),
(3009, 1713.23, '1994-10-04', 2002, 1003),
(3010, 1309.95, '1994-10-06', 2004, 1002),
(3011, 9891.88, '1994-10-06', 2006, 1001);


Select*from orders;



# Q4: Match salespeople to customers according to the city they are living in - 

SELECT C.CNAME AS Customer, S.SNAME AS Salesperson, C.CITY
FROM CUSTOMERS C
JOIN SALESPEOPLE S ON C.CITY = S.CITY;


# Q5: Select names of customers and the salespersons who are providing service to them

SELECT C.CNAME AS Customer, S.SNAME AS Salesperson
FROM CUSTOMERS C
JOIN SALESPEOPLE S ON C.SNUM = S.SNUM;


# Q6: Find all orders by customers not located in the same cities as their salespeople

SELECT O.ONUM, C.CNAME, S.SNAME, C.CITY AS Customer_City, S.CITY AS Salesperson_City
FROM ORDERS O
JOIN CUSTOMERS C ON O.CNUM = C.CNUM
JOIN SALESPEOPLE S ON O.SNUM = S.SNUM
WHERE C.CITY <> S.CITY;


# Q7: List each order number followed by name of customer who made that order

SELECT O.ONUM, C.CNAME
FROM ORDERS O
JOIN CUSTOMERS C ON O.CNUM = C.CNUM;


# Q8: Find all pairs of customers having the same rating

SELECT A.CNAME AS Customer1, B.CNAME AS Customer2, A.RATING
FROM CUSTOMERS A
JOIN CUSTOMERS B ON A.RATING = B.RATING AND A.CNUM < B.CNUM;


# Q9: Find all pairs of customers served by the same salesperson

SELECT A.CNAME AS Customer1, B.CNAME AS Customer2, A.SNUM
FROM CUSTOMERS A
JOIN CUSTOMERS B ON A.SNUM = B.SNUM AND A.CNUM < B.CNUM;


# Q10: All pairs of salespeople who are living in the same city

SELECT A.SNAME AS Salesperson1, B.SNAME AS Salesperson2, A.CITY
FROM SALESPEOPLE A
JOIN SALESPEOPLE B ON A.CITY = B.CITY AND A.SNUM < B.SNUM;


# Q11: Find all orders credited to the same salesperson who services Customer 2008

SELECT O.ONUM, O.AMOUNT
FROM ORDERS O
WHERE O.SNUM = (
    SELECT SNUM FROM CUSTOMERS WHERE CNUM = 2008
);


#  Q12: Find all orders that are greater than the average for Oct 4th

select Onum , Amount
from Orders 
where Amount > ( select avg(Amount) from Orders where Odate='1994-10-04');


# Q13: All orders attributed to salespeople in London

SELECT O.ONUM, O.AMOUNT
FROM ORDERS O
JOIN SALESPEOPLE S ON O.SNUM = S.SNUM
WHERE S.CITY = 'London';


#  Q14: Customers whose CNUM is 1000 above SNUM of Serres

SELECT * FROM CUSTOMERS
WHERE CNUM = (
    SELECT SNUM + 1000 FROM SALESPEOPLE WHERE SNAME = 'Serres'
);


# Q15: Count customers with ratings above San Jose’s average rating

SELECT COUNT(*) AS High_Rating_Customers
FROM CUSTOMERS
WHERE RATING > (
    SELECT AVG(RATING) FROM CUSTOMERS WHERE CITY = 'San Jose'
);


# Q16: Show each salesperson with multiple customers

SELECT S.SNAME, COUNT(C.CNUM) AS Num_Customers
FROM SALESPEOPLE S
JOIN CUSTOMERS C ON S.SNUM = C.SNUM
GROUP BY S.SNAME
HAVING COUNT(C.CNUM) > 1;
