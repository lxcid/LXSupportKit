//
//  LXKeyValueObserverTests.swift
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 19/6/15.
//  Copyright (c) 2015 lxcid. All rights reserved.
//

import XCTest

class LXMockTarget: NSObject {
    dynamic var hit = false
}

class LXMockObservee: NSObject {
    let expectation: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    func action(anyObject: AnyObject) {
        self.expectation.fulfill()
    }
}

class LXKeyValueObserverTests: XCTestCase {
    func testObserver() {
        let expectation = self.expectationWithDescription("observe target being hit")
        
        var context: UInt8 = 0
        let target = LXMockTarget()
        let observee = LXMockObservee(expectation: expectation)
        let observer = LXKeyValueObserver(target: target, keyPaths: ["hit"], delegate: observee, action: Selector("action:"), context: &context)
        
        target.hit = true
        
        self.waitForExpectationsWithTimeout(1.0, handler: { error in
            print((observer, error))
        })
    }
}
