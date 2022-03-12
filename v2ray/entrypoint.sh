#!/bin/sh
set -e

CONFIG_FILE=/etc/v2ray/config.json

trap "exit" 2 # SIGINT

if [ -z "$V2RAY_UUID" ]; then
    echo "Environment variable - V2RAY_UUID is required."
    exit 1
fi

if [ -z "$WS_PATH" ]; then
    echo "Environment variable - WS_PATH is required."
    exit 1
fi

cat > "${CONFIG_FILE}" <<EOF
{
  "log": {
    "access": "/dev/stdout",
    "error": "/dev/stderr",
    "loglevel": "error"
  },
  "inbounds": [
    {
      "port": 8489,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${V2RAY_UUID}",
            "alterId": 64
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "${WS_PATH}"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
EOF

if [ $# -eq 0 ]; then
    v2ray -test -config "${CONFIG_FILE}"
    exec v2ray -config "${CONFIG_FILE}"
fi

exec "$@"
