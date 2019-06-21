//
//  File.swift
//  
//
//  Created by 孙翔宇 on 21/06/2019.
//
import XCTest
@testable import BowlingKit

class BowlingBotTests: XCTestCase {
    var bot: BowlingBot!
    override func setUp() {
        bot = BowlingBot()
    }
    
    func testAutoRoll() {
        XCTAssertNoThrow(try bot.generateFullGame())
        XCTAssertEqual(bot.game.frames.count, 10)
    }
    
    func testRollOneBall() {
        XCTAssertNoThrow(try bot.rollNextBall())
        XCTAssertEqual(bot.game.frames.count, 1)
    }
}
