//
//  Game.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

enum GameError : Error {
    case gameFinished
}

public final class Game {
    
    public static let maximumFrameCount: UInt = 10
    
    public private(set) var frames = [Frame]()
    
    public var completelyScoredFames: [Frame] { frames.filter{ $0.isCompletelyScored } }
    
    public var frameIndexForNextBall: UInt {
        let currentFrameDelta: UInt = isNextFrameNew ? 1 : 0
        return min(Game.maximumFrameCount, UInt(frames.count) + currentFrameDelta)
    }
    
    public var isGameover: Bool { completelyScoredFames.count >= Game.maximumFrameCount }
    
    var isNextFrameNew: Bool { frames.isEmpty || frames.last?.isCompleted == true }
    
    public init() {}
    
    public func rolledWith(pinsKnockedDown: UInt) throws {
        guard !isGameover else { throw GameError.gameFinished }

        if let newFrame = makeNextFrame() {
            frames.append(newFrame)
        }
        
        frames.last?.addPinsKnockedDown(pinsKnockedDown)
    }
    
    public func rolledWith(pinsKnockedDownSequence: [UInt]) throws {
        try pinsKnockedDownSequence.forEach{ try self.rolledWith(pinsKnockedDown: $0) }
    }
    
    func makeNextFrame() -> Frame? {
        if isNextFrameNew {
            let newFrame = Frame(lastFrame: frames.count == Game.maximumFrameCount - 1 )
            
            if frames.last?.state is StrikeState || frames.last?.state is SpareState {
                frames.last?.scoringFrame = newFrame
            }
            
            return newFrame
        }
        
        return nil
    }
}

extension Game: CustomDebugStringConvertible {
    public var debugDescription: String {
        return frames.compactMap{ $0.pinsKnockedDown }.debugDescription
    }
}
