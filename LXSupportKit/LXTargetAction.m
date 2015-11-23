//
//  LXTargetAction.m
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 24/11/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

#import "LXTargetAction.h"

#import "LXErrors.h"
#import "LXDefines.h"
#import "LXHelpers.h"

@interface LXTargetAction ()

@property (nonatomic, weak) id<NSObject> target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, assign) NSUInteger hash;

@end

@implementation LXTargetAction

@synthesize hash = _hash;

- (instancetype)initWithTarget:(id<NSObject>)target action:(SEL)action {
    NSParameterAssert(target);
    NSParameterAssert(action);
    
    self = [super init];
    if (self) {
        _target = target;
        _action = action;
        _hash = _target.hash ^ NSStringFromSelector(_action).hash;
    }
    return self;
}

- (BOOL)sendActionToTargetWithObject:(nullable id)object error:(NSError * __nullable __autoreleasing * __nullable)outError {
    id target = self.target;
    SEL action = self.action;
    if (!target) {
        if (outError) {
            *outError = [NSError errorWithDomain:LXSupportKitErrorDomain code:LXErrorCodeInvalidState userInfo:nil];
        }
        return NO;
    }
    
    NSMethodSignature *methodSignature = [target methodSignatureForSelector:action];
    if (!methodSignature) {
        if (outError) {
            *outError = [NSError errorWithDomain:LXSupportKitErrorDomain code:LXErrorCodeInvalidState userInfo:nil];
        }
        return NO;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target = target;
    invocation.selector = action;
    if (methodSignature.numberOfArguments >= 3) {
        [invocation setArgument:&object atIndex:2];
    }
    [invocation invoke];
    
    return YES;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    LXTargetAction *targetAction = LXDynamicCast(object, LXTargetAction);
    if (!targetAction) {
        return NO;
    }
    
    return (LXEqualObjects(self.target, targetAction.target) &&
            (self.action == targetAction.action));
}

@end
