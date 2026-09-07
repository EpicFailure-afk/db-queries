CREATE TABLE Dept
(
	Dept_id int primary key,
	dname varchar(20)
)

CREATE TABLE emp 
(
	eid int identity(1,1),
	ename varchar(20),
	eadd varchar(20) DEFAULT 'Alex',
	hiredate date DEFAULT getdate(),
	sal int,
	overtime int,
	netsal AS (ISNULL(sal,0) + ISNULL(overtime,0)) persisted,
	BD date,
	age AS (year(getdate()) - year(BD)),  -- --> can not be presisted bc of getdate() 
	gender varchar(1),
	hour_rate int NOT NULL ,
	did int,

	-- constraints
	CONSTRAINT c1 PRIMARY KEY (eid, ename),
	CONSTRAINT c2 UNIQUE (sal),
	CONSTRAINT c3 UNIQUE (overtime),
	CONSTRAINT c4 CHECK (sal>1000),
	CONSTRAINT c5 CHECK (eadd in ('cairo', 'Mansoura', 'Alex')),
	CONSTRAINT c6 CHECK (gender = 'F' or gender = 'M'),
	CONSTRAINT c7 CHECK (overtime between 150 and 500 ),
	CONSTRAINT c8 FOREIGN KEY (did) REFERENCES Dept(Dept_id)
		ON DELETE SET NULL ON UPDATE CASCADE -- constraint on relation  
)

-- constraint --> on new data
-- constraint --> shared among multible tables 

-- Rule
/*
	CREATE rule r1 AS @x>1000
	sp_bindrule r1, 'instructor.salary'
	sp_bindrule r1, 'emp.overtime'
*/

-- create a new complex data type 
CREATE rule r1 AS @x>1000 -- 1: create the rule
CREATE DEFAULT def1 AS 5000 -- 2: create the default value
sp_addtype ComplexDT, 'int' -- 3: create the datatype

sp_bindrule r1, ComplexDT
sp_bindefault  def1, ComplexDT


-- test the complex

CREATE TABLE test3 
(
	id int,
	name varchar(20),
	salary ComplexDT

)

