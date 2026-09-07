-- VARIABLES 
--local:
Declare @x int
SELECT @x = st_age FROM Student WHERE St_Id = 1

UPDATE Student
SET St_Fname = 'Mahmoud', st_age = @x
WHERE St_Id = 4


SELECT @x

-- simple declare, assign and visualize !!
Declare @y int
SET @y = 20
SELECT @y AS new_var

-- ---------------------------------------------------

SELECT @@ROWCOUNT AS [row count] -- to know how many rows has been affected after the last statement


SELECT @@version 

Declare @x int
SET @x = @@ROWCOUNT
SELECT @x

-- ----------------------------------------
-- execute 
execute ('SELECT * FROM Student') 

DECLARE @col varchar(20)='*', @tab varchar(20)='Student'
EXECUTE(' SELECT ' + @col + ' FROM ' + @tab)
SELECT @col FROM @tab  -- X can't be done!! 

-- ----------------------------------------
-- if exists
if exists (SELECT name FROM sys.tables WHERE name='Student')
	SELECT 'table is exists' AS result
else
	CREATE TABLE Student 
	(
		id int, 
		name varchar(20)
	)


-- if not exists 
if not exists(SELECT name FROM sys.tables WHERE name='Student')
	CREATE TABLE Student 
	(
		id int, 
		name varchar(20)
	)
else 
	SELECT 'Table is exists' AS result


-- ----------------------------------------------------

--while

declare @x int = 10
WHILE @x <= 20
	BEGIN
		SET @x += 1
		if @x = 14
			continue
		if @x = 16
			break
		SELECT @x
	END


-- -----------------------------------------------
-- Explicit transaction 

BEGIN TRY
	BEGIN TRANSACTION
		INSERT INTO child VALUES(1)
		INSERT INTO child VALUES(2)
		INSERT INTO child VALUES(3)
	COMMIT
END TRY
BEGIN CATCH 
	ROLLBACK
END CATCH

SELECT db_name() AS [db_name]


SELECT max(len(st_fname)), st_fname
FROM Student 

SELECT st_fname, DENSE_RANK(over(order by max(len(st_fname)) desc) AS [max_len]
FROM Student
WHERE [max_len] = 1

SELECT TOP(1) st_fname
FROM Student
ORDER BY len(st_fname) desc

-- -------------------------------------------------

-- create my own function 
-- scalar function
CREATE FUNCTION getname(@id int)
RETURNS varchar (20)  -- ---> type of the return value
	BEGIN
		DECLARE @name varchar(20)
		SELECT @name = st_fname FROM Student WHERE st_id=@id
		RETURN @name -- ---> thbe returned value
	END


SELECT dbo.getname(1) AS [first name]
 

-- --------------

-- inline table function 
CREATE FUNCTION getist(@did int)
RETURNS TABLE
AS
RETURN
(
	SELECT ins_name, Salary*12 AS TotalSal
	FROM Instructor
	WHERE dept_id=@did
)

SELECT * FROM getist(10)

SELECT SUM (TotalSAl) FROM getist(10) AS [TOTAL]


-- -------
-- multistatement function 

CREATE FUNCTION getstuds (@format varchar(20))
RETURNS @t TABLE
	(
		id int,
		ename varchar(20)
	)
AS
BEGIN
	if @format = 'first'
		INSERT INTO @t
		SELECT st_id, st_fname FROM Student
	else if @format='last'
		INSERT INTO @t
		SELECT st_id, st_lname FROM Student
	else if @format='full'
		INSERT INTO @t
		SELECT st_id, st_fname+' '+ st_lname FROM Student 
	RETURN
END

SELECT * FROM getstuds('first')