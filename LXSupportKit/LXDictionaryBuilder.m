//
//  LXDictionaryBuilder.m
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 21/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

#import "LXDictionaryBuilder.h"

@implementation LXDictionaryBuilder {
    NSMutableDictionary *_dictionary;
}

- (NSDictionary *)dictionary {
    return [_dictionary copy];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _dictionary = [dictionary mutableCopy];
    }
    return self;
}

- (instancetype)init {
    return [self initWithDictionary:@{}];
}

- (nullable id)objectForKey:(id<NSCopying>)aKey {
    return [_dictionary objectForKey:aKey];
}

- (void)setObject:(nullable id)anObject forKey:(id<NSCopying>)aKey {
    if (!anObject) {
        [_dictionary removeObjectForKey:aKey];
        return;
    }
    [_dictionary setObject:anObject forKey:aKey];
}

- (nullable id)objectForKeyedSubscript:(id<NSCopying>)aKey {
    return _dictionary[aKey];
}

- (void)setObject:(nullable id)anObject forKeyedSubscript:(id<NSCopying>)aKey {
    if (!anObject) {
        [_dictionary removeObjectForKey:aKey];
        return;
    }
    _dictionary[aKey] = anObject;
}

@end
