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

extension Arena: Equatable {

    // MARK: Equatable

    public static func ==(lhs: Arena, rhs: Arena) -> Bool {
        return lhs.name == rhs.name &&
        lhs.isDomestic == rhs.isDomestic &&
        lhs.city == rhs.city &&
        lhs.stateAbbr == rhs.stateAbbr &&
        lhs.country == rhs.country
    }
}

public struct BoxscorePeriod: Decodable {
    let current: Int
    let type: Int
    let maxRegular: Int
    let isHalftime: Bool
    let isEndOfPeriod: Bool
}

extension BoxscorePeriod: Equatable {

    // MARK: Equatable

    public static func ==(lhs: BoxscorePeriod, rhs: BoxscorePeriod) -> Bool {
        return lhs.current == rhs.current &&
        lhs.type == rhs.type &&
        lhs.maxRegular == rhs.maxRegular &&
        lhs.isHalftime == rhs.isHalftime &&
        lhs.isEndOfPeriod == rhs.isEndOfPeriod
    }
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

extension GameDuration: Equatable {

    // MARK: Equatable

    public static func ==(lhs: GameDuration, rhs: GameDuration) -> Bool {
        return lhs.hours == rhs.hours &&
        lhs.minutes == rhs.minutes
    }
}

public struct Official {
    let fullName: String
}

extension Official: Equatable {

    // MARK: Equatable

    public static func ==(lhs: Official, rhs: Official) -> Bool {
        return lhs.fullName == rhs.fullName
    }
}

public struct Score {
    let score: Int
}

extension Score: Equatable {

    // MARK: Equatable

    public static func ==(lhs: Score, rhs: Score) -> Bool {
        return lhs.score == rhs.score
    }
}

extension BoxscoreTeamData: Equatable {

    // MARK: Equatable

    public static func == (lhs: BoxscoreTeamData, rhs: BoxscoreTeamData) -> Bool {
        return lhs.teamId == rhs.teamId &&
        lhs.triCode == rhs.triCode &&
        lhs.wins == rhs.wins &&
        lhs.losses == rhs.losses &&
        lhs.seriesWins == rhs.seriesWins &&
        lhs.seriesLosses == rhs.seriesLosses &&
        lhs.score == rhs.score &&
        lhs.linescore == rhs.linescore
    }
}

public struct BoxscoreTeamData {
    let teamId: String
    let triCode: String
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
        triCode = try boxscoreTeamDataContainer.decode(String.self, forKey: .triCode)

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
        case triCode
        case wins = "win"
        case losses = "loss"
        case seriesWins = "seriesWin"
        case seriesLosses = "seriesLoss"
        case score
        case linescore
    }
}

public struct ActivePlayer {
    let playerId: String
    let firstName: String
    let lastName: String
    let teamId: String
    let isOnCourt: Bool
    let position: String
    let positionFull: String
    let points: Int
    let fgm: Int
    let fga: Int
    let fgp: Double
    let ftm: Int
    let fta: Int
    let ftp: Double
    let tpm: Int
    let tpa: Int
    let tpp: Double
    let offensiveRebounds: Int
    let defensiveRebounds: Int
    let totalRebounds: Int
    let assists: Int
    let personalFouls: Int
    let steals: Int
    let turnovers: Int
    let blocks: Int
    let plusMinus: Int
    let minutes: Int
    let seconds: Int

