//
//  ActivePlayer.swift
//  JumpShot
//
//  Created by Jerel Rocktaschel on 6/23/21.
//

import Foundation

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
