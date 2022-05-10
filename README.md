# npmlock.sh

Replaces dependencies versions ranges syntax in `package.json` with the
exact versions found in `package-lock.json`.

## install

[bpkg](https://github.com/bpkg/bpkg)

```sh
$ bpkg install -g sergeylukin/npmlock.sh
```

source:

```sh
$ git clone https://github.com/sergeylukin/npmlock.sh.git
$ make install -C npmlock/
```

## usage

```
usage: npmlock [-hvd] <package>
```

## example

```sh
$ npmlock foo -d
Dry run (not updating package.json)
npmlock: found 1 package(s)

  foo (specified: ^1.2.0, installed: 1.2.9)
```

## license

MIT
