#ifndef __SECUREC_H__
#define __SECUREC_H__

#include <stdio.h>
#include <string.h>

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif /* End of #ifdef __cplusplus */

#define EOK (0)

#define snprintf_s(str, destMax, size, fmt, args...) snprintf(str, destMax, fmt, ##args)

inline int memset_s(void* dest, size_t destMax, int c, size_t count)
{
    memset(dest, c, count);
    return EOK;
}

inline int memcpy_s(void* dest, size_t destMax, const void* src, size_t count)
{
    memcpy(dest, src, count);
    return EOK;
}

inline int strncpy_s(char* strDest, size_t destMax, const char* strSrc, size_t count)
{
    strncpy(strDest, strSrc, count);
    return EOK;
}

inline int memmove_s(void* dest, size_t destMax, const void* src, size_t count)
{
    memmove(dest, src, count);
    return EOK;
}

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* End of #ifdef __cplusplus */

#endif /* End of __SECUREC_H__ */