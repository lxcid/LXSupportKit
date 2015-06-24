//
//  NSURLComponents+LXSupportKit.h
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 24/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LXURLQueryItem;

NS_ASSUME_NONNULL_BEGIN

@interface NSURLComponents (LXSupportKit)

@property (nonatomic, copy, readonly, nullable) NSString *lx_string;
@property (nonatomic, copy, nullable) NSArray/*<LXURLQueryItem *>*/ *lx_queryItems;

@end

NS_ASSUME_NONNULL_END
