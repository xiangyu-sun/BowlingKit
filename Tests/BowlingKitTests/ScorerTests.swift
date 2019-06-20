//
//  ScorerTests.swift
//  BowlingureTests
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import XCTest
import BowlingKit

class ScorerTests: XCTestCase {
    var scorer: Scorer!
    override func setUp() {
        scorer = Scorer()
        
    }
    
    
    func testScoreOverWhentItsOver() {
        scorer.rolledWith(pinsKnockedDownSequence: [UInt].init(repeating: 10, count: 12))
        XCTAssertTrue(scorer.gameIsOver)
    }
    
    func testScoreOverWhentItsNotOver() {
        scorer.rolledWith(pinsKnockedDownSequence: [UInt].init(repeating: 10, count: 1))
        XCTAssertFalse(scorer.gameIsOver)
    }
    
    func testScoreSofar() {
        scorer.rolledWith(pinsKnockedDownSequence: [10, 2, 3, 8])
        XCTAssertEqual(scorer.scoreSoFar, "28")
    }
    
    func testFrameNumber() {
        scorer.rolledWith(pinsKnockedDown: 9)
        XCTAssertEqual(scorer.frameNumber, "1")
        scorer.rolledWith(pinsKnockedDown: 1)
        XCTAssertEqual(scorer.frameNumber, "2")
    }
    
    func testFirstRollShouldReturnEmptyScoreArray() {
        let frameScore = scorer.rolledWith(pinsKnockedDown: 8)
        XCTAssertEqual(frameScore, [])
    }
    
    func testStrikeWithoutTwoSubsequentialBallCanNotBeScored() {
        let frameScore = scorer.rolledWith(pinsKnockedDownSequence: [10])
        XCTAssertEqual(frameScore, [])
    }
    
    func testFirstStrikeSecondSpareRollShouldReturnOneScore() {
        let frameScore = scorer.rolledWith(pinsKnockedDownSequence: [10, 2, 8])
        XCTAssertEqual(frameScore, [20])
    }
    
    func testFirstStrikeSecondMissRollShouldReturnTwoScore() {
        let frameScore = scorer.rolledWith(pinsKnockedDownSequence: [10, 2, 7])
        XCTAssertEqual(frameScore, [19, 28])
    }
    
    func testRollBallOnGameoverSHouldTriggerANewGame() {
        scorer.rolledWith(pinsKnockedDownSequence: [UInt].init(repeating: 10, count: 12))
        XCTAssertEqual(scorer.frameNumber, "10")
        scorer.rolledWith(pinsKnockedDown: 8)
        XCTAssertEqual(scorer.frameNumber, "1")
    }
    
    func testTwoStrikesScoreCalculation() {
        let frameScore = scorer.rolledWith(pinsKnockedDownSequence: [10, 10, 6, 4])
        XCTAssertEqual(frameScore, [26, 46])
    }

}
