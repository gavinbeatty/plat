plat
====
Gavin Beatty <gavinbeatty@gmail.com>

plat: Platform/compiler/endian-ness detection headers for C.

License
-------
Copyright and license details are found in the included LICENSE.txt.

Requirements
------------
GNU Make (tested with 3.81)

Install
-------
To configure just run `make`.

Default install prefix is `/usr/local`. Examples for installing:

* `make install PREFIX="$HOME"/.local`
* `fakeroot make install PREFIX="/usr" DESTROOT=./plat-bin`

