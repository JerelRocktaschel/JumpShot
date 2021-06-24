//
//  ScheduledTeam.swift
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

public struct ScheduledTeam {
    let teamId: String
    let score: Int?

    public init(from decoder: Decoder) throws {
        let scheduledTeamContainer = try decoder.container(keyedBy: ScheduledTeamCodingKeys.self)
        let scoreString = try scheduledTeamContainer.decode(String.self, forKey: .score)

        teamId = try scheduledTeamContainer.decode(String.self, forKey: .teamId)
        score = Int(scoreString)
    }
}

extension ScheduledTeam: Equatable {
    
    // MARK: Equatable
    
    public static func ==(lhs: ScheduledTeam, rhs: ScheduledTeam) -> Bool {
        return lhs.teamId == rhs.teamId && lhs.score == rhs.score
    }
}

extension ScheduledTeam: Decodable {

    // MARK: Coding Keys

    enum ScheduledTeamCodingKeys: String, CodingKey {
        case teamId
        case score
    }
}
