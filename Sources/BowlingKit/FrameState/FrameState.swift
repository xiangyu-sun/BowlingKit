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
    func canScore(_ frame: Frame) -> Bool
    func calcualtedScore(_ frame: Frame) -> UInt
    func ballsForScoring(_ frame: Frame) -> [UInt]?
    func addPinsKnockedDown(_ count: UInt, frame: Frame)
}

public extension FrameState {
    func isFrameCompleted(_ frame: Frame) -> Bool { frame.pinsKnockedDown.count == maximumBallCount }

    var maximumBallCount: UInt { 2 }

    var ballsRequiredForScoring: UInt { maximumBallCount }

    func calcualtedScore(_ frame: Frame) -> UInt { ballsForScoring(frame)?.sum() ?? 0 }

    func canScore(_ frame: Frame) -> Bool { ballsForScoring(frame)?.count == ballsRequiredForScoring }

    func ballsForScoring(_ frame: Frame) -> [UInt]? { frame.pinsKnockedDown }
}

public protocol CompleteFrameState: FrameState {}
public extension CompleteFrameState {
    var ballsRequiredForScoring: UInt { 3 }

    func addPinsKnockedDown(_ count: UInt, frame: Frame) {
        guard !isFrameCompleted(frame) else { return }
        frame.addballsKnockedDown(count: count)
    }

    func ballsForScoring(_ frame: Frame) -> [UInt]? {
        var frames = frame.pinsKnockedDown

        let countOfBallsMissing = ballsRequiredForScoring - frames.count

        if countOfBallsMissing > 0 {
            frames.append(contentsOf: frame.getScoringFramePinsKnockedDown(ballIndex: countOfBallsMissing))
        }

        return frames
    }
}

public struct MissedState: CompleteFrameState {
    public var ballsRequiredForScoring: UInt { maximumBallCount }
}

public struct SpareState: CompleteFrameState {}

public struct StrikeState: CompleteFrameState {
    public var maximumBallCount: UInt { 1 }
}

public protocol FinalFrameState: CompleteFrameState {}
public extension FinalFrameState {
    func isFrameCompleted(_ frame: Frame) -> Bool { canScore(frame) }
}

public struct FinalFrameStrikeState: FinalFrameState {}
public struct FinalFrameSpareState: FinalFrameState {}
