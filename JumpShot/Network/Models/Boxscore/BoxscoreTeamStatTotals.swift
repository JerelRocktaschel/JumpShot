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
        let offensiveReboundsString = try boxscoreTeamStatTotalsDataContainer.decode(String.self,
                                                                                     forKey: .offensiveRebounds)
        let defensiveReboundsString = try boxscoreTeamStatTotalsDataContainer.decode(String.self,
                                                                                     forKey: .defensiveRebounds)
        let totalReboundsString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .totalRebounds)
        let assistsString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .assists)
        let personalFoulsString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .personalFouls)
        let stealsString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .steals)
        let turnoversString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .turnovers)
        let blocksString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .blocks)
        let plusMinusString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .plusMinus)
        let minutesString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .minutes)
        let shortTimeoutsRemainingString =
            try boxscoreTeamStatTotalsDataContainer.decode(String.self,
                                                           forKey: .shortTimeoutsRemaining )
        let fullTimeoutsRemainingString = try boxscoreTeamStatTotalsDataContainer.decode(String.self,
                                                                                         forKey: .fullTimeoutsRemaining)
        let teamFoulsString = try boxscoreTeamStatTotalsDataContainer.decode(String.self, forKey: .teamFouls)
        let delimeter = ":"
        let separatedMinutesString = minutesString.components(separatedBy: delimeter)

        if let pointsInt = Int(pointsString),
           let fgmInt = Int(fgmString),
           let fgaInt = Int(fgaString),
           let fgpDouble = Double(fgpString),
           let ftmInt = Int(ftmString),
           let ftaInt = Int(ftaString),
           let ftpDouble = Double(ftpString),
           let tpmInt = Int(tpmString),
           let tpaInt = Int(tpaString),
           let tppDouble = Double(tppString),
           let offensiveReboundsInt = Int(offensiveReboundsString),
           let defensiveReboundsInt = Int(defensiveReboundsString),
           let totalReboundsInt = Int(totalReboundsString),
           let assistsInt = Int(assistsString),
           let personalFoulsInt = Int(personalFoulsString),
           let stealsInt = Int(stealsString),
           let turnoversInt = Int(turnoversString),
           let blocksInt = Int(blocksString),
           let plusMinusInt = Int(plusMinusString),
           let minutesInt = Int(separatedMinutesString[0]), let secondsInt = Int(separatedMinutesString[1]),
           let shortTimeoutsRemainingInt = Int(shortTimeoutsRemainingString),
           let fullTimeoutsRemainingInt = Int(fullTimeoutsRemainingString),
           let teamFoulsInt = Int(teamFoulsString) {
            points = pointsInt
            fgm = fgmInt
            fga = fgaInt
            fgp = fgpDouble
            ftm = ftmInt
            fta = ftaInt
            ftp = ftpDouble
            tpm = tpmInt
            tpa = tpaInt
            tpp = tppDouble
            offensiveRebounds = offensiveReboundsInt
            defensiveRebounds = defensiveReboundsInt
            totalRebounds = totalReboundsInt
            assists = assistsInt
            personalFouls = personalFoulsInt
            steals = stealsInt
            turnovers = turnoversInt
            blocks = blocksInt
            plusMinus = plusMinusInt
            minutes = minutesInt
            seconds = secondsInt
            shortTimeoutsRemaining = shortTimeoutsRemainingInt
            fullTimeoutsRemaining = fullTimeoutsRemainingInt
            teamFouls = teamFoulsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .points,
                                                   in: boxscoreTeamStatTotalsDataContainer,
                                                   debugDescription: "Points is not in expected format.")
        }
    }
}

extension BoxscoreTeamStatTotals: Equatable {

    // MARK: Equatable

    public static func == (lhs: BoxscoreTeamStatTotals, rhs: BoxscoreTeamStatTotals) -> Bool {
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
