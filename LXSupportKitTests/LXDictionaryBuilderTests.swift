//
//  LXDictionaryBuilderTests.swift
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 21/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

import XCTest

class LXDictionaryBuilderTests: XCTestCase {
    func testNew() {
        let builder = LXDictionaryBuilder()
        
        XCTAssertTrue((builder.dictionary as NSDictionary).isEqual([:]))
        
        builder["nil"] = nil;
        XCTAssertTrue((builder.dictionary as NSDictionary).isEqual([:]))
        
        builder["one"] = 1;
        XCTAssertTrue((builder.dictionary as NSDictionary).isEqual(["one" : 1]))
        
        builder.setObject(2, forKey: "two")
        XCTAssertTrue((builder.dictionary as NSDictionary).isEqual(["one" : 1, "two" : 2]))
        
        if let two = builder["two"] as? Int {
            XCTAssertEqual(two, 2)
        } else {
            XCTFail()
        }
        
        if let one = builder.objectForKey("one") as? Int {
            XCTAssertEqual(one, 1)
        } else {
            XCTFail()
        }
        
        builder["one"] = nil
        XCTAssertTrue((builder.dictionary as NSDictionary).isEqual(["two" : 2]))
        
        builder.setObject(nil, forKey: "two")
        XCTAssertTrue((builder.dictionary as NSDictionary).isEqual([:]))
    }
    
    func testFromDictionary() {
        let builder = LXDictionaryBuilder(dictionary: ["one" : 1, "two" : 2])
        XCTAssertTrue((builder.dictionary as NSDictionary).isEqual(["one" : 1, "two" : 2]))
        
        builder["nil"] = nil;
        XCTAssertTrue((builder.dictionary as NSDictionary).isEqual(["one" : 1, "two" : 2]))
        
        builder["three"] = 3;
        XCTAssertTrue((builder.dictionary as NSDictionary).isEqual(["one" : 1, "two" : 2, "three" : 3]))
        
        builder.setObject(NSNull(), forKey: "null")
        XCTAssertTrue((builder.dictionary as NSDictionary).isEqual(["one" : 1, "two" : 2, "three" : 3, "null" : NSNull()]))
    }
}
