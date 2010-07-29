plat
====
Gavin Beatty <gavinbeatty@gmail.com>

plat: Platform/compiler/endian-ness detection headers for C.

License
-------
Copyright (c) 2010 Gavin Beatty <gavinbeatty@gmail.com>.
All rights reserved.

New BSD License. Found in LICENSE.txt.

Install
-------
Configure:
    mkdir build
    cd build
    cmake ../

Select your own prefix:
    cmake -DCMAKE_INSTALL_PREFIX=~/.local/usr ../

Build:
    make

Default prefix is `/usr/local`:
    sudo make install