    public init(from decoder: Decoder) throws {
        let activePlayerCodingKeysDataContainer = try decoder.container(keyedBy: ActivePlayerCodingKeys.self)
        let pointsString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .points)
        let fgmString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .fgm)
        let fgaString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .fga)
        let fgpString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .fgp)
        let ftmString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .ftm)
        let ftaString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .fta)
        let ftpString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .ftp)
        let tpmString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .tpm)
        let tpaString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .tpa)
        let tppString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .tpp)
        let offensiveReboundsString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .offensiveRebounds)
        let defensiveReboundsString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .defensiveRebounds)
        let totalReboundsString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .totalRebounds)
        let assistsString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .assists)
        let personalFoulsString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .personalFouls)
        let stealsString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .steals)
        let turnoversString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .turnovers)
        let blocksString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .blocks)
        let plusMinusString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .plusMinus)
        let minutesString = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .minutes)
        
        if let pointsInt = Int(pointsString) {
            points = pointsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .points,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Points is not in expected format.")
        }
        
        if let fgmInt = Int(fgmString) {
            fgm = fgmInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .fgm,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Field goals made is not in expected format.")
        }

        if let fgaInt = Int(fgaString) {
            fga = fgaInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .fga,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Field goals attempted is not in expected format.")
        }

        if let fgpDouble = Double(fgpString) {
            fgp = fgpDouble
        } else {
            throw DecodingError.dataCorruptedError(forKey: .fgp,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Field goals percentage is not in expected format.")
        }
        
        if let ftmInt = Int(ftmString) {
            ftm = ftmInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .ftm,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Foul shots made is not in expected format.")
        }

        if let ftaInt = Int(ftaString) {
            fta = ftaInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .fta,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Foul shots attempted is not in expected format.")
        }

        if let ftpDouble = Double(ftpString) {
            ftp = ftpDouble
        } else {
            throw DecodingError.dataCorruptedError(forKey: .ftp,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Foul shots percentage is not in expected format.")
        }

        if let tpmInt = Int(tpmString) {
            tpm = tpmInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .tpm,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Total points made is not in expected format.")
        }

        if let tpaInt = Int(tpaString) {
            tpa = tpaInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .tpa,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Total points attempted is not in expected format.")
        }

        if let tppDouble = Double(tppString) {
            tpp = tppDouble
        } else {
            throw DecodingError.dataCorruptedError(forKey: .tpp,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Total points percentage is not in expected format.")
        }

        if let offensiveReboundsInt = Int(offensiveReboundsString) {
            offensiveRebounds = offensiveReboundsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .offensiveRebounds,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Offensive Rebounds is not in expected format.")
        }

        if let defensiveReboundsInt = Int(defensiveReboundsString) {
            defensiveRebounds = defensiveReboundsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .defensiveRebounds,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Defensive Rebounds is not in expected format.")
        }

        if let totalReboundsInt = Int(totalReboundsString) {
            totalRebounds = totalReboundsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .totalRebounds,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Total Rebounds is not in expected format.")
        }

        if let assistsInt = Int(assistsString) {
            assists = assistsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .assists,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Assists is not in expected format.")
        }

        if let personalFoulsInt = Int(personalFoulsString) {
            personalFouls = personalFoulsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .personalFouls,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Personal Fouls is not in expected format.")
        }

        if let stealsInt = Int(stealsString) {
            steals = stealsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .steals,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Steals is not in expected format.")
        }

        if let turnoversInt = Int(turnoversString) {
            turnovers = turnoversInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .turnovers,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Turnovers is not in expected format.")
        }

        if let blocksInt = Int(blocksString) {
            blocks = blocksInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .blocks,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Blocks is not in expected format.")
        }

        if let plusMinusInt = Int(plusMinusString) {
            plusMinus = plusMinusInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .plusMinus,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Plus Minus is not in expected format.")
        }

        let delimeter = ":"
        let separatedMinutesString = minutesString.components(separatedBy: delimeter)

        if let minutesInt = Int(separatedMinutesString[0]), let secondsInt = Int(separatedMinutesString[1]) {
            minutes = minutesInt
            seconds = secondsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .plusMinus,
                                                   in: activePlayerCodingKeysDataContainer,
                                                   debugDescription: "Minutes is not in expected format.")
        }

        playerId = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .playerId)
        firstName = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .firstName)
        lastName = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .lastName)
        teamId = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .teamId)
        isOnCourt = try activePlayerCodingKeysDataContainer.decode(Bool.self, forKey: .isOnCourt)
        position = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .position)
        positionFull = try activePlayerCodingKeysDataContainer.decode(String.self, forKey: .positionFull)
    }
}

extension ActivePlayer: Equatable {

    // MARK: Equatable

