//
//  LXScrollViewObserver.m
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 20/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

#import "LXScrollViewObserver.h"

@implementation LXScrollViewObserver

static void *_LXScrollViewObserverContext = &_LXScrollViewObserverContext;

- (instancetype)initWithTargetView:(UIScrollView *)scrollView delegate:(id<LXScrollViewObserverDelegate>)delegate {
    return [super initWithTarget:scrollView
                        keyPaths:@[@"contentOffset"]
                        delegate:delegate
                          action:@selector(observedScrollViewDidScroll:)
                         context:_LXScrollViewObserverContext];
}

@end
