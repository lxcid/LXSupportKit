//
//  LXNumberTransformerTests.swift
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 21/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

import XCTest

class LXNumberTransformerTests: XCTestCase {
    func testAllocInit() {
        let numberTransformer = LXNumberTransformer()
        
        XCTAssertNil(numberTransformer.transformedValue(nil))
        XCTAssertEqual(numberTransformer.transformedValue(123)!, 123)
        XCTAssertEqual(numberTransformer.transformedValue("456")!, 456)
        XCTAssertEqual(numberTransformer.transformedValue(1.23)!, 1.23)
        XCTAssertEqual(numberTransformer.transformedValue("4.56")!, 4.56)
        
        XCTAssertNil(numberTransformer.reverseTransformedValue(nil))
        XCTAssertEqual(numberTransformer.reverseTransformedValue(123)!, "123")
        XCTAssertNil(numberTransformer.reverseTransformedValue("456"))
        XCTAssertEqual(numberTransformer.reverseTransformedValue(1.23)!, "1.23")
        XCTAssertNil(numberTransformer.reverseTransformedValue("4.56"))
    }
    
    func testSharedTransformer() {
        let numberTransformer = LXNumberTransformer.sharedTransformer()
        
        XCTAssertNil(numberTransformer.transformedValue(nil))
        XCTAssertEqual(numberTransformer.transformedValue(123)!, 123)
        XCTAssertEqual(numberTransformer.transformedValue("456")!, 456)
        XCTAssertEqual(numberTransformer.transformedValue(1.23)!, 1.23)
        XCTAssertEqual(numberTransformer.transformedValue("4.56")!, 4.56)
        
        XCTAssertNil(numberTransformer.reverseTransformedValue(nil))
        XCTAssertEqual(numberTransformer.reverseTransformedValue(123)!, "123")
        XCTAssertNil(numberTransformer.reverseTransformedValue("456"))
        XCTAssertEqual(numberTransformer.reverseTransformedValue(1.23)!, "1.23")
        XCTAssertNil(numberTransformer.reverseTransformedValue("4.56"))
    }
    
    func test() {
        if let numberTransformer = NSValueTransformer(forName: LXNumberTransformerName) as? LXNumberTransformer {
            XCTAssertNil(numberTransformer.transformedValue(nil))
            XCTAssertEqual(numberTransformer.transformedValue(123)!, 123)
            XCTAssertEqual(numberTransformer.transformedValue("456")!, 456)
            XCTAssertEqual(numberTransformer.transformedValue(1.23)!, 1.23)
            XCTAssertEqual(numberTransformer.transformedValue("4.56")!, 4.56)
            
            XCTAssertNil(numberTransformer.reverseTransformedValue(nil))
            XCTAssertEqual(numberTransformer.reverseTransformedValue(123)!, "123")
            XCTAssertNil(numberTransformer.reverseTransformedValue("456"))
            XCTAssertEqual(numberTransformer.reverseTransformedValue(1.23)!, "1.23")
            XCTAssertNil(numberTransformer.reverseTransformedValue("4.56"))
        } else {
            XCTFail()
        }
    }
}
