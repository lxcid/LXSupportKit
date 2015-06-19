//
//  LXDeltaCalculator.m
//  LXDeltaCalculation
//
//  Created by Stan Chang Khin Boon on 3/3/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import "LXDeltaCalculator.h"

#import "LXDelta.h"

const lx_delta_calculator_equality_test_t LXDeltaCalculatorDefaultEqualityTest = ^BOOL(id a, id b) {
    return [a isEqual:b];
};

@interface LXDeltaCalculator ()

@property (nonatomic, copy) lx_delta_calculator_equality_test_t equalityTest;

@end

@implementation LXDeltaCalculator

+ (instancetype)defaultCalculator {
    static LXDeltaCalculator *defaultCalculator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCalculator = [[LXDeltaCalculator alloc] init];
    });
    
    return defaultCalculator;
}

+ (instancetype)deltaCalculatorWithEqualityTest:(lx_delta_calculator_equality_test_t)equalityTest {
    return [[LXDeltaCalculator alloc] initWithEqualityTest:equalityTest];
}

- (instancetype)init {
    return [self initWithEqualityTest:LXDeltaCalculatorDefaultEqualityTest];
}

- (instancetype)initWithEqualityTest:(lx_delta_calculator_equality_test_t)equalityTest {
    self = [super init];
    if (self) {
        _equalityTest = [equalityTest copy];
    }
    return self;
}

- (LXDelta *)deltaFromOldArray:(NSArray *)oldArray toNewArray:(NSArray *)newArray {
    // Deleted
    NSMutableArray *newArrayMutableCopy = [newArray mutableCopy] ?: [[NSMutableArray alloc] init];
    NSMutableIndexSet *deletedIndices = [NSMutableIndexSet indexSet];
    for (NSUInteger i = 0; i < oldArray.count; i++) {
        id objectInOldArray = oldArray[i];
        NSUInteger indexInNewArray = [newArrayMutableCopy indexOfObject:objectInOldArray];
        if (indexInNewArray == NSNotFound) {
            [deletedIndices addIndex:i];
        } else {
            [newArrayMutableCopy replaceObjectAtIndex:indexInNewArray withObject:[NSNull null]];
        }
    }
    
    // Inserted
    NSMutableArray *oldArrayMutableCopy = [oldArray mutableCopy] ?: [[NSMutableArray alloc] init];
    NSMutableIndexSet *insertedIndices = [NSMutableIndexSet indexSet];
    for (NSUInteger i = 0; i < newArray.count; i++) {
        id objectInNewArray = newArray[i];
        NSUInteger indexInOldArray = [oldArrayMutableCopy indexOfObject:objectInNewArray];
        if (indexInOldArray == NSNotFound) {
            [insertedIndices addIndex:i];
        } else {
            [oldArrayMutableCopy replaceObjectAtIndex:indexInOldArray withObject:[NSNull null]];
        }
    }
    
    // Moved
    oldArrayMutableCopy = [oldArray mutableCopy] ?: [[NSMutableArray alloc] init];
    NSMutableArray *unchangedIndexPairs = [NSMutableArray array];
    NSMutableArray *movedIndexPairs = [NSMutableArray array];
    for (NSUInteger indexInNewArray = 0; indexInNewArray < newArray.count; indexInNewArray++) {
        id objectInNewArray = newArray[indexInNewArray];
        NSUInteger indexInOldArray = [oldArrayMutableCopy indexOfObject:objectInNewArray];
        if (indexInOldArray == NSNotFound) {
            // Ignore Inserted
            continue;
        } else {
            [oldArrayMutableCopy replaceObjectAtIndex:indexInOldArray withObject:[NSNull null]];
        }
        if ([deletedIndices containsIndex:indexInOldArray]) {
            // Ignore Deleted
            continue;
        }
        
        NSUInteger previousInsertedCount = [insertedIndices countOfIndexesInRange:NSMakeRange(0, indexInNewArray + 1)];
        NSUInteger previousDeletedCount = [deletedIndices countOfIndexesInRange:NSMakeRange(0, indexInOldArray + 1)];
        NSUInteger transformedIndex = indexInNewArray - previousInsertedCount + previousDeletedCount;
        if (transformedIndex != indexInOldArray) {
            [movedIndexPairs addObject:@[ @(indexInOldArray), @(indexInNewArray) ]];
        } else {
            [unchangedIndexPairs addObject:@[ @(indexInOldArray), @(indexInNewArray) ]];
        }
    }
    
    return [LXDelta deltaWithAddedIndices:[insertedIndices copy]
                           removedIndices:[deletedIndices copy]
                          movedIndexPairs:[movedIndexPairs copy]
                      unchangedIndexPairs:[unchangedIndexPairs copy]];
}

@end
