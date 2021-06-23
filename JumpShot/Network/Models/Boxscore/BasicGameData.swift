//
//  BasicGameData.swift
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

public struct BasicGameData {

    // MARK: Internal Properties

    let isGameActivated: Bool
    let status: Int
    let extendedStatus: Int
    let startTime: Date
    let endTime: Date
    let isBuzzerBeater: Bool
    let isNeutralVenue: Bool
    let arena: Arena
    let gameDuration: GameDuration
    let period: BoxscorePeriod
    let officials: [Official]
    let homeTeamData: BoxscoreTeamData
    let visitorTeamData: BoxscoreTeamData

    // MARK: Init

    public init(from decoder: Decoder) throws {
        let dateFormatter: DateFormatter
        dateFormatter = DateFormatter.iso8601Full
        let boxscoreContainer = try decoder.container(keyedBy: BasicGameDataCodingKeys.self)
        let startTimeString = try boxscoreContainer.decode(String.self, forKey: .startTime)
        let endTimeString = try boxscoreContainer.decode(String.self, forKey: .endTime)
        let officialsList = try boxscoreContainer.decode([String: [[String: String]]].self,
                                                                           forKey: .officials)

        status = try boxscoreContainer.decode(Int.self, forKey: .status)
        extendedStatus = try boxscoreContainer.decode(Int.self, forKey: .extendedStatus)
        isGameActivated = try boxscoreContainer.decode(Bool.self, forKey: .isGameActivated)
        isBuzzerBeater = try boxscoreContainer.decode(Bool.self, forKey: .isBuzzerBeater)
        isNeutralVenue = try boxscoreContainer.decode(Bool.self, forKey: .isNeutralVenue)

        if let startTimeUTCDate = dateFormatter.date(from: startTimeString) {
            startTime = startTimeUTCDate
        } else {
            throw DecodingError.dataCorruptedError(forKey: .startTime,
                                                   in: boxscoreContainer,
                                                   debugDescription: "Date string does not match expected format.")
        }

        if let endTimeUTCDate = dateFormatter.date(from: endTimeString) {
            endTime = endTimeUTCDate
        } else {
            throw DecodingError.dataCorruptedError(forKey: .endTime,
                                                   in: boxscoreContainer,
                                                   debugDescription: "Date string does not match expected format.")
        }

        arena = try boxscoreContainer.decode(Arena.self, forKey: .arena)
        gameDuration = try boxscoreContainer.decode(GameDuration.self, forKey: .gameDuration)
        period = try boxscoreContainer.decode(BoxscorePeriod.self, forKey: .period)

        var officialsArray = [Official]()
        if let officials = officialsList["formatted"] {
            for official in officials {
                if let official = official.values.first {
                    let official = Official(fullName: official)
                    officialsArray.append(official)
                }
            }
        }
        officials = officialsArray
        homeTeamData = try boxscoreContainer.decode(BoxscoreTeamData.self, forKey: .hTeam)
        visitorTeamData = try boxscoreContainer.decode(BoxscoreTeamData.self, forKey: .vTeam)
    }
}

extension BasicGameData: Decodable {

    // MARK: Coding Keys

    enum BasicGameDataCodingKeys: String, CodingKey {
        case isGameActivated
        case status = "statusNum"
        case extendedStatus = "extendedStatusNum"
        case startTime = "startTimeUTC"
        case endTime = "endTimeUTC"
        case isBuzzerBeater
        case isNeutralVenue
        case arena
        case gameDuration
        case period
        case officials
        case vTeam
        case hTeam
    }
}