    public static func == (lhs: ActivePlayer, rhs: ActivePlayer) -> Bool {
        return lhs.playerId == rhs.playerId &&
        lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName &&
        lhs.teamId == rhs.teamId &&
        lhs.isOnCourt == rhs.isOnCourt &&
        lhs.position == rhs.position &&
        lhs.positionFull == rhs.positionFull &&
        lhs.points == rhs.points &&
        lhs.fgm == rhs.fgm &&
        lhs.fga == rhs.fga &&
        lhs.fgp == rhs.fgp &&
        lhs.ftm == rhs.ftm &&
        lhs.fta == rhs.fta &&
        lhs.ftp == rhs.ftp &&
        lhs.tpm == rhs.tpm &&
        lhs.tpa == rhs.tpa &&
        lhs.tpp == rhs.tpp &&
        lhs.offensiveRebounds == rhs.offensiveRebounds &&
        lhs.defensiveRebounds == rhs.defensiveRebounds &&
        lhs.totalRebounds == rhs.totalRebounds &&
        lhs.assists == rhs.assists &&
        lhs.personalFouls == rhs.personalFouls &&
        lhs.steals == rhs.steals &&
        lhs.turnovers == rhs.turnovers &&
        lhs.blocks == rhs.blocks &&
        lhs.plusMinus == rhs.plusMinus &&
        lhs.minutes == rhs.minutes &&
        lhs.seconds == rhs.seconds
    }
}

extension ActivePlayer: Decodable {

    // MARK: Coding Keys

    enum ActivePlayerCodingKeys: String, CodingKey {
        case playerId = "personId"
        case firstName
        case lastName
        case teamId
        case isOnCourt
        case position = "pos"
        case positionFull = "position_full"
        case points
        case fgm
        case fga
        case fgp
        case ftm
        case fta
        case ftp
        case tpm
        case tpa
        case tpp
        case offensiveRebounds = "offReb"
        case defensiveRebounds = "defReb"
        case totalRebounds = "totReb"
        case assists
        case personalFouls = "pFouls"
        case steals
        case turnovers
        case blocks
        case minutes = "min"
        case plusMinus
    }
}

public struct BoxscoreStats {
    let timesTied: Int
    let leadChanges: Int
    let visitorTeamStats: BoxscoreTeamStats
    let homeTeamStats: BoxscoreTeamStats
    let activePlayers: [ActivePlayer]

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

        visitorTeamStats = try boxscoreStatsDataContainer.decode(BoxscoreTeamStats.self, forKey: .vTeam)
        homeTeamStats = try boxscoreStatsDataContainer.decode(BoxscoreTeamStats.self, forKey: .hTeam)
        activePlayers = try boxscoreStatsDataContainer.decode([ActivePlayer].self, forKey: .activePlayers)
    }
}

extension BoxscoreStats: Equatable {

    // MARK: Coding Keys

    enum BoxscoreStatsDataCodingKeys: String, CodingKey {
        case timesTied
        case leadChanges
        case vTeam
        case hTeam
        case activePlayers
    }
}

extension BoxscoreStats: Decodable {

    // MARK: Equatable

    public static func == (lhs: BoxscoreStats, rhs: BoxscoreStats) -> Bool {
        return lhs.timesTied == rhs.timesTied &&
        lhs.leadChanges == rhs.leadChanges &&
        lhs.visitorTeamStats == rhs.visitorTeamStats &&
        lhs.homeTeamStats == rhs.homeTeamStats &&
        lhs.activePlayers == rhs.activePlayers
    }
}

public struct BoxscoreTeamStatTotals {
    let points: Int
    let fgm: Int
    let fga: Int
    let fgp: Double
    let ftm: Int
    let fta: Int
    let ftp: Double
    let tpm: Int
    let tpa: Int
    let tpp: Double
    let offensiveRebounds: Int
    let defensiveRebounds: Int
    let totalRebounds: Int
    let assists: Int
    let personalFouls: Int
    let steals: Int
    let turnovers: Int
    let blocks: Int
    let plusMinus: Int
    let minutes: Int
    let seconds: Int
    let shortTimeoutsRemaining: Int
    let fullTimeoutsRemaining: Int
    let teamFouls: Int
    
