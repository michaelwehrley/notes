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

## .git/config

```
[remote "origin"]
  url = git@github.com:michaelwehrley/notes.git
  fetch = +refs/heads/*:refs/remotes/origin/*
```

Then you can run `$ git fetch origin` and it will run:
`$ git fetch origin +refs/heads/*:refs/remotes/origin/*`

* Which means a remote `heads/test` will be local `remotes/origin/test`
* The plus sign means they'll be updated even if they are not fast-forward.

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

## Reopen Pull Request

This happens when you close a PR but then force push.

1. Get PR commit hash from PR.  (I am not yet sure the best way to do this except by visiting Github) *37b2wa2*
1. `git push -f origin 37b2wa2:mw-hot-fix` (i.e., [commit hash]:[branch])
1. Reopen PR
1. Switch back: `git checkout mw-hot-fix`
1. Push `git push -f origin head`
