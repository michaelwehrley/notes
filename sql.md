# SQL

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
