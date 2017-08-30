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

Move multiple files at once to a new directory:
`mv ~/Desktop/*.png ~/path/to/new/directory/`

# Linking Files

* Link `$ ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl`
* Unlink `$ rm /usr/local/bin/subl`