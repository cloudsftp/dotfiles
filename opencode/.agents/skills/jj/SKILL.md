---
name: jj
description: Jujutsu aka jj - a git compatible version control system
---

# Jujutsu

## Important Commands

### Status

```
jj log
jj status
jj diff
```

### Committing

In jj it works differently from git.
You have some different options, but the basic flow is the following:

You can checkout a commit with `jj edit -r <id>`.
You can change the description of a commit with `jj describe -r <id> -m <message>`.
Create a new commit with `jj new -r <id>` ontop of the commit with the id `<id>`.

### Bookmarks

Jujutsu is branchless and uses bookmarks instead.
You don't have to worry about either.

## Your Job

Your job is to pack your work into large, but still logically seperate commits.
Each commit should start with the message "slop: ".
