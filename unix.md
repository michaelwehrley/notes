# Unix/Bash

## .bashrc or .bash_profile

`.bashrc` was originally a separate file from `.bash_profile` for performance reasons and work habits. There are certain command someone probably only needs to run once in the morning when they log in.[✝](http://mywiki.wooledge.org/DotFiles)

`.bash_profile` typically launched when a users logs in and provides username and password. 
`.bashrc` is the default bash profiling file for Unix or Linux and runs when a new terminal window is opened.
`.bash_profile` on MacOS when Terminal.app on macOS opens a new terminal, it will run `.bash_profile` not `.bashrc` as would happen on Unix.

Solution for MacOS users if you want to be consistent with Unix or Linux bc MacOS only reads `.bashrc` for non-login shells::
```bash
# .bash_profile
if [ -r ~/.bashrc ]; then
   source ~/.bashrc
fi
```

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