//
//  Arena.swift
//  JumpShot
//
//  Created by Jerel Rocktaschel on 6/23/21.
//

import Foundation

public struct Arena: Decodable {
    let name: String
    let isDomestic: Bool
    let city: String
    let stateAbbr: String
    let country: String
}

extension Arena: Equatable {

    // MARK: Equatable

    public static func == (lhs: Arena, rhs: Arena) -> Bool {
        return lhs.name == rhs.name &&
        lhs.isDomestic == rhs.isDomestic &&
        lhs.city == rhs.city &&
        lhs.stateAbbr == rhs.stateAbbr &&
        lhs.country == rhs.country
    }
}
