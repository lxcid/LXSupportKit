//
//  LXSupportKitTests.m
//  LXSupportKitTests
//
//  Created by Stan Chang Khin Boon on 5/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "LXDefines.h"
#import "LXHelpers.h"

@interface LXSupportKitTests : XCTestCase

@end

@implementation LXSupportKitTests

- (void)testDynamicCast {
    id foo = @"foo";
    XCTAssertNotNil(LXDynamicCast(foo, NSString)); // Downcast
    XCTAssertNotNil(LXDynamicCast([foo mutableCopy], NSString)); // Upcast
    XCTAssertNil(LXDynamicCast(foo, NSNumber));
}

@end
