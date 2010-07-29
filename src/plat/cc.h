#ifndef PLAT_CC_H
#define PLAT_CC_H

#include <plat/config.h>


/* compilers */
#if defined(__INSURE__)
/* XXX test */
#   warning "plat: PLAT_CC_INSURE is not mutually exclusive like all other PLAT_CC_FOO variables. TEST."
#   define PLAT_CC_INSURE 1
#endif

#if defined(__MWERKS__)
#   define PLAT_CC_MWERKS 1
#elif defined(_MSC_VER)
#   define PLAT_CC_MSVC 1
#   if _MSC_VER >= 1400
#       define PLAT_CC_MSVC_2005 1
#   elif _MSC_VER >= 1310
#       define PLAT_CC_MSVC_2003 1
#   elif _MSC_VER > 1300
#       define PLAT_CC_MSVC_2002 1
#   endif /* #if _MSC_VER >= 1400 */
#   if _MSC_VER >= 1300
#       define PLAT_CC_MSVC_NET 1
#   endif
#elif defined(__BORLANDC__)
#   define PLAT_CC_BOR 1
#elif defined(__GNUC__)
#   define PLAT_CC_GCC 1
#   define PLAT_CC_GCC_VER_MAJOR __GNUC__
#   define PLAT_CC_GCC_VER_MINOR __GNUC_MINOR__
#   define PLAT_CC_GCC_VER_PATCH __GNUC_PATCHLEVEL__
#   define PLAT_CC_GCC_VER ((__GNUC__ << 16) | (__GNUC_MINOR__ << 8) | (__GNUC_PATCHLEVEL__))
#   define PLAT_CC_GCC_MAKE_VER(x, y, z) (((x) << 16) | ((y) << 8) | (z))
#elif defined(__GCCXML__)
#   define PLAT_CC_GCCXML 1
#elif defined(__DOXYGEN__)
#   define PLAT_CC_DOXYGEN 1
#else
#   error "plat: Unknown compiler!"
#endif

#define PLAT_C 1
/* TODO add support for Obj-C++ */
#ifdef __cplusplus
#   define PLAT_CXX 1
#   undef PLAT_C
#   if __cplusplus > 199711L
#       define PLAT_CXX_0X 1
#   elif __cplusplus == 199711L
#       define PLAT_CXX_03 1
#   else
#       define PLAT_CXX_NOT_ISO 1
#   endif
#endif
#ifdef __OBJC__
#   define PLAT_OBJC 1
/* XXX undef C? */
#   undef PLAT_C
#endif

#define PLAT_CC_GNU (0plat_cc_gnu_does_not_exist_anymore__use_plat_cc_gcc)

#endif /* PLAT_CC_H */

