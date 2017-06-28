# Servers

## SimpleHTTPServer

Run a simple http server in any directory on mac: `$ python -m SimpleHTTPServer [port number]`

Example: `$ python -m SimpleHTTPServer 8005`

## PostgreSQL Server

*PG::ConnectionBad*
```Unix
Started GET "/" for 127.0.0.1 at 2017-06-28 10:31:13 -0500
could not connect to server: No such file or directory
	Is the server running locally and accepting
	connections on Unix domain socket "/tmp/.s.PGSQL.5432"?
 excluded from capture: DSN not set

PG::ConnectionBad (could not connect to server: No such file or directory
	Is the server running locally and accepting
	connections on Unix domain socket "/tmp/.s.PGSQL.5432"?
):
```

Starting the server: `pg_ctl` - [utility to initialize, start, stop, or control a PostgreSQL server](https://www.postgresql.org/docs/9.5/static/app-pg-ctl.html).

Example: `$ pg_ctl start [-D datadir] [-l filename]`
* get path to postgres via `$ which postgres` => `/usr/local/var/postgres`
* `-D datadir`: Specifies the file system location of the database files.
* `-l filename`: Append the server log output to filename.
If you don't specify this, logs will be outputted to the console.

```Unix
$ pg_ctl -D /usr/local/var/postgres -l logfile start
```
