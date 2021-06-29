//
//  BoxscorePeriod.swift
//  JumpShot
//
//  Created by Jerel Rocktaschel on 6/23/21.
//

import Foundation

public struct BoxscorePeriod: Decodable {
    let current: Int
    let type: Int
    let maxRegular: Int
    let isHalftime: Bool
    let isEndOfPeriod: Bool
}

extension BoxscorePeriod: Equatable {

    // MARK: Equatable

    public static func == (lhs: BoxscorePeriod, rhs: BoxscorePeriod) -> Bool {
        return lhs.current == rhs.current &&
        lhs.type == rhs.type &&
        lhs.maxRegular == rhs.maxRegular &&
        lhs.isHalftime == rhs.isHalftime &&
        lhs.isEndOfPeriod == rhs.isEndOfPeriod
    }
}
