//
//  LXHelpers.m
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 5/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import "LXHelpers.h"

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
