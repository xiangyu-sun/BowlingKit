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
    public var state: FrameState
    
    public var calcualtedScore: UInt { state.calcualtedScore(self) }
    
    public var isCompleted: Bool { state.isFrameCompleted(self) }
    
    public var isCompletelyScored: Bool { state.canBeScored(self) }
    
    weak var scoringFrame: Frame?
    
    let isLastFrame: Bool
    
    var pinsLeft: UInt { Frame.maxiumPinsCount - (ballKnockedDownRecord.first ?? 0) }
    
    private(set) var ballKnockedDownRecord = [UInt]()
    
    public init(lastFrame: Bool = false) {
        self.isLastFrame = lastFrame
        self.state = EmptyState()
    }
    
    public func addPinsKnockedDown(_ count: UInt) { state.addPinsKnockedDown(count, frame: self) }
    
    func addBallKnockedDownRecord(count: UInt) { ballKnockedDownRecord.append(count) }
    
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
    
    func getFirstBallRolledState() -> FrameState { FirstBallRolledState() }
    
    func getStrikeState() -> FrameState { isLastFrame ? FinalFrameStrikeState() : StrikeState() }
    
    func getSpareState() -> FrameState { isLastFrame ? FinalFrameSpareState() : SpareState() }
    
    func getMissedState() -> FrameState { MissedState() }
}

extension Frame : CustomDebugStringConvertible {
    public var debugDescription: String { ballKnockedDownRecord.debugDescription }
}
