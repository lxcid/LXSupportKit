//
//  LXScrollViewObserver.h
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 20/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

#import "LXKeyValueObserver.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LXScrollViewObserver;

@protocol LXScrollViewObserverDelegate<NSObject>

@required
- (void)observedScrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface LXScrollViewObserver : LXKeyValueObserver

- (instancetype)initWithTargetView:(UIScrollView *)scrollView delegate:(id<LXScrollViewObserverDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
