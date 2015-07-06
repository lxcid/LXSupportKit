//
//  LXDictionaryReader.h
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 30/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXDictionaryReader : NSObject

// @discussion We only copy if we can't ensure immutability of dictionary.
@property (nonatomic, copy, readonly) NSDictionary *dictionary;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

- (nullable NSArray *)arrayForKey:(id<NSCopying>)key;
- (nullable NSNumber *)booleanForKey:(id<NSCopying>)key;
- (nullable NSDictionary *)dictionaryForKey:(id<NSCopying>)key;
- (nullable NSNumber *)numberForKey:(id<NSCopying>)key;
- (nullable NSDate *)iso8601DateForKey:(id<NSCopying>)key;
- (nullable NSString *)strictStringForKey:(id<NSCopying>)key;
- (nullable NSString *)stringForKey:(id<NSCopying>)key;

@end

NS_ASSUME_NONNULL_END
