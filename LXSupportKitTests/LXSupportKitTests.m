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

- (void)testAssertMainThread {
    {
        XCTestExpectation *mainThreadExpectation = [self expectationWithDescription:@"on main thread"];
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertNoThrow([self lx_assertOnMainThread]);
            [mainThreadExpectation fulfill];
        });
        [self waitForExpectationsWithTimeout:1.0 handler:^(NSError * __nullable error) {
            NSLog(@"%@", error);
        }];
    }
    
    {
        XCTestExpectation *notMainThreadExpectation = [self expectationWithDescription:@"not on main thread"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            XCTAssertThrowsSpecificNamed([self lx_assertOnMainThread], NSException, NSInternalInconsistencyException);
            [notMainThreadExpectation fulfill];
        });
        [self waitForExpectationsWithTimeout:1.0 handler:^(NSError * __nullable error) {
            NSLog(@"%@", error);
        }];
    }
}

- (void)lx_assertOnMainThread {
    LXAssertMainThread();
}

@end
