
#ifndef _HI_COMMON_H_
#define _HI_COMMON_H_

#ifdef __cplusplus
extern "C"{
#endif	// __cplusplus

#include <stdio.h>
#include <unistd.h>
#include <string.h>

#ifndef ExecFunc
#define ExecFunc(_func_, _ret_) \
    do{ \
        MI_S32 s32Ret = MI_SUCCESS; \
        s32Ret = _func_; \
        if (s32Ret != _ret_) \
        { \
            printf("[%s %d]exec function failed, error:%x\n", __func__, __LINE__, s32Ret); \
            return s32Ret; \
        } \
        else \
        { \
            printf("[%s %d]exec function pass\n", __func__, __LINE__); \
        } \
    } while(0)
#endif

#ifndef STCHECKRESULT
#define STCHECKRESULT(_func_)\
    do{ \
        MI_S32 s32Ret = MI_SUCCESS; \
        s32Ret = _func_; \
        if (s32Ret != MI_SUCCESS)\
        { \
            printf("[%s %d]exec function failed, error:%x\n", __func__, __LINE__, s32Ret); \
            return s32Ret; \
        } \
        else \
        { \
            printf("(%s %d)exec function pass\n", __FUNCTION__,__LINE__); \
        } \
    } while(0)
#endif

#define STDBG_ENTER() \
    printf("\n"); \
    printf("[IN] [%s:%s:%d] \n", __FILE__, __FUNCTION__, __LINE__); \
    printf("\n"); \

#define STDBG_LEAVE() \
    printf("\n"); \
    printf("[OUT] [%s:%s:%d] \n", __FILE__, __FUNCTION__, __LINE__); \
    printf("\n"); \

#define HI_RUN() \
    printf("\n"); \
    printf("[RUN] ok [%s:%s:%d] \n", __FILE__, __FUNCTION__, __LINE__); \
    printf("\n"); \

#define COLOR_NONE          "\033[0m"
#define COLOR_BLACK         "\033[0;30m"
#define COLOR_BLUE          "\033[0;34m"
#define COLOR_GREEN         "\033[0;32m"
#define COLOR_CYAN          "\033[0;36m"
#define COLOR_RED           "\033[0;31m"
#define COLOR_YELLOW        "\033[1;33m"
#define COLOR_WHITE         "\033[1;37m"

#define HI_NOP(fmt, args...)
#define HI_DBG(fmt, args...) \
    do { \
        printf(COLOR_GREEN "[DBG]:%s[%d]: " COLOR_NONE, __FUNCTION__,__LINE__); \
        printf(fmt, ##args); \
    }while(0)

#define HI_WARN(fmt, args...) \
    do { \
        printf(COLOR_YELLOW "[WARN]:%s[%d]: " COLOR_NONE, __FUNCTION__,__LINE__); \
        printf(fmt, ##args); \
    }while(0)

#define HI_INFO(fmt, args...) \
    do { \
        printf("[INFO]:%s[%d]: ", __FUNCTION__,__LINE__); \
        printf(fmt, ##args); \
    }while(0)

#define HI_ERR(fmt, args...) \
    do { \
        printf(COLOR_RED "[ERR]:%s[%d]: " COLOR_NONE, __FUNCTION__,__LINE__); \
        printf(fmt, ##args); \
    }while(0)

#ifndef MIN
#define MIN(a,b) ((a) < (b) ? (a) : (b))
#endif

#ifndef MAX
#define MAX(x,y) ((x) > (y) ? (x) : (y))
#endif

#ifndef ARRAY_SIZE
#define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
#endif

#define MI_U32VALUE(pu8Data, index) (pu8Data[index]<<24)|(pu8Data[index+1]<<16)|(pu8Data[index+2]<<8)|(pu8Data[index+3])

#define MAKE_YUYV_VALUE(y,u,v)  ((y) << 24) | ((u) << 16) | ((y) << 8) | (v)
#define YUYV_BLACK              MAKE_YUYV_VALUE(0,128,128)
#define YUYV_WHITE              MAKE_YUYV_VALUE(255,128,128)
#define YUYV_RED                MAKE_YUYV_VALUE(76,84,255)
#define YUYV_GREEN              MAKE_YUYV_VALUE(149,43,21)
#define YUYV_BLUE               MAKE_YUYV_VALUE(29,225,107)

#define ALIGN_UP(x, align)      (((x) + ((align) - 1)) & ~((align) - 1))
#define ALIGN_BACK(x, a)        (((x) / (a)) * (a))

/** Mutex Lock */
#define MUTEX_INIT_LOCK(mutex)  do { (void) pthread_mutex_init(&mutex, NULL); } while(0)
#define MUTEX_LOCK(mutex)       do { (void) pthread_mutex_lock(&mutex); } while(0)
#define MUTEX_UNLOCK(mutex)     do { (void) pthread_mutex_unlock(&mutex); } while(0)
#define MUTEX_DESTROY(mutex)    do { (void) pthread_mutex_destroy(&mutex); } while(0)

#ifdef __cplusplus
}
#endif	// __cplusplus

#endif //_HI_COMMON_H_

