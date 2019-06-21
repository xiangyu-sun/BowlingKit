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

public struct Game {
    
    public static let maximumFrameCount: UInt = 10
    
    public private(set) var frames = [Frame]()
    
    public var completelyScoredFames: [Frame] { frames.filter{ $0.isCompletelyScored } }
    
    public var nextBallFrameNumber: UInt {
        let currentFrameDelta: UInt = isNextFrameNew ? 1 : 0
        return min(Game.maximumFrameCount, UInt(frames.count) + currentFrameDelta)
    }
    
    public var isGameover: Bool { completelyScoredFames.count >= Game.maximumFrameCount }
    
    var isNextFrameNew: Bool { frames.isEmpty || frames.last?.isCompleted == true }
    
    public init() {}
    
    public mutating func rolledWith(pinsKnockedDown: UInt) throws {
        guard !isGameover else { throw GameError.gameFinished }

        if let newFrame = makeNextFrame() {
            frames.append(newFrame)
        }
        
        frames.last?.addPinsKnockedDown(pinsKnockedDown)
    }
    
    public mutating func rolledWith(pinsKnockedDownSequence: [UInt]) throws {
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

extension Array where Element == Frame {
    var mapToScores: [UInt] {
        return map{ $0.calcualtedScore }
    }
}

extension ArraySlice where Element == Frame {
    var mapToScores: [UInt] {
        return map{ $0.calcualtedScore }
    }
}
