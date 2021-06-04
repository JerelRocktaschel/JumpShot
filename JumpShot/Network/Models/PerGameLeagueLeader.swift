//
//  PerGameLeagueLeader.swift
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

public struct PerGameLeagueLeader {

    // MARK: Internal Properties

    let playerId: String
    let rank: Int
    let player: String
    let team: String
    let gamesPlayed: Int
    let minutes: Double
    let fieldGoalsMade: Double
    let fieldGoalsAttempted: Double
    let fieldGoalsPercentage: Double
    let threePointersMade: Double
    let threePointersAttempted: Double
    let threePointersPercentage: Double
    let foulShotsMade: Double
    let foulShotsAttempted: Double
    let foulShotsPercentage: Double
    let offensiveRebounds: Double
    let defensiveRebounds: Double
    let rebounds: Double
    let assists: Double
    let steals: Double
    let blocks: Double
    let turnovers: Double
    let playerEfficiency: Double
    let points: Double

    public init(from decoder: Decoder) throws {

        // MARK: Init

        let perGameLeagueLeaderCodingKeysContainer = try decoder.container(keyedBy: PerGameLeagueLeaderCodingKeys.self)
        let intPlayerId = try perGameLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .playerId)
        playerId = String(intPlayerId)
        rank = try perGameLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .rank)
        player = try perGameLeagueLeaderCodingKeysContainer.decode(String.self, forKey: .player)
        team = try perGameLeagueLeaderCodingKeysContainer.decode(String.self, forKey: .team)
        gamesPlayed = try perGameLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .gamesPlayed)
        minutes = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .minutes)
        fieldGoalsMade = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .fieldGoalsMade)
        fieldGoalsAttempted = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .fieldGoalsAttempted)
        fieldGoalsPercentage = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self,
                                                                               forKey: .fieldGoalsPercentage)
        threePointersMade = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .threePointersMade)
        threePointersAttempted = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self,
                                                                                 forKey: .threePointersAttempted)
        threePointersPercentage = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self,
                                                                                  forKey: .threePointersPercentage)
        foulShotsMade = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .foulShotsMade)
        foulShotsAttempted = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .foulShotsAttempted)
        foulShotsPercentage = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .foulShotsPercentage)
        offensiveRebounds = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .offensiveRebounds)
        defensiveRebounds = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .defensiveRebounds)
        rebounds = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .rebounds)
        assists = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .assists)
        steals = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .steals)
        blocks = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .blocks)
        turnovers = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .turnovers)
        playerEfficiency = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .playerEfficiency)
        points = try perGameLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .points)
    }
}

extension PerGameLeagueLeader: Decodable {

    // MARK: Coding Keys

    enum PerGameLeagueLeaderCodingKeys: String, CodingKey {

        case playerId = "PLAYER_ID"
        case rank = "RANK"
        case player = "PLAYER"
        case team = "TEAM"
        case gamesPlayed = "GP"
        case minutes = "MIN"
        case fieldGoalsMade = "FGM"
        case fieldGoalsAttempted = "FGA"
        case fieldGoalsPercentage = "FG_PCT"
        case threePointersMade = "FG3M"
        case threePointersAttempted = "FG3A"
        case threePointersPercentage = "FG3_PCT"
        case foulShotsMade = "FTM"
        case foulShotsAttempted = "FTA"
        case foulShotsPercentage = "FT_PCT"
        case offensiveRebounds = "OREB"
        case defensiveRebounds = "DREB"
        case rebounds = "REB"
        case assists = "AST"
        case steals = "STL"
        case blocks = "BLK"
        case turnovers = "TOV"
        case points = "PTS"
        case playerEfficiency = "EFF"
    }
}

struct PerGameLeagueLeaderApiResponse {

    // MARK: Internal Properties

    var perGameLeagueLeaders: [PerGameLeagueLeader]
}

extension PerGameLeagueLeaderApiResponse {

    // MARK: Init

    init?(json: [String: Any]) {
        do {
            guard let resultSetDictionary = json["resultSet"] as? JSONDictionary else {
                return nil
            }

            guard let headersDictionary = resultSetDictionary["headers"] as? [String] else {
                return nil
            }

            guard let rowSetArray = resultSetDictionary["rowSet"] as? [[Any]] else {
                return nil
            }

            self.perGameLeagueLeaders = [PerGameLeagueLeader]()
            for perGameLeagueLeaderRowArray in rowSetArray {
                let perGameLeagueLeaderDictionary = Dictionary(uniqueKeysWithValues:
                                                                zip(headersDictionary, perGameLeagueLeaderRowArray))
                guard let jsonPerGameLeagueLeaderData = try? JSONSerialization.data(withJSONObject: perGameLeagueLeaderDictionary,
                                                                                 options: []) else {
                        return nil
                }
                
                let perGameLeagueLeader = try JSONDecoder().decode(PerGameLeagueLeader.self, from: jsonPerGameLeagueLeaderData)
                self.perGameLeagueLeaders.append(perGameLeagueLeader)
            }
        } catch {
            return nil
        }
    }
}

