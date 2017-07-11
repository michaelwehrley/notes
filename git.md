# Git

## Cleaning

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	Arm 1 Intervention only.csv
	Arm 2 Intervention + Facilitator Contact (FC).csv
	Arm 3 Intervention + Activity Feed (Online Discussion Board).csv
	Arm 4 Intervention + Incentives (Gamification).csv
	Arm 5 Intervention + Facilitator Contact (FC) + Activity Feed (Online Discussion Board).csv
	Arm 6 Intervention + Facilitator Contact (FC) + Incentives (Gamification).csv
	Arm 7 Intervention + Activity Feed (Online Discussion Board) Incentives (Gamification).csv
	Arm 8 Intervention + Facilitator Contact (FC) + Activity Feed (Online Discussion Board) + Incentives (Gamification).csv
	Arm 9 Emotion Reporting only (daily DES surveys over 5 weeks).csv
	Default.csv
	slides.csv
	tools_and_modules.csv

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

*refs* is for instance 'git@github.com:michaelwehrley/notes.git'

## Undo Last Commit

Leave existing changes staged: `$ git reset --soft HEAD~`.

Unstage changes: `$ git reset HEAD~`.

## Amending a Commit

`$ git comment --amend`

## Rebasing

Rebase last 2 commits: `$ git rebase -i HEAD~2`

## Pushing to Branch

`$ git push origin HEAD -f`

## Working on Someone Else's Branch

`$ git checkout remotes/origin/test` # You are in a 'detached HEAD' state
`$ git checkout -b test`

To push the current branch and set the remote as upstream, use

`$ git push --set-upstream origin test`
