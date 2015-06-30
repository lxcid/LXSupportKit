//
//  LXHelpers.m
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 5/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import "LXHelpers.h"

#import <CoreGraphics/CGBase.h>

/**
 * Make sure we will use the right core graphic functions
 *
 */
#if defined(CGFLOAT_IS_DOUBLE) && CGFLOAT_IS_DOUBLE
    #define _LXCGFloor(value) floor(value)
    #define _LXCGCeil(value) ceil(value)
#else
    #define _LXCGFloor(value) floorf(value)
    #define _LXCGCeil(value) ceilf(value)
#endif

UIColor *LXRGBA(uint32_t x, CGFloat alpha) {
    CGFloat b = (x & 0xff) / 255.0; x >>= 8;
    CGFloat g = (x & 0xff) / 255.0; x >>= 8;
    CGFloat r = (x & 0xff) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

UIColor *LXRGB(uint32_t x) {
    return LXRGBA(x, 1.0);
}

BOOL LXDoubleEqual(double x, double y) {
    static double K = 1;
    return (fabs(x-y) < K * DBL_EPSILON * fabs(x+y) || fabs(x-y) < DBL_MIN);
}

CGFloat LXCGFloor(CGFloat value) {
    return _LXCGFloor(value);
}

CGFloat LXCGCeil(CGFloat value) {
    return _LXCGCeil(value);
}

CGFloat LXAdjustToScale(CGFloat (*adjustFn)(CGFloat), CGFloat value, CGFloat scale) {
    if (scale == 0) {
        static CGFloat __scale = 1.0;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            __scale = [[UIScreen mainScreen] scale];
        });
        scale = __scale;
    }
    if (scale == 1.0) {
        return adjustFn(value);
    } else {
        return adjustFn(value * scale) / scale;
    }
}

CGFloat LXFloorToViewScale(CGFloat value, UIView * __nullable view) {
    return LXAdjustToScale(LXCGFloor, value, view.contentScaleFactor);
}

CGFloat LXCeilToViewScale(CGFloat value, UIView * __nullable view) {
    return LXAdjustToScale(LXCGCeil, value, view.contentScaleFactor);
}
