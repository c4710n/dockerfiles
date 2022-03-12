# docker-nginx-spa

> Forked from [SocialEngine/docker-nginx-spa](https://github.com/SocialEngine/docker-nginx-spa)

Nginx image for Single Page App (pure frontend javascript):

- support [PushState](https://developer.mozilla.org/en-US/docs/Web/API/History_API). Every request is routed to `/app/index.html`. Useful for the clean urls (no `!#`)
- support Env-based Config

## Usage

As said before, this image is built for `index.html` file being in the `/app` directory.

At a minimum, use it like this:

```
FROM docolomo/nginx-spa

COPY build/ /app
COPY index.html /app/index.html
```

Then you can build & run your app.

```
$ docker build -t your-app-image .
$ docker run -e API_URL=http://api.example.com -e CONFIG_VARS=API_URL -p 8000:80 your-app-image
```

You can then go to http://docker-ip:8000/ to see it in action.

## Talk about Env-based Config

Env-based Config provides a way to config your app in runtime.

This is very useful in case your API is on a different domain, or if you want to configure central error logging.

There are three related Envs:

- `CONFIG_OBJ`: define which obj is used for storing configurations. Default: `window.__env`.
- `CONFIG_VARS`: define which environment variables is stored into `CONFIG_OBJ`. Default is empty.
- `CONFIG_FILE`: define which file is used. Default: `/app/config.js`.

```
$ docker run -e API_URL='https://api.example.com' -e CONFIG_VARS=API_URL -e CONFIG_OBJ=window.ENV -p 8000:80 docolomo/nginx-spa
> Writing /app/config.js with 'window.ENV = {"API_URL":"https://api.example.com"}'
```

# LICENSE

MIT
