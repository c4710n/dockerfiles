#!/usr/bin/env sh
set -e

trap "exit" 2 # SIGINT

CONFIG_FILE=/etc/trojan-server.json

if [ "$1" = 'start' ]; then
    : ${TROJAN_SSL_CERT_PATH:=""}
    : ${TROJAN_SSL_KEY_PATH:=""}
    : ${TROJAN_REMOTE_ADDR:="127.0.0.1"}
    : ${TROJAN_REMOTE_PORT:="80"}
    : ${TROJAN_PASSWORD:="trojan-gfw"}


    if [ -z "$TROJAN_SSL_CERT_PATH" ]; then
        echo "Environment variable - TROJAN_SSL_CERT_PATH is required."
        exit 1
    fi

    if [ -z "$TROJAN_SSL_KEY_PATH" ]; then
        echo "Environment variable - TROJAN_SSL_KEY_PATH is required."
        exit 1
    fi

    cat > "${CONFIG_FILE}" <<EOF
{
    "run_type": "server",
    "local_addr": "0.0.0.0",
    "local_port": 443,
    "remote_addr": "${TROJAN_REMOTE_ADDR}",
    "remote_port": ${TROJAN_REMOTE_PORT},
    "password": [
        "${TROJAN_PASSWORD}"
    ],
    "log_level": 1,
    "ssl": {
        "cert": "${TROJAN_SSL_CERT_PATH}",
        "key": "${TROJAN_SSL_KEY_PATH}",
        "key_password": "",
        "cipher": "ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384",
        "cipher_tls13": "TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384",
        "prefer_server_cipher": true,
        "alpn": [
            "http/1.1"
        ],
        "reuse_session": true,
        "session_ticket": false,
        "session_timeout": 600,
        "plain_http_response": "",
        "curves": "",
        "dhparam": ""
    },
    "tcp": {
        "prefer_ipv4": false,
        "no_delay": true,
        "keep_alive": true,
        "reuse_port": false,
        "fast_open": false,
        "fast_open_qlen": 20
    },
    "mysql": {
        "enabled": false
    }
}
EOF

    trojan --test "${CONFIG_FILE}"
    exec trojan --config "${CONFIG_FILE}"
fi

exec "$@"
