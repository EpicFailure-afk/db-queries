-- day 23 --> suptupe and overtype

SELECT st_fname, st_age, dept_id
FROM Student 
ORDER BY 3

SELECT db_name()
-- ---------------------------------------------------------------
-- get the user 
SELECT SUSER_NAME() AS [Owner]

-- ---------------------------------------------------------------
-- select top

SELECT TOP (3) St_Fname
FROM Student
WHERE St_Address = 'Alex'


-- ----------------------------------------------------------------
-- newid()
SELECT *, newid() AS [GUID]
FROM Student


-- ------------------------------------------------------------\
-- select 3 random
SELECT TOP (3) st_fname
FROM Student
ORDER BY NEWID()


SELECT *
FROM ITI.dbo.Student


