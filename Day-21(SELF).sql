CREATE DATABASE Employee
use Employee
CREATE TABLE Emp
(
	empID int primary key identity (1,1),
	empName nvarchar (50),
	superID INT REFERENCES Emp(empID)
) 

-- ---------------------------------------------------------
INSERT INTO Emp ( empName, superID)
VALUES
('ahmed', NULL ),
('omar', 1 ),
('eman', 1 ),
('nada', 2 )

-- ---------------------------------------------------------
-- self join 

SELECT E.empName AS Employee , M.empName AS Manager 
FROM Emp E
INNER JOIN Emp M 
	ON E.superID = M.empID


-- ---------------------------------------------------------

SELECT 
FROM Emp

UNION 
SELECT * 
FROM Emp

SELECT empName, ISNULL (superID, 99) AS Manger
FROM EMP

SELECT CONCAT (empName,'  ', 'his manager is ',superID )
FROM Emp


SELECT empName 
FROM Emp
WHERE empName LIKE '__m%'