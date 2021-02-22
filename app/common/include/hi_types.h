/*
 * Copyright (C), UNIONMAN Technologies Co., Ltd. 2005-2019. All rights reserved.
 * Description   : head file for hisi types.
 * Author        :
 * Create        : 2005-04-23
 */

#ifndef __HI_TYPES_H__
#define __HI_TYPES_H__

#include "hi_type.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif /* __cplusplus */

/* -------------------------------------------------------------------------------------------------------------*
 * Defintion of basic data types. The data types are applicable to both the application layer and kernel codes. *
 * -------------------------------------------------------------------------------------------------------------*
 */
/*
 * define of HI_HANDLE :
 * bit31                                                           bit0
 *   |<----   16bit --------->|<---   8bit    --->|<---  8bit   --->|
 *   |--------------------------------------------------------------|
 *   |      HI_MOD_ID_E       |  mod defined data |     chnID       |
 *   |--------------------------------------------------------------|
 *
 * mod defined data: private data define by each module(for example: sub-mod id), usually, set to 0.
 */

#define HI_HANDLE_MAKEHANDLE(mod, privatedata, chnid)  \
    (st_handle)((((mod)& 0xffff) << 16) | ((((privatedata)& 0xff) << 8)) | (((chnid) & 0xff)))

#define HI_HANDLE_GET_MODID(handle)     (((handle) >> 16) & 0xffff)
#define HI_HANDLE_GET_PriDATA(handle)   (((handle) >> 8) & 0xff)
#define HI_HANDLE_GET_CHNID(handle)     (((handle)) & 0xff)

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* __cplusplus */

#endif /* __HI_TYPES_H__ */

