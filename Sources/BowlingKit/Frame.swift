//
//  Frame.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public final class Frame {
    
    public static let maxiumPinsCount: UInt = 10
    
    private(set) var ballKnockedDownRecord = [UInt]()
    
    public var state: FrameState
    
    weak var scoringFrame: Frame?
    
    let lastFrame: Bool

    public var calcualtedScore: UInt {
        return state.calcualtedScore(self)
    }
    
    public var isCompleted: Bool {
        return state.isFrameCompleted(self)
    }
    
    public var isCompletelyScored: Bool {
       return state.canBeScored(self)
    }
    
    var pinsLeft: UInt {
        return Frame.maxiumPinsCount - (ballKnockedDownRecord.first ?? 0)
    }
    
    public init(lastFrame: Bool = false) {
        self.lastFrame = lastFrame
        self.state = EmptyState()
    }
    
    public func addPinsKnockedDown(_ count: UInt) {
        state.addPinsKnockedDown(count, frame: self)
    }
    
    func addBallKnockedDownRecord(count: UInt) {
        ballKnockedDownRecord.append(count)
    }
    
    func getNextBallKnockedDownRecord(count: Int) -> [UInt] {
        guard let scoringFrame = scoringFrame, count != 0 else { return [] }
        
        var allFrames = scoringFrame.ballKnockedDownRecord
        
        let ballsKnockDownNeeded = allFrames.count - count
        
        if ballsKnockDownNeeded >= 0 {
            return Array(allFrames[..<count])
        }
        
        guard let scoringFrameAfterNext = scoringFrame.scoringFrame else { return allFrames }
        let ballsMissed = abs(ballsKnockDownNeeded)
        
        
        allFrames.append(contentsOf: Array(scoringFrameAfterNext.ballKnockedDownRecord[..<ballsMissed]))
        return allFrames
    }
    
    func getFirstBallRolledState() -> FrameState {
        return FirstBallRolledState()
    }
    
    func getStrikeState() -> FrameState {
        return lastFrame ? FinalFrameStrikeState() : StrikeState()
    }
    
    func getSpareState() -> FrameState {
        return lastFrame ? FinalFrameSpareState() : SpareState()
    }
    
    func getMissedState() -> FrameState {
        return MissedState()
    }
}
