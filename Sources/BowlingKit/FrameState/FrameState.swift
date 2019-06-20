//
//  FrameState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public protocol FrameState {
    var maximumBallCount: UInt { get }
    var ballsRequiredForScoring: UInt { get }
    
    func isFrameCompleted(_ frame: Frame) -> Bool
    func canBeScored(_ frame: Frame) -> Bool
    func calcualtedScore(_ frame: Frame) -> UInt
    func ballsForScoring(_ frame: Frame) -> [UInt]?
    func addPinsKnockedDown(_ count: UInt, frame: Frame)
}

public extension FrameState {
    
    func isFrameCompleted(_ frame: Frame) -> Bool {
        return false
    }
    
    var maximumBallCount: UInt {
        return 2
    }
    
    var ballsRequiredForScoring: UInt {
        return maximumBallCount
    }
    
    func calcualtedScore(_ frame: Frame) -> UInt {
        return ballsForScoring(frame)?.sum() ?? 0
    }
    
    func canBeScored(_ frame: Frame) -> Bool {
         return ballsForScoring(frame)?.count == ballsRequiredForScoring
    }
    
    func ballsForScoring(_ frame: Frame) -> [UInt]? {
        return frame.ballKnockedDownRecord
    }
}

public protocol CompleteFrameState: FrameState {}
public extension CompleteFrameState {
    func isFrameCompleted(_ frame: Frame) -> Bool{
        return true
    }
    
    func addPinsKnockedDown(_ count: UInt, frame: Frame) {
        guard frame.ballKnockedDownRecord.count < maximumBallCount else { return }
        frame.addBallKnockedDownRecord(count: count)
    }
}

public protocol FinalFrameState: FrameState {}
public extension FinalFrameState {
    var maximumBallCount: UInt {
        return 3
    }
    
    func isFrameCompleted(_ frame: Frame) -> Bool{
        return canBeScored(frame)
    }
    
    func addPinsKnockedDown(_ count: UInt, frame: Frame) {
        guard !canBeScored(frame) else { return }
        frame.addBallKnockedDownRecord(count: count)
    }
}
