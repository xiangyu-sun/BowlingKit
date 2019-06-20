//
//  BowlingureTests.swift
//  BowlingureTests
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import XCTest
import BowlingKit

class GameTests: XCTestCase {
    var game: Game!
    override func setUp() {
        game = Game()
    }

    func testGameMaximumFrames() {
        XCTAssertEqual(Game.maximumFrameCount, 10)
    }
    
    func testCompletedFrameWhenOneFrameIncomplete() {
        game.rolledWith(pinsKnockedDownSequence: [10, 3, 7, 7])
        XCTAssertEqual(game.frames.count, 3)
        XCTAssertEqual(game.completelyScoredFames.count, 2)
    }
    
    func testGameStopWhenReachMaxiumFrame() {
        game.rolledWith(pinsKnockedDownSequence: [10, 3, 7, 7, 0, 10, 4, 6, 2, 3, 10, 2, 8, 10, 3, 5])
        XCTAssertEqual(game.frames.count, Int(Game.maximumFrameCount))
        game.rolledWith(pinsKnockedDown: 9)
        XCTAssertEqual(game.frames.count, Int(Game.maximumFrameCount))
    }
    
}
