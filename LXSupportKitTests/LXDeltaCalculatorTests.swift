//
//  LXDeltaCalculatorTests.swift
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 18/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

import XCTest

class LXDeltaCalculatorTests: XCTestCase {
    func testEmptyOrNilArrays() {
        let oldArray = [1, 3, 5]
        let newArray = [0, 1, 2, 3, 4, 5, 6]
        
        let defaultCalculator = LXDeltaCalculator.defaultCalculator()
        
        do {
            let delta = defaultCalculator.deltaFromOldArray(nil, toNewArray: nil)
            XCTAssertTrue(delta.addedIndices.count == 0)
            XCTAssertTrue(delta.removedIndices.count == 0)
            XCTAssertTrue(delta.movedIndexPairs.count == 0)
            XCTAssertTrue(delta.unchangedIndexPairs.count == 0)
        }
        
        do {
            let delta = defaultCalculator.deltaFromOldArray([], toNewArray: [])
            XCTAssertTrue(delta.addedIndices.count == 0)
            XCTAssertTrue(delta.removedIndices.count == 0)
            XCTAssertTrue(delta.movedIndexPairs.count == 0)
            XCTAssertTrue(delta.unchangedIndexPairs.count == 0)
        }
        
        do {
            let delta = defaultCalculator.deltaFromOldArray(nil, toNewArray: [])
            XCTAssertTrue(delta.addedIndices.count == 0)
            XCTAssertTrue(delta.removedIndices.count == 0)
            XCTAssertTrue(delta.movedIndexPairs.count == 0)
            XCTAssertTrue(delta.unchangedIndexPairs.count == 0)
        }
        
        do {
            let delta = defaultCalculator.deltaFromOldArray([], toNewArray: nil)
            XCTAssertTrue(delta.addedIndices.count == 0)
            XCTAssertTrue(delta.removedIndices.count == 0)
            XCTAssertTrue(delta.movedIndexPairs.count == 0)
            XCTAssertTrue(delta.unchangedIndexPairs.count == 0)
        }
        
        do {
            let delta = defaultCalculator.deltaFromOldArray(nil, toNewArray: newArray)
            XCTAssertTrue(delta.addedIndices.count == 7)
            XCTAssertTrue(delta.removedIndices.count == 0)
            XCTAssertTrue(delta.movedIndexPairs.count == 0)
            XCTAssertTrue(delta.unchangedIndexPairs.count == 0)
        }
        
        do {
            let delta = defaultCalculator.deltaFromOldArray([], toNewArray: newArray)
            XCTAssertTrue(delta.addedIndices.count == 7)
            XCTAssertTrue(delta.removedIndices.count == 0)
            XCTAssertTrue(delta.movedIndexPairs.count == 0)
            XCTAssertTrue(delta.unchangedIndexPairs.count == 0)
        }
        
        do {
            let delta = defaultCalculator.deltaFromOldArray(oldArray, toNewArray: nil)
            XCTAssertTrue(delta.addedIndices.count == 0)
            XCTAssertTrue(delta.removedIndices.count == 3)
            XCTAssertTrue(delta.movedIndexPairs.count == 0)
            XCTAssertTrue(delta.unchangedIndexPairs.count == 0)
        }
        
        do {
            let delta = defaultCalculator.deltaFromOldArray(oldArray, toNewArray: [])
            XCTAssertTrue(delta.addedIndices.count == 0)
            XCTAssertTrue(delta.removedIndices.count == 3)
            XCTAssertTrue(delta.movedIndexPairs.count == 0)
            XCTAssertTrue(delta.unchangedIndexPairs.count == 0)
        }
    }
    
    func testInsertion() {
        let oldArray = [1, 3, 5]
        let newArray = [0, 1, 2, 3, 4, 5, 6]
        
        let defaultCalculator = LXDeltaCalculator.defaultCalculator()
        
        let delta = defaultCalculator.deltaFromOldArray(oldArray, toNewArray: newArray)
        XCTAssertTrue(delta.addedIndices.count == 4)
        XCTAssertTrue(delta.removedIndices.count == 0)
        XCTAssertTrue(delta.movedIndexPairs.count == 0)
        XCTAssertTrue(delta.unchangedIndexPairs.count == 3)
        
        let addedIndices = NSMutableIndexSet()
        addedIndices.addIndex(0)
        addedIndices.addIndex(2)
        addedIndices.addIndex(4)
        addedIndices.addIndex(6)
        XCTAssertTrue(delta.addedIndices == addedIndices)
        
        let unchangedIndexPairs = NSMutableArray()
        unchangedIndexPairs.addObject([0, 1])
        unchangedIndexPairs.addObject([1, 3])
        unchangedIndexPairs.addObject([2, 5])
        XCTAssertTrue(delta.unchangedIndexPairs == unchangedIndexPairs)
    }
    
