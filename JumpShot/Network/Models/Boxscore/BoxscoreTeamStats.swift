//
//  BoxscoreTeamStats.swift
//  JumpShot
//
//  Created by Jerel Rocktaschel on 6/23/21.
//

import Foundation

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

        if let pointsInPaintInt = Int(pointsInPaintString),
           let biggestLeadInt = Int(biggestLeadString),
           let secondChancePointsInt = Int(secondChancePointsString),
           let pointsOffTurnoversInt = Int(pointsOffTurnoversString),
           let longestRunInt = Int(longestRunString) {
            pointsInPaint = pointsInPaintInt
            biggestLead = biggestLeadInt
            secondChancePoints = secondChancePointsInt
            pointsOffTurnovers = pointsOffTurnoversInt
            longestRun = longestRunInt
        } else {
            throw JumpShotNetworkManagerError.unableToDecodeError
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
