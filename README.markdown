# UFO
[![Build Status](https://travis-ci.org/ta2gch/UFO.svg?branch=master)](https://travis-ci.org/ta2gch/UFO)
[![Coverage Status](https://coveralls.io/repos/ta2gch/UFO/badge.svg?branch=master)](https://coveralls.io/r/ta2gch/UFO)

This project was DEPRECATED. You can use `ros install <Github Repo>/<Project>`.

Thanks for your stars. :smile:

## Description
**UFO** is a Roswell script manager.

you can install following utilities via **UFO**.
- [chls.ros](https://gist.github.com/fukamachi/3510ea1609c1b52830c2) -- opening HyperSpec page describing a given symbol in the default browser.
- [lem.ros](https://gist.github.com/peccu/b1db8bf3f26d0b7c31d1) --  launch lem from shell.
- etc ... 

## Features
### Easy to Install and Execute.
You can install Roswell Script on internet,
as easy as Quicklisp.
```
$ ufo install https://example.com/test.ros # Only this!
```

### Schemes Extension
UFO has mercurial style _schemes extension_.

`gist://example.com/sample.com` , `file:///path/to/roswell/script/test.ros`,etc ...

Of course, you can use `http://` and `https://`.

### Addons
UFO have a self enhancement system, _addons_.

If you want to make _addons_ of UFO,
UFO requires to make with Roswell Script.

UFO has some preinstall Addons.

#### Manage CommonLisp Project on Github
schemes is `gh://`.
and you can use `install` and `update` ,`remove` sub commands.

```
$ ufo install gh://ta2gch/cl-pov
$ ufo update gh://ta2gch/cl-pov
$ ufo remove cl-pov
```

#### Generate Roswell Script
subcommand is `init`.

- `ufo init <file-name>` generate temprate of Roswell Script

## Usage

UFO has `apt` style sub commands,

`install <package-url>` and `remove <package-name>` ,`update <package-url>`
### Install

```
$ ufo install <package-url>
$ ufo install https://example.com/sample.ros
$ ufo install gist://ta2gch/repl.ros
$ ufo install file://~/hello.ros
```
### Uninstall

```
$ ufo remove <package-name>
$ ufo remove repl
$ ufo remove hello
```

### Update
```
$ ufo update <package-url>
$ ufo update gist://ta2gch/repl.ros
$ ufo update file://~/hello.ros
```

## Installation

```shell
$ cd ~/common-lisp
$ git clone git://github.com/ta2gch/UFO
$ cd UFO && ros -l ufo.asd install ufo
```
*ensure that `~/.roswell/bin` is in the system's search path.*

## Requirements

* [Roswell](https://github.com/snmsts/roswell)

## Why 'UFO'
LISP Aliens fly in a UFO. :smile:

## Author

* Masaya TANIGUCHI (ta2gch@gmail.com)

## License

GPLv3

## Copyright

Copyright (c) 2015 Masaya TANIGUCHI (ta2gch@gmail.com)
