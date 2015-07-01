//
//  LXStringTransformer.h
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 1/7/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LXDefines.h"

NS_ASSUME_NONNULL_BEGIN

/// Lenient mode, non-string and non-null class are converted to string using description.
LXSUPPORTKIT_EXPORT NSString * const LXStringTransformerName;
/// Strict mode, non-string and non-null class are nullified.
LXSUPPORTKIT_EXPORT NSString * const LXStrictStringTransformerName;

@interface LXStringTransformer : NSValueTransformer

@property (nonatomic, assign, readonly, getter = isStrict) BOOL strict;

+ (instancetype)sharedTransformer;

- (instancetype)initWithStrict:(BOOL)strict NS_DESIGNATED_INITIALIZER;
- (instancetype)init;

- (nullable NSString *)transformedValue:(nullable id)value;

+ (nullable NSString *)fromValue:(nullable id)value;

@end

@interface LXStrictStringTransformer : LXStringTransformer

- (instancetype)init NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
