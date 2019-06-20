//
//  SpareState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public final class SpareState: CompleteFrameState {
    public func ballsForScoring(_ frame: Frame) -> [UInt]? {
        var frames = frame.ballKnockedDownRecord
        let firstBallOfNextFrame = frame.getNextBallKnockedDownRecord(count: 1)
        if !firstBallOfNextFrame.isEmpty {
            frames.append(contentsOf: firstBallOfNextFrame)
        }
        return frames
    }
    
    public var ballsRequiredForScoring: UInt {
        return 3
    }
}