    public init(from decoder: Decoder) throws {
        let boxscoreTeamStatTotalsDataContainer = try decoder.container(keyedBy: BoxscoreTeamStatTotalsCodingKeys.self)
        let pointsString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .points)
        let fgmString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .fgm)
        let fgaString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .fga)
        let fgpString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .fgp)
        let ftmString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .ftm)
        let ftaString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .fta)
        let ftpString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .ftp)
        let tpmString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .tpm)
        let tpaString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .tpa)
        let tppString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .tpp)
        let offensiveReboundsString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .offensiveRebounds)
        let defensiveReboundsString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .defensiveRebounds)
        let totalReboundsString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .totalRebounds)
        let assistsString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .assists)
        let personalFoulsString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .personalFouls)
        let stealsString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .steals)
        let turnoversString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .turnovers)
        let blocksString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .blocks)
        let plusMinusString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .plusMinus)
        let minutesString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .minutes)
        let shortTimeoutsRemainingString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .shortTimeoutsRemaining )
        let fullTimeoutsRemainingString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .fullTimeoutsRemaining)
        let teamFoulsString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .teamFouls)
        
        if let pointsInt = Int(pointsString) {
            points = pointsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .points,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Points is not in expected format.")
        }
        
        if let fgmInt = Int(fgmString) {
            fgm = fgmInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .fgm,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Field goals made is not in expected format.")
        }
        
        if let fgaInt = Int(fgaString) {
            fga = fgaInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .fga,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Field goals attempted is not in expected format.")
        }
        
        if let fgpDouble = Double(fgpString) {
            fgp = fgpDouble
        } else {
            throw DecodingError.dataCorruptedError(forKey: .fgp,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Field goals percentage is not in expected format.")
        }
        
        if let ftmInt = Int(ftmString) {
            ftm = ftmInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .ftm,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Foul shots made is not in expected format.")
        }
        
        if let ftaInt = Int(ftaString) {
            fta = ftaInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .fta,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Foul shots attempted is not in expected format.")
        }
        
        if let ftpDouble = Double(ftpString) {
            ftp = ftpDouble
        } else {
            throw DecodingError.dataCorruptedError(forKey: .ftp,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Foul shots percentage is not in expected format.")
        }
        
        if let tpmInt = Int(tpmString) {
            tpm = tpmInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .tpm,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Total points made is not in expected format.")
        }
        
        if let tpaInt = Int(tpaString) {
            tpa = tpaInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .tpa,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Total points attempted is not in expected format.")
        }
        
        if let tppDouble = Double(tppString) {
            tpp = tppDouble
        } else {
            throw DecodingError.dataCorruptedError(forKey: .tpp,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Total points percentage is not in expected format.")
        }
        
        if let offensiveReboundsInt = Int(offensiveReboundsString) {
            offensiveRebounds = offensiveReboundsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .offensiveRebounds,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Offensive Rebounds is not in expected format.")
        }
        
        if let defensiveReboundsInt = Int(defensiveReboundsString) {
            defensiveRebounds = defensiveReboundsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .defensiveRebounds,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Defensive Rebounds is not in expected format.")
        }
        
        if let totalReboundsInt = Int(totalReboundsString) {
            totalRebounds = totalReboundsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .totalRebounds,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Total Rebounds is not in expected format.")
        }
        
        if let assistsInt = Int(assistsString) {
            assists = assistsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .assists,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Assists is not in expected format.")
        }
        
        if let personalFoulsInt = Int(personalFoulsString) {
            personalFouls = personalFoulsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .personalFouls,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Personal Fouls is not in expected format.")
        }
        
        if let stealsInt = Int(stealsString) {
            steals = stealsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .steals,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Steals is not in expected format.")
        }
        
        if let turnoversInt = Int(turnoversString) {
            turnovers = turnoversInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .turnovers,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Turnovers is not in expected format.")
        }
        
        if let blocksInt = Int(blocksString) {
            blocks = blocksInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .blocks,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Blocks is not in expected format.")
        }
        
        if let plusMinusInt = Int(plusMinusString) {
            plusMinus = plusMinusInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .plusMinus,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Plus Minus is not in expected format.")
        }
        
        //minutes seconds
        let delimeter = ":"
        let separatedMinutesString = minutesString.components(separatedBy: delimeter)
        
        if let minutesInt = Int(separatedMinutesString[0]), let secondsInt = Int(separatedMinutesString[1]) {
            minutes = minutesInt
            seconds = secondsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .plusMinus,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Plus Minus is not in expected format.")
        }
        
        if let shortTimeoutsRemainingInt = Int(shortTimeoutsRemainingString) {
            shortTimeoutsRemaining = shortTimeoutsRemainingInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .shortTimeoutsRemaining,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Short Timeouts Remaining is not in expected format.")
        }
        
        if let fullTimeoutsRemainingInt = Int(fullTimeoutsRemainingString) {
            fullTimeoutsRemaining = fullTimeoutsRemainingInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .fullTimeoutsRemaining,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Full Timeouts Remaining is not in expected format.")
        }
        
        if let teamFoulsInt = Int(teamFoulsString) {
            teamFouls = teamFoulsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .teamFouls,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Team Fouls is not in expected format.")
        }
    }
}

extension BoxscoreTeamStatTotals: Equatable {
    
    // MARK: Equatable

    public static func ==(lhs: BoxscoreTeamStatTotals, rhs: BoxscoreTeamStatTotals) -> Bool {
        return lhs.points == rhs.points &&
        lhs.points == rhs.points &&
        lhs.fgm == rhs.fgm &&
        lhs.fga == rhs.fga &&
        lhs.fgp == rhs.fgp &&
        lhs.ftm == rhs.ftm &&
        lhs.fta == rhs.fta &&
        lhs.ftp == rhs.ftp &&
        lhs.tpm == rhs.tpm &&
        lhs.tpa == rhs.tpa &&
        lhs.tpp == rhs.tpp &&
        lhs.offensiveRebounds == rhs.offensiveRebounds &&
        lhs.defensiveRebounds == rhs.defensiveRebounds &&
        lhs.totalRebounds == rhs.totalRebounds &&
        lhs.assists == rhs.assists &&
        lhs.personalFouls == rhs.personalFouls &&
        lhs.turnovers == rhs.turnovers &&
        lhs.plusMinus == rhs.plusMinus &&
        lhs.minutes == rhs.minutes &&
        lhs.seconds == rhs.seconds &&
        lhs.steals == rhs.steals &&
        lhs.blocks == rhs.blocks &&
        lhs.shortTimeoutsRemaining == rhs.shortTimeoutsRemaining &&
        lhs.fullTimeoutsRemaining == rhs.fullTimeoutsRemaining &&
        lhs.teamFouls == rhs.teamFouls
    }
}

extension BoxscoreTeamStatTotals: Decodable {

    // MARK: Coding Keys

    enum BoxscoreTeamStatTotalsCodingKeys: String, CodingKey {
        case points
        case fgm
        case fga
        case fgp
        case ftm
        case fta
        case ftp
        case tpm
        case tpa
        case tpp
        case offensiveRebounds = "offReb"
        case defensiveRebounds = "defReb"
        case totalRebounds = "totReb"
        case assists
        case personalFouls = "pFouls"
        case steals
        case turnovers
        case blocks
        case plusMinus
        case minutes = "min"
        case shortTimeoutsRemaining = "short_timeout_remaining"
        case fullTimeoutsRemaining = "full_timeout_remaining"
        case teamFouls = "team_fouls"
    }
}

public struct BoxscoreTeamStats {
    let fastBreakPoints: Int
    let pointsInPaint: Int
    let biggestLead: Int
    let secondChancePoints: Int
    let pointsOffTurnovers: Int
    let longestRun: Int
    let totals: BoxscoreTeamStatTotals

    public init(from decoder: Decoder) throws {
        let boxscoreTeamStatsDataContainer = try decoder.container(keyedBy: BoxscoreTeamStatsDataCodingKeys.self)
        let fastBreakPointsString = try boxscoreTeamStatsDataContainer.decode(String.self, forKey: .fastBreakPoints)
        let pointsInPaintString = try boxscoreTeamStatsDataContainer.decode(String.self, forKey: .pointsInPaint)
        let biggestLeadString = try boxscoreTeamStatsDataContainer.decode(String.self, forKey: .biggestLead)
        let secondChancePointsString = try boxscoreTeamStatsDataContainer.decode(String.self,
                                                                                 forKey: .secondChancePoints)
        let pointsOffTurnoversString = try boxscoreTeamStatsDataContainer.decode(String.self,
                                                                                 forKey: .pointsOffTurnovers)
        let longestRunString = try boxscoreTeamStatsDataContainer.decode(String.self, forKey: .longestRun)

        if let fastBreakPointsInt = Int(fastBreakPointsString) {
            fastBreakPoints = fastBreakPointsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .fastBreakPoints,
                                                   in: boxscoreTeamStatsDataContainer,
                                                   debugDescription: "Fast break points is not in expected format.")
        }

        if let pointsInPaintInt = Int(pointsInPaintString) {
            pointsInPaint = pointsInPaintInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .pointsInPaint,
                                                   in: boxscoreTeamStatsDataContainer,
                                                   debugDescription: "Fast break points is not in expected format.")
        }

        if let biggestLeadInt = Int(biggestLeadString) {
            biggestLead = biggestLeadInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .biggestLead,
                                                   in: boxscoreTeamStatsDataContainer,
                                                   debugDescription: "Biggest lead is not in expected format.")
        }

        if let secondChancePointsInt = Int(secondChancePointsString) {
            secondChancePoints = secondChancePointsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .secondChancePoints,
                                                   in: boxscoreTeamStatsDataContainer,
                                                   debugDescription: "Second chance points is not in expected format.")
        }

        if let pointsOffTurnoversInt = Int(pointsOffTurnoversString) {
            pointsOffTurnovers = pointsOffTurnoversInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .pointsOffTurnovers,
                                                   in: boxscoreTeamStatsDataContainer,
                                                   debugDescription: "Points off turnovers is not in expected format.")
        }

        if let longestRunInt = Int(longestRunString) {
            longestRun = longestRunInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .longestRun,
                                                   in: boxscoreTeamStatsDataContainer,
                                                   debugDescription: "Longest run is not in expected format.")
        }

        totals = try boxscoreTeamStatsDataContainer.decode(BoxscoreTeamStatTotals.self, forKey: .totals)

    }
}

