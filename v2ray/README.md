# v2ray

A simple v2ray image using WebSocket.

## Environments

| Environment  | Default value |
| ------------ | ------------- |
| `V2RAY_UUID` |               |
| `WS_PATH`    |               |

## Usage

Run the server behind a valid Web server, such as Nginx:

```sh
docker run \
   -d \
   --name v2ray \
   -p 8489:8489/tcp \
   -e V2RAY_UUID=<uuid> \
   -e WS_PATH=/ray \
   2players/v2ray
```

A possible configuration for client:

```json
{
  "log": {
    "access": "/dev/stdout",
    "error": "/dev/stderr",
    "loglevel": "error"
  },
  "inbounds": [
    {
      "protocol": "socks",
      "listen": "127.0.0.1",
      "port": 1080,
      "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls"]
      },
      "settings": {
        "auth": "noauth",
        "udp": false
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "vmess",
      "settings": {
        "vnext": [
          {
            "address": "<domain>",
            "port": 443,
            "users": [
              {
                "id": "<uuid>",
                "alterId": 64
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "wsSettings": {
          "path": "/ray" # notice here
        }
      }
    }
  ]
}
```

Now, a Socks proxy is exposed at `127.0.0.1:1080` in your local network.

## License

MIT
