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

@interface LXSupportKitTests : XCTestCase

@end

@implementation LXSupportKitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDynamicCast {
    id foo = @"foo";
    XCTAssertNotNil(LXDynamicCast(foo, NSString)); // Downcast
    XCTAssertNotNil(LXDynamicCast([foo mutableCopy], NSString)); // Upcast
    XCTAssertNil(LXDynamicCast(foo, NSNumber));
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
