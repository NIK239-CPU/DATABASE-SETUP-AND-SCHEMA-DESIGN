--TASK 2 : DATA INSERTION AND HANDLING 
-- SQL FILE WITH INSERT,UPDATE,DELETE ,STATEMENTS
--INSERT INTO
-- INSERT INTO AUTHORS

-- AUTHORS TABLE – INSERT 4 ROWS (1 WITH NULL COUNTRY)

INSERT INTO AUTHORS (AUTHORID, NAME, COUNTRY) VALUES
(1, 'J.K. ROWLING', 'UK'),
(2, 'GEORGE ORWELL', NULL),
(3, 'JANE AUSTEN', 'UK'),
(4, 'MARK TWAIN', 'USA');

-- BOOK TABLE – INSERT 5 ROWS (1 WITH NULL AUTHORID, 1 WITH NULL ISBN)

INSERT INTO BOOK (BOOKID, TITLE, AUTHORID, PUBLISHEDYEAR, ISBN) VALUES
(101, 'HARRY POTTER', 1, 1997, 'ISBN001'),
(102, '1984', 2, 1949, 'ISBN002'),
(103, 'PRIDE AND PREJUDICE', 3, 1813, NULL),
(104, 'ADVENTURES OF HUCKLEBERRY FINN', 4, 1884, 'ISBN004'),
(105, 'UNKNOWN BOOK', NULL, 2020, 'ISBN005');  -- NO AUTHOR ASSIGNED


---MEMBERS TABLE – INSERT 4 ROWS (1 WITH NULL EMAIL)

INSERT INTO MEMBERS (MEMBERID, FULLNAME, EMAIL) VALUES
(201, 'ALICE SMITH', 'ALICE@EXAMPLE.COM'),
(202, 'BOB JOHNSON', NULL),
(203, 'CHARLIE BROWN', 'CHARLIE@EXAMPLE.COM'),
(204, 'DAISY MILLER', 'DAISY@EXAMPLE.COM');


-- LENDING TABLE – INSERT 5 ROWS (2 WITH NULL RETURN DATE)

INSERT INTO LENDING (LENDINGID, BOOKID, MEMBERID, ISSUEDATE, RETURNDATE) VALUES
(301, 101, 201, '2025-06-01', '2025-06-15'),
(302, 102, 202, '2025-06-05', NULL),  -- NOT RETURNED YET
(303, 103, 203, '2025-06-10', '2025-06-20'),
(304, 104, 204, '2025-06-12', NULL),  -- NOT RETURNED YET
(305, 105, 201, '2025-06-18', '2025-06-25');

-- UPDATE STATEMENTS

-- UPDATE MISSING MEMBER EMAIL
UPDATE MEMBERS
SET EMAIL = 'BOB123@MAIL.COM'
WHERE MEMBERID = 202;

-- UPDATE BOOK TO ASSIGN AUTHOR
UPDATE BOOK
SET AUTHORID = 3
WHERE BOOKID = 105;


---DELETE STATEMENTS

-- DELETE LENDING WHERE RETURNDATE IS NULL
DELETE FROM LENDING
WHERE RETURNDATE IS NULL;

-- DELETE BOOKS WITH NULL ISBN
DELETE FROM BOOK
WHERE ISBN IS NULL;

--UPDATE QUERIES (WITH WHERE CLAUSE AND NULL HANDLING)
--UPDATE AUTHOR COUNTRY
UPDATE AUTHORS
SET COUNTRY = 'UNITED KINGDOM'
WHERE NAME = 'GEORGE ORWELL' AND COUNTRY IS NULL;

--UPDATE BOOK AVAILABILITY YEAR
UPDATE BOOK
SET PUBLISHEDYEAR = 2001
WHERE TITLE = 'HARRY POTTER';

--UPDATE MISSING MEMBER EMAIL
UPDATE MEMBERS
SET EMAIL = 'BOB123@EXAMPLE.COM'
WHERE FULLNAME = 'BOB' AND EMAIL IS NULL;

--UPDATE BOOK AUTHOR IF AUTHORID IS NULL
UPDATE BOOK
SET AUTHORID = 3
WHERE BOOKID = 105 AND AUTHORID IS NULL;

