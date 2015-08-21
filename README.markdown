# UFO
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
$ ufo uninstall clhs

```

### Update

```shell
$ ufo install gist://fukamachi/clhs.ros
$ ufo install https://raw.githubusercontent.com/ta2gch/UFO/master/ufo.ros
```
## Installation

```
$ cd ~/.roswell/bin
$ wget https://raw.githubusercontent.com/ta2gch/UFO/master/ufo.ros
$ ros build ufo.ros && rm ufo.ros
```
## Requirements

* [dexador (v0.9.7 or later)](https://github.com/fukamachi/dexador)
* [Roswell](https://github.com/snmsts/roswell)

## Author

* Masaya TANIGUCHI (ta2gch@gmail.com)

## Why 'UFO'
LISP Aliens fly in a UFO. :smile:

## License

GPLv3

## Copyright

Copyright (c) 2015 Masaya TANIGUCHI (ta2gch@gmail.com)
