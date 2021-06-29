//
//  Per48LeagueLeader.swift
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

public struct Per48LeagueLeader {

    // MARK: Internal Properties

    let playerId: String
    let rank: Int
    let player: String
    let team: String
    let gamesPlayed: Int
    let minutes: Int
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
    let personalFouls: Double
    let playerEfficiency: Double
    let points: Double

    public init(from decoder: Decoder) throws {

        // MARK: Init

        let per48LeagueLeaderCodingKeysContainer = try decoder.container(keyedBy: Per48LeagueLeaderCodingKeys.self)
        let intPlayerId = try per48LeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .playerId)
        playerId = String(intPlayerId)
        rank = try per48LeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .rank)
        player = try per48LeagueLeaderCodingKeysContainer.decode(String.self, forKey: .player)
        team = try per48LeagueLeaderCodingKeysContainer.decode(String.self, forKey: .team)
        gamesPlayed = try per48LeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .gamesPlayed)
        minutes = try per48LeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .minutes)
        fieldGoalsMade = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .fieldGoalsMade)
        fieldGoalsAttempted = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .fieldGoalsAttempted)
        fieldGoalsPercentage = try per48LeagueLeaderCodingKeysContainer.decode(Double.self,
                                                                               forKey: .fieldGoalsPercentage)
        threePointersMade = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .threePointersMade)
        threePointersAttempted = try per48LeagueLeaderCodingKeysContainer.decode(Double.self,
                                                                                 forKey: .threePointersAttempted)
        threePointersPercentage = try per48LeagueLeaderCodingKeysContainer.decode(Double.self,
                                                                                  forKey: .threePointersPercentage)
        foulShotsMade = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .foulShotsMade)
        foulShotsAttempted = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .foulShotsAttempted)
        foulShotsPercentage = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .foulShotsPercentage)
        offensiveRebounds = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .offensiveRebounds)
        defensiveRebounds = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .defensiveRebounds)
        rebounds = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .rebounds)
        assists = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .assists)
        steals = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .steals)
        blocks = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .blocks)
        turnovers = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .turnovers)
        playerEfficiency = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .playerEfficiency)
        personalFouls = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .personalFouls)
        points = try per48LeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .points)
    }
}

extension Per48LeagueLeader: Decodable {

    // MARK: Coding Keys

    enum Per48LeagueLeaderCodingKeys: String, CodingKey {

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
        case personalFouls = "PF"
        case points = "PTS"
        case playerEfficiency = "EFF"
    }
}

struct Per48LeagueLeaderApiResponse {

    // MARK: Internal Properties

    var per48LeagueLeaders: [Per48LeagueLeader]
}

extension Per48LeagueLeaderApiResponse {

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

            self.per48LeagueLeaders = [Per48LeagueLeader]()
            for per48LeagueLeaderRowArray in rowSetArray {
                let per48LeagueLeaderDictionary = Dictionary(uniqueKeysWithValues:
                                                                zip(headersDictionary, per48LeagueLeaderRowArray))
                guard let jsonPer48LeagueLeaderData = try? JSONSerialization.data(withJSONObject: per48LeagueLeaderDictionary,
                                                                                 options: []) else {
                        return nil
                }

                let per48LeagueLeader = try JSONDecoder().decode(Per48LeagueLeader.self,
                                                                 from: jsonPer48LeagueLeaderData)
                self.per48LeagueLeaders.append(per48LeagueLeader)
            }
        } catch {
            return nil
        }
    }
}
