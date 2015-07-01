//
//  LXStringTransformersTests.swift
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 1/7/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

import UIKit
import XCTest

class LXStringTransformerTests: XCTestCase {
    func testNew() {
        let stringTransformer = LXStringTransformer()
        
        XCTAssertNil(stringTransformer.transformedValue(nil))
        XCTAssertEqual(stringTransformer.transformedValue(123)!, "123")
        XCTAssertEqual(stringTransformer.transformedValue("456")!, "456")
        
        let strictStringTransformer = LXStringTransformer(strict: true)
        
        XCTAssertNil(strictStringTransformer.transformedValue(nil))
        XCTAssertNil(strictStringTransformer.transformedValue(123))
        XCTAssertEqual(strictStringTransformer.transformedValue("456")!, "456")
        
        XCTAssertFalse(LXStringTransformer.allowsReverseTransformation())
    }
    
    func testForName() {
        if let stringTransformer = NSValueTransformer(forName: LXStringTransformerName) as? LXStringTransformer {
            XCTAssertNil(stringTransformer.transformedValue(nil))
            XCTAssertEqual(stringTransformer.transformedValue(123)!, "123")
            XCTAssertEqual(stringTransformer.transformedValue("456")!, "456")
            
            XCTAssertFalse(LXStringTransformer.allowsReverseTransformation())
        } else {
            XCTFail()
        }
    }

    func testSharedTransformer() {
        let stringTransformer = LXStringTransformer.sharedTransformer()
        
        XCTAssertNil(stringTransformer.transformedValue(nil))
        XCTAssertEqual(stringTransformer.transformedValue(123)!, "123")
        XCTAssertEqual(stringTransformer.transformedValue("456")!, "456")
        
        XCTAssertFalse(LXStringTransformer.allowsReverseTransformation())
    }

    func testFromValue() {
        XCTAssertNil(LXStringTransformer.fromValue(nil))
        XCTAssertEqual(LXStringTransformer.fromValue(123)!, "123")
        XCTAssertEqual(LXStringTransformer.fromValue("456")!, "456")
        
        XCTAssertFalse(LXStringTransformer.allowsReverseTransformation())
    }

    func testTransformedValueClass() {
        let expectedClass: AnyClass = LXStringTransformer.transformedValueClass()
        if let result = LXStringTransformer.sharedTransformer().transformedValue("1") {
            XCTAssertTrue(result.isKindOfClass(expectedClass))
        } else {
            XCTFail()
        }
    }
}

class LXStrictStringTransformerTests: XCTestCase {
    func testNew() {
        var strictStringTransformer = LXStrictStringTransformer()
        
        XCTAssertNil(strictStringTransformer.transformedValue(nil))
        XCTAssertNil(strictStringTransformer.transformedValue(123))
        XCTAssertEqual(strictStringTransformer.transformedValue("456")!, "456")
        
        strictStringTransformer = LXStrictStringTransformer(strict: true)
        
        XCTAssertNil(strictStringTransformer.transformedValue(nil))
        XCTAssertNil(strictStringTransformer.transformedValue(123))
        XCTAssertEqual(strictStringTransformer.transformedValue("456")!, "456")
        
        XCTAssertFalse(LXStrictStringTransformer.allowsReverseTransformation())
    }
    
    func testForName() {
        if let strictStringTransformer = NSValueTransformer(forName: LXStrictStringTransformerName) as? LXStrictStringTransformer {
            XCTAssertNil(strictStringTransformer.transformedValue(nil))
            XCTAssertNil(strictStringTransformer.transformedValue(123))
            XCTAssertEqual(strictStringTransformer.transformedValue("456")!, "456")
            
            XCTAssertFalse(LXStrictStringTransformer.allowsReverseTransformation())
        } else {
            XCTFail()
        }
    }
    
    func testSharedTransformer() {
        let strictStringTransformer = LXStrictStringTransformer.sharedTransformer()
        
        XCTAssertNil(strictStringTransformer.transformedValue(nil))
        XCTAssertNil(strictStringTransformer.transformedValue(123))
        XCTAssertEqual(strictStringTransformer.transformedValue("456")!, "456")
        
        XCTAssertFalse(LXStrictStringTransformer.allowsReverseTransformation())
    }
    
    func testFromValue() {
        XCTAssertNil(LXStrictStringTransformer.fromValue(nil))
        XCTAssertNil(LXStrictStringTransformer.fromValue(123))
        XCTAssertEqual(LXStrictStringTransformer.fromValue("456")!, "456")
        
        XCTAssertFalse(LXStrictStringTransformer.allowsReverseTransformation())
    }
    
    func testTransformedValueClass() {
        let expectedClass: AnyClass = LXStrictStringTransformer.transformedValueClass()
        if let result = LXStrictStringTransformer.sharedTransformer().transformedValue("1") {
            XCTAssertTrue(result.isKindOfClass(expectedClass))
        } else {
            XCTFail()
        }
    }
}
