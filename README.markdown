plat
====
Gavin Beatty <gavinbeatty@gmail.com>

plat: Platform/compiler/endian-ness detection headers for C.

License
-------
Copyright and license details are found in the included LICENSE.txt.

Requirements
------------
GNU make (tested with 3.81)

Install
-------
To generate config.h and plat.pc, run `make configure`. The prefix in plat.pc
is determinted at this time, so do `make conf PREFIX=/your/path`.

Default install prefix is `/usr/local`. Examples for installing:

* `sudo make install`
* `make install PREFIX="${HOME}/.local"`
* `fakeroot make install PREFIX="/usr" DESTROOT=./plat-bin`

Only the headers are installed. You must install plat.pc yourself.
