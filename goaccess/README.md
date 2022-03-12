# goaccess

> Forked from [GregYankovoy/docker-goaccess](https://github.com/GregYankovoy/docker-goaccess).

GoAccess with GeoIP support.

It reverse proxies the GoAccess HTML files and WebSocket at same port through Nginx.

# Usage

```sh
docker run \
  --name goaccess \
  -p 5000:80 \
  -v ./weblog:/var/log/web \
  -d goaccess
```

## Variables

- PUID
  - User Id of user to run Nginx & GoAccess
- PGID
  - User Group to run Nginx & GoAccess

## Reverse Proxy Examples

### Nginx

```
location ^~ /goaccess {
    resolver 127.0.0.11 valid=30s;
    set $upstream_goaccess goaccess;
    proxy_pass http://$upstream_goaccess:7889/;

    proxy_connect_timeout 1d;
    proxy_send_timeout 1d;
    proxy_read_timeout 1d;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "Upgrade";
}
```

## LICENSE

MIT
