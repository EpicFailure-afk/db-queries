-- Day-27
-- merge statement

-- Demo DB 
CREATE DATABASE bankTest

CREATE TABLE LastTransaction
(
	lid int,
	lname varchar(10),
	lvalue int
)

CREATE TABLE DailyTransaction
(
	did int,
	dname varchar(10),
	dvalue int
)

INSERT INTO LastTransaction
VALUES
	(1, 'ahmed', 4000),
	(2, 'ali', 2000),
	(3, 'omar', 6000),
	(4, 'eman', 7000)

INSERT INTO DailyTransaction
VALUES
	(1, 'ahmed', 9000),
	(2, 'ali', 1000),
	(10, 'nada', 3000)

-- -----------------------------------
-- merging

MERGE INTO LastTransaction AS Target
USING DailyTransaction AS Source
ON Target.lid = Source.did
WHEN MATCHED THEN
	UPDATE
		SET Target.lvalue=Source.dvalue
WHEN NOT MATCHED BY Target THEN
	INSERT   
	VALUES (Source.did, Source.dname, Source.dvalue);

-- --------------------------------------------------------
-- stored procedure 
CREATE PROCEDURE GetSt @id int
AS 
	SELECT *
	FROM Student 
	WHERE st_id = @id

-- calling
GetSt 4

-- --------------------------------
-- SP parameterless
CREATE PROCEDURE GetSTable -- or --> CREATE PROC  
AS
	SELECT * FROM Student


GetSTable -- calling

-- ---------------------------------
-- insert withSP

CREATE PROC InstSt @id int, @name varchar(10)
AS
	BEGIN TRY
		INSERT INTO Student (st_id, st_fname)
		VALUES (@id, @name)
	END TRY
	BEGIN CATCH
		SELECT 'Duplicate ID' AS "msg"   -- should hide the error itself
	END CATCH

InstSt 1, 'ahmed'  


-- alter proc
ALTER PROC InstSt @id int, @name varchar(10)
AS
	BEGIN TRY
		INSERT INTO Student (st_id, st_fname)
		VALUES (@id, @name)
	END TRY
	BEGIN CATCH
		SELECT 'Error' AS "msg"
	END CATCH

-- ------------------------------------
CREATE PROC sumdata @x int, @y int
AS
		SELECT @x + @y
	
sumdata 3,9	  -- calling by parameter position
sumdata @y=3, @x=9 -- calling by parameter name 

-- default value
AlTER PROC sumdata @x int, @y int=100
AS
		SELECT @x + @y

sumdata 4

-- -----------------------------------
-- returned result is table
CREATE PROC GetStbyAge @age1 int, @age2 int
AS
	SELECT St_Id, st_fname 
	FROM Student
	WHERE st_age BETWEEN @age1 AND @age2

GetStbyAge 23, 28	

-- Insert based on execute
Declare @t TABLE(x int, y varchar(20))
INSERT INTO @t
EXECUTE GetStbyAge 23, 28
SELECT COUNT(x) FROM @t 

-- -----------------------------------------
-- returned result is one value 
-- deals like scalar function 

CREATE PROC Getdata2 @id int
AS
	declare @age int 
		SELECT @age=st_age
		FROM Student 
		WHERE St_ID=@id 
	RETURN @age  -- return is not like return that with delcare 
	-- but this query will success bc the return value is int
	-- return at SP used to return the status not the value like in scalar function

Declare @x int 
SET @x=EXECUTE Getdata2 3
SELECT @x

-- correct query
CREATE PROC Getdata2 @id int, @age int OUTPUT  -- like in and out at C# 
AS
	
		SELECT @age=st_age
		FROM Student 
		WHERE St_ID=@id 

Declare @x int 
EXECUTE Getdata2 3, @x OUTPUT
SELECT @x


-- -----------------------------------------------------------------------
-- trigger
-- trigger on table level
CREATE TRIGGER t1
ON Student 
AFTER INSERT 
AS
	SELECT 'WElcome to db'

-- after any insert that happen at Student level will show that msg

-- ------------------------
CREATE TRIGGER t2
ON Student 
FOR UPDATE  -- for like after 
AS
	SELECT GETDATE()

UPDATE Student
	SET St_Age+=1

-- ------------------------
-- trigger to deny users from delete 
CREATE TRIGGER t3
ON Student 
INSTEAD OF DELETE
AS
	SELECT 'Not Allowed For User: '+SUSER_NAME

DLETE FROM Student WHERE st_id=779

-- --------------------------
-- make table read only
CREATE TRIGGER t4
ON Department
INSTEAD OF DELETE, UPDATE, INSERT
AS 
	SELECT 'Not Allowed'

-- --------------------------
-- drop trigger 
DROP TRIGGER t1

-- --------------------------
-- disable trigger
ALTER TABLE Student DISABLE TRIGGER t3
					-- ENABLE
-- --------------------------
CREATE TRIGGER t5
ON Student
FOR UPDATE  -- update here is the update query
AS
	if UPDATE(st_fname)  -- update here is a function
		SELECT 'first name updated successfully'
-- --------------------------
-- use trigger for auditing
CREATE TRIGGER t6
ON Course
AFTER UPDATE 
AS
	SELECT * FROM inserted -- data after update 
	SELECT * FROM deleted -- data before update 

UPDATE Course
	SET crs_name='cloud', Crs_Duration=45
WHERE Crs_Id=100