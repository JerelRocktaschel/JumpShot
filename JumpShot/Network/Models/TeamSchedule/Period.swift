//
//  Period.swift
//  JumpShot
//
//  Copyright (c) 2021 Jerel Rocktaschel
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public struct Period {
    let current: Int
    let type: Int
    let maxRegular: Int

    public init(from decoder: Decoder) throws {
        let periodTeamContainer = try decoder.container(keyedBy: PeriodCodingKeys.self)
        current = try periodTeamContainer.decode(Int.self, forKey: .current)
        type = try periodTeamContainer.decode(Int.self, forKey: .type)
        maxRegular = try periodTeamContainer.decode(Int.self, forKey: .maxRegular)
    }
}

extension Period: Equatable {
    
    // MARK: Equatable
    
    public static func ==(lhs: Period, rhs: Period) -> Bool {
        return lhs.current == rhs.current && lhs.current == rhs.current && lhs.maxRegular == rhs.maxRegular
    }
}

extension Period: Decodable {

    // MARK: Coding Keys

    enum PeriodCodingKeys: String, CodingKey {
        case current
        case type
        case maxRegular
    }
}
