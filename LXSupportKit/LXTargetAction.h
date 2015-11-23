//
//  LXTargetAction.h
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 24/11/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXTargetAction : NSObject

@property (nonatomic, weak, readonly) id<NSObject> target;
@property (nonatomic, assign, readonly) SEL action;

- (instancetype)initWithTarget:(id<NSObject>)target action:(SEL)action;

- (BOOL)sendActionToTargetWithObject:(nullable id)object error:(NSError * __nullable __autoreleasing * __nullable)outError;

@end

NS_ASSUME_NONNULL_END