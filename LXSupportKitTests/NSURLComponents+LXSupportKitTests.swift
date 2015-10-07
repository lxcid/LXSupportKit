//
//  LXURLComponentsTests.swift
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 24/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

import XCTest

class LXURLQueryItemTests: XCTestCase {
    func testHashAndEquality() {
        let queryItem1 = LXURLQueryItem()
        XCTAssertEqual(queryItem1, queryItem1)
        XCTAssertFalse(queryItem1.isEqual(NSURL()))
        XCTAssertEqual(queryItem1, LXURLQueryItem())
        
        let queryItem2 = LXURLQueryItem(name: "hello", value: "world")
        XCTAssertNotEqual(queryItem1, queryItem2)
        XCTAssertEqual(queryItem2, LXURLQueryItem(name: "hello", value: "world"))
        
        var queryItems = Set<LXURLQueryItem>()
        XCTAssertEqual(queryItems.count, 0)
        queryItems.insert(queryItem1)
        XCTAssertEqual(queryItems.count, 1)
        queryItems.insert(queryItem2)
        XCTAssertEqual(queryItems.count, 2)
        queryItems.insert(LXURLQueryItem())
        XCTAssertEqual(queryItems.count, 2)
        queryItems.insert(LXURLQueryItem(name: "hello", value: "world"))
        XCTAssertEqual(queryItems.count, 2)
    }
    
    func testCopying() {
        let queryItem1 = LXURLQueryItem()
        let queryItem2 = queryItem1.copy() as! LXURLQueryItem
        XCTAssertTrue(queryItem1 === queryItem2)
    }
    
    func testDescription() {
        XCTAssertNotNil(LXURLQueryItem().description)
    }
    
    func testCoding() {
        let queryItem1 = LXURLQueryItem(name: "hello", value: "world")
        
        let data = NSMutableData()
        
        let keyedArchiver = NSKeyedArchiver(forWritingWithMutableData: data)
        keyedArchiver.requiresSecureCoding = true
        keyedArchiver.encodeObject(queryItem1, forKey: "hello world")
        keyedArchiver.finishEncoding()
        
        let keyedUnarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        let queryItem2 = keyedUnarchiver.decodeObjectForKey("hello world") as! LXURLQueryItem
        XCTAssertEqual(queryItem1, queryItem2)
        keyedUnarchiver.finishDecoding()
    }
}

class NSURLComponents_LXSupportKitTests: XCTestCase {
    func testConstructingQueryItems() {
        let urlComponents = NSURLComponents()
        urlComponents.lx_queryItems = [LXURLQueryItem](arrayLiteral:
            LXURLQueryItem(),
            LXURLQueryItem(name: "", value: nil),
            LXURLQueryItem(name: "", value: ""),
            LXURLQueryItem(name: "say", value: "hahahahah?"),
            LXURLQueryItem(name: "base64", value: "aGFoYWhhaGFoPw==")
        )
        XCTAssertEqual(urlComponents.query!, "&&=&say=hahahahah?&base64=aGFoYWhhaGFoPw==")
        XCTAssertEqual(urlComponents.percentEncodedQuery!, "&&=&say=hahahahah?&base64=aGFoYWhhaGFoPw%3D%3D")
    }
    
    func testNoQuery() {
        let urlComponents = NSURLComponents()
        urlComponents.lx_queryItems = nil
        
        XCTAssertNil(urlComponents.query)
        XCTAssertNil(urlComponents.lx_queryItems)
    }
    
    func testEmptyQuery() {
        let urlComponents = NSURLComponents()
        urlComponents.lx_queryItems = []
        
        XCTAssertEqual(urlComponents.query!, "")
        XCTAssertTrue((urlComponents.lx_queryItems! as NSArray).isEqual([]))
    }
    
    func testExtractingQueryItems() {
        let urlComponents = NSURLComponents()
        urlComponents.query = "&&=&hello&world=&say=hahahahah?&base64=aGFoYWhhaGFoPw=="
        XCTAssertEqual(urlComponents.lx_queryItems! as! [LXURLQueryItem], [
            LXURLQueryItem(),
            LXURLQueryItem(),
            LXURLQueryItem(name: "", value: ""),
            LXURLQueryItem(name: "hello", value: nil),
            LXURLQueryItem(name: "world", value: ""),
            LXURLQueryItem(name: "say", value: "hahahahah?"),
            LXURLQueryItem(name: "base64", value: "aGFoYWhhaGFoPw==")
        ])
    }
    
    func testQueryWithURL() {
        if let urlComponents = NSURLComponents(string: "https://www.facebook.com/login.php?next=https%3A%2F%2Fwww.facebook.com%2Fgroups%2Fiosdevscout%2F%3Fref%3Dbookmarks") {
            XCTAssertEqual(urlComponents.scheme!, "https")
            XCTAssertEqual(urlComponents.host!, "www.facebook.com")
            XCTAssertEqual(urlComponents.path!, "/login.php")
            XCTAssertEqual(urlComponents.query!, "next=https://www.facebook.com/groups/iosdevscout/?ref=bookmarks")
            if let queryItems = urlComponents.lx_queryItems as! [LXURLQueryItem]? {
                XCTAssertEqual(queryItems.count, 1)
                XCTAssertEqual(queryItems, [LXURLQueryItem(name: "next", value: "https://www.facebook.com/groups/iosdevscout/?ref=bookmarks")])
            }
        } else {
            XCTFail()
        }
    }
    
    func testString() {
        if let urlComponents = NSURLComponents(string: "https://www.facebook.com/login.php?next=https%3A%2F%2Fwww.facebook.com%2Fgroups%2Fiosdevscout%2F%3Fref%3Dbookmarks") {
            XCTAssertEqual(urlComponents.lx_string!, "https://www.facebook.com/login.php?next=https%3A%2F%2Fwww.facebook.com%2Fgroups%2Fiosdevscout%2F%3Fref%3Dbookmarks")
            // FIXME: (stan@minus.com) Only available for Xcode 7.
//            if #available(iOS 8.0, *) {
//                XCTAssertEqual(urlComponents.lx_string!, urlComponents.string!)
//            }
        } else {
            XCTFail()
        }
    }
}
