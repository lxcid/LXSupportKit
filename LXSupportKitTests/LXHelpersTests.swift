//
//  LXHelpersTests.swift
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 18/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

import XCTest

class LXHelpersTests: XCTestCase {
    func testRGBA() {
        XCTAssertEqual(LXRGBA(0x000000, 0.5), UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5))
        XCTAssertEqual(LXRGBA(0xFFFFFF, 0.5), UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5))
        XCTAssertEqual(LXRGB(0xFF0000), UIColor.redColor())
        XCTAssertEqual(LXRGB(0x00FF00), UIColor.greenColor())
        XCTAssertEqual(LXRGB(0x0000FF), UIColor.blueColor())
        XCTAssertEqual(LXRGB(0xFFFF00), UIColor.yellowColor())
        XCTAssertEqual(LXRGB(0x00FFFF), UIColor.cyanColor())
        XCTAssertEqual(LXRGB(0xFF00FF), UIColor.magentaColor())
    }
    
    func testEqualObjects() {
        XCTAssertTrue(LXEqualObjects(nil, nil))
        XCTAssertTrue(LXEqualObjects(NSNumber(integer: 1), NSNumber(integer: 1)))
        XCTAssertTrue(LXEqualObjects(1, 1))
        XCTAssertTrue(LXEqualObjects("Hello", "Hello"))
        XCTAssertFalse(LXEqualObjects(1, nil))
        XCTAssertFalse(LXEqualObjects(nil, 1))
        XCTAssertFalse(LXEqualObjects(1, 2))
        XCTAssertFalse(LXEqualObjects("Hello", "World"))
    }
}
