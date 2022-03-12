# ImageMagick

Build static ImageMagick.

> Static binary can be copied to anywhere without worrying about its dependencies.

## Usage

Binary `magick` is located at `$WORKDIR/bin/magick`:

1. copy it to valid `$PATH`
2. link subcommands which will be used

For example:

```sh
$ cp $WORK/bin/magick /usr/local/bin

# link subcommand convert and identify
$ ln -rs /usr/local/bin/{magick,convert}
$ ln -rs /usr/local/bin/{magick,identify}
```

## License

MIT
