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
    
    public var isCompletelyScored: Bool { state.canScore(self) }
    
    weak var scoringFrame: Frame?
    
    let isLastFrame: Bool
    
    var pinsLeft: UInt { Frame.maxiumPinsCount - (pinsKnockedDown.first ?? 0) }
    
    private(set) var pinsKnockedDown = [UInt]()
    
    public init(lastFrame: Bool = false) {
        self.isLastFrame = lastFrame
        self.state = InitialState()
    }
    
    public func addPinsKnockedDown(_ count: UInt) { state.addPinsKnockedDown(count, frame: self) }
    
    func addballsKnockedDown(count: UInt) { pinsKnockedDown.append(count) }
    
    func getScoringFramePinsKnockedDown(ballIndex: Int) -> [UInt] {
        guard let scoringFrame = scoringFrame, ballIndex != 0 else { return [] }
        
        let allFrames = scoringFrame.pinsKnockedDown + (scoringFrame.scoringFrame?.pinsKnockedDown ?? [])
        
        let ballsKnockDownNeeded = allFrames.count - ballIndex
        
        guard ballsKnockDownNeeded >= 0 else {
            return []
        }
        return Array(allFrames[..<ballIndex])
    }
    
    func getFirstBallRolledState(pinsDown: UInt) -> FrameState {
        let state = OneBallState()
        state.addPinsKnockedDown(pinsDown, frame: self)
        return state
    }
    
    func getStrikeState(pinsDown: UInt) -> FrameState {
        let state: FrameState = isLastFrame ? FinalFrameStrikeState() : StrikeState()
        state.addPinsKnockedDown(pinsDown, frame: self)
        return state
    }
    
    func getSpareState(pinsDown: UInt) -> FrameState {
        let state:FrameState = isLastFrame ? FinalFrameSpareState() : SpareState()
        state.addPinsKnockedDown(pinsDown, frame: self)
        return state
    }
    
    func getMissedState(pinsDown: UInt) -> FrameState {
        let state = MissedState()
        state.addPinsKnockedDown(pinsDown, frame: self)
        return state
    }
}

extension Frame : CustomDebugStringConvertible {
    public var debugDescription: String { pinsKnockedDown.debugDescription }
}
