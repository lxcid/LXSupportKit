//
//  LXKeyValueObserver.m
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 19/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import "LXKeyValueObserver.h"

#import <objc/message.h>

@implementation LXKeyValueObserver

- (instancetype)initWithTarget:(id)target keyPaths:(NSArray *)keyPaths delegate:(nullable id)delegate action:(SEL)action context:(void *)context {
    self = [super init];
    if (self) {
        _target = target;
        _keyPaths = keyPaths;
        _delegate = delegate;
        _action = action;
        _context = context;
        [self lx_startObserving];
    }
    return self;
}

- (void)dealloc {
    [self lx_stopObserving];
}

#pragma mark - Key Value Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSAssert(context == self.context, @"Unexpected KVO");
    void (*performSelectorWithObject)(id, SEL, id) = (void (*)(id, SEL, id))objc_msgSend;
    performSelectorWithObject(self.delegate, self.action, self.target);
}

#pragma mark - Private

- (void)lx_startObserving {
    if (!self.isObserving) {
        NSAssert(self.keyPaths, @"");
        NSAssert(self.target, @"");
        NSAssert(self.context, @"");
        NSAssert(self.delegate, @"");
        NSAssert(self.action, @"");
        for (NSString *keyPath in self.keyPaths) {
            [self.target addObserver:self forKeyPath:keyPath options:(NSKeyValueObservingOptions)0 context:self.context];
        }
        _observing = YES;
    }
}

- (void)lx_stopObserving {
    if (self.isObserving) {
        for (NSString *keyPath in self.keyPaths) {
            [self.target removeObserver:self forKeyPath:keyPath];
        }
        _observing = NO;
    }
}

@end
