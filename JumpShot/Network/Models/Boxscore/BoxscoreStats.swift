//
//  BoxscoreStats.swift
//  JumpShot
//
//  Created by Jerel Rocktaschel on 6/23/21.
//

import Foundation

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
