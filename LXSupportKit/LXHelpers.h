//
//  LXHelpers.h
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 5/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LXDefines.h"

NS_ASSUME_NONNULL_BEGIN

// Pass 0xcccccc and get color #cccccc
// FIXME: (me@lxcid.com) Maybe we should create a factory method like `+[UIColor colorWithRGB:alpha:]` instead.
LXSUPPORTKIT_EXTERN UIColor *LXRGB(uint32_t x);
LXSUPPORTKIT_EXTERN UIColor *LXRGBA(uint32_t x, CGFloat alpha);

LX_INLINE BOOL LXEqualObjects(id __nullable o1, id __nullable o2) {
    return (o1 == o2) || (o1 && o2 && [o1 isEqual:o2]);
}

// FIXME: (me@lxcid.com) Using an absolute epsilon is not recommended. We should review it again.
// See http://floating-point-gui.de/errors/comparison/
// See https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/
LXSUPPORTKIT_EXTERN BOOL LXDoubleEqual(double x, double y);

LXSUPPORTKIT_EXTERN CGFloat LXCGFloor(CGFloat value);
LXSUPPORTKIT_EXTERN CGFloat LXCGCeil(CGFloat value);

LXSUPPORTKIT_EXTERN CGFloat LXAdjustToScale(CGFloat (*adjustFn)(CGFloat), CGFloat value, CGFloat scale);
LXSUPPORTKIT_EXTERN CGFloat LXFloorToViewScale(CGFloat value, UIView * __nullable view);
LXSUPPORTKIT_EXTERN CGFloat LXCeilToViewScale(CGFloat value, UIView * __nullable view);

NS_ASSUME_NONNULL_END
