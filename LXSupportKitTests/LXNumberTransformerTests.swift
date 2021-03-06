//
//  LXNumberTransformerTests.swift
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 21/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

import XCTest

class LXNumberTransformerTests: XCTestCase {
    func testNew() {
        let numberTransformer = LXNumberTransformer()
        
        XCTAssertNil(numberTransformer.transformedValue(nil))
        XCTAssertNil(numberTransformer.transformedValue(NSDate()))
        XCTAssertEqual(numberTransformer.transformedValue(123)!, 123)
        XCTAssertEqual(numberTransformer.transformedValue("456")!, 456)
        XCTAssertEqual(numberTransformer.transformedValue(1.23)!, 1.23)
        XCTAssertEqual(numberTransformer.transformedValue("4.56")!, 4.56)
        
        XCTAssertTrue(LXNumberTransformer.allowsReverseTransformation())
        
        XCTAssertNil(numberTransformer.reverseTransformedValue(nil))
        XCTAssertEqual(numberTransformer.reverseTransformedValue(123)!, "123")
        XCTAssertNil(numberTransformer.reverseTransformedValue("456"))
        XCTAssertEqual(numberTransformer.reverseTransformedValue(1.23)!, "1.23")
        XCTAssertNil(numberTransformer.reverseTransformedValue("4.56"))
    }
    
    func testForName() {
        if let numberTransformer = NSValueTransformer(forName: LXNumberTransformerName) as? LXNumberTransformer {
            XCTAssertNil(numberTransformer.transformedValue(nil))
            XCTAssertNil(numberTransformer.transformedValue(NSDate()))
            XCTAssertEqual(numberTransformer.transformedValue(123)!, 123)
            XCTAssertEqual(numberTransformer.transformedValue("456")!, 456)
            XCTAssertEqual(numberTransformer.transformedValue(1.23)!, 1.23)
            XCTAssertEqual(numberTransformer.transformedValue("4.56")!, 4.56)
            
            XCTAssertTrue(LXNumberTransformer.allowsReverseTransformation())
            
            XCTAssertNil(numberTransformer.reverseTransformedValue(nil))
            XCTAssertEqual(numberTransformer.reverseTransformedValue(123)!, "123")
            XCTAssertNil(numberTransformer.reverseTransformedValue("456"))
            XCTAssertEqual(numberTransformer.reverseTransformedValue(1.23)!, "1.23")
            XCTAssertNil(numberTransformer.reverseTransformedValue("4.56"))
        } else {
            XCTFail()
        }
    }
    
    func testSharedTransformer() {
        let numberTransformer = LXNumberTransformer.sharedTransformer()
        
        XCTAssertNil(numberTransformer.transformedValue(nil))
        XCTAssertNil(numberTransformer.transformedValue(NSDate()))
        XCTAssertEqual(numberTransformer.transformedValue(123)!, 123)
        XCTAssertEqual(numberTransformer.transformedValue("456")!, 456)
        XCTAssertEqual(numberTransformer.transformedValue(1.23)!, 1.23)
        XCTAssertEqual(numberTransformer.transformedValue("4.56")!, 4.56)
        
        XCTAssertTrue(LXNumberTransformer.allowsReverseTransformation())
        
        XCTAssertNil(numberTransformer.reverseTransformedValue(nil))
        XCTAssertEqual(numberTransformer.reverseTransformedValue(123)!, "123")
        XCTAssertNil(numberTransformer.reverseTransformedValue("456"))
        XCTAssertEqual(numberTransformer.reverseTransformedValue(1.23)!, "1.23")
        XCTAssertNil(numberTransformer.reverseTransformedValue("4.56"))
    }
    
    func testFromToValue() {
        
        XCTAssertNil(LXNumberTransformer.fromValue(nil))
        XCTAssertNil(LXNumberTransformer.fromValue(NSDate()))
        XCTAssertEqual(LXNumberTransformer.fromValue(123)!, 123)
        XCTAssertEqual(LXNumberTransformer.fromValue("456")!, 456)
        XCTAssertEqual(LXNumberTransformer.fromValue(1.23)!, 1.23)
        XCTAssertEqual(LXNumberTransformer.fromValue("4.56")!, 4.56)
        
        XCTAssertTrue(LXNumberTransformer.allowsReverseTransformation())
        
        XCTAssertNil(LXNumberTransformer.toValue(nil))
        XCTAssertEqual(LXNumberTransformer.toValue(123)!, "123")
        XCTAssertNil(LXNumberTransformer.toValue("456"))
        XCTAssertEqual(LXNumberTransformer.toValue(1.23)!, "1.23")
        XCTAssertNil(LXNumberTransformer.toValue("4.56"))
    }
    
    func testTransformedValueClass() {
        let expectedClass: AnyClass = LXNumberTransformer.transformedValueClass()
        if let result = LXNumberTransformer.sharedTransformer().transformedValue("1") {
            XCTAssertTrue(result.isKindOfClass(expectedClass))
        } else {
            XCTFail()
        }
    }
}
