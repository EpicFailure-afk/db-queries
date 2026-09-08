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
		SELECT 'Duplicate ID' AS "msg"
	END CATCH

InstSt 1, 'ahmed'  
