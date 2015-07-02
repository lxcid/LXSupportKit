//
//  LXStringTransformer.m
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 1/7/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import "LXStringTransformers.h"

NSString * const LXStringTransformerName = @"LXString";
NSString * const LXStrictStringTransformerName = @"LXStrictString";

@implementation LXStringTransformer

+ (void)load {
    LXStringTransformer *stringTransformer = [[LXStringTransformer alloc] initWithStrict:NO];
    [NSValueTransformer setValueTransformer:stringTransformer forName:LXStringTransformerName];
}

+ (instancetype)sharedTransformer {
    NSValueTransformer *valueTransformer = [NSValueTransformer valueTransformerForName:LXStringTransformerName];
    LXStringTransformer *stringTransformer = LXDynamicCast(valueTransformer, LXStringTransformer);
    NSAssert(stringTransformer != nil, @"must not be nil.");
    return stringTransformer;
}

+ (nullable NSString *)fromValue:(nullable id)value {
    return [[self sharedTransformer] transformedValue:value];
}

#pragma mark - Object Life Cycle

- (instancetype)initWithStrict:(BOOL)strict {
    self = [super init];
    if (self) {
        _strict = strict;
    }
    return self;
}

- (instancetype)init {
    return [self initWithStrict:NO];
}

#pragma mark - NSValueTransformer overrides

+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

- (nullable NSString *)transformedValue:(nullable id)value {
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNull class]]) {
        return nil;
    } else if (!self.isStrict) {
        return [value description];
    } else {
        return nil;
    }
}

@end

@implementation LXStrictStringTransformer

+ (void)load {
    LXStrictStringTransformer *strictStringTransformer = [[LXStrictStringTransformer alloc] init];
    [NSValueTransformer setValueTransformer:strictStringTransformer forName:LXStrictStringTransformerName];
}

+ (instancetype)sharedTransformer {
    NSValueTransformer *valueTransformer = [NSValueTransformer valueTransformerForName:LXStrictStringTransformerName];
    LXStrictStringTransformer *strictStringTransformer = LXDynamicCast(valueTransformer, LXStrictStringTransformer);
    NSAssert(strictStringTransformer != nil, @"must not be nil.");
    return strictStringTransformer;
}

#pragma mark - Object Life Cycle

- (instancetype)init {
    self = [super initWithStrict:YES];
    if (self) {
    }
    return self;
}

- (instancetype)initWithStrict:(BOOL)strict {
    if (!strict) {
        [NSException raise:NSInternalInconsistencyException format:@"Can't initialize a non-strict %@ instance.", [self class]];
    }
    return [self init];
}

@end
