SELECT SUM(Salary) 
FROM Instructor
-- AGGREGATE 
SELECT MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary
FROM Instructor

SELECT COUNT (*) AS [All], COUNT (st_id) AS Student_id, COUNT (st_lname) AS LastName, COUNT (st_age) AS St_age
FROM Student

SELECT AVG (ISNULL(st_age, 0)) AS Age
FROM Student 

SELECT SUM (st_age) / COUNT (*) AS Age_comp
FROM Student 

-- ----------------------------------------------------------------------
-- AGGR with GROUP BY 

SELECT COUNT (Ins_Name) AS [num of names], Dept_Id  AS [Dept id]
FROM Instructor
where Ins_degree = 'Master'
GROUP BY Dept_Id
-- HAVING SUM(Salary) >= 17000

-- ----------------------------------------------------------------------
-- Subqueries

SELECT * 
FROM Student
WHERE st_age < 
(
	SELECT avg(st_age)
	FROM Student  -- inner query will produse <23>
)
