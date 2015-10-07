//
//  LXDateTransformersTests.swift
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 21/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

import XCTest

class LXISO8601DateTransformerTests: XCTestCase {
    let localTimeZone = NSTimeZone.localTimeZone()
    
    let newYorkTimeZone = NSTimeZone(forSecondsFromGMT: -4 * 60 * 60)
    let londonTimeZone = NSTimeZone(forSecondsFromGMT: 0)
    let singaporeTimeZone = NSTimeZone(forSecondsFromGMT: 8 * 60 * 60)
    
    let date001 = NSDate(timeIntervalSince1970: 1434911058) // 2015-06-21T18:24:18+0000
    
    override func setUp() {
        super.setUp()
        
        NSTimeZone.setDefaultTimeZone(NSTimeZone.systemTimeZone())
    }
    
    override func tearDown() {
        super.tearDown()
        
        NSTimeZone.setDefaultTimeZone(NSTimeZone.systemTimeZone())
    }
    
    /**
     * This test case illustrates that a copy of local time zone is a
     * snapshot of the time zone at the point of copy, not one that
     * always return the current default time zone.
     */
    func testCopyLocalTimeZone() {
        NSTimeZone.setDefaultTimeZone(newYorkTimeZone)
        XCTAssertEqual(newYorkTimeZone, localTimeZone)
        
        NSTimeZone.setDefaultTimeZone(londonTimeZone)
        XCTAssertEqual(londonTimeZone, localTimeZone)
        
        let copiedLocalTimeZone = localTimeZone.copy() as! NSTimeZone
        
        NSTimeZone.setDefaultTimeZone(singaporeTimeZone)
        XCTAssertEqual(singaporeTimeZone, localTimeZone)
        XCTAssertNotEqual(localTimeZone, copiedLocalTimeZone)
    }
    
    func testNew() {
        let iso8601DateTransformer = LXISO8601DateTransformer()
        
        XCTAssertNil(iso8601DateTransformer.transformedValue(nil))
        XCTAssertNil(iso8601DateTransformer.transformedValue(1))
        
        if let date = iso8601DateTransformer.transformedValue(date001) {
            XCTAssertEqual(date, date001)
        } else {
            XCTFail()
        }
        
        if let date = iso8601DateTransformer.transformedValue("2015-06-22T02:24:18+0800") {
            XCTAssertEqual(date, date001)
        } else {
            XCTFail()
        }
        
        XCTAssertTrue(LXISO8601DateTransformer.allowsReverseTransformation())
        
        XCTAssertNil(iso8601DateTransformer.reverseTransformedValue(nil))
        XCTAssertNil(iso8601DateTransformer.reverseTransformedValue(1))
        
        NSTimeZone.setDefaultTimeZone(self.newYorkTimeZone)
        if let string = iso8601DateTransformer.reverseTransformedValue(date001) {
            XCTAssertEqual(string, "2015-06-21T14:24:18-0400")
        } else {
            XCTFail()
        }
        
        NSTimeZone.setDefaultTimeZone(self.londonTimeZone)
        if let string = iso8601DateTransformer.reverseTransformedValue(date001) {
            XCTAssertEqual(string, "2015-06-21T18:24:18+0000")
        } else {
            XCTFail()
        }
        
        NSTimeZone.setDefaultTimeZone(self.singaporeTimeZone)
        if let string = iso8601DateTransformer.reverseTransformedValue(date001) {
            XCTAssertEqual(string, "2015-06-22T02:24:18+0800")
        } else {
            XCTFail()
        }
    }
    
    func testNewWithTimeZone() {
        let iso8601DateTransformer = LXISO8601DateTransformer(timeZone: self.singaporeTimeZone)
        
        NSTimeZone.setDefaultTimeZone(self.londonTimeZone)
        if let string = iso8601DateTransformer.reverseTransformedValue(date001) {
            XCTAssertEqual(string, "2015-06-22T02:24:18+0800")
        } else {
            XCTFail()
        }
    }
    
    func testForName() {
        if let iso8601DateTransformer = NSValueTransformer(forName: LXISO8601DateTransformerName) as? LXISO8601DateTransformer {
            XCTAssertNil(iso8601DateTransformer.transformedValue(nil))
            XCTAssertNil(iso8601DateTransformer.transformedValue(1))
            
            if let date = iso8601DateTransformer.transformedValue("2015-06-22T02:24:18+0800") {
                XCTAssertEqual(date, date001)
            } else {
                XCTFail()
            }
            
            XCTAssertTrue(LXISO8601DateTransformer.allowsReverseTransformation())
            
            XCTAssertNil(iso8601DateTransformer.reverseTransformedValue(nil))
            XCTAssertNil(iso8601DateTransformer.reverseTransformedValue(1))
            
            NSTimeZone.setDefaultTimeZone(self.newYorkTimeZone)
            if let string = iso8601DateTransformer.reverseTransformedValue(date001) {
                XCTAssertEqual(string, "2015-06-21T14:24:18-0400")
            } else {
                XCTFail()
            }
        } else {
            XCTFail()
        }
    }
    
