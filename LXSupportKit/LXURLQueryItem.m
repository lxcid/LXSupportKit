//
//  LXURLQueryItem.m
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 24/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

#import "LXURLQueryItem.h"

#import "LXDefines.h"
#import "LXHelpers.h"

@implementation LXURLQueryItem

+ (instancetype)queryItemWithName:(NSString *)name value:(nullable NSString *)value {
    return [[self alloc] initWithName:name value:value];
}

- (instancetype)initWithName:(NSString *)name value:(nullable NSString *)value {
    self = [super init];
    if (self) {
        // Although name parameter is nonnull, we still protect against nullable situation.
        _name = name ? [name copy] : @"";
        _value = [value copy];
    }
    return self;
}

- (instancetype)init {
    return [self initWithName:@"" value:nil];
}

#pragma mark - NSCoding

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    Class class = [self class];
    if (!aDecoder.allowsKeyedCoding) {
        [NSException raise:NSInvalidArgumentException format:@"%@ cannot be decoded by non-keyed archivers", class];
    }
    NSString *name = [aDecoder decodeObjectOfClass:class forKey:@"NS.name"];
    NSString *value = [aDecoder decodeObjectOfClass:class forKey:@"NS.value"];
    return [self initWithName:name value:value];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    Class class = [self class];
    if (!aCoder.allowsKeyedCoding) {
        [NSException raise:NSInvalidArgumentException format:@"%@ cannot encoded non-keyed archivers", class];
    }
    [aCoder encodeObject:_name forKey:@"NS.name"];
    [aCoder encodeObject:_value forKey:@"NS.value"];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(nullable NSZone *)zone {
    // Immutable, thus it's safe to return self
    return self;
}

#pragma mark - NSObject

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p> {name = %@, value = %@}", [self class], self, _name, _value];
}

- (NSUInteger)hash {
    return _name.hash ^ _value.hash;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    LXURLQueryItem *queryItem = LXDynamicCast(object, LXURLQueryItem);
    if (!queryItem) {
        return NO;
    }
    return (LXEqualObjects(_name, queryItem->_name) &&
            LXEqualObjects(_value, queryItem->_value));
}

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
