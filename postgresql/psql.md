# PostgreSQL

## Installation

* Default port the server will listen on: `5432`
* Locale for default database cluster
  - `initdb` also initializes the default locale for the database cluster

## Overview

### Creating Database Cluster

* A database storage area must be initialized on disk to do anything.
  - We call this a _database cluster_.
  - A database cluster is a single *directory* under which all data will be stored (i.e., _data directory_ or _data area_)
  - The SQL standard uses the term catalog _cluster_.
  - After initialization, a database cluster will contain a database named _postgres_.

`-D` specifies the path to the database cluster/data directory:

* `pg_ctl` is an executable used to start or stop a server so you could use it for both.
* `$ pg_ctl -D /usr/local/pgsql/data initdb` or `$ initdb -D /usr/local/pgsql/data`.

There is no default, although locations such as `/usr/local/pgsql/data` or `/var/lib/pgsql/data` are popular:
* note `postgres` and `template1` as default database.

                                    List of databases
Name         | Owner | Encoding |   Collate   |    Ctype    | Access privileges
-------------+-------+----------+-------------+-------------+-------------------
postgres     | mike  | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
template0    | mike  | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/mike          +
             |       |          |             |             | mike=CTc/mike
template1    | mike  | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/mike          +
             |       |          |             |             | mike=CTc/mike

## Kill

1. Find the processes running postgres: `$ ps -ef | grep postgres`
1. Kill process: `$ sudo kill -9 "# of the connection"`

### Directory Permission Issues

* You will likely need access to the `pgsql` & `data` directories:

```
root# mkdir /usr/local/pgsql
root# chown postgres /usr/local/pgsql
root# su postgres

postgres$ initdb -D /usr/local/pgsql/data
```

### Roles and Permissions

