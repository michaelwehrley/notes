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

## Cleaning

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	test.csv

`$ git clean -f`

## Updating a Branch

`$ git fetch`

`$ git rebase origin/master`

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

## Pushing to Branch

`$ git push origin HEAD`

to force...

`$ git push origin HEAD -f`

## Working on Someone Else's Branch

```Bash
$ git checkout remotes/origin/test # You are in a 'detached HEAD' state
```

`$ git checkout -b test`

To push the current branch and set the remote as upstream, use

`$ git push --set-upstream origin test`
