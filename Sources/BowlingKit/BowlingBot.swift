//
//  File.swift
//  
//
//  Created by 孙翔宇 on 21/06/2019.
//

import Foundation

public class BowlingBot {
    public private(set) var game: Game
    
    public init() {
        game = Game()
    }
    
    public func generateFullGame() throws {
        if game.isGameover {
            game = Game()
        }
        
        while !game.isGameover {
            try rollNextBall()
        }
    }
    
    @discardableResult
    public func rollNextBall() throws -> UInt {
        let pinsDown: UInt
        if let lastFrame = game.frames.last, !lastFrame.isCompleted  {
            pinsDown = UInt.random(in: 0...lastFrame.pinsLeft)
            try game.rolledWith(pinsKnockedDown: UInt.random(in: 0...lastFrame.pinsLeft))
        } else {
            pinsDown = UInt.random(in: 0...10)
            try game.rolledWith(pinsKnockedDown: UInt.random(in: 0...10))
        }
        
        return pinsDown
    }
}
