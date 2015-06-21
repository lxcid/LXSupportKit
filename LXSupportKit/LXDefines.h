//
//  LXDefines.h
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 5/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#if defined(__cplusplus)
    #define LXSUPPORTKIT_EXTERN extern "C"
#else
    #define LXSUPPORTKIT_EXTERN extern
#endif

#if TARGET_OS_WIN32
    #if defined(NSBUILDINGFOUNDATION)
        #define LXSUPPORTKIT_EXPORT LXSUPPORTKIT_EXTERN __declspec(dllexport)
    #else
        #define LXSUPPORTKIT_EXPORT LXSUPPORTKIT_EXTERN __declspec(dllimport)
    #endif

    #define LXSUPPORTKIT_IMPORT LXSUPPORTKIT_EXTERN __declspec(dllimport)
#else
    #define LXSUPPORTKIT_EXPORT  LXSUPPORTKIT_EXTERN
    #define LXSUPPORTKIT_IMPORT LXSUPPORTKIT_EXTERN
#endif

#if !defined(LX_INLINE)
    #if defined(__GNUC__)
        #define LX_INLINE static __inline__ __attribute__((always_inline))
    #elif defined(__MWERKS__) || defined(__cplusplus)
        #define LX_INLINE static inline
    #elif defined(_MSC_VER)
        #define LX_INLINE static __inline
    #elif TARGET_OS_WIN32
        #define LX_INLINE static __inline__
    #else
        #define LX_INLINE static
    #endif
#endif

#if !defined(LXSUPPORTKIT_STATIC_INLINE)
    #define LXSUPPORTKIT_STATIC_INLINE static __inline__
#endif

#if !defined(LXSUPPORTKIT_EXTERN_INLINE)
    #define LXSUPPORTKIT_EXTERN_INLINE extern __inline__
#endif

/**
 * Dynamically cast an instance to a class. Return nil if the cast fail
 *
 */

#define LXDynamicCast(x, c) ((c *) ([x isKindOfClass:[c class]] ? x : nil))

#define LXStrongType(x) __strong __typeof(x)
#define LXWeakType(x) __weak __typeof(x)

/**
 * Helpers for completions which call the block only if non-nil
 *
 */

#define LXBlockExec(block, ...) \
do { \
    if (block) { \
        block(__VA_ARGS__); \
    } \
} while (0)

#define LXDispatchExec(queue, block, ...) \
do { \
    if (block) { \
        dispatch_async(queue, ^{ \
            block(__VA_ARGS__); \
        }); \
    } \
} while (0)

#define LXBlockExecOnMainThread(block, ...) \
do { \
    if ([NSThread isMainThread]) { \
        LXBlockExec(block, __VA_ARGS__); \
    } else { \
        LXDispatchExec(dispatch_get_main_queue(), block, __VA_ARGS__); \
    } \
} while (0)

/**
 * Common assertions
 *
 */

#define LXAssertMainThread() NSAssert([NSThread isMainThread], @"Must be on the main thread at this point")
