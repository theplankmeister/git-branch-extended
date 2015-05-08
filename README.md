# Prettified Git Branches

[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](LICENSE.txt)

Prettify the display of your git branches. Also includes the last commit date/time and the branch's description.

If, like me, you have many branches, some of which become long-lived, you may find yourself in a situation where you need to annotate branches with a short description so you know what the branch is for. The problem is, `git branch --list` does not show anything other than the branch's name. 

Add a description to a branch using `git branch --edit-description`

If you add the following code to your `.bashrc`, this functionality will replace the existing default `git branch` functionality:

```bash
git() { if [[ $# -eq 1 && $1 == "branch" ]]; then command ~/br.sh; else command git "$@"; fi; }
```

Issuing the `git branch` command will subsequently produce output similar to the following:

```
  Branch name                                   Last commit ▾       Description

  staging                                     | 2015-05-07 13:16  | Only merge upstream!
  devel                                       | 2015-05-07 13:15  | Here be dragons
  GCD-238_FixTheThingThatDoesntDoTheThing     | 2015-05-06 04:29  | The thing that doesn't do what it should needs some attention
  GCD-318_CriticalBugfixForDivInWrongPlace    | 2015-05-05 11:01  | We need to move that div half a pixel to the left
* GCD-329_BrandNewHugeEnormousFeature         | 2015-05-04 21:45  | Big-Ass Huge Feature™
  master                                      | 2015-03-12 13:03  | Only 100% bug-free goodness
```

This project is based on/inspired by [this GitHub project](https://github.com/bahmutov/git-branches) which I found through [this post](http://bahmutov.calepin.co/git-branches-with-descriptions-really.html).
