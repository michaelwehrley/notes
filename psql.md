# PSQL

## Installation

* Default port the server will listen on: `5432`
* Locale for default database cluster
  - `initdb` also initializes the default locale for the database cluster

## Creating Database Cluster

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

## Permission Issues

* You will likely need access to the `pgsql` & `data` directories:

```
root# mkdir /usr/local/pgsql
root# chown postgres /usr/local/pgsql
root# su postgres
postgres$ initdb -D /usr/local/pgsql/data
```

## Database

* Log in `$ psql postgres`
* View users: `postgres=# \du`

List of roles
Role name |                   Attributes                   | Member of
----------+------------------------------------------------+-----------
mike      | Superuser, Create role, Create DB, Replication | {}

## List Databases

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

## Accessing PostgreSQL

Note: The letters `E`, `i`, `m`, `s`, `t`, and `v` stand for foreign table, index, materialized view, sequence, table, and view, respectively.

* From command line to access database: `$ psql database_name_development`
* List datatables once in psql:
* ` \dt[S+] [ pattern ]`
```sql
database_name_development=# \dt
```
* Display one table:
```sql
database_name_development=# \d my_table
```

* Connect to a specific database (analogous to `$ psql -d foo_development`): `postgres=# \connect foo_development`
  - You could also skip the `-d` flag: `$ psql foo_development`
  - You will then be in "foo_development": `foo_development=#`
  - To exit: `\q`

## Create/Drop Database

Create within PostgreSQL:
* `postgres=# CREATE DATABASE dbname owner rolename;`

Drop within PostgreSQL (cannot be executed while connected to the target database):
* `postgres=# DROP DATABASE dbname;` or `postgres=#  DROP DATABASE IF EXISTS dbname;`
* `$ dropdb dbname`

`postgres=# DROP DATABASE test4;`
`ERROR:  database "test4" does not exist`

`postgres=# DROP DATABASE [IF EXISTS] test4;`
`DROP DATABASE`

Create within the terminal:
  - `$ createdb test -U mike` (this will give that user privileges otherwise it is public)
  - `createdb` is a postgres command that issues the `CREATE DATABASE` command.
  - log in to via `$ psql postgres`
  - List database `postgres=# \list` or `postgres=# \l` or `postgres=# \l+` for *additional* information.

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
