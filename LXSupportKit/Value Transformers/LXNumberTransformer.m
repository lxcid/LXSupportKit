//
//  LXNumberTransformer.m
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 20/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

#import "LXNumberTransformer.h"

NSString * const LXNumberTransformerName = @"LXNumber";

@implementation LXNumberTransformer

+ (void)load {
    LXNumberTransformer *numberTransformer = [[LXNumberTransformer alloc] init];
    [NSValueTransformer setValueTransformer:numberTransformer forName:LXNumberTransformerName];
}

+ (NSNumberFormatter *)numberFormatter {
    static NSNumberFormatter *numberFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    });
    return numberFormatter;
}

+ (instancetype)sharedTransformer {
    NSValueTransformer *valueTransformer = [NSValueTransformer valueTransformerForName:LXNumberTransformerName];
    LXNumberTransformer *numberTransformer = LXDynamicCast(valueTransformer, LXNumberTransformer);
    NSAssert(numberTransformer != nil, @"must not be nil.");
    return numberTransformer;
}

#pragma mark - NSValueTransformer overrides

+ (Class)transformedValueClass {
    return [NSNumber class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (nullable NSNumber *)transformedValue:(nullable id)value {
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)value;
        NSNumberFormatter *numberFormatter = [[self class] numberFormatter];
        return [numberFormatter numberFromString:string];
    } else {
        return nil;
    }
}

- (nullable NSString *)reverseTransformedValue:(nullable id)value {
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)value;
        NSNumberFormatter *numberFormatter = [[self class] numberFormatter];
        return [numberFormatter stringFromNumber:number];
    } else {
        return nil;
    }
}

@end
