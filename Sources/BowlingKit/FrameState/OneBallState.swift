//
//  FirstBallRolledState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public struct OneBallState: FrameState {
    public func addPinsKnockedDown(_ count: UInt, frame: Frame) {
        if count == frame.pinsLeft {
            frame.state = frame.getSpareState(pinsDown: count)
        } else {
            frame.state = frame.getMissedState(pinsDown: count)
        }
    }
}
