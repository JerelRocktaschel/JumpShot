//
//  Boxscore.swift
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

public struct Arena: Decodable {
    let name: String
    let isDomestic: Bool
    let city: String
    let stateAbbr: String
    let country: String
}

public struct BoxscorePeriod: Decodable {
    let current: Int
    let type: Int
    let maxRegular: Int
    let isHalftime: Bool
    let isEndOfPeriod: Bool
}

public struct GameDuration {
    let hours: Int
    let minutes: Int

    public init(from decoder: Decoder) throws {
        let gameDurationContainer = try decoder.container(keyedBy: GameDurationCodingKeys.self)
        let hoursString = try gameDurationContainer.decode(String.self, forKey: .hours)
        let minutesString = try gameDurationContainer.decode(String.self, forKey: .minutes)

        if let hoursInt = Int(hoursString) {
            hours = hoursInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .hours,
                                                   in: gameDurationContainer,
                                                   debugDescription: "Hours is not in expected format.")
        }

        if let minutesInt = Int(minutesString) {
            minutes = minutesInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .minutes,
                                                   in: gameDurationContainer,
                                                   debugDescription: "Minutes is not in expected format.")
        }
    }
}

extension GameDuration: Decodable {

    // MARK: Coding Keys

    enum GameDurationCodingKeys: String, CodingKey {
        case hours
        case minutes
    }
}

public struct Official {
    let fullName: String
}

public struct Score {
    let score: Int
}

public enum BoxscoreTeamLeaderCategory {
    case assists
    case rebounds
    case points
}

public struct BoxscoreTeamLeader {
    let boxscoreTeamLeaderCategory: BoxscoreTeamLeaderCategory
    let value: Int
    let playerId: [String]
}

public struct ActivePlayer {
    let personId: String
    let firstName: String
    let lastName: String
    let jersey: Int
    let isOnCourt: Bool
    let points: Int
    let position: String
    let positionFull: String
    let min: String
    let fgm: Int
    let fga: Int
    let fgp: Double
    let ftm: Int
    let fta: Int
    let ftp: Double
    let tpm: Int
    let tpa: Int
    let tpp: Double
    let offReb: Int
    let defReb: Int
    let totReb: Int
    let assists: Int
    let pFouls: Int
    let steals: Int
    let turnovers: Int
    let blocks: Int
    let plusMinus: Int
    let dnp: String
}

public struct BoxscoreTeamData {
    let teamId: String
    let wins: Int
    let losses: Int
    let seriesWins: Int
    let seriesLosses: Int
    let score: Int
    let linescore: [Score]

    public init(from decoder: Decoder) throws {
        let boxscoreTeamDataContainer = try decoder.container(keyedBy: BoxscoreTeamDataCodingKeys.self)
        let winsString = try boxscoreTeamDataContainer.decode(String.self, forKey: .wins)
        let lossesString = try boxscoreTeamDataContainer.decode(String.self, forKey: .losses)
        let seriesWinsString = try boxscoreTeamDataContainer.decode(String.self, forKey: .seriesWins)
        let seriesLossesString = try boxscoreTeamDataContainer.decode(String.self, forKey: .seriesLosses)
        let scoreString = try boxscoreTeamDataContainer.decode(String.self, forKey: .score)
        let scoreList = try boxscoreTeamDataContainer.decode([[String: String]].self, forKey: .linescore)

        teamId = try boxscoreTeamDataContainer.decode(String.self, forKey: .teamId)

        if let winsInt = Int(winsString) {
            wins = winsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .wins,
                                                   in: boxscoreTeamDataContainer,
                                                   debugDescription: "Wins is not in expected format.")
        }

        if let lossesInt = Int(lossesString) {
            losses = lossesInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .losses,
                                                   in: boxscoreTeamDataContainer,
                                                   debugDescription: "Losses is not in expected format.")
        }

        if let seriesWinsInt = Int(seriesWinsString) {
            seriesWins = seriesWinsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .seriesWins,
                                                   in: boxscoreTeamDataContainer,
                                                   debugDescription: "Series wins is not in expected format.")
        }

        if let seriesLossesInt = Int(seriesLossesString) {
            seriesLosses = seriesLossesInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .seriesLosses,
                                                   in: boxscoreTeamDataContainer,
                                                   debugDescription: "Series losses is not in expected format.")
        }

        if let scoreInt = Int(scoreString) {
            score = scoreInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .score,
                                                   in: boxscoreTeamDataContainer,
                                                   debugDescription: "Score wins is not in expected format.")
        }

        var scoreArray = [Score]()
        for score in scoreList {
            if let scoreString = score["score"] {
                if let scoreInt = Int(scoreString) {
                    let score = Score(score: scoreInt)
                    scoreArray.append(score)
                }
            }
        }
        linescore = scoreArray
    }
}

