//
//  IntegrationTests.swift
//  BowlingureTests
//
//  Created by 孙翔宇 on 4/22/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import XCTest
import BowlingKit

class IntegrationTests: XCTestCase {
    var scorer: Scorer!
    override func setUp() {
        scorer = Scorer()
    }

    func testSample() {
        XCTAssertEqual(try! scorer.rolledWith(pinsKnockedDownSequence: [9 ,1, 0, 10, 10, 10, 6, 2, 7, 3, 8, 2, 10, 9, 0, 10, 10, 8]), [10, 30, 56, 74, 82, 100, 120, 139, 148, 176])
    }
    
    func testSampleSpare() {
        XCTAssertEqual(try! scorer.rolledWith(pinsKnockedDownSequence: [9 ,1, 0, 10, 10, 10, 6, 2, 7, 3, 8, 2, 10, 9, 0, 2, 8, 10]), [10, 30, 56, 74, 82, 100, 120, 139, 148, 168])
    }
    
    func testSampleTenthSpareMissedLastOne() {
        XCTAssertEqual(try! scorer.rolledWith(pinsKnockedDownSequence: [9 ,1, 0, 10, 10, 10, 6, 2, 7, 3, 8, 2, 10, 9, 0, 2, 8, 9]), [10, 30, 56, 74, 82, 100, 120, 139, 148, 167])
    }
    
    func testSampleTenthMissed() {
        XCTAssertEqual(try! scorer.rolledWith(pinsKnockedDownSequence: [9 ,1, 0, 10, 10, 10, 6, 2, 7, 3, 8, 2, 10, 9, 0, 2, 7]), [10, 30, 56, 74, 82, 100, 120, 139, 148, 157])
    }
    
    func testThePerfectGame() {
        XCTAssertEqual(try! scorer.rolledWith(pinsKnockedDownSequence: Array<UInt>(repeating: 10, count: 12)), [30, 60, 90, 120, 150, 180, 210, 240, 270, 300])
    }
}