    func testInsertionDuplicate() {
        let oldArray = [1, 3, 5]
        let newArray = [1, 1, 3, 3, 5, 5]
        
        let defaultCalculator = LXDeltaCalculator.defaultCalculator()
        
        let delta = defaultCalculator.deltaFromOldArray(oldArray, toNewArray: newArray)
        XCTAssertTrue(delta.addedIndices.count == 3)
        XCTAssertTrue(delta.removedIndices.count == 0)
        XCTAssertTrue(delta.movedIndexPairs.count == 0)
        XCTAssertTrue(delta.unchangedIndexPairs.count == 3)
        
        let addedIndices = NSMutableIndexSet()
        addedIndices.addIndex(1)
        addedIndices.addIndex(3)
        addedIndices.addIndex(5)
        XCTAssertTrue(delta.addedIndices == addedIndices)
        
        let unchangedIndexPairs = NSMutableArray()
        unchangedIndexPairs.addObject([0, 0])
        unchangedIndexPairs.addObject([1, 2])
        unchangedIndexPairs.addObject([2, 4])
        XCTAssertTrue(delta.unchangedIndexPairs == unchangedIndexPairs)
    }
    
    func testDeletion() {
        let oldArray = [0, 1, 2, 3, 4, 5, 6]
        let newArray = [1, 3, 5]
        
        let defaultCalculator = LXDeltaCalculator.defaultCalculator()
        
        let delta = defaultCalculator.deltaFromOldArray(oldArray, toNewArray: newArray)
        XCTAssertTrue(delta.addedIndices.count == 0)
        XCTAssertTrue(delta.removedIndices.count == 4)
        XCTAssertTrue(delta.movedIndexPairs.count == 0)
        XCTAssertTrue(delta.unchangedIndexPairs.count == 3)
    }
    
    func testDeleteDuplicate() {
        let oldArray = [1, 1, 3, 3, 5, 5]
        let newArray = [1, 3, 5]
        
        let defaultCalculator = LXDeltaCalculator.defaultCalculator()
        
        let delta = defaultCalculator.deltaFromOldArray(oldArray, toNewArray: newArray)
        XCTAssertTrue(delta.addedIndices.count == 0)
        XCTAssertTrue(delta.removedIndices.count == 3)
        XCTAssertTrue(delta.movedIndexPairs.count == 0)
        XCTAssertTrue(delta.unchangedIndexPairs.count == 3)
    }
    
    func testMove() {
        let oldArray = [0, 1, 2, 3, 4, 5]
        let newArray = [2, 5, 0, 3, 4, 1]
        
        let defaultCalculator = LXDeltaCalculator.defaultCalculator()
        
        let delta = defaultCalculator.deltaFromOldArray(oldArray, toNewArray: newArray)
        XCTAssertTrue(delta.addedIndices.count == 0)
        XCTAssertTrue(delta.removedIndices.count == 0)
        XCTAssertTrue(delta.movedIndexPairs.count == 4)
        XCTAssertTrue(delta.unchangedIndexPairs.count == 2)
    }
    
    func testInsertionAndDeletion() {
        let oldArray = [1, 2, 3, 4, 5, 6]
        let newArray = [0, 1, 2, 3, 4, 5]
        
        let defaultCalculator = LXDeltaCalculator.defaultCalculator()
        
        let delta = defaultCalculator.deltaFromOldArray(oldArray, toNewArray: newArray)
        XCTAssertTrue(delta.addedIndices.count == 1)
        XCTAssertTrue(delta.removedIndices.count == 1)
        XCTAssertTrue(delta.movedIndexPairs.count == 0)
        XCTAssertTrue(delta.unchangedIndexPairs.count == 5)
    }
}
