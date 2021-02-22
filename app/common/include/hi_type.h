/******************************************************************************
 * Copyright (C) UNIONMAN Technologies Co., Ltd. 2005-2019. All rights reserved.
 * Description: Common data types of the system.
 * Author: UNIONMAN multimedia software group
 * Create: 2005-4-23
******************************************************************************/

#ifndef __HI_TYPE_H__
#define __HI_TYPE_H__

#ifdef __KERNEL__

#include <linux/types.h>
#else

#include <stdint.h>
#endif

#ifdef __cplusplus
#if __cplusplus
extern "C"{
#endif
#endif /* __cplusplus */

/*--------------------------------------------------------------------------------------------------------------*
 * Defintion of basic data types. The data types are applicable to both the application layer and kernel codes. *
 *--------------------------------------------------------------------------------------------------------------*/
/*************************** Structure Definition ****************************/
/** \addtogroup      Common_TYPE */
/** @{ */  /** <!-- [Common_TYPE] */

typedef unsigned char           HI_UCHAR;
typedef unsigned char           HI_U8;
typedef unsigned short          HI_U16;
typedef unsigned int            HI_U32;
typedef unsigned long           HI_UL;
typedef HI_UL                   HI_ULONG;
typedef uintptr_t               HI_UINTPTR_T;

typedef char                    HI_CHAR;
typedef signed char             HI_S8;
typedef short                   HI_S16;
typedef int                     HI_S32;
typedef long                    HI_SL;

typedef float                   HI_FLOAT;
typedef double                  HI_DOUBLE;

#ifndef _M_IX86
    typedef unsigned long long  HI_U64;
    typedef long long           HI_S64;
#else
    typedef unsigned __int64    HI_U64;
    typedef __int64             HI_S64;
#endif

typedef unsigned long           HI_SIZE_T;
typedef unsigned long           HI_LENGTH_T;
typedef unsigned long int       HI_PHYS_ADDR_T;

typedef unsigned int            HI_HANDLE;

/*----------------------------------------------*
 * const defination                             *
 *----------------------------------------------*/
typedef enum {
    HI_FALSE = 0,
    HI_TRUE  = 1,
} HI_BOOL;

#ifndef NULL
    #define NULL                0L
#endif

#define HI_NULL                 0L
#define HI_SUCCESS              0
#define HI_FAILURE              (-1)
#define HI_INVALID_HANDLE       (0xffffffff)

#define HI_VOID                 void

typedef unsigned char           st_uchar;
typedef unsigned char           st_u8;
typedef unsigned short          st_u16;
typedef unsigned int            st_u32;
typedef unsigned long           st_ulong;

typedef char                    st_char;
typedef signed char             st_s8;
typedef short                   st_s16;
typedef int                     st_s32;
typedef long                    st_slong;

typedef float                   st_float;
typedef double                  st_double;

typedef void                    st_void;

#ifndef _M_IX86
    typedef unsigned long long  st_u64;
    typedef long long           st_s64;
#else
    typedef unsigned __int64    st_u64;
    typedef __int64             st_s64;
#endif

typedef unsigned long           st_size_t;
typedef unsigned long           st_length_t;

typedef st_u32                  st_handle;

typedef HI_BOOL                 st_bool;
typedef HI_UINTPTR_T            st_uintptr_t;
typedef unsigned long int       st_phys_addr_t;


/** @} */  /** <!-- ==== Structure Definition end ==== */

#define HI_UNUSED(x)            ((x) = (x))

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* __cplusplus */

#endif /* __HI_TYPE_H__ */

