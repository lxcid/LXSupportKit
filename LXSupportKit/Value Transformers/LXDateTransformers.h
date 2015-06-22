//
//  LXDateTransformer.h
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 21/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LXDefines.h"

NS_ASSUME_NONNULL_BEGIN

LXSUPPORTKIT_EXPORT NSString * const LXISO8601DateTransformerName;

/**
 * @discussion As `NSDateFormatter` stores a copy of `NSTimeZone`, it does not response to changes to default time zone even if we passes it `+[NSTimeZone localTimeZone]`. Thus, we store a reference of the time zone passed and manually check to make sure the time zone in `NSDateFormatter` does not goes out of sync with the reference time zone we hold.
 *
 */
@interface LXISO8601DateTransformer : NSValueTransformer

+ (instancetype)sharedTransformer;

- (instancetype)initWithTimeZone:(NSTimeZone *)timeZone NS_DESIGNATED_INITIALIZER;
- (instancetype)init;

- (nullable NSDate *)transformedValue:(nullable id)value;
- (nullable NSString *)reverseTransformedValue:(nullable id)value;

@end

NS_ASSUME_NONNULL_END
