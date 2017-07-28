# SQL

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
