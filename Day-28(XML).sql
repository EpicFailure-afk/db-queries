-- ------XML------
--2: FOR XML --> convert table to xml
-- XMl RAW
SELECT * FROM Student 
FOR XML RAW('Student')

-- as elements, root
SELECT * FROM Student 
FOR XML RAW('Student'), ELEMENTS , ROOT('ITI_Studs')

-- show null values
SELECT * FROM Student --> ELEMENTS XSINIL
FOR XML RAW('Student'), ELEMENTS XSINIL, ROOT('ITI_Studs')

-- usecase
SELECT St_Address, COUNT(st_id) 
FROM Student
GROUP BY St_Address
FOR XML RAW('Student'), ELEMENTS, ROOT('ITI_Studs')

-- XMl AUTO -- with join 
-- select each Topic with its courses with old style join 
SELECT topic.Top_Id, Top_name, crs_Id, crs_name
FROM Topic, Course
WHERE topic.Top_Id=Course.Top_Id
FOR XML AUTO, ELEMENTS

-- XML path
-- xpath expression
SELECT St_Id "@StudentID", -- attribute
		St_Fname "StudentName/FirstName", -- nested tag 
		St_Lname "StudentName/LastName",
		St_Address "Address" -- tag
FROM Student
FOR XML PATH ('Student'), Root ('Students')

-- -----------------------------------------------------------
--2: open xml --> convert from xml to table

-------step 1: put xml in a variable--------------
Declare @docs XML='
<Students>
  <Student StudentID="1">
    <StudentName>
      <FirstName>Ahmed</FirstName>
      <LastName>Hassan    </LastName>
    </StudentName>
    <Address>Cairo</Address>
  </Student>
  <Student StudentID="2">
    <StudentName>
      <FirstName>Amr</FirstName>
      <LastName>Magdy     </LastName>
    </StudentName>
    <Address>Cairo</Address>
  </Student>
  <Student StudentID="3">
    <StudentName>
      <FirstName>Mona</FirstName>
      <LastName>Saleh     </LastName>
    </StudentName>
    <Address>Cairo</Address>
  </Student>
  <Student StudentID="4">
    <StudentName>
      <FirstName>Mahmoud</FirstName>
      <LastName>Mohamed   </LastName>
    </StudentName>
    <Address>Alex</Address>
  </Student>
  <Student StudentID="5">
    <StudentName>
      <FirstName>Khalid</FirstName>
      <LastName>Moahmed   </LastName>
    </StudentName>
    <Address>Alex</Address>
  </Student>
  <Student StudentID="6">
    <StudentName>
      <FirstName>Heba</FirstName>
      <LastName>Farouk    </LastName>
    </StudentName>
    <Address>Mansoura</Address>
  </Student>
  <Student StudentID="7">
    <StudentName>
      <FirstName>Ali</FirstName>
      <LastName>Hussien   </LastName>
    </StudentName>
    <Address>Cairo</Address>
  </Student>
  <Student StudentID="8">
    <StudentName>
      <FirstName>Mohamed</FirstName>
      <LastName>Fars      </LastName>
    </StudentName>
    <Address>Alex</Address>
  </Student>
  <Student StudentID="9">
    <StudentName>
      <FirstName>Saly</FirstName>
      <LastName>Ahmed     </LastName>
    </StudentName>
    <Address>Mansoura</Address>
  </Student>
  <Student StudentID="10">
    <StudentName>
      <FirstName>Fady</FirstName>
      <LastName>Ali       </LastName>
    </StudentName>
    <Address>Alex</Address>
  </Student>
  <Student StudentID="11">
    <StudentName>
      <FirstName>Marwa</FirstName>
      <LastName>Ahmed     </LastName>
    </StudentName>
    <Address>Cairo</Address>
  </Student>
  <Student StudentID="12">
    <StudentName>
      <FirstName>Noha</FirstName>
      <LastName>Omar      </LastName>
    </StudentName>
    <Address>Cairo</Address>
  </Student>
  <Student StudentID="13">
    <StudentName>
      <FirstName>Said</FirstName>
    </StudentName>
  </Student>
  <Student StudentID="14">
    <StudentName>
      <LastName>Saleh     </LastName>
    </StudentName>
    <Address>Tanta</Address>
  </Student>
</Students>
'

-------step 2: declare document handle--------------
Declare @hdocs int

-------step 3: create memory tree--------------------
EXEC SP_XML_PREPAREDOCUMENT @hdocs OUTPUT, @docs

-------step 4: Process Document----------------------
SELECT *
FROM OPENXML ( @hdocs, '//Student')  -- xpath expression (each student tag)
WITH (StudentID int '@StudentID',
      SAddress varchar(10) 'Address',
      StudentFirst varchar(10) 'StudentName/FirstName',
      StudentSecond varchar(10) 'StudentName/LastName'
      )

-------step 5: reomve mem tree----------------------
EXEC SP_XML_REMOVEDOCUMENT @hdocs
