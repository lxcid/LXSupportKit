//
//  LXBooleanTransformer.h
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 22/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LXDefines.h"

NS_ASSUME_NONNULL_BEGIN

LXSUPPORTKIT_EXPORT NSString * const LXBooleanTransformerName;

@interface LXBooleanTransformer : NSValueTransformer

+ (instancetype)sharedTransformer;

- (nullable NSNumber *)transformedValue:(nullable id)value;

+ (nullable NSNumber *)fromValue:(nullable id)value;

@end

NS_ASSUME_NONNULL_END
