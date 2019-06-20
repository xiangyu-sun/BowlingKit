//
//  EmptyState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public final class EmptyState: FrameState {
    public func addPinsKnockedDown(_ count: UInt, frame: Frame) {
        frame.state = count == Frame.maxiumPinsCount ? frame.getStrikeState() : frame.getFirstBallRolledState()
        frame.state.addPinsKnockedDown(count, frame: frame)
    }
}
