# Heroku

## Dynos

### Dyno Configurations (https://devcenter.heroku.com/articles/dynos#dyno-configurations)

Every dyno belongs to one of the three following configurations:

* Web: Web dynos are dynos of the “web” process type that is defined in your Procfile. Only web dynos receive HTTP traffic from the routers.

* Worker: Worker dynos can be of any process type declared in your Procfile, other than “web”. Worker dynos are typically used for background jobs, queueing systems, and timed jobs. You can have multiple kinds of worker dynos in your application. For example, one for urgent jobs and another for long-running jobs. For more information, see Worker Dynos, Background Jobs and Queueing.

* One-off: One-off dynos are temporary dynos that can run detached, or with their input/output attached to your local terminal. They’re loaded with your latest release. They can be used to handle administrative tasks, such as database migrations and console sessions. They can also be used to run occasional background work, as with Heroku Scheduler. For more information, see One-Off Dynos


###$ Process/thread limits

The maximum number of processes/threads that can exist in a dyno at any one time depends on dyno type:

* free, hobby and standard-1x dynos support no more than 256
* standard-2x and private-s dynos support no more than 512
* performance-m and private-m dynos support no more than 16384
* performance-l and private-l dynos support no more than 32768

`bundle exec sidekiq -q foo -c 4` with `2 dynos`

`$ bin/sidekiq --help`

```
  -c, --concurrency INT            processor threads to use
  -d, --daemon                     Daemonize process
  -e, --environment ENV            Application environment
  -g, --tag TAG                    Process tag for procline
  -i, --index INT                  unique process index on this machine
  -q, --queue QUEUE[,WEIGHT]       Queues to process with optional weights
  -r, --require [PATH|DIR]         Location of Rails application with workers or file to require
  -t, --timeout NUM                Shutdown timeout
  -v, --verbose                    Print more verbose output
  -C, --config PATH                path to YAML config file
  -L, --logfile PATH               path to writable logfile
  -P, --pidfile PATH               path to pidfile
  -V, --version                    Print version and exit
  -h, --help                       Show help
```