//
//  LXDeltaCalculator.h
//  LXDeltaCalculation
//
//  Created by Stan Chang Khin Boon on 3/3/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LXDelta;

typedef BOOL (^lx_delta_calculator_equality_test_t)(id a, id b);

extern const lx_delta_calculator_equality_test_t LXDeltaCalculatorDefaultEqualityTest;

@interface LXDeltaCalculator : NSObject

+ (instancetype)defaultCalculator;

/**
 Resolve differences between two versions of an array.
 
 @param oldArray the array representing the "old" version of the array
 @param newArray the array representing the "new" version of the array.
 @returns A delta instance containing NSIndexSets representing added, moved, removed, and unchanged elements.
 */
- (LXDelta *)deltaFromOldArray:(nullable NSArray *)oldArray toNewArray:(nullable NSArray *)newArray;

@end

NS_ASSUME_NONNULL_END
