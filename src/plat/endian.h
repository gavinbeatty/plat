#ifndef PLAT_ENDIAN_H
#define PLAT_ENDIAN_H

/* XXX test for this in cmake */
/* XXX what do other platforms/compilers use? */
#if __LITTLE_ENDIAN__
#   define PLAT_LE
#elif __BIG_ENDIAN__
#   define PLAT_BE
#endif

#endif /* PLAT_ENDIAN_H */

