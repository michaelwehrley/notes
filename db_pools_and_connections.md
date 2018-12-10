# Concurrency, Database Connections, & Testing

https://devcenter.heroku.com/articles/concurrency-and-database-connections

* Pool is 5
* Standard4 heroku-postgresql:standard-4 500 Connection limit
* `heroku pg:info -r demo`: "Connections: 4/500"

https://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html
(-) save
(-) valid
(1) before_validation
(-) validate
(2) after_validation
(3) before_save
(4) before_create
(-) create
(5) after_create
(6) after_save (code is run and trigger and the record is saved, but other db connections can't see the record yet until the TRANSACTION is completed)
(7) after_commit (db TRANSACTION is now complete)

https://www.justinweiss.com/articles/a-couple-callback-gotchas-and-a-rails-5-fix/
Rails calls `after_save` callbacks immediately after the record saves. *But that record can’t be seen by other database connections, like the one Sidekiq is using, until the database _transaction_ is committed, which happens a little later.* This means there’s a chance that Sidekiq will try to find your question after you save it, but before you commit it. It can’t find your record, and it explodes.

### Testing (RSpec):

Each spec is run in its own db transaction (faster), so when the tests that have a callback for the `after_commit` are run, the transaction that ran the spec (such as saving the object) is now rolled back, and the `after_commit` can't find that object created in that spec.

`test_after_commit` was needed before rails 5
