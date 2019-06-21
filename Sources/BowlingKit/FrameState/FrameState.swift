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
    
    func isFrameCompleted(_ frame: Frame) -> Bool { false }
    
    var maximumBallCount: UInt { 2 }
    
    var ballsRequiredForScoring: UInt { maximumBallCount }
    
    func calcualtedScore(_ frame: Frame) -> UInt { ballsForScoring(frame)?.sum() ?? 0 }
    
    func canBeScored(_ frame: Frame) -> Bool { ballsForScoring(frame)?.count == ballsRequiredForScoring }
    
    func ballsForScoring(_ frame: Frame) -> [UInt]? { frame.ballKnockedDownRecord }
}

public protocol CompleteFrameState: FrameState {}
public extension CompleteFrameState {
    var ballsRequiredForScoring: UInt { 3 }
    
    func isFrameCompleted(_ frame: Frame) -> Bool { true }

    func addPinsKnockedDown(_ count: UInt, frame: Frame) {
        guard frame.ballKnockedDownRecord.count < maximumBallCount else { return }
        frame.addBallKnockedDownRecord(count: count)
    }
}

public protocol FinalFrameState: FrameState {}
public extension FinalFrameState {
    var maximumBallCount: UInt { 3 }
    
    func isFrameCompleted(_ frame: Frame) -> Bool { canBeScored(frame) }
    
    func addPinsKnockedDown(_ count: UInt, frame: Frame) {
        guard !canBeScored(frame) else { return }
        frame.addBallKnockedDownRecord(count: count)
    }
}

public struct MissedState: CompleteFrameState {
    public var ballsRequiredForScoring: UInt { maximumBallCount }
}

public struct FinalFrameStrikeState: FinalFrameState {}
public struct FinalFrameSpareState: FinalFrameState {}
