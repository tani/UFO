# UFO
[![Build Status](https://travis-ci.org/ta2gch/UFO.svg?branch=master)](https://travis-ci.org/ta2gch/UFO)
[![Coverage Status](https://coveralls.io/repos/ta2gch/UFO/badge.svg?branch=master)](https://coveralls.io/r/ta2gch/UFO)

Roswell script installer

## Usage
### Install *.ros

```shell
$ ufo install gist://fukamachi/clhs.ros
$ ufo install http://example.com/sample/test.ros
$ ufo install https://example.com/sample/test.ros
$ ufo install file:///home/ta2gch/Downloads/hello.ros
```

### Uninstall *.ros

```shell
$ ufo remove clhs

```

### Update

```shell
$ ufo update gist://fukamachi/clhs.ros
```

### Install new addon

```shell
$ ufo addon-install <addon-url>
$ ufo addon-install file://~/UFO/addon/extension/build.ros
```

### Remove addon

```shell
$ ufo addon-remove <addon-name>
$ ufo addon-remove build
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

## TODO
* Quicklisp
* `ros -l foo.asd install foo`

## Author

* Masaya TANIGUCHI (ta2gch@gmail.com)

## License

GPLv3

## Copyright

Copyright (c) 2015 Masaya TANIGUCHI (ta2gch@gmail.com)
