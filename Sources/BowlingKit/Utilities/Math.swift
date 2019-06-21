//
//  Math.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/22/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

extension Array where Element == UInt {
    func sum() -> UInt {
        return reduce(0, +)
    }
}
