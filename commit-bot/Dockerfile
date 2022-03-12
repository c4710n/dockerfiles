FROM alpine:3.2

RUN apk add --update git openssh-client && rm -rf /var/cache/apk/*

## COMMIT-BOT MAIN DIR
RUN mkdir /commit-bot

## SSH CONFIG
ENV SSH_CONF_DIR='/root/.ssh'
RUN mkdir ${SSH_CONF_DIR} && chmod 0700 ${SSH_CONF_DIR}
# this line ensure ssh use /commit-bot/gitpush_key as private key
ADD sshconfig ${SSH_CONF_DIR}/config

## REPO LOCATION
VOLUME /repo

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["crond", "-f"]
