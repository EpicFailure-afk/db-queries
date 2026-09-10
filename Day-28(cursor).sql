--------Cursor--------
--1: declare cursor
Declare c1 CURSOR  -- cursor is not a bd object 
FOR	SELECT st_id, st_fname 
	FROM Student 
	WHERE st_address='cairo'
FOR READ ONLY   -- OR FOR UPDATE  ---> ()Behavior of cursor 

--2: Declare variables 
Declare @id int, @name varchar(20)

--3: open cursor 
open c1

--4: fetch
FETCH c1 INTO @id, @name 

--5: loop
WHILE @@FETCH_STATUS=0
	BEGIN
		SELECT @id AS "id", @name AS "name" 
		FETCH c1 INTO @id, @name  --move to next row, like cursor++ 
	END

--6: close cursor
CLOSE c1

--7: dellocate cursor 
DEALLOCATE c1  -- once deallocated (remove from mem)

-- --------------------------------
-- retrieve result as one cell [name1, name2, ...]
Declare c1 CURSOR 
FOR SELECT st_fname 
	FROM Student
	WHERE st_fname IS NOT NULL
FOR READ ONLY
Declare @name varchar(20), @allnames varchar(300)=''
OPEN c1
FETCH c1 into @name
WHILE @@FETCH_STATUS=0
	BEGIN
		SET @allnames=CONCAT(@allnames,', ',@name)
		FETCH c1 into @name
	END
SELECT @allnames AS Names
CLOSE c1
DEALLOCATE c1

-- -----------------------------------
-- cursor with (FOR UPDATE)
Declare c1 cursor
FOR SELECT Salary
	FROM Instructor
FOR UPDATE --update here means edit
Declare @sal int
OPEN c1
FETCH c1 INTO @sal
WHILE @@FETCH_STATUS=0
	BEGIN
		if @Sal>=3000
			UPDATE Instructor
				SET Salary=@sal*1.20
				WHERE CURRENT OF c1  --deal with the current row (where c1 point at)
		else 
			UPDATE Instructor
				SET Salary=@sal*1.10
				WHERE CURRENT OF c1
		FETCH c1 INTO @sal -- cursor++ (loop)
	END
CLOSE c1
DEALLOCATE c1

-- -----------------------------------
-- how many times this pattern appears (ahmed then amr)
Declare c1 CURSOR
FOR SELECT st_fname
	FROM Student
FOR READ ONLY
Declare @name varchar(10), @counter int=0, @flag int=0
OPEN c1
FETCH c1 INTO @name 
WHILE @@FETCH_STATUS=0
	BEGIN
		if @name='ahmed'
			SET @flag=1
		if @name='ali'
			BEGIN
				if @flag=1
				BEGIN
					SET @counter+=1
					SET @flag=0
				END
			END
		FETCH c1 INTO @name
	END
SELECT @counter AS "pattern repeated"
CLOSE c1
DEALLOCATE c1