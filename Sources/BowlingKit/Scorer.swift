//
//  Scorer.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public struct Scorer {
    private(set) var game: Game
    
    public var frameNumber: String {
        return String(describing: game.nextBallFrameNumber)
    }
    
    public var gameIsOver: Bool {
        return game.isGameover
    }
    
    public var scoreSoFar: String {
        return String(describing: game.frames.mapToScores.sum())
    }
    
    public init() {
        self.game = Game()
    }
    
    @discardableResult
    public mutating func rolledWith(pinsKnockedDown: UInt) -> [UInt] {
        if gameIsOver {
            game = Game()
        }
        
        game.rolledWith(pinsKnockedDown: pinsKnockedDown)
        
        return cuculativeScores(frames: game.completelyScoredFames)
    }
    
    @discardableResult
    public mutating func rolledWith(pinsKnockedDownSequence: [UInt]) -> [UInt] {
        return pinsKnockedDownSequence.compactMap { self.rolledWith(pinsKnockedDown: $0) }.last ?? []
    }
    
    private func cuculativeScores(frames: [Frame]) -> [UInt] {
        return frames.enumerated().map { frames[...$0.0].mapToScores.sum()}
    }
}
