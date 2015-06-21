//
//  LXDictionaryBuilder.h
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 21/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXDictionaryBuilder : NSObject

@property (nonatomic, copy, readonly) NSDictionary *dictionary;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;
- (instancetype)init;

- (nullable id)objectForKey:(id<NSCopying>)aKey;
- (void)setObject:(nullable id)anObject forKey:(id<NSCopying>)aKey;

- (nullable id)objectForKeyedSubscript:(id<NSCopying>)aKey;
- (void)setObject:(nullable id)obj forKeyedSubscript:(id<NSCopying>)key;

@end

NS_ASSUME_NONNULL_END
