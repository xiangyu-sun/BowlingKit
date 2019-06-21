//
//  FirstBallRolledState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public struct FirstBallRolledState: FrameState {
    public func addPinsKnockedDown(_ count: UInt, frame: Frame) {
        if frame.ballKnockedDownRecord.count == 0 {
            frame.addBallKnockedDownRecord(count: count)
        } else if count == frame.pinsLeft  {
            frame.state = frame.getSpareState()
            frame.state.addPinsKnockedDown(count, frame: frame)
        } else {
            frame.state = frame.getMissedState()
            frame.state.addPinsKnockedDown(count, frame: frame)
        }
    }
}
