//
//  Scorer.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public final class Scorer {
    private(set) var game: Game

    /// returns the number of the frame containing the ball about to be rolled
    public var frameNumber: String { String(describing: game.frameIndexForNextBall) }

    /// returns true when the tenth frame has been
    /// scored and false otherwise, and which causes the next roll to start a new
    /// game
    public var gameIsOver: Bool { game.isGameover }

    /// returns the score in the game so far
    public var scoreSoFar: String { String(describing: game.frames.lazy.map { $0.calcualtedScore }.sum()) }

    public init() {
        game = Game()
    }

    /// given the number of pins knocked down by a roll of the
    /// ball, returns an array whose length is the number of frames completely scored and whose contents are the cumulative scores for those frames
    /// - Parameter pinsKnockedDown: pins knocked down by a roll of the
    /// ball
    @discardableResult
    public func rolledWith(pinsKnockedDown: UInt) throws -> [UInt] {
        do {
            try game.rolledWith(pinsKnockedDown: pinsKnockedDown)
        } catch {
            game = Game()
            try game.rolledWith(pinsKnockedDown: pinsKnockedDown)
        }

        return cuculativeScores(frames: game.completelyScoredFames)
    }

    @discardableResult
    public func rolledWith(pinsKnockedDownSequence: [UInt]) throws -> [UInt] {
        try pinsKnockedDownSequence.compactMap { try self.rolledWith(pinsKnockedDown: $0) }.last ?? []
    }

    private func cuculativeScores(frames: [Frame]) -> [UInt] {
        frames.enumerated().map { frames[...$0.0].lazy.map { $0.calcualtedScore }.sum() }
    }
}
