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

`$ initdb -D /usr/local/pgsql/data` or analogously `$ pg_ctl -D /usr/local/pgsql/data initdb`

`pg_ctl` is an executable used to start or stop a server so you could use it for both.

### Create Database

* Log in `psql postgres`

* View users: `postgres=# \du`

List of roles
Role name |                   Attributes                   | Member of
----------+------------------------------------------------+-----------
mike      | Superuser, Create role, Create DB, Replication | {}

* List database `postgres-# \l`
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

* Connect to a specific database (analogous to `psql -d foo_development`): `postgres=# \connect foo_development`
  - To exit: `psql postgres`

* `which createdb` to verify it exists. Create: `createdb test -U mike`
  - log in `psql postgres`
  - List database `postgres=# \list`
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
   test            | mike  | UTF8     | en_US.UTF-8 | en_US.UTF-8 |

### Permission Issues

* You will likely need access to the `pgsql` & `data` directories:

```
root# mkdir /usr/local/pgsql
root# chown postgres /usr/local/pgsql
root# su postgres
postgres$ initdb -D /usr/local/pgsql/data
```

## Accessing

* From command line to access database: `$ psql database_name_development`
* List datatables once in psql:
```sql
database_name_development=# \dt
```
* Display one table:
```sql
database_name_development=# \d my_table
```
