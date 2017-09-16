# Git

* _remote_ is just a git repo not on your computer (i.e. on Github);
* _origin_ is the repo you cloned your repo from (i.e., git@github.com:michaelwehrley/notes.git);
* _master_ is the default branch.

```Bash
git branch -l # local branches..
master
* test
```

```Bash
git branch -r # remote branches (i.e., remote is Github)

# origin is michaelwehrley/notes.git)
# When cloned this branch (i.e., master) will be checked out by default
remotes/origin/HEAD -> origin/master

remotes/origin/master
remotes/origin/test
```

## AutoCompletion

Request the file
```bash
curl -OL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
```
`-O, --remote-name` flag causes only the file part of the remote file is used, the path is cut off.
`-L, --location` flag says that if the HTTP GET request from the server reports that the requested page has moved to a different location then this option will make curl redo the request on the new place.

Rename:
```bash
mv ~/git-completion.bash ~/.git-completion.bash
```

Add to `~/.bash_profile`:
```bash
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi
```

## Configuration

`~/path/to/project/.git/config`

```Bash
cat ~/path/to/project/.git/config

[remote "origin"]
  url = git@github.com:michaelwehrley/notes.git
  fetch = +refs/heads/*:refs/remotes/origin/*
```

Then you can run `$ git fetch origin` and it will run:
`$ git fetch origin +refs/heads/*:refs/remotes/origin/*`

* Which means a remote `heads/test` will be local `remotes/origin/test`
* The plus sign means they'll be updated even if they are not fast-forward.

* System: `git config --system`
* User: `git config --global`
* Locally: `git config`

### Locally

This can be used for different projects.

```Bash
git config user.name "Your Name Here"
git config user.email your@email.com
```
This will append your `/path/to/project/.git/config` file:

```
# /path/to/project/.git/config
[user]
        name = Your Name Here
        email = your@email.com
```

### Globally

If you desire multiple git configurations, you can specify a global configuration and/or a local one.

`git config --global --list` will create a file in `/Users/username/.gitconfig`

```Bash
git config --global user.name "Your Name Here"
git config --global user.email your@email.com
git config --global color.ui true
```

A `.gitconfig` will be created at `~/` directory.

```
# ~/.gitconfig
[user]
        name = Your Name Here
        email = your@email.com
```

### System

`git config --system --list`

To make Sublime the default editor when you save. `w` tells to wait, `l1` means to start at *line 1*.
`git config --global core.editor "subl -wl1"`

## Architecture

* 2-Tree Architecture: *working directory* --(`commit`)--> *repo/HEAD*
* 3-Tree Architecture: *working directory* --(`git add`)--> *staging index* --(`git commit`)--> *repo/HEAD*

## HEAD

Points to the tip of the currently checked out branch from the *repository*

`cat ./.git/HEAD` => `ref: refs/heads/master`

`cat ./.git/refs/heads/master` => `527b3edrfad3a43ac9d93108218ad620ii03xc5w`

List all branch heads: `ls -la /git/refs/heads`

```
HomeChedminsMBP:notes mike$ ls -la .git/refs/heads/
total 16
drwxr-xr-x  4 mike  staff  136 Sep 16 09:57 .
drwxr-xr-x  5 mike  staff  170 Aug 17 19:34 ..
-rw-r--r--  1 mike  staff   41 Sep 16 09:57 master
-rw-r--r--  1 mike  staff   41 Sep 16 09:57 new_feature
```
Print out commit each branch head references: `cat .git/refs/heads/new_feature` => 1233210f1bc3e26311d825...

## Fun Commnads

* `git mv`
* `git rm`

## Git Log

Convenience Commands
`git log --until=2017-07-16`
`git log --author=Mike`

## Reseting

* Soft: `git reset --soft 855d9`
  - moves HEAD to SHA-1 855d9.
  - changes are stagged, but not committed
  - `cat .git/refs/heads/master` will be 855d9...
  - `git log` will have the lastest commit to be 855d9...
  - HOWEVER, the working directory and staging index has changes from the previous commit.
  - `git diff --staged` to see changes.
* Mixed (default): `git reset 855d9` or `git reset --mixed 855d9`
  - changes exist *but* are no longer stagged (i.e., not commited)
* Hard: `git reset --hard 855d9`
  - changes no longer exist and moves HEAD back to 855d9

### Undoing File From Current Commit

`$ git reset --mixed HEAD~ path/to/file`

