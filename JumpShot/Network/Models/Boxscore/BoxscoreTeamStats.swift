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
