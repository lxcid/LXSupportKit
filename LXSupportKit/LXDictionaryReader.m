//
//  LXDictionaryReader.m
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 30/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import "LXDictionaryReader.h"

#import "LXBooleanTransformer.h"
#import "LXDateTransformers.h"
#import "LXNumberTransformer.h"

@implementation LXDictionaryReader

- (nonnull instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        // We only copy if we can't ensure immutability of dictionary.
        _dictionary = ([dictionary isKindOfClass:[NSMutableDictionary class]]) ? [dictionary copy] : dictionary;
    }
    return self;
}

- (nullable NSArray *)arrayForKey:(id<NSCopying>)key {
    id value = self.dictionary[key];
    return [self _arrayFromValue:value];
}

- (nullable NSNumber *)booleanForKey:(nonnull id<NSCopying>)key {
    id value = self.dictionary[key];
    return [LXBooleanTransformer fromValue:value];
}

- (nullable NSNumber *)numberForKey:(nonnull id<NSCopying>)key {
    id value = self.dictionary[key];
    return [LXNumberTransformer fromValue:value];
}

- (nullable NSDate *)iso8601DateForKey:(nonnull id<NSCopying>)key {
    id value = self.dictionary[key];
    return [LXISO8601DateTransformer fromValue:value];
}

#pragma mark - Private

- (NSArray *)_arrayFromValue:(id)value {
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    } else {
        return nil;
    }
}

@end
