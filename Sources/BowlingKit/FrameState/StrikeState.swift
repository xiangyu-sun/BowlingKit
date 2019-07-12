//
//  StrikeState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public struct StrikeState: CompleteFrameState {
    public var maximumBallCount: UInt { 1 }
    
    public func ballsForScoring(_ frame: Frame) -> [UInt]? {

        var frames = frame.pinsKnockedDown
        
        let countOfBallsMissing = ballsRequiredForScoring - frames.count
        if countOfBallsMissing > 0 {
            frames.append(contentsOf: frame.getScoringFramePinsKnockedDown(ballIndex: countOfBallsMissing))
        }
        
        return frames
    }
}
