//
//  LXScrollViewObserverTests.swift
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 20/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

import Foundation
import XCTest

class LXMockObserverDelegate: NSObject, LXScrollViewObserverDelegate {
    let expectation: XCTestExpectation
    var offset = CGPointZero
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    func observedScrollViewDidScroll(scrollView: UIScrollView) {
        self.offset = scrollView.contentOffset
        self.expectation.fulfill()
    }
}

class LXScrollViewObserverTests: XCTestCase {
    func testObserver() {
        let expectation = self.expectationWithDescription("observe scroll view content offset being adjusted to (5, 5)")
        
        let scrollView = UIScrollView(frame: CGRectMake(0.0, 0.0, 100.0, 100.0))
        let observerDelegate = LXMockObserverDelegate(expectation: expectation)
        
        let observer = LXScrollViewObserver(targetView: scrollView, delegate: observerDelegate)
        
        scrollView.contentOffset = CGPointMake(5.0, 5.0)
        self.waitForExpectationsWithTimeout(1.0, handler: { (error) in
            XCTAssertEqual(CGPointMake(5.0, 5.0), observerDelegate.offset)
        })
    }

}
