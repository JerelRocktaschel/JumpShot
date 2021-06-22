//
//  TeamLeaders.swift
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

public enum StatCategory: String {
    case ppg
    case trpg
    case apg
    case fgp
    case tpp
    case ftp
    case bpg
    case spg
    case tpg
    case pfpg
}

public struct StatLeader {

    // MARK: Internal Properties

    let category: StatCategory
    let leader: Leader
}

public struct Leader {

    // MARK: Internal Properties

    let playerId: String
    let value: Double

    public init(from decoder: Decoder) throws {
        let leaderContainer = try decoder.container(keyedBy: LeaderCodingKeys.self)
        let valueString = try leaderContainer.decode(String.self, forKey: .value)

        playerId = try leaderContainer.decode(String.self, forKey: .playerId)
        value = Double(valueString)!
    }
}

extension Leader: Decodable {

    // MARK: Coding Keys

    enum LeaderCodingKeys: String, CodingKey {
        case playerId = "personId"
        case value
    }
}

struct LeaderApiResponse {

    // MARK: Internal Properties

    var statLeaders: [StatLeader]

    init?(json: [String: Any]) {

        guard let leagueDictionary = json["league"] as? JSONDictionary else {
            return nil
        }

        guard let standardDictionary = leagueDictionary["standard"] as? JSONDictionary else {
            return nil
        }

        self.statLeaders = [StatLeader]()
        for (key, value) in standardDictionary {
            if let statCategoryKey = StatCategory(rawValue: key) {
                guard let leaderDictionaries = value as? [JSONDictionary] else {
                    return nil
                }

                for leaderDictionary in leaderDictionaries {
                    guard let leaderJSONData = try? JSONSerialization.data(withJSONObject: leaderDictionary,
                                                                                 options: []) else {
                            return nil
                    }

                    do {
                        let leader = try JSONDecoder().decode(Leader.self, from: leaderJSONData)
                        let statLeader = StatLeader(category: statCategoryKey, leader: leader)
                        statLeaders.append(statLeader)
                    } catch {
                        return nil
                    }
                }
            }
        }
    }
}
