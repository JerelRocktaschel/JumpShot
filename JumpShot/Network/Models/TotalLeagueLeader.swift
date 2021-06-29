//
//  LeagueLeaderTotal.swift
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

public struct TotalLeagueLeader {

    // MARK: Internal Properties

    let playerId: String
    let rank: Int
    let player: String
    let team: String
    let gamesPlayed: Int
    let minutes: Int
    let fieldGoalsMade: Int
    let fieldGoalsAttempted: Int
    let fieldGoalsPercentage: Double
    let threePointersMade: Int
    let threePointersAttempted: Int
    let threePointersPercentage: Double
    let foulShotsMade: Int
    let foulShotsAttempted: Int
    let foulShotsPercentage: Double
    let offensiveRebounds: Int
    let defensiveRebounds: Int
    let rebounds: Int
    let assists: Int
    let steals: Int
    let blocks: Int
    let turnovers: Int
    let personalFouls: Int
    let playerEfficiency: Int
    let points: Int
    let assistsToTurnovers: Double
    let stealsToTurnovers: Double

    public init(from decoder: Decoder) throws {

        // MARK: Init

        let totalLeagueLeaderCodingKeysContainer = try decoder.container(keyedBy: TotalLeagueLeaderCodingKeys.self)
        let intPlayerId = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .playerId)
        playerId = String(intPlayerId)
        rank = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .rank)
        player = try totalLeagueLeaderCodingKeysContainer.decode(String.self, forKey: .player)
        team = try totalLeagueLeaderCodingKeysContainer.decode(String.self, forKey: .team)
        gamesPlayed = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .gamesPlayed)
        minutes = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .minutes)
        fieldGoalsMade = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .fieldGoalsMade)
        fieldGoalsAttempted = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .fieldGoalsAttempted)
        fieldGoalsPercentage = try totalLeagueLeaderCodingKeysContainer.decode(Double.self,
                                                                               forKey: .fieldGoalsPercentage)
        threePointersMade = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .threePointersMade)
        threePointersAttempted = try totalLeagueLeaderCodingKeysContainer.decode(Int.self,
                                                                                 forKey: .threePointersAttempted)
        threePointersPercentage = try totalLeagueLeaderCodingKeysContainer.decode(Double.self,
                                                                                  forKey: .threePointersPercentage)
        foulShotsMade = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .foulShotsMade)
        foulShotsAttempted = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .foulShotsAttempted)
        foulShotsPercentage = try totalLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .foulShotsPercentage)
        offensiveRebounds = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .offensiveRebounds)
        defensiveRebounds = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .defensiveRebounds)
        rebounds = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .rebounds)
        assists = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .assists)
        steals = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .steals)
        blocks = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .blocks)
        turnovers = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .turnovers)
        personalFouls = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .personalFouls)
        playerEfficiency = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .playerEfficiency)
        points = try totalLeagueLeaderCodingKeysContainer.decode(Int.self, forKey: .points)
        assistsToTurnovers = try totalLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .assistsToTurnovers)
        stealsToTurnovers = try totalLeagueLeaderCodingKeysContainer.decode(Double.self, forKey: .stealsToTurnovers)
    }
}

extension TotalLeagueLeader: Decodable {

    // MARK: Coding Keys

    enum TotalLeagueLeaderCodingKeys: String, CodingKey {

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
        case assistsToTurnovers = "AST_TOV"
        case stealsToTurnovers = "STL_TOV"
    }
}

struct TotalLeagueLeaderApiResponse {

    // MARK: Internal Properties

    var totalLeagueLeaders: [TotalLeagueLeader]
}

extension TotalLeagueLeaderApiResponse {

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

            self.totalLeagueLeaders = [TotalLeagueLeader]()
            for totalLeagueLeaderRowArray in rowSetArray {
                let totalLeagueLeaderDictionary = Dictionary(uniqueKeysWithValues: zip(headersDictionary, totalLeagueLeaderRowArray))
                guard let jsonTotalLeagueLeaderData = try? JSONSerialization.data(withJSONObject: totalLeagueLeaderDictionary,
                                                                                 options: []) else {
                        return nil
                }

                let totalLeagueLeader = try JSONDecoder().decode(TotalLeagueLeader.self, from: jsonTotalLeagueLeaderData)
                self.totalLeagueLeaders.append(totalLeagueLeader)
            }
        } catch {
            return nil
        }
    }
}