    func testSharedTransformer() {
        let iso8601DateTransformer = LXISO8601DateTransformer.sharedTransformer()
        
        XCTAssertNil(iso8601DateTransformer.transformedValue(nil))
        XCTAssertNil(iso8601DateTransformer.transformedValue(1))
        
        if let date = iso8601DateTransformer.transformedValue("2015-06-22T02:24:18+0800") {
            XCTAssertEqual(date, date001)
        } else {
            XCTFail()
        }
        
        XCTAssertTrue(LXISO8601DateTransformer.allowsReverseTransformation())
        
        XCTAssertNil(iso8601DateTransformer.reverseTransformedValue(nil))
        XCTAssertNil(iso8601DateTransformer.reverseTransformedValue(1))
        
        NSTimeZone.setDefaultTimeZone(self.newYorkTimeZone)
        if let string = iso8601DateTransformer.reverseTransformedValue(date001) {
            XCTAssertEqual(string, "2015-06-21T14:24:18-0400")
        } else {
            XCTFail()
        }
    }
    
    func testFromToValue() {
        XCTAssertNil(LXISO8601DateTransformer.fromValue(nil))
        XCTAssertNil(LXISO8601DateTransformer.fromValue(1))
        
        if let date = LXISO8601DateTransformer.fromValue("2015-06-22T02:24:18+0800") {
            XCTAssertEqual(date, date001)
        } else {
            XCTFail()
        }
        
        XCTAssertTrue(LXISO8601DateTransformer.allowsReverseTransformation())
        
        XCTAssertNil(LXISO8601DateTransformer.toValue(nil))
        XCTAssertNil(LXISO8601DateTransformer.toValue(1))
        
        NSTimeZone.setDefaultTimeZone(self.newYorkTimeZone)
        if let string = LXISO8601DateTransformer.toValue(date001) {
            XCTAssertEqual(string, "2015-06-21T14:24:18-0400")
        } else {
            XCTFail()
        }
    }
    
    func testTransformedValueClass() {
        let expectedClass: AnyClass = LXISO8601DateTransformer.transformedValueClass()
        if let result = LXISO8601DateTransformer.sharedTransformer().transformedValue("2015-06-22T02:24:18+0800") {
            XCTAssertTrue(result.isKindOfClass(expectedClass))
        } else {
            XCTFail()
        }
    }
    
    func testVariations() {
        let iso8601DateTransformer = LXISO8601DateTransformer.sharedTransformer()
        
        if let date = iso8601DateTransformer.transformedValue("2015-06-22T02:24:18+0800") {
            XCTAssertEqual(date, date001)
        } else {
            XCTFail()
        }
        
        if let date = iso8601DateTransformer.transformedValue("2015-06-22T02:24:18+08:00") {
            XCTAssertEqual(date, date001)
        } else {
            XCTFail()
        }
        
        if let date = iso8601DateTransformer.transformedValue("2015-06-22T02:24:18+08") {
            XCTAssertEqual(date, date001)
        } else {
            XCTFail()
        }
        
        if let date = iso8601DateTransformer.transformedValue("2015-06-21T18:24:18Z") {
            XCTAssertEqual(date, date001)
        } else {
            XCTFail()
        }
    }
}

class LXRFC1123DateTransformerTests: XCTestCase {
    let date001 = NSDate(timeIntervalSince1970: 1434911058) // Sun, 21 Jun 2015 18:24:18 GMT
    
    func testFromToValue() {
        XCTAssertNil(LXRFC1123DateTransformer.fromValue(nil))
        XCTAssertNil(LXRFC1123DateTransformer.fromValue(1))
        
        XCTAssertEqual(LXRFC1123DateTransformer.fromValue("Sun, 21 Jun 2015 18:24:18 GMT")!, date001)
        
        XCTAssertTrue(LXRFC1123DateTransformer.allowsReverseTransformation())
        
        XCTAssertEqual(LXRFC1123DateTransformer.toValue(date001), "Sun, 21 Jun 2015 18:24:18 GMT")
    }
}