--SET RETURN DATE FOR RETURNED BOOKS
UPDATE LENDING
SET RETURNDATE = '2025-06-25'
WHERE RETURNDATE IS NULL;


--DELETE QUERIES (WITH WHERE CLAUSE)
--DELETE A MEMBER BY ID
DELETE FROM MEMBERS
WHERE MEMBERID = 202;

-- DELETE BOOKS WITH NULL ISBN
DELETE FROM BOOK
WHERE ISBN IS NULL;

--DELETE LENDING ENTRIES WITH NULL RETURN DATE
DELETE FROM LENDING
WHERE RETURNDATE IS NULL;

-- DELETE BOOKS WRITTEN BY A SPECIFIC AUTHOR
DELETE FROM BOOK
WHERE AUTHORID = (SELECT AUTHORID FROM AUTHORS WHERE NAME = 'MARK TWAIN');

-- DELETE ORPHAN BOOKS (BOOKS WITH NULL AUTHORID)
DELETE FROM BOOK
WHERE AUTHORID IS NULL;

===================================================================================================================================================================
INTERVIEW QUETIONS 
1)DIFFERENCE BETWEEN NULL AND 0 
The difference between NULL and 0 in databases (like SQL) is fundamental. Here's a clear explanation:
  1)NULL
Meaning: Unknown, missing, or not applicable.
Type: Not a value — it represents the absence of a value.
Use Case: A field hasn't been filled in yet, or the data doesn't exist.
Example: If a book's PUBLISHEDYEAR is NULL, it means we don’t know when it was published.

2) 0 (Zero)
Meaning: A known value that is literally zero.
Type: Numeric value.
Use Case: A count, quantity, or numeric field that is explicitly set to zero.
Example: If a copies_sold column is 0, it means the book has sold none, not that we don't know the number.

2) What is a DEFAULT constraint?
= A DEFAULT constraint sets a default value for a column when no value is provided during INSERT.
 CREATE TABLE books (
  bookid INT,
  title VARCHAR(100),
  genre VARCHAR(50) DEFAULT 'Unknown'
);
If you insert without a genre, it will automatically be 'Unknown'.

3) How does NULL work?
=NULL means no value or unknown value.
 Comparisons with NULL use IS NULL or IS NOT NULL.
 SELECT * FROM books WHERE genre IS NULL;
  
4) How do you update multiple rows?
= Use UPDATE with a WHERE clause that matches multiple rows:
UPDATE books
SET genre = 'Fiction'
WHERE publishedyear < 2010;
=You can also use CASE for different values:
 UPDATE books
 SET genre = CASE 
    WHEN bookid = 1 THEN 'Thriller'
    WHEN bookid = 2 THEN 'Fantasy'
  END
WHERE bookid IN (1, 2);
  
5) Can we insert partial values?
= Yes if:The columns you're skipping have default values, or
  They allow NULLs
 INSERT INTO books (bookid, title) VALUES (4, 'New Book');

6) What happens if a NOT NULL field is left empty?
= It causes an error. Example:
= Fails if title is NOT NULL
INSERT INTO books (bookid, genre) VALUES (5, 'Horror');

7) How do you rollback a deletion?
Use transactions:
BEGIN TRANSACTION;
DELETE FROM books WHERE bookid = 1;
ROLLBACK;  -- Undoes the DELETE
            Or
COMMIT;  -- Permanently saves the deletion

8) Can we insert value into specific columns only?
= Yes= Just list the columns you want to insert:
 INSERT INTO books (bookid, title) VALUES (6, 'Skybound');

9) How to insert values using SELECT?
= You can copy rows from another table or result:
INSERT INTO books (bookid, title, genre)
SELECT bookid, title, genre FROM old_books WHERE publishedyear > 2000;

10) What is ON DELETE CASCADE?
= It’s a foreign key rule that means: If a parent row is deleted, all matching child rows are automatically deleted.
CREATE TABLE orders (
  orderid INT,
  bookid INT,
  FOREIGN KEY (bookid) REFERENCES books(bookid) ON DELETE CASCADE
);
