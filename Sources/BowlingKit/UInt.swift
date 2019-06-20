//
//  UInt.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

extension Int {
    static func == (left: Int, right: UInt) -> Bool {
        return left == Int(right)
    }
}

extension Int {
    static func - (left: UInt, right: Int) -> Int {
        return Int(left) - right
    }
}

extension Optional where Wrapped == Int {
    static func == (left: Int?, right: UInt) -> Bool {
        return left == Int(right)
    }
}
