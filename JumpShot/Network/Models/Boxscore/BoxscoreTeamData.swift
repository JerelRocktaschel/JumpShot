//
//  BoxscoreTeamData.swift
//  JumpShot
//
//  Created by Jerel Rocktaschel on 6/23/21.
//

import Foundation

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
