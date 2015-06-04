//
//  LXHelpers.h
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 5/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LXDefines.h"

// Pass 0xcccccc and get color #cccccc
LXSUPPORTKIT_EXTERN UIColor *LXRGB(uint32_t x);
LXSUPPORTKIT_EXTERN UIColor *LXRGBA(uint32_t x, CGFloat alpha);

LX_INLINE BOOL ORKEqualObjects(id o1, id o2) {
    return (o1 == o2) || (o1 && o2 && [o1 isEqual:o2]);
}