* Utility from command line `$createuser bob` is the same as `CREATE ROLE bob;` (note: can't login)
* `CREATE USER` is equivalent to `CREATE ROLE` except that `CREATE USER` assumes `LOGIN by default, while `CREATE ROLE` does not.

`postgres=# CREATE ROLE bob;`
`postgres=# CREATE USER foo;`
`postgres=# CREATE ROLE colleen LOGIN CREATEROLE CREATEDB;`
`postgres=# CREATE USER colleen SUPERUSER;`
`postgres=# \du`
                             List of roles
 Role name |                   Attributes                   | Member of
-----------+------------------------------------------------+-----------
 bob       | Cannot login                                   | {}        
 foo       |                                                | {}
 mike      | Superuser, Create role, Create DB, Replication | {}

```
 CREATE ROLE name [ [ WITH ] option [ ... ] ]

 where option can be:

     | SUPERUSER | NOSUPERUSER
     | CREATEDB | NOCREATEDB
     | CREATEROLE | NOCREATEROLE
     | CREATEUSER | NOCREATEUSER
     | INHERIT | NOINHERIT
     | LOGIN | NOLOGIN
     | REPLICATION | NOREPLICATION
     | CONNECTION LIMIT connlimit
     | [ ENCRYPTED | UNENCRYPTED ] PASSWORD 'password'
     | VALID UNTIL 'timestamp'
     | IN ROLE role_name [, ...]
     | IN GROUP role_name [, ...]
     | ROLE role_name [, ...]
     | ADMIN role_name [, ...]
     | USER role_name [, ...]
     | SYSID uid
```

### Database

* Log in `$ psql postgres`
* View users: `postgres=# \du`

List of roles
Role name |                   Attributes                   | Member of
----------+------------------------------------------------+-----------
bob       | Cannot login                                   | {}
mike      | Superuser, Create role, Create DB, Replication | {}

### List Databases

* From command line: `$ psql -l` or `psql --list`
* From within PostgreSQL: `postgres-# \l` or `postgres-# \list`

                                    List of databases
         Name    | Owner | Encoding |   Collate   |    Ctype    | Access privileges
-----------------+-------+----------+-------------+-------------+-------------------
 foo_development | mike  | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 foo_test        | mike  | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 postgres        | mike  | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0       | mike  | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/mike          +
                 |       |          |             |             | mike=CTc/mike
 template1       | mike  | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/mike          +
                 |       |          |             |             | mike=CTc/mike

* List database with *additional* information `postgres=# \l+`.

                 List of databases
Name         | Owner | Encoding |   Collate   |    Ctype    | Access privileges |  Size   | Tablespace |                Description                 
-------------+-------+----------+-------------+-------------+-------------------+---------+------------+--------------------------------------------
data_sci     | mike  | UTF8     | en_US.UTF-8 | en_US.UTF-8 |                   | 6620 kB | pg_default |
postgres     | mike  | UTF8     | en_US.UTF-8 | en_US.UTF-8 |                   | 6620 kB | pg_default | default administrative connection database
template0    | mike  | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/mike          +| 6497 kB | pg_default | unmodifiable empty database
             |       |          |             |             | mike=CTc/mike     |         |            |
template1    | mike  | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/mike          +| 6505 kB | pg_default | default template for new databases
             |       |          |             |             | mike=CTc/mike     |         |            |
test         | mike  | UTF8     | en_US.UTF-8 | en_US.UTF-8 |                   | 6620 kB | pg_default |
(7 rows)


### Accessing PostgreSQL

* From command line to access database: `$ psql database_name_development`

* Connect to a specific database (analogous to `$ psql -d foo_development`): `postgres=# \connect foo_development`
  - You could also skip the `-d` flag: `$ psql foo_development`
  - You will then be in "foo_development": `foo_development=#`
  - To exit: `\q`

### Listing Tables

* List datatables within psql:
* ` \dt[S+] [ pattern ]`
Note: The letters `E`, `i`, `m`, `s`, `t`, and `v` stand for foreign table, index, materialized view, sequence, table, and view, respectively.

```sql
database_name_development=# \dtsi
```

Schema | Name  |   Type   | Owner |       Table                       
-------+-=-----+----------+-------+-----------------------
public | foo   | table    | mike  |
public | bar   | sequence | mike  |
public | baz   | index    | mike  | admin_comments

* Display one table:
```sql
database_name_development=# \d my_table
```

### Create/Drop Database

Create within the terminal:
  - `$ createdb test -U mike` (this will give that user privileges otherwise it is public)
  - `createdb` is a postgres command/utility that issues the `CREATE DATABASE` command.
  - log in to via `$ psql postgres`
  - List database `postgres=# \list` or `postgres=# \l` or `postgres=# \l+` for *additional* information.

Create within PostgreSQL (cannot be executed while connected to the target database):
* `postgres=# CREATE DATABASE dbname owner rolename;`
* `postgres=# DROP DATABASE dbname;` or `postgres=# DROP DATABASE IF EXISTS dbname;`

Drop db using the utility from UNIX command line: `$ dropdb dbname`

From server:
`postgres=# DROP DATABASE test4;`
`DROP DATABASE`

`postgres=# DROP DATABASE test4;`
`ERROR:  database "test4" does not exist`

`postgres=# DROP DATABASE [IF EXISTS] test4;`
`DROP DATABASE`

## Privileges

### Table Privileges

`$ psql postgres`
`postgres=# CREATE DATABASE data_sci; => CREATE DATABASE`
`postgres=# \connect data_sci;`
`data_sci=# CREATE TABLE users (first_name TEXT, last_name TEXT); => CREATE TABLE`
`data_sci=# GRANT SELECT ON users TO PUBLIC; => GRANT`

Grant access to a table:

```
data_sci=# \dp
                           Access privileges
 Schema | Name  | Type  | Access privileges | Column access privileges
--------+-------+-------+-------------------+--------------------------
 public | users | table | mike=arwdDxt/mike+|
        |       |       | =r/mike           |
(1 row)
```

Grant a permission on a column on the `users` table:
`data_sci=# GRANT SELECT (first_name), UPDATE (first_name) ON users TO mike; => GRANT`


```
data_sci=# \dp
                           Access privileges
 Schema | Name  | Type  | Access privileges | Column access privileges
--------+-------+-------+-------------------+--------------------------
 public | users | table | mike=arwdDxt/mike+| first_name:             +
        |       |       | =r/mike           |   mike=rw/mike
(1 row)
```

## Commands

* Simple Arithmetic:

`$ psql postgres`
```
psql (9.4.13)
Type "help" for help.

postgres=# select 1+1;
 ?column?
----------
        2
```

## Queries

Setup:
1. log in: `$ pgsl postgres`;
1. List databases: `postgres=# \l` or `postgres=# \list`;
1. Create database: `postgres=# CREATE DATABASE world;`;
1. Adding data can be done by copying and pasting the sql script when connected to db or `$ psql world < ./postgresql/world-pg.sql`;
1. Connect: `postgres=# \c world` or `postgres=# \connect world`;
1. Inspect database: `world=# \d`:
  * View on the tables: `world=# \dt`
  * View on the view: `world=# \dv`
  * View on the sequence: `world=# \ds`

```
world=# \d
              List of relations
 Schema |      Name       |   Type   | Owner
--------+-----------------+----------+-------
 public | city            | table    | mike
 public | city_id_seq     | sequence | mike
 public | country         | table    | mike
 public | countrylanguage | table    | mike
 public | view_databases  | view     | mike
 public | view_indexes    | view     | mike
 public | view_tables     | view     | mike
 public | view_views      | view     | mike
(8 rows)
```

### Arithmetic...

### Subqueries

* Average population for each continent (Subquery in SELECT clause)

`world=# SELECT country.code, country.population FROM country;`
`world=# SELECT city.name, city.population, city.countrycode FROM city;`

```
SELECT
  co.name,
  ci.name,
  ci.population
FROM
  country AS co,
  city AS ci;
```

```
SELECT
  co.name,
  ci.name,
  ci.population,
  (SELECT round(avg(co2.population)) FROM country AS co2 WHERE ci.population = 0)
FROM
  country AS co,
  city AS ci;
```

## JOINS

### INNER JOIN
* What we want: `SELECT ci.name, ci.population, co.name`;
* From where: `FROM city as ci` and `FROM country as co`;
* What we want to `JOIN`:
```
FROM
  city as ci
JOIN
  country as co
```
* How to join:
```
FROM
  city AS ci
JOIN
  country AS co
ON
  ci.countrycode = co.code;
```
* Put it together:
```
SELECT
  ci.name,
  ci.population,
  co.name
FROM
  city AS ci JOIN country AS co
ON
  ci.countrycode = co.code;
```

### LEFT JOIN / LEFT OUTER JOIN
* What we want: `SELECT ci.name, ci.population, co.name`;
* From where: `FROM city as ci` and `FROM country as co`;
* What we want to `LEFT OUTER JOIN` just in case a country exists without a city:
```
SELECT
  co.name,
  ci.name,
  ci.population
FROM
  country AS co LEFT OUTER JOIN city AS ci
ON
  co.code = ci.countrycode;
```

<!-- select wb.user_id, (select users.email from users where users.id = wb.user_id) from waste_bags wb where wb.order = true limit 10; -->