extension BoxscoreTeamData: Decodable {

    // MARK: Coding Keys

    enum BoxscoreTeamDataCodingKeys: String, CodingKey {
        case teamId
        case wins = "win"
        case losses = "loss"
        case seriesWins = "seriesWin"
        case seriesLosses = "seriesLoss"
        case score
        case linescore
    }
}

public struct BoxscoreStats {
    let timesTied: Int
    let leadChanges: Int
    //let teamsStats: [BoxscoreTeamStats]

    public init(from decoder: Decoder) throws {
        let boxscoreStatsDataContainer = try decoder.container(keyedBy: BoxscoreStatsDataCodingKeys.self)
        let timesTiedString = try boxscoreStatsDataContainer.decode(String.self, forKey: .timesTied)
        let leadChangesString = try boxscoreStatsDataContainer.decode(String.self, forKey: .leadChanges)

        if let timesTiedInt = Int(timesTiedString) {
            timesTied = timesTiedInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .timesTied,
                                                   in: boxscoreStatsDataContainer,
                                                   debugDescription: "Times tied is not in expected format.")
        }
        
        if let leadChangesInt = Int(leadChangesString) {
            leadChanges = leadChangesInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .leadChanges,
                                                   in: boxscoreStatsDataContainer,
                                                   debugDescription: "Lead changes wins is not in expected format.")
        }
    }
}

extension BoxscoreStats: Decodable {

    // MARK: Coding Keys

    enum BoxscoreStatsDataCodingKeys: String, CodingKey {
        case timesTied
        case leadChanges
    }
}

public struct BoxscoreTeamStats {
    let isHomeTeam: Bool
    let fastBreakPoints: Int
    let pointsInPaint: Int
    let biggestLead: Int
    let secondChancePoints: Int
    let pointsOffTurnovers: Int
    let longestRun: Int
    let points: Int
    let fgm: Int
    let fga: Int
    let fgp: Int
    let ftm: Int
    let fta: Int
    let ftp: Double
    let tpm: Int
    let tpa: Int
    let tpp: Double
    let offReb: Int
    let defReb: Int
    let totReb: Int
    let assists: Int
    let personalFouls: Int
    let steals: Int
    let turnovers: Int
    let blocks: Int
    let plusMinus: Int
    let min: Double
    let shortTimeoutTemaining: Int
    let fullTimeoutTemaining: Int
    let teamFouls: Int
    let boxscoreTeamLeaders: [BoxscoreTeamLeader]
    let activePlayers: [ActivePlayer]
}

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
    let teamsData: [BoxscoreTeamData]

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

        var teamsDataArray = [BoxscoreTeamData]()
        let homeTeamData = try boxscoreContainer.decode(BoxscoreTeamData.self, forKey: .hTeam)
        let visitorTeamData = try boxscoreContainer.decode(BoxscoreTeamData.self, forKey: .vTeam)
        teamsDataArray.append(homeTeamData)
        teamsDataArray.append(visitorTeamData)
        teamsData = teamsDataArray
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

public struct Boxscore {

    // MARK: Internal Properties

    let basicGameData: BasicGameData
    let boxscoreStats: BoxscoreStats
    
}

struct BoxscoreApiResponse {

    // MARK: Internal Properties

    var boxscore: Boxscore
}

extension BoxscoreApiResponse {

    // MARK: Init

    init?(json: [String: Any]) {

        guard let basicGameDataSetDictionary = json["basicGameData"] as? JSONDictionary else {
            return nil
        }
        
        guard let gameStatsSetDictionary = json["stats"] as? JSONDictionary else {
            return nil
        }

        var basicGameData: BasicGameData
        do {
            guard let jsonBoxscoreData = try? JSONSerialization.data(withJSONObject: basicGameDataSetDictionary,
                                                                     options: []) else {
                    return nil
            }

            let basicGameDataDecoded = try JSONDecoder().decode(BasicGameData.self, from: jsonBoxscoreData)
            basicGameData = basicGameDataDecoded
            } catch {
                return nil
        }
        
        var boxscoreStats: BoxscoreStats
        do {
            guard let jsonBoxscoreStatsData = try? JSONSerialization.data(withJSONObject: gameStatsSetDictionary,
                                                                     options: []) else {
                    return nil
            }

            let boxscoreStatsDataDecoded = try JSONDecoder().decode(BoxscoreStats.self, from: jsonBoxscoreStatsData)
            boxscoreStats = boxscoreStatsDataDecoded
            } catch {
                return nil
        }

        
        self.boxscore = Boxscore(basicGameData: basicGameData, boxscoreStats: boxscoreStats)
    }
}
