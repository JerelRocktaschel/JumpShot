//
//  BoxscoreTeamStatTotals.swift
//  JumpShot
//
//  Created by Jerel Rocktaschel on 6/23/21.
//

import Foundation

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
