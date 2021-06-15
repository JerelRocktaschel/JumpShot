//
//  Boxscore.swift
//  JumpShot
//
//  Created by Jerel Rocktaschel on 6/11/21.
//

import Foundation

public struct Arena {
    let name: String
    let isDomestic: Bool
    let city: String
    let stateAbby: String
    let country: String
}

public struct BoxscorePeriod {
    let current: Int
    let type: Int
    let maxRegular: Int
    let isHalftime: Bool
    let isEndOfPeriod: Bool
}

public struct GameDuration {
    let hours: Int
    let minutes: Int
}

public struct Official {
    let fullName: String
}

public struct LineScore {
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

public struct BoxscoreTeam {
    let isHomeTeam: Bool
    let teamId: String
    let wins: Int
    let losses: Int
    let seriesWins: Int
    let seriesLosses: Int
    let score: Int
    let lineScores: [LineScore]
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

public struct Boxscore {

    // MARK: Internal Properties

    let isGameActivated: Bool
    let status: Int
    let extendedStatus: Int
  /*  let startTimeUTC: Date
    let endTimeUTC: Date
    let arena: Arena
    let isBuzzerBeater: Bool
    let attendance: Int
    let isNeutralVenue: Bool
    let gameDuration: GameDuration
    let period: [BoxscorePeriod]
    let timesTied: Int
    let leadChanges: Int
    let officials: [Official]
    let boxscoreTeams: [BoxscoreTeam]*/

    // MARK: Init

    public init(from decoder: Decoder) throws {
        let boxscoreContainer = try decoder.container(keyedBy: BoxscoreCodingKeys.self)
        let statusString = try boxscoreContainer.decode(String.self, forKey: .status)
        let extendedStatusString = try boxscoreContainer.decode(String.self, forKey: .extendedStatus)

        if let statusInt = Int(statusString) {
            status = statusInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .status,
                                                   in: boxscoreContainer,
                                                   debugDescription: "Status is not in expected format.")
        }

        if let extendedStatusInt = Int(extendedStatusString) {
            extendedStatus = extendedStatusInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .extendedStatus,
                                                   in: boxscoreContainer,
                                                   debugDescription: "Status is not in expected format.")
        }

        isGameActivated = try boxscoreContainer.decode(Bool.self, forKey: .isGameActivated)
        
    }
}

extension Boxscore: Decodable {

    // MARK: Coding Keys

    enum BoxscoreCodingKeys: String, CodingKey {
        case isGameActivated
        case status = "statusNum"
        case extendedStatus = "extendedStatusNum"
    }
}
