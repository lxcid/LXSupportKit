//
//  LXDelta.m
//  LXDeltaCalculation
//
//  Created by Stan Chang Khin Boon on 3/3/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import "LXDelta.h"

@implementation LXDelta

+ (instancetype)deltaWithAddedIndices:(NSIndexSet *)addedIndices
                       removedIndices:(NSIndexSet *)removedIndices
                      movedIndexPairs:(NSArray *)movedIndexPairs
                  unchangedIndexPairs:(NSArray *)unchangedIndexPairs {
    return [[self alloc] initWithAddedIndices:addedIndices
                               removedIndices:removedIndices
                              movedIndexPairs:movedIndexPairs
                          unchangedIndexPairs:unchangedIndexPairs];
}

- (instancetype)initWithAddedIndices:(NSIndexSet *)addedIndices
                      removedIndices:(NSIndexSet *)removedIndices
                     movedIndexPairs:(NSArray *)movedIndexPairs
                 unchangedIndexPairs:(NSArray *)unchangedIndexPairs {
    self = [super init];
    if (self) {
        _addedIndices = [addedIndices copy];
        _removedIndices = [removedIndices copy];
        _movedIndexPairs = [movedIndexPairs copy];
        _unchangedIndexPairs = [unchangedIndexPairs copy];
    }
    return self;
}

@end
