//
//  LXDateTransformer.m
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 21/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import "LXDateTransformers.h"

#import "LXConstants.h"
#import "LXHelpers.h"

NSString * const LXISO8601DateTransformerName = @"LXISO8601Date";

@interface LXISO8601DateTransformer ()

@property (nonatomic, strong, readonly) NSTimeZone *timeZone;
@property (nonatomic, strong, readonly) NSDateFormatter *dateFormatter;

@end

@implementation LXISO8601DateTransformer

+ (void)load {
    LXISO8601DateTransformer *iso8601DateTransformer = [[LXISO8601DateTransformer alloc] init];
    [NSValueTransformer setValueTransformer:iso8601DateTransformer forName:LXISO8601DateTransformerName];
}

+ (instancetype)sharedTransformer {
    NSValueTransformer *valueTransformer = [NSValueTransformer valueTransformerForName:LXISO8601DateTransformerName];
    LXISO8601DateTransformer *iso8601DateTransformer = LXDynamicCast(valueTransformer, LXISO8601DateTransformer);
    NSAssert(iso8601DateTransformer != nil, @"must not be nil.");
    return iso8601DateTransformer;
}

#pragma mark - Object Life Cycle

- (instancetype)initWithTimeZone:(NSTimeZone *)timeZone {
    self = [super init];
    if (self) {
        _timeZone = timeZone;
        
        NSDateFormatter *dateFormatter = [self lx_createISO8601DateFormatter];
        dateFormatter.timeZone = timeZone;
        _dateFormatter = dateFormatter;
    }
    return self;
}

- (instancetype)init {
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    return [self initWithTimeZone:localTimeZone];
}

#pragma mark - Private

- (NSDateFormatter *)lx_createISO8601DateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:kLXDateFormatLocaleEN_US_POSIX];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    return dateFormatter;
}

#pragma mark - NSValueTransformer overrides

+ (Class)transformedValueClass {
    return [NSDate class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (nullable NSDate *)transformedValue:(nullable id)value {
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSDate class]]) {
        return value;
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)value;
        NSDateFormatter *dateFormatter = self.dateFormatter;
        if (!LXEqualObjects(self.timeZone, dateFormatter.timeZone)) {
            dateFormatter.timeZone = self.timeZone;
        }
        return [dateFormatter dateFromString:string];
    } else {
        return nil;
    }
}

- (nullable NSString *)reverseTransformedValue:(nullable id)value {
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSDate class]]) {
        NSDate *date = (NSDate *)value;
        NSDateFormatter *dateFormatter = self.dateFormatter;
        if (!LXEqualObjects(self.timeZone, dateFormatter.timeZone)) {
            dateFormatter.timeZone = self.timeZone;
        }
        return [dateFormatter stringFromDate:date];
    } else {
        return nil;
    }
}

@end
