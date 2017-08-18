# Unix/Bash

`rvm use "$(cat .ruby-version)"`

The following command will only list files and will exclude directories, special files, pipes, symbolic links etc:

`$ find . -type f -name '*.js'`

* `-name pattern` True if the last component of the pathname being examined matches pattern.

* `-type type` True if the file is of the specified type.  Possible file types are as follows:
  - `d`: directory
  - `f`: regular file
  - `l`: symbolic link

`$ man find` for more options.
