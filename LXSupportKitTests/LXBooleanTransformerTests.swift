//
//  LXBooleanTransformerTests.swift
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 22/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

import XCTest

class LXBooleanTransformerTests: XCTestCase {
    func testNew() {
        let booleanTransformer = LXBooleanTransformer()
        
        XCTAssertNil(booleanTransformer.transformedValue(nil))
        XCTAssertNil(booleanTransformer.transformedValue(NSDate()))
        XCTAssertEqual(booleanTransformer.transformedValue("true")!, true)
        XCTAssertEqual(booleanTransformer.transformedValue("false")!, false)
        XCTAssertEqual(booleanTransformer.transformedValue("yes")!, true)
        XCTAssertEqual(booleanTransformer.transformedValue("no")!, false)
        XCTAssertEqual(booleanTransformer.transformedValue("1")!, true)
        XCTAssertEqual(booleanTransformer.transformedValue("0")!, false)
        XCTAssertEqual(booleanTransformer.transformedValue("999")!, true)
        XCTAssertEqual(booleanTransformer.transformedValue("-999")!, true)
        XCTAssertNil(booleanTransformer.transformedValue("a"))
        XCTAssertEqual(booleanTransformer.transformedValue(true)!, true)
        XCTAssertEqual(booleanTransformer.transformedValue(false)!, false)
        XCTAssertEqual(booleanTransformer.transformedValue(1)!, true)
        XCTAssertEqual(booleanTransformer.transformedValue(0)!, false)
        XCTAssertEqual(booleanTransformer.transformedValue(999)!, true)
        XCTAssertEqual(booleanTransformer.transformedValue(-999)!, true)
        
        XCTAssertFalse(LXBooleanTransformer.allowsReverseTransformation())
        
        // FIXME: (me@lxcid.com) booleanTransformer.reverseTransformedValue(true)
    }
    
    func testForName() {
        if let booleanTransformer = NSValueTransformer(forName: LXBooleanTransformerName) as? LXBooleanTransformer {
            XCTAssertNil(booleanTransformer.transformedValue(nil))
            XCTAssertNil(booleanTransformer.transformedValue(NSDate()))
            XCTAssertEqual(booleanTransformer.transformedValue("true")!, true)
            XCTAssertEqual(booleanTransformer.transformedValue("false")!, false)
            XCTAssertEqual(booleanTransformer.transformedValue("yes")!, true)
            XCTAssertEqual(booleanTransformer.transformedValue("no")!, false)
            XCTAssertEqual(booleanTransformer.transformedValue("1")!, true)
            XCTAssertEqual(booleanTransformer.transformedValue("0")!, false)
            XCTAssertEqual(booleanTransformer.transformedValue("999")!, true)
            XCTAssertEqual(booleanTransformer.transformedValue("-999")!, true)
            XCTAssertNil(booleanTransformer.transformedValue("a"))
            XCTAssertEqual(booleanTransformer.transformedValue(true)!, true)
            XCTAssertEqual(booleanTransformer.transformedValue(false)!, false)
            XCTAssertEqual(booleanTransformer.transformedValue(1)!, true)
            XCTAssertEqual(booleanTransformer.transformedValue(0)!, false)
            XCTAssertEqual(booleanTransformer.transformedValue(999)!, true)
            XCTAssertEqual(booleanTransformer.transformedValue(-999)!, true)
            
            XCTAssertFalse(LXBooleanTransformer.allowsReverseTransformation())
            
            // FIXME: (me@lxcid.com) booleanTransformer.reverseTransformedValue(true)
        } else {
            XCTFail()
        }
    }
    
    func testSharedTransformer() {
        let booleanTransformer = LXBooleanTransformer.sharedTransformer()
        
        XCTAssertNil(booleanTransformer.transformedValue(nil))
        XCTAssertNil(booleanTransformer.transformedValue(NSDate()))
        XCTAssertEqual(booleanTransformer.transformedValue("true")!, true)
        XCTAssertEqual(booleanTransformer.transformedValue("false")!, false)
        XCTAssertEqual(booleanTransformer.transformedValue("yes")!, true)
        XCTAssertEqual(booleanTransformer.transformedValue("no")!, false)
        XCTAssertEqual(booleanTransformer.transformedValue("1")!, true)
        XCTAssertEqual(booleanTransformer.transformedValue("0")!, false)
        XCTAssertEqual(booleanTransformer.transformedValue("999")!, true)
        XCTAssertEqual(booleanTransformer.transformedValue("-999")!, true)
        XCTAssertNil(booleanTransformer.transformedValue("a"))
        XCTAssertEqual(booleanTransformer.transformedValue(true)!, true)
        XCTAssertEqual(booleanTransformer.transformedValue(false)!, false)
        XCTAssertEqual(booleanTransformer.transformedValue(1)!, true)
        XCTAssertEqual(booleanTransformer.transformedValue(0)!, false)
        XCTAssertEqual(booleanTransformer.transformedValue(999)!, true)
        XCTAssertEqual(booleanTransformer.transformedValue(-999)!, true)
        
        XCTAssertFalse(LXBooleanTransformer.allowsReverseTransformation())
        
        // FIXME: (me@lxcid.com) booleanTransformer.reverseTransformedValue(true)
    }
    
    func testFromValue() {
        XCTAssertNil(LXBooleanTransformer.fromValue(nil))
        XCTAssertNil(LXBooleanTransformer.fromValue(NSDate()))
        XCTAssertEqual(LXBooleanTransformer.fromValue("true")!, true)
        XCTAssertEqual(LXBooleanTransformer.fromValue("false")!, false)
        XCTAssertEqual(LXBooleanTransformer.fromValue("yes")!, true)
        XCTAssertEqual(LXBooleanTransformer.fromValue("no")!, false)
        XCTAssertEqual(LXBooleanTransformer.fromValue("1")!, true)
        XCTAssertEqual(LXBooleanTransformer.fromValue("0")!, false)
        XCTAssertEqual(LXBooleanTransformer.fromValue("999")!, true)
        XCTAssertEqual(LXBooleanTransformer.fromValue("-999")!, true)
        XCTAssertNil(LXBooleanTransformer.fromValue("a"))
        XCTAssertEqual(LXBooleanTransformer.fromValue(true)!, true)
        XCTAssertEqual(LXBooleanTransformer.fromValue(false)!, false)
        XCTAssertEqual(LXBooleanTransformer.fromValue(1)!, true)
        XCTAssertEqual(LXBooleanTransformer.fromValue(0)!, false)
        XCTAssertEqual(LXBooleanTransformer.fromValue(999)!, true)
        XCTAssertEqual(LXBooleanTransformer.fromValue(-999)!, true)
        
        XCTAssertFalse(LXBooleanTransformer.allowsReverseTransformation())
        
        // FIXME: (me@lxcid.com) booleanTransformer.reverseTransformedValue(true)
    }
    
    func testTransformedValueClass() {
        let expectedClass: AnyClass = LXBooleanTransformer.transformedValueClass()
        if let result = LXBooleanTransformer.sharedTransformer().transformedValue("true") {
            XCTAssertTrue(result.isKindOfClass(expectedClass))
        } else {
            XCTFail()
        }
    }
}
