#!/usr/bin/env sh

echo -e "Variables set:\\n\
PUID=${PUID}\\n\
PGID=${PGID}\\n"

GOACCESS_LOG_ROOT=/var/log/web
GOACCESS_LOG_FILE="$GOACCESS_LOG_ROOT/access.log"
GOACCESS_WEB_ROOT=/var/www/goaccess

mkdir -p "$GOACCESS_LOG_ROOT"
mkdir -p "$GOACCESS_WEB_ROOT"

# create an empty access.log file so goaccess does not crash if not exist
[ -f "$GOACCESS_LOG_FILE" ] || touch "$GOACCESS_LOG_FILE"

/sbin/tini -s -- nginx -c /config/nginx.conf
/sbin/tini -s -- goaccess --log-file=$GOACCESS_LOG_FILE \
                          --log-format='%h %^ %e [%d:%t %^] "%r" %s %b "%R" "%u" %^ "%v" %^ %Lms' \
                          --date-format='%d/%b/%Y' \
                          --time-format='%H:%M:%S' \
                          --real-os \
                          --real-time-html \
                          --addr=127.0.0.1 \
                          --port=7890 \
                          --output=${GOACCESS_WEB_ROOT}/index.html