extension BoxscoreTeamStats: Equatable {

    // MARK: Equatable

    public static func == (lhs: BoxscoreTeamStats, rhs: BoxscoreTeamStats) -> Bool {
        return lhs.fastBreakPoints == rhs.fastBreakPoints &&
        lhs.pointsInPaint == rhs.pointsInPaint &&
        lhs.biggestLead == rhs.biggestLead &&
        lhs.secondChancePoints == rhs.secondChancePoints &&
        lhs.pointsOffTurnovers == rhs.pointsOffTurnovers &&
        lhs.longestRun == rhs.longestRun &&
        lhs.totals == rhs.totals
    }
}

extension BoxscoreTeamStats: Decodable {

    // MARK: Coding Keys

    enum BoxscoreTeamStatsDataCodingKeys: String, CodingKey {
        case fastBreakPoints
        case pointsInPaint
        case biggestLead
        case secondChancePoints
        case pointsOffTurnovers
        case longestRun
        case totals
        case leaders
    }
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

        guard let basicGameDataDictionary = json["basicGameData"] as? JSONDictionary else {
            return nil
        }

        guard let gameStatsDictionary = json["stats"] as? JSONDictionary else {
            return nil
        }

        var basicGameData: BasicGameData
        do {
            guard let jsonBoxscoreData = try? JSONSerialization.data(withJSONObject: basicGameDataDictionary,
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
            guard let jsonBoxscoreStatsData = try? JSONSerialization.data(withJSONObject: gameStatsDictionary,
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
