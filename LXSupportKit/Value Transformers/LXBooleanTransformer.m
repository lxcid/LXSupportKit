//
//  LXBooleanTransformer.m
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 22/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import "LXBooleanTransformer.h"

#import "LXNumberTransformer.h"

NSString * const LXBooleanTransformerName = @"LXBoolean";

@implementation LXBooleanTransformer

+ (void)load {
    LXBooleanTransformer *booleanTransformer = [[LXBooleanTransformer alloc] init];
    [NSValueTransformer setValueTransformer:booleanTransformer forName:LXBooleanTransformerName];
}

+ (instancetype)sharedTransformer {
    NSValueTransformer *valueTransformer = [NSValueTransformer valueTransformerForName:LXBooleanTransformerName];
    LXBooleanTransformer *booleanTransformer = LXDynamicCast(valueTransformer, LXBooleanTransformer);
    NSAssert(booleanTransformer != nil, @"must not be nil.");
    return booleanTransformer;
}

#pragma mark - NSValueTransformer overrides

+ (Class)transformedValueClass {
    return [NSNumber class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

- (nullable NSNumber *)transformedValue:(nullable id)value {
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)value;
        return [NSNumber numberWithBool:number.boolValue];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)value;
        if ([string compare:@"true" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            return @YES;
        } else if ([string compare:@"false" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            return @NO;
        } else {
            LXNumberTransformer *numberTransformer = [LXNumberTransformer sharedTransformer];
            NSNumber *number = [numberTransformer transformedValue:string];
            if (!number) {
                return nil;
            }
            return [NSNumber numberWithBool:number.boolValue];
        }
    } else {
        return nil;
    }
}

@end
