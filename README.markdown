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
$ ufo remove clhs

```

### Update

```shell
$ ufo update gist://fukamachi/clhs.ros
```

## Installation

```shell
$ cd ~/common-lisp
$ git clone git://github.com/ta2gch/UFO
$ cd UFO && ros -l ufo.asd install ufo
```
*ensure that `~/.roswell/bin` is in the system's search path.*

to make static build `ufo`, 
```
$ git clone git://github.com/ta2gch/UFO
$ cd UFO && ros -L sbcl-bin -l bootstrap.lisp
```

## Requirements

* [dexador (v0.9.7 or later)](https://github.com/fukamachi/dexador)
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
