//
//  FrameTests.swift
//  BowlingureTests
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import XCTest
import BowlingKit


class FrameTests: XCTestCase {
    var frame: Frame!
    
    override func setUp() {
        frame = Frame()
    }
    
    func testGameMaximumBallsPerFrame() {
        XCTAssertEqual(frame.state.maximumBallCount, 2)
    }
    
    func testMaximumPinCountPerFrame() {
        XCTAssertEqual(Frame.maxiumPinsCount, 10)
    }
    
    func testNewFrame() {
        XCTAssertTrue(frame.state is EmptyState)
    }
    
    func testStrike() {
        frame.addPinsKnockedDown(10)
        XCTAssertTrue(frame.state is StrikeState)
    }
    
    func testSpare() {
        frame.addPinsKnockedDown(3)
        frame.addPinsKnockedDown(7)
        XCTAssertTrue(frame.state is SpareState)
    }
    
    func testMissed() {
        frame.addPinsKnockedDown(2)
        frame.addPinsKnockedDown(3)
        XCTAssertTrue(frame.state is MissedState)
    }
    
    
}
