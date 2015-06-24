//
//  LXURLQueryItem.h
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 24/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// NSURLQueryItem
@interface LXURLQueryItem : NSObject <NSSecureCoding, NSCopying>

+ (instancetype)queryItemWithName:(NSString *)name value:(nullable NSString *)value;

- (instancetype)initWithName:(NSString *)name value:(nullable NSString *)value NS_DESIGNATED_INITIALIZER;
- (instancetype)init;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly, nullable) NSString *value;

@end

NS_ASSUME_NONNULL_END
