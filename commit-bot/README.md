# commit-bot

A commit bot for Git repo.

## Status

Now, it can work.

## Quick Start

### Required

You must volume these things:

- `<your_repo>:/repo`
- `<your_ssh_private_key_for_git_push>:/commit-bot/gitpush_key`

### Optional

Other avialable ENV variables that you can set:

- `GIT_COMMIT_MSG` (default: `commit from automatic world automatically`)
- `GIT_REMOTE` (default: `origin`)
- `GIT_BRANCH` (default: `master`)
- `GIT_COMMIT_INTERVAL` (default: `* 2 * * *`)
- `GIT_COMMIT_USER` (default: `commit-bot`)
- `GIT_COMMIT_EMAIL` (default: `commit-bot@rekcod.org`)

Maybe, you don't how to write `GIT_COMMIT_INTERNAL`. Actually, it just
a part of standard UNIX crontab file. Here are some examples to help you
recall that.

```
# min   hour    day     month   weekday
# Per 15min
*/15    *       *       *       *
# Hourly
0       *       *       *       *
# Daily
0       2       *       *       *
# Weekly
0       3       *       *       6
# Monthly
0       5       1       *       *
```

### An example

Now I want to commit a repo per 15 minutes automatically:

```
docker run -d -v $(pwd)/example_private_key:/commit-bot/gitpush_key \
              -v $(pwd)/example-repo:/repo \
              -e GIT_COMMIT_INTERVAL='*/15 * * * *' \
              commit-bot
```

## Note

- You can download the prebuild docker image from Docker Hub with repo name: `commit-bot`.
- If you want to run it more automatic, you should use [docker/compose](https://github.com/docker/compose).
