//
//  LXKeyValueObserver.h
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 19/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 An observer for KVO.
 
 @note: An implementation of observer based on ResearchKit's `ORKObserver`. Alternatively, you can use Facebook's `KVOObserver`.
 */
@interface LXKeyValueObserver : NSObject

@property (nonatomic, strong, readonly) id target;
@property (nonatomic, strong, readonly) NSArray *keyPaths;
@property (nonatomic, assign, readonly) void *context;

@property (nonatomic, weak, nullable) id delegate;
@property (nonatomic, assign) SEL action;

@property (nonatomic, assign, getter = isObserving, readonly) BOOL observing;

- (instancetype)initWithTarget:(id)target keyPaths:(NSArray *)keyPaths delegate:(nullable id)delegate action:(SEL)action context:(void *)context NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
