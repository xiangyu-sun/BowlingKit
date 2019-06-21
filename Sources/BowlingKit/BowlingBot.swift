//
//  File.swift
//  
//
//  Created by 孙翔宇 on 21/06/2019.
//

import Foundation

public struct BowlingBot {
    private(set) var game: Game
    
    public init() {
        game = Game()
    }
    
    public mutating func generateFullGame() throws {
        while !game.isGameover {
            try rollNextBall()
        }
    }
    
    public mutating func rollNextBall() throws {
        if let lastFrame = game.frames.last, !lastFrame.isCompleted  {
            try game.rolledWith(pinsKnockedDown: UInt.random(in: 0...lastFrame.pinsLeft))
        } else {
            try game.rolledWith(pinsKnockedDown: UInt.random(in: 0...10))
        }
    }
}
