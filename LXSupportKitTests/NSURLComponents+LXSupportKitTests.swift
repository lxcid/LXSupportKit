//
//  LXURLComponentsTests.swift
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 24/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

import XCTest

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