* `$ git diff --staged` will show what changes have been added
* `$ git commit --amend` will add them to the repo/HEAD
* `$ git checkout -- path/to/file` with now checkout the changes in the working directory
* Happiness 

## Referencing Commits

* Parent Commit
  - `HEAD^`, `as8w3r^`, `master^`
  - `HEAD~1`, `HEAD~`
* Grandparent Commit
  - `HEAD^^`, `as8w3r^^`, `master^^`
  - `HEAD~2`
* Great-Grandparent Commit
  - `HEAD^^^`, `as8w3r^^^`, `master^^^`
  - `HEAD~3`

## Origin (rough draft)

`$ git remote -v`

```
origin	git@github.com:michaelwehrley/notes.git (fetch)
origin	git@github.com:michaelwehrley/notes.git (push)
```

`git fetch` is the same as `git fetch git@github.com:michaelwehrley/notes.git master`

When no _remote_ is specified, by default the _origin remote_ will be used, unless there’s an upstream branch configured for the current branch.

`$ git fetch origin/master` means fetch from repo named 'origin/master'.
origin is named origin not origin/master

## Setting Up/Updating Origin

Via SSH:
`git remote rm origin git@github.com:michaelwehrley/notes.git`
`git remote add origin git@github.com:michaelwehrley/notes.git`

## Reverting

When you want to completely undo the changes for a commit: `$ git revert`

## Cleaning

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	test.csv

`$ git clean -f`

## Updating a Branch

`$ git fetch`

`$ git rebase origin/master`

TODO: How does the rebased commit get merged/rebased into master? - Where go?

## Clean branches

`$ git remote prune origin`

## Deleting Tags

Tag named 0.1.0
`$ git tag -d 0.1.0`

`$ git push origin :refs/tags/0.1.0`

## Undo Last Commit

Leave existing changes staged: `$ git reset --soft HEAD~`.

To unstage the last commit's changes: `$ git reset HEAD~`.

## Amending a Commit

This is helpful when you just added a commit and you want to "fixup" the last commit:

`$ git comment --amend`

## Viewing Diff Files

`$ git diff --stat HEAD master`

## Rebasing

Rebase last 2 commits: `$ git rebase -i HEAD~2`

Rebase from the tracking branch of origin `$ git rebase origin`

Rebase from the branch master of origin `$ git rebase origin/master`

## Pushing

1. List tracked repositories (verbosely) `$ git remote -v`:

```Bash
git remote -v

# origin	git@github.com:michaelwehrley/notes.git (fetch)
# origin	git@github.com:michaelwehrley/notes.git (push)
# staging	git@heroku.com:mike-staging.git (fetch)
# staging	git@heroku.com:mike-staging.git (push)
```

1. Pushing to repo from any branch (i.e., head). This repo could be on a Heroku server for instance.

```Bash
git push origin HEAD
git push staging head:master

# or forcefully
git push -f origin HEAD
git push -f staging head:master
```

## Working on Someone Else's Branch

```Bash
$ git checkout remotes/origin/test # You are in a 'detached HEAD' state
```

`$ git checkout -b test`

To push the current branch and set the remote as upstream, use

`$ git push --set-upstream origin test`

## Checking Out Files

Git doesn't know if your checkout out is a **file** or branch unless you use `--`:

* Checkout branch "assets" `$ git checkout assets`
* Checkout directory "assets" `$ git checkout -- assets`

## Reopen Pull Request

This happens when you close a PR but then force push.

1. Get PR commit hash from PR.  (I am not yet sure the best way to do this except by visiting Github) *37b2wa2*
1. `git push -f origin 37b2wa2:mw-hot-fix` (i.e., [commit hash]:[branch])
1. Reopen PR
1. Switch back: `git checkout mw-hot-fix`
1. Push `git push -f origin head`

## History

* Version Control System (VCS) vs Source Code Management (SCM)

| Year | Name | Open/Closed Source | Notes |
| ---- | ---- | ------------------ | ----- |
| 1972 | Source Code Control System (SCCS) | closed source | but free with Unix |
| 1982 | Revision Control System (RCS) | open source | |
| 1986-1990 | Concurrent Versions System (CVS) | open source | |
| 2000 | Apache Subversion (SVN) | open source | |
| 2000 | BitKeeper SCM | closed source | proprietary; distributed version control; **community version** was free |
| 2005 | BitKeeper SCM | closed source | **Free** version was no longer free  |
| 2005 | Git | open source | Linus Torvalds |

