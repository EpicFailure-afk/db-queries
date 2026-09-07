-- Ranking Functions 

-- SELECT *, Row_Number() over (ORDER BY Salary desc) AS RN
SELECT *
FROM (

	SELECT Ins_Name, Salary, Dense_Rank() OVER (ORDER BY Salary DESC) AS DR 
	FROM Instructor 
	) AS new_table
-- WHERE DR in (1, 2, 3)
-- WHERE R = 3


SELECT Ins_Name, Salary 
FROM Instructor 
ORDER BY Salary DESC

SELECT Ins_Name, Salary, Rank() OVER (ORDER BY Salary DESC) AS R 
FROM Instructor 


-- ---------------------------------------------------------------------

-- partition by 

SELECT *, DENSE_RANK() OVER(PARTITION BY Dept_Id ORDER BY St_age DESC) As DR
FROM Student


-- ---------------------------------------------------------

-- NTiles()

SELECT * 
FROM (
	SELECT *, NTile(4) OVER (ORDER BY St_Age DESC) AS G
	FROM Student
) AS new_table
WHERE G = 1

-- -----------------------------------------------

-- case when then 

SELECT  
	case 
		when Salary >= 3000 then ' High Sal '
		when Salary < 3000 then ' Low Sal '
	else ' no data '
	end AS [Case],
	ins_name, Salary  -- ممكن اغير ترتيب الاعمده اللي هتظهر 
FROM Instructor

-- -------

-- case with update 

UPDATE Instructor
SET Salary = 
	case
		when Salary >= 3000 then Salary * 1.10
		when Salary < 3000 then Salary * 1.20
		else 1500
	end


SELECT ins_name, iif (Salary >= 3000, 'High', 'Low') AS [CASE]
FROM Instructor


-- ------------------------------------------------------------

-- How to convert date to string 

SELECT CONVERT(varchar(20), getdate()) AS [string date]
SELECT getdate() AS [Date]

SELECT CONVERT(varchar(20), getdate()) AS [string date]

SELECT CONVERT(varchar(20), getdate(), 101) AS [101]
SELECT CONVERT(varchar(20), getdate(), 102) AS [102]
SELECT CONVERT(varchar(20), getdate(), 103) AS [103]
SELECT CONVERT(varchar(20), getdate(), 104) AS [104]
SELECT CONVERT(varchar(20), getdate(), 105) As [105]

SELECT CONVERT(varchar(20), getdate(), 106) As [106]
SELECT CONVERT(varchar(20), getdate()) AS [string date]

-- ----------------------------

-- get date with format function --> the diff at **return type**

SELECT Format(getdate(), 'dd') AS [format]
SELECT day(getdate()) AS [day]


-- eomonth function
SELECT format(eomonth(getdate()), 'dd')    -- number of the day
SELECT format(eomonth(getdate()), 'dddd')  -- name of day 


-----------------------
--datatypes
--numeric
--bit   bool  0:1   true:false 
--tinyint		 1byte       -128:+127  unsigned 0:255
--smallint		 2b			  -32768:+32767 unsigned 0:65555 
--int		   	8b
--big int	   	2g
---------------------------
--decimale
--smallmoney 4b  .0000
--money      8b   .0000
--real			0.0000000
--float				0.0000000000000......
--dec dec(digits,floats) dec(5,2) 122.12    12.898 xx
------------------------------
--char  char(max number 10msln)  ficxed length chars reserved
--varchar(max number 10msln) variable length charachter by7gz 3la 2d ma tktb
--nchar()
--nvarchar() n for scability lw 3ayz aktb ai lo3'a 3'er el english
---------------------------------
--datetime
-- Date mm/dd/yyyy
--time hh:mm
--time(7) hh:mm 12.7875464
--smalldatetime modern dates mm/dd/yyy hh:mm
--datetime   more dates range
--datetime(7)
--datetimeoffset 24/11/2021 10:30 +2:00 time zone
--------------------------------
--binary 01110101
--image bttsave as binaries 


------------------------------------------------------------------------

-- synonym

use ITI
CREATE synonym ins
FOR Instructor

SELECT * FROM ins


 

