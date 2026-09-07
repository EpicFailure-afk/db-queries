CREATE NONCLUSTERED INDEX myIndex
ON Student(st_fname)

 CREATE TABLE Test22
 (
	tid INT PRIMARY KEY ,
	tname varchar(20),
	t_age INT UNIQUE
 )

 CREATE UNIQUE NONCLUSTERED INDEX myUniqueIndex
 ON Student(st_age)  -- will not run bc age does not have a unique vals


-- ------------ ROLLUP, CUBE, PIVOT -------------------------

CREATE TABLE Sales 
(
	ProductID int, 
	SalesmanName varchar (10),
	Quantity int 
)

TRUNCATE TABLE Sales

INSERT INTO Sales
Values (1, 'ahmed', 10),
	   (1, 'khalid', 20),
	   (1, 'ali', 45),
	   (2, 'ahmed', 15),
	   (2, 'khalid', 30),
	   (2, 'ali', 70),
	   (3, 'ahmed', 30),
	   (4, 'ali', 90),
	   (3, 'khalid', 30),
	   (4, 'khalid', 90)

SELECT ProductID, SalesmanName, Quantity  
FROM Sales

SELECT ProductID AS X, SUM(Quantity) AS "Quantities"
FROM Sales
GROUP BY ProductID

-- rollup

SELECT ProductID AS X, SUM(Quantity) AS "Quantities"
FROM Sales
GROUP BY ROLLUP(ProductID)


-- another examble
SELECT ProductID, SalesmanName, SUM(quantity) AS "Quantities"
FROM Sales
GROUP BY ROLLUP(ProductID, SalesmanName)

-- ------------------------------------------------
-- pivot
SELECT * 
FROM Sales
PIVOT (SUM(Quantity) FOR SalesmanName IN ([Ahmed], [Khaled], [Ali])) As PVT
ORDER BY ProductID


-- -------------------------------------------------------
-- view (Standard)
CREATE VIEW Vcairo
AS 
	SELECT st_id, st_fname, St_Address
	FROM Student
	WHERE st_address = 'cairo'


SELECT st_fname FROM Vcairo 

DROP VIEW Vcairo

-- alter view 
ALTER VIEW Vcairo(sid, sname, sadd)
AS
	SELECT st_id, st_fname, St_Address
	FROM Student
	WHERE st_address = 'cairo'
