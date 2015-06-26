//
//  LXNumberTransformer.h
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 20/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LXDefines.h"

NS_ASSUME_NONNULL_BEGIN

LXSUPPORTKIT_EXPORT NSString * const LXNumberTransformerName;

@interface LXNumberTransformer : NSValueTransformer

+ (instancetype)sharedTransformer;

- (nullable NSNumber *)transformedValue:(nullable id)value;
- (nullable NSString *)reverseTransformedValue:(nullable id)value;

+ (nullable NSNumber *)fromValue:(nullable id)value;
+ (nullable NSString *)toValue:(nullable id)value;

@end

NS_ASSUME_NONNULL_END
