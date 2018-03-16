# Upon Closer RSpection

## DSL vs GPL (General-Purpose Language)

### DSL: Used for a specific problem domain.
* `make` langauge (vs `Rake`) is a DSL focused on building C programs
* `Ant` (you will see when you make Android applications for instance) is an XML-based equivalent of `make` for Java programs. `Ant` is complete different from Java even though the `Ant` interpreter is written in Java.
* Languages that have their own parser.

**Internal DSL** (i,e., Markaby)
* A language that lives within a larger GPL (i.e., Markaby, RSpec)
* You can fall back on the underlying GPL if needed.
* Syntax of GPL will be a constraint (Ruby does make this easier b/c of its flexibility vs Java)

**External DSL***
Langues that have their own parsers: `Ant`

### GPL (C++ or Ruby)
* RSpec lives within Ruby
* Sometimes DSLs are actually GPL in disguise: `Markaby`

