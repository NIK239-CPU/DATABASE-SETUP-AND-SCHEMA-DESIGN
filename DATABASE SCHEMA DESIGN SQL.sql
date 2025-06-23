--CREATE DATABSE 
CREATE DATABASE Librarydb;
GO

----USE DATABASE
USE Librarydb;
GO

---CREATE TABLE
-- CREATE AUTHORS TABLE
CREATE TABLE AUTHORS (
    AUTHORID INT PRIMARY KEY,
	NAME NVARCHAR(100) NOT NULL,
	COUNTRY NVARCHAR(50)
	);
	GO

-- CREATE BOOK TABLE
CREATE TABLE BOOK (
    BOOKID INT PRIMARY KEY,
	TITLE NVARCHAR(150) NOT NULL,
	GENRE NVARCHAR(50),
	AUTHORID INT FOREIGN KEY REFERENCES AUTHORS(AUTHORID),
	PUBLISHEDYEAR INT,
	ISBN NVARCHAR (20) UNIQUE
	);
	GO

-- CREATE MEMBERS TABLE
CREATE TABLE MEMBERS (
     MEMBERID INT PRIMARY KEY,
	 FULLNAME NVARCHAR(100),
	 EMAIL NVARCHAR(100) UNIQUE,
	 JOINDATE DATE DEFAULT GETDATE()
	 );
	 GO

-- CREATE LENDING TABLE
CREATE TABLE LENDING (
     LENDINGID INT PRIMARY KEY,
	 BOOKID INT FOREIGN KEY REFERENCES BOOK(BOOKID),
	 MEMBERID INT FOREIGN KEY REFERENCES MEMBERS(MEMBERID),
	 ISSUEDATE DATE NOT NULL,
	 RETURNDATE DATE
	 );
	 GO

🔶 Entities and Relationships
1. AUTHORS
Primary Key: AUTHORID
Attributes: NAME, COUNTRY

2. BOOK
Primary Key: BOOKID
Attributes: TITLE, GENRE, PUBLISHEDYEAR, ISBN
Foreign Key: AUTHORID → AUTHORS(AUTHORID)

3. MEMBERS
Primary Key: MEMBERID
Attributes: FULLNAME, EMAIL, JOINDATE

4. LENDING
Primary Key: LENDINGID
Attributes: ISSUEDATE, RETURNDATE

Foreign Keys:
BOOKID → BOOK(BOOKID)
MEMBERID → MEMBERS(MEMBERID)

🔗 Relationships
AUTHORS → BOOK: One-to-Many (One author can write many books)
BOOK → LENDING: One-to-Many (One book can be lent many times)
MEMBERS → LENDING: One-to-Many (One member can borrow many books)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
INTRVIEW QUETIONS
		 
1) WHAT IS NORMALIZATION ?
=  Normalization is the process of organizing data in a database to eliminate redundancy (duplicate data) and ensure data integrity. 
   It involves dividing large tables into smaller, related tables and using keys to link them.
		 
2) EXPLAIN PRIMARY VS FOREGIN KEY.
= 1. Primary Key:A Primary Key is a column (or combination of columns) that uniquely identifies each record in a table.
Points:
1)Must contain unique values
2)Cannot be NULL
3)Each table can have only one primary key
4)Ensures entity integrity
5)The primary key acts as the unique identity of a row. It is the main way to distinguish one record from another in a table, ensuring that each record can be referenced or retrieved accurately.
💡 Example:
In a STUDENTS table:
StudentID (Primary Key), Name, Email
StudentID uniquely identifies each student.

= 2. Foreign Key:A Foreign Key is a column (or set of columns) in one table that refers to the primary key in another table.
  Points:
 1)Can contain duplicate values
 2)Can be NULL (if allowed)
 3)Can have multiple foreign keys in a table
 4)Ensures referential integrity
 5)Foreign keys are used to link related tables. They enforce consistency by making sure that a record in one table corresponds to a valid record in another.

💡 Example:
In a BOOKS table:
BookID, Title, AuthorID (Foreign Key)
AuthorID refers to the AUTHORID in the AUTHORS table, forming a relationship between books and authors.
A Primary Key ensures each record in a table is unique and not null.
A Foreign Key connects tables and ensures that the value in one table matches a value in another.


3) WHAT ARE CONSTAIN ?	
= Constraints are rules applied to columns in a table to ensure validity, consistency, and accuracy of the data.
  Common types:PRIMARY KEY,FOREIGN KEY,UNIQUE,NOT NULL,CHECK,DEFAULT.
		 
4) WHAT IS SURROGATE KEY?
= A surrogate key is an artificially generated unique identifier (usually a number or UUID) used as a primary key, instead of using a natural key.
 Example: Auto-incremented ID column instead of using something like an email address.

5) HOW DO YOU AVOID DATA REDUNDANCY?
= To avoid redundancy:
  1)Use Normalization
  2)Create separate related tables
  3)Use Primary and Foreign Keys
  4)Store data in one place only and reference it as needed
		 
6) WHAT IS ER DIAGRAM ?
= An ER (Entity-Relationship) Diagram is a visual representation of:
 1) Entities (tables)
  2)Attributes (columns)
  3)Relationships between entities
  4)Used in database design to show how data is structured and connected.
		 
7) WHAT ARE THE TYPE OF RELATIONSHIP IN DBMS?
= a Database Management System (DBMS), relationships define how data in one table is related to data in another.
  These relationships are based on cardinality — the number of occurrences in one entity that relate to the number of occurrences in another.
  Here are the three main types of relationships in DBMS, explained in theory:
 🔹 1. One-to-One (1:1)
 A one-to-one relationship means each record in Table A relates to only one record in Table B, and vice versa.
 Use Case: Separating sensitive or rarely used information.
 Example: Each person has one passport.
 This relationship ensures a unique mapping between two entities, often used for performance or security reasons by splitting data into two related tables.

🔹 2. One-to-Many (1:N)
A one-to-many relationship means one record in Table A can relate to many records in Table B, but each record in Table B relates to only one record in Table A.
Use Case:Classic parent-child relationship.
Example: One author writes many books.
This is the most common type in relational databases. It reflects a hierarchical structure, where one entity is the “parent” and the other the “child.”

🔹 3. Many-to-Many (M:N)
 In a many-to-many relationship, multiple records in Table A can relate to multiple records in Table B.
 Use Case:Students and courses: A student can enroll in many courses, and a course can have many students.
 Since relational databases do not support direct M:N relationships, this is implemented using a junction (or associative) table that breaks the relationship into two one-to-many relationships.


8) EXPLIAN THE PURPOSE OF AUTO_INCREMENT.
= AUTO_INCREMENT is used in MySQL to automatically generate a unique number for a column (usually a primary key) when a new record is inserted.
 Example:
        ID INT AUTO_INCREMENT PRIMARY KEY	
		 
9) WHAT IS THE DEFAULT STORAGE ENGIN IN MYSQL?
As of recent versions, the default storage engine in MySQL is:
InnoDB
It supports transactions, foreign keys, and better crash recovery.
		 
10) WHAT IS A COMPOITE KEY ?
A composite key is a primary key made up of two or more columns that together uniquely identify a record in a table.
Example:
PRIMARY KEY (StudentID, CourseID)
This means the combination of StudentID and CourseID must be unique.		 




