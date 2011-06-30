#ifndef PLAT_CC_H_
#define PLAT_CC_H_

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
#   if _MSC_VER >= 1600
#       define PLAT_CC_MSVC_2010 1
#       define PLAT_CC_MSVC_V10 1
#   elif _MSC_VER >= 1500
#       define PLAT_CC_MSVC_2008
#       define PLAT_CC_MSVC_V9 1
#   elif _MSC_VER >= 1400
#       define PLAT_CC_MSVC_2005 1
#       define PLAT_CC_MSVC_V8 1
#   elif _MSC_VER >= 1310
#       define PLAT_CC_MSVC_2003 1
#       define PLAT_CC_MSVC_V7_1 1
#   elif _MSC_VER >= 1300
#       define PLAT_CC_MSVC_2002 1
#       define PLAT_CC_MSVC_V7 1
#   elif _MSC_VER >= 1200
#       define PLAT_CC_MSVC_V6 1
#   endif /* #if _MSC_VER >= 1600 */
#   if _MSC_VER >= 1300
#       define PLAT_CC_MSVC_NET 1
#   endif
#   if defined(_MSC_FULL_VER)
#       define PLAT_CC_MSVC_VER _MSC_FULL_VER
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
#   if defined(__clang__)
#     define PLAT_CC_CLANG 1
#     define PLAT_CC_CLANG_VER_MAJOR __clang_major__
#     define PLAT_CC_CLANG_VER_MINOR __clang_minor__
#     define PLAT_CC_CLANG_VER_PATCH __clang_patchlevel__
#     define PLAT_CC_CLANG_VER ((__clang_major__ << 16) | (__clang_minor__ << 8) | (__clang_patchlevel__))
#     define PLAT_CC_CLANG_MAKE_VER(x, y, z) (((x) << 16) | ((y) << 8) | (z))
#     define PLAT_CC_CLANG_VER_STR __clang_version__
#   endif
#elif defined(__GCCXML__)
/* XXX test - __GNUC__ is probably defined too, so this'll fail */
#   define PLAT_CC_GCCXML 1
#elif defined(__llvm__)
#   define PLAT_CC_LLVM 1
#elif defined(__DOXYGEN__)
#   define PLAT_CC_DOXYGEN 1
#else
#   error "plat: Unknown compiler!"
#endif

#ifdef __STDC__
#  ifdef __STDC_VERSION__
#    if __STDC_VERSION__ >= 199901L
#      define PLAT_CC_ATLEAST_C99 1
#      define PLAT_CC_ATLEAST_C89_AMEND1 1
#      define PLAT_CC_ATLEAST_C89 1
#      if __STDC_VERSION__ == 199901L
#        define PLAT_CC_C99 1
#      endif
#    elif __STDC_VERSION__ >= 199409L
#      define PLAT_CC_ATLEAST_C89_AMEND1 1
#      define PLAT_CC_ATLEAST_C89 1
#      if __STDC_VERSION__ == 199409L
#        define PLAT_CC_C89_AMEND1 1
#      endif
#    else
#      define PLAT_CC_C89 1
#      define PLAT_CC_ATLEAST_C89 1
#    endif
#  endif
#else
#  define PLAT_CC_C_PRE89 1
#endif

#ifdef __cplusplus
#  define PLAT_CC_CXX
#  if __cplusplus >= 199711L
#    define PLAT_CC_ATLEAST_CXX_0X 1
#    define PLAT_CC_ATLEAST_CXX_03 1
#    define PLAT_CC_ATLEAST_CXX_97 1
#    if __cplusplus == 199711L
#      define PLAT_CC_CXX_03 1
#    endif
#  else
#    define PLAT_CC_CXX_NOT_ISO 1
#  endif
#endif

#ifdef __OBJC__
#  define PLAT_CC_OBJC 1
#endif

#define PLAT_CC_GNU (0plat_cc_gnu_does_not_exist_anymore__use_plat_cc_gcc)

#endif
