FROM nginx:1.11.6-alpine

# This tool converts env vars into json to be injected into the config
# https://github.com/assemblyline/json_env
# https://s3.amazonaws.com/se-com-docs/bins/json_env
ADD bin/json_env /usr/local/bin

ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD conf/app.conf /etc/nginx/conf.d/default.conf
ADD conf/gzip.conf /etc/nginx/conf.d/gzip.conf

ENV CONFIG_FILE /app/config.js

RUN mkdir /app
WORKDIR /app
ADD index.html /app

ADD docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
