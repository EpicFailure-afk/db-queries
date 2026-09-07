-- create a database
-- create database Students 

-- ------------------------------------

/*
first we will create the dept table bc table student will
ref to that table 
*/
/*
use Students
create table Dept (
	Did int,
	Dname nvarchar(50)
)
*/ 
-- --------------------------------
-- put Did as not null first then put the pk
--alter table Dept 
--alter column Did int not null 
-- --------------------------------

-- add pk to Did
/*
alter table Dept
add constraint PK_dept
primary key (Did)
*/
-- --------------------------------

-- create the student table:
/*
use Students
create table Student
(
	Sid int primary key,
	Sname nvarchar (50),
	did int, 
	foreign key (did) REFERENCES Dept (Did) 
);
*/


-- --------------------------------------------------------
-- insert into Dept first 
/*
insert into Dept ( did, Dname )
Values
( 10, 'SD' ),
( 20, 'HR' ),
( 30, 'IS' ),
( 40, 'Admin' );
*/
-- --------------------------------------------------------


-- add Data into Student 
/*
insert into Student ( Sid, Sname, did )
values 
( 1, 'ahmed', 10),
( 2, 'khaled', 10),
( 3, 'eman', 20),
( 4, 'omar', null );
*/

-- ---------------------------------------------------------------

-- join 
--1 ( equi join )
/*
SELECT Sname, Dname 
FROM Student, Dept
WHERE Student.did = Dept.Did
*/

--2 ( inner join )

SELECT Sname, Dname
FROM Student S
FULL OUTER JOIN Dept D
	ON S.did = D.Did
