//
//  Game.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public struct Game {
    public static let maximumFrameCount: UInt = 10
    
    public private(set) var frames = [Frame]()
    
    public var completelyScoredFames: [Frame] {
        return frames.filter{ $0.isCompletelyScored }
    }
    
    public var nextBallFrameNumber: UInt {
        let currentFrameDelta: UInt = (frames.last?.isCompleted ?? false) ? 1 : 0
        return min(Game.maximumFrameCount, UInt(frames.count) + currentFrameDelta)
    }
    
    public var isGameover: Bool {
        return completelyScoredFames.count >= Game.maximumFrameCount
    }
    
    public init() {
        
    }
    
    public mutating func rolledWith(pinsKnockedDown: UInt) {
        guard !isGameover else { return }

        if frames.isEmpty || frames.last?.isCompleted == true {
            let newFrame = Frame(lastFrame: frames.count == 9)
            
            if frames.last?.state is StrikeState || frames.last?.state is SpareState{
                frames.last?.scoringFrame = newFrame
            }
            
            frames.append(newFrame)
        }
        
        frames.last?.addPinsKnockedDown(pinsKnockedDown)
    }
    
    public mutating func rolledWith(pinsKnockedDownSequence: [UInt]) {
        pinsKnockedDownSequence.forEach{ self.rolledWith(pinsKnockedDown: $0) }
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

