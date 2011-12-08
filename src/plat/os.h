/**
Copyright (c) 2010, 2011, Gavin Beatty <gavinbeatty@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

  Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

  Redistributions in binary form must reproduce the above copyright notice, this
  list of conditions and the following disclaimer in the documentation and/or
  other materials provided with the distribution.

  Neither the name of Gavin Beatty nor the names of its contributors may be
  used to endorse or promote products derived from this software without specific
  prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
#ifndef PLAT_OS_H
#define PLAT_OS_H

#include <plat/config.h>

#if defined(__APPLE__) && defined(__GNUC__)
#   define PLAT_OS_DARWIN 1
#   define PLAT_OS_MACOSX 1
#   if defined(TARGET_OS_IPHONE)
#       define PLAT_OS_IPHONE 1
#   elif defined(TARGET_IPHONE_SIMULATOR)
#       define PLAT_OS_IPHONE 1
#       define PLAT_OS_IPHONE_SIM 1
#   endif
#   if PLAT_OS_IPHONE
#       if 0 /* XXX find out how to do this */
#       define PLAT_OS_IPHONE_MIN_VERSION_MAJOR \
    ((__ENVIRONMENT_IPHONE_OS_VERSION_MIN_REQUIRED__) / XXX)
#       define PLAT_OS_IPHONE_MIN_VERSION_MINOR \
    ((__ENVIRONMENT_IPHONE_OS_VERSION_MIN_REQUIRED__) / XXX)
#       define PLAT_OS_IPHONE_MIN_VERSION_PATCH \
    ((__ENVIRONMENT_IPHONE_OS_VERSION_MIN_REQUIRED__) / XXX)
#       endif
#   endif
#   ifdef __LP64__
#       define PLAT_OS_64 1
#   endif
/* TODO: do the following actually exist??  - they seem to but should be tested */
#elif defined(__MSYS__) || defined(__MINGW__) || defined(__MINGW32__)
#   define PLAT_OS_MSYS 1
#elif defined(__CYGWIN__)
#   define PLAT_OS_CYGWIN 1
#elif defined(MSDOS) || defined(_MSDOS)
#   define PLAT_OS_MSDOS 1
#elif defined(WIN64) || defined(_WIN64) || defined(__WIN64__)
#   define PLAT_OS_WIN 1
#   define PLAT_OS_64 1
#elif defined(WIN32) || defined(_WIN32) || defined(__WIN32__) || defined(__NT__)
#   define PLAT_OS_WIN 1
#elif defined(__sun) || defined(sun)
#   define PLAT_OS_SOLARIS 1
#   define PLAT_OS_UNIX 1
#elif defined(__linux__) || defined(__linux)
#   define PLAT_OS_LINUX 1
#   define PLAT_OS_UNIX 1
#elif defined(__FreeBSD__)
#   define PLAT_OS_FREEBSD 1
#   define PLAT_OS_UNIX 1
#elif defined(__NetBSD__)
#   define PLAT_OS_NETBSD 1
#   define PLAT_OS_UNIX 1
#elif defined(__OpenBSD__)
#   define PLAT_OS_OPENBSD 1
#   define PLAT_OS_UNIX 1
#elif defined(_AIX)
#   define PLAT_OS_AIX 1
#   define PLAT_OS_UNIX 1
#elif defined(__GNU__)
#   define PLAT_OS_HURD 1
#   define PLAT_OS_UNIX 1
#elif defined(__native_client__)
#   define PLAT_OS_NACL 1
#else
#   error "plat: Unknown platform!"
#endif

#if !PLAT_OS_64
#   define PLAT_OS_32 1
#endif

#endif /* PLAT_OS_H */

