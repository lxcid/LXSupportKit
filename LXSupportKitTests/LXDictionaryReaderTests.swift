//
//  LXDictionaryReaderTests.swift
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 30/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

import UIKit
import XCTest

class LXDictionaryReaderTests: XCTestCase {
    func testDictionaryReader() {
        let reader = LXDictionaryReader(dictionary: [
            "ISO8601Date" : "2015-06-21T18:24:18+0000",
            "one" : 1,
            "true" : true
        ])
        XCTAssertEqual(reader.numberForKey("one")!, 1)
        XCTAssertEqual(reader.booleanForKey("true")!, true)
        XCTAssertEqual(reader.iso8601DateForKey("ISO8601Date")!, NSDate(timeIntervalSince1970: 1434911058))
    }
}
