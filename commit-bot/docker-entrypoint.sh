#!/bin/sh
set -e

if [ "$1" = 'crond' -a "$2" = '-f' ]; then
    : ${GIT_COMMIT_MSG:="commit from automatic world automatically"}
    : ${GIT_REMOTE:="origin"}
    : ${GIT_BRANCH:="master"}
    : ${GIT_COMMIT_INTERVAL:="* 2 * * *"}
    : ${GIT_COMMIT_USER:="commit-bot"}
    : ${GIT_COMMIT_EMAIL:="commit-bot@rekcod.org"}

    # Its content is generated dynamically according:
    #     GIT_COMMIT_MSG
    #     GIT_REMOTE
    #     GIT_BRANCH
    COMMIT_CMD="/usr/local/bin/commit-bot"

    # Step 1
    echo 'Generating commit-bot main program ...'
    cat > ${COMMIT_CMD} <<EOF
#!/bin/sh

cd /repo

git checkout ${GIT_BRANCH}

git add .
git commit -am "${GIT_COMMIT_MSG}"
git push ${GIT_REMOTE} ${GIT_BRANCH}
EOF
    chmod +x ${COMMIT_CMD}

    # Step 2
    echo 'Generating git configuration ...'
    git config --system user.name ${GIT_COMMIT_USER}
    git config --system user.email ${GIT_COMMIT_EMAIL}

    # Step 3
    echo 'Generating cron task ...'
    echo "${GIT_COMMIT_INTERVAL} ${COMMIT_CMD}" > /etc/crontabs/root
    echo 'commit-bot is runnig ... Congratulations !'
fi

exec "$@"
