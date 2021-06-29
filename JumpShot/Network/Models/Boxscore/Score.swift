//
//  Score.swift
//  JumpShot
//
//  Created by Jerel Rocktaschel on 6/23/21.
//

import Foundation

public struct Score {
    let score: Int
}

extension Score: Equatable {

    // MARK: Equatable

    public static func == (lhs: Score, rhs: Score) -> Bool {
        return lhs.score == rhs.score
    }
}
