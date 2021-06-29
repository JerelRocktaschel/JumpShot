//
//  Official.swift
//  JumpShot
//
//  Created by Jerel Rocktaschel on 6/23/21.
//

import Foundation

public struct Official {
    let fullName: String
}

extension Official: Equatable {

    // MARK: Equatable

    public static func == (lhs: Official, rhs: Official) -> Bool {
        return lhs.fullName == rhs.fullName
    }
}
