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

    public init?(with values: [Any]) throws {

        guard let intPlayerId = values[0] as? Int,
              let intRank = values[1]  as? Int,
              let strPlayer = values[2] as? String,
              let strTeam = values[3] as? String,
              let intGamesPlayed = values[4] as? Int,
              let intMinutes = values[5] as? Int,
              let intFGMade = values[6] as? Int,
              let intFGAttempts = values[7] as? Int,
              let dblFieldGoalsPercentage = values[8] as? Double,
              let int3PMade = values[9] as? Int,
              let int3PAttemps = values[10] as? Int,
              let dbl3PPercent = values[11] as? Double,
              let intFtMade = values[12] as? Int,
              let intFtAttempts = values[13] as? Int,
              let dblFtPercentage = values[14] as? Double,
              let intOffensiveRebounds = values[15] as? Int,
              let intDefensiveRebounds = values[16] as? Int,
              let intRebounds = values[17] as? Int,
              let intAssists = values[18] as? Int,
              let intSteals = values[19] as? Int,
              let intBlocks = values[20] as? Int,
              let intTurnovers = values[21] as? Int,
              let intPersonalFouls = values[22] as? Int,
              let intPlayerEfficiency = values[23] as? Int,
              let intPoints = values[24] as? Int,
              let dblAssistsToTurnovers = values[25] as? Double,
              let dblStealsToTurnovers = values[26] as? Double else {
            throw JumpShotNetworkManagerError.unableToDecodeError
        }
        self.playerId = String(intPlayerId)
        self.rank = intRank
        self.player = strPlayer
        self.team = strTeam
        self.gamesPlayed = intGamesPlayed
        self.minutes = intMinutes
        self.fieldGoalsMade = intFGMade
        self.fieldGoalsAttempted = intFGAttempts
        self.fieldGoalsPercentage = dblFieldGoalsPercentage
        self.threePointersMade = int3PMade
        self.threePointersAttempted = int3PAttemps
        self.threePointersPercentage = dbl3PPercent
        self.foulShotsMade = intFtMade
        self.foulShotsAttempted = intFtAttempts
        self.foulShotsPercentage = dblFtPercentage
        self.offensiveRebounds = intOffensiveRebounds
        self.defensiveRebounds = intDefensiveRebounds
        self.rebounds = intRebounds
        self.assists = intAssists
        self.steals = intSteals
        self.blocks = intBlocks
        self.turnovers = intTurnovers
        self.personalFouls = intPersonalFouls
        self.playerEfficiency = intPlayerEfficiency
        self.points = intPoints
        self.assistsToTurnovers = dblAssistsToTurnovers
        self.stealsToTurnovers = dblStealsToTurnovers
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

            guard let rowSetArray = resultSetDictionary["rowSet"] as? [[Any]] else {
                return nil
            }

            self.totalLeagueLeaders = [TotalLeagueLeader]()
            for totalLeagueLeaderRowArray in rowSetArray {
                if let totalLeagueLeader = try TotalLeagueLeader(with: totalLeagueLeaderRowArray) {
                    totalLeagueLeaders.append(totalLeagueLeader)
                } else {
                    return nil
                }
            }
            } catch {
                return nil
        }
    }
}
