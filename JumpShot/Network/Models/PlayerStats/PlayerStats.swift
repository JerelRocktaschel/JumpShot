//
//  PlayerStat.swift
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

public struct PlayerStats {
    let ppg: Double
    let rpg: Double
    let apg: Double
    let mpg: Double
    let topg: Double
    let spg: Double
    let bpg: Double
    let tpp: Double
    let ftp: Double
    let fgp: Double
    let assists: Int
    let blocks: Int
    let steals: Int
    let turnovers: Int
    let offensiveRebounds: Int
    let defensiveRebounds: Int
    let totalRebounds: Int
    let fgm: Int
    let fga: Int
    let tpm: Int
    let tpa: Int
    let ftm: Int
    let fta: Int
    let personalFouls: Int
    let points: Int
    let gamesPlayed: Int
    let gamesStarted: Int
    let plusMinus: Int
    let min: Int
    let dd2: Int
    let td3: Int

    public init(from decoder: Decoder) throws {
        let playerStatsRankingContainer = try decoder.container(keyedBy: PlayerStatsCodingKeys.self)
        let ppgString = try playerStatsRankingContainer.decode(String.self, forKey: .ppg)
        let rpgString = try playerStatsRankingContainer.decode(String.self, forKey: .rpg)
        let apgString = try playerStatsRankingContainer.decode(String.self, forKey: .apg)
        let mpgString = try playerStatsRankingContainer.decode(String.self, forKey: .mpg)
        let topgString: String
        let spgString = try playerStatsRankingContainer.decode(String.self, forKey: .spg)
        let bpgString = try playerStatsRankingContainer.decode(String.self, forKey: .bpg)
        let tppString = try playerStatsRankingContainer.decode(String.self, forKey: .tpp)
        let ftpString = try playerStatsRankingContainer.decode(String.self, forKey: .ftp)
        let fgpString = try playerStatsRankingContainer.decode(String.self, forKey: .fgp)
        let assistsString = try playerStatsRankingContainer.decode(String.self, forKey: .assists)
        let blocksString = try playerStatsRankingContainer.decode(String.self, forKey: .blocks)
        let stealsString = try playerStatsRankingContainer.decode(String.self, forKey: .steals)
        let turnoversString = try playerStatsRankingContainer.decode(String.self, forKey: .turnovers)
        let offRebString = try playerStatsRankingContainer.decode(String.self, forKey: .offReb)
        let defRebString = try playerStatsRankingContainer.decode(String.self, forKey: .defReb)
        let totRebString = try playerStatsRankingContainer.decode(String.self, forKey: .totReb)
        let fgmString = try playerStatsRankingContainer.decode(String.self, forKey: .fgm)
        let fgaString = try playerStatsRankingContainer.decode(String.self, forKey: .fga)
        let tpmString = try playerStatsRankingContainer.decode(String.self, forKey: .tpm)
        let tpaString = try playerStatsRankingContainer.decode(String.self, forKey: .tpa)
        let ftmString = try playerStatsRankingContainer.decode(String.self, forKey: .ftm)
        let ftaString = try playerStatsRankingContainer.decode(String.self, forKey: .fta)
        let pFoulsString = try playerStatsRankingContainer.decode(String.self, forKey: .pFouls)
        let pointsString = try playerStatsRankingContainer.decode(String.self, forKey: .points)
        let gamesPlayedString = try playerStatsRankingContainer.decode(String.self, forKey: .gamesPlayed)
        let gamesStartedString = try playerStatsRankingContainer.decode(String.self, forKey: .gamesStarted)
        let plusMinusString = try playerStatsRankingContainer.decode(String.self, forKey: .plusMinus)
        let minString = try playerStatsRankingContainer.decode(String.self, forKey: .min)
        let dd2String = try playerStatsRankingContainer.decode(String.self, forKey: .dd2)
        let td3String = try playerStatsRankingContainer.decode(String.self, forKey: .td3)

        if let ppgDouble = Double(ppgString),
           let rpgDouble = Double(rpgString),
           let apgDouble = Double(apgString),
           let mpgDouble = Double(mpgString),
           let spgDouble = Double(spgString),
           let bpgDouble = Double(bpgString),
           let tppDouble = Double(tppString),
           let ftpDouble = Double(ftpString),
           let fgpDouble = Double(fgpString),
           let assistsInt = Int(assistsString),
           let blocksInt = Int(blocksString),
           let stealsInt = Int(stealsString),
           let turnoversInt = Int(turnoversString),
           let offRebInt = Int(offRebString),
           let defRebInt = Int(defRebString),
           let totRebInt = Int(totRebString),
           let fgmInt = Int(fgmString),
           let fgaInt = Int(fgaString),
           let tpmInt = Int(tpmString),
           let tpaInt = Int(tpaString),
           let ftmInt = Int(ftmString),
           let ftaInt = Int(ftaString),
           let pFoulsInt = Int(pFoulsString),
           let pointsInt = Int(pointsString),
           let gamesPlayedInt = Int(gamesPlayedString),
           let gamesStartedInt = Int(gamesStartedString),
           let plusMinusInt = Int(plusMinusString),
           let minInt = Int(minString),
           let dd2Int = Int(dd2String),
           let td3Int = Int(td3String) {
            ppg = ppgDouble
            rpg = rpgDouble
            apg = apgDouble
            mpg = mpgDouble
            spg = spgDouble
            bpg = bpgDouble
            tpp = tppDouble
            ftp = ftpDouble
            fgp = fgpDouble
            assists = assistsInt
            blocks = blocksInt
            steals = stealsInt
            turnovers = turnoversInt
            offensiveRebounds = offRebInt
            defensiveRebounds = defRebInt
            totalRebounds = totRebInt
            fgm = fgmInt
            fga = fgaInt
            tpm = tpmInt
            tpa = tpaInt
            ftm = ftmInt
            fta = ftaInt
            personalFouls = pFoulsInt
            points = pointsInt
            gamesPlayed = gamesPlayedInt
            gamesStarted = gamesStartedInt
            plusMinus = plusMinusInt
            min = minInt
            dd2 = dd2Int
            td3 = td3Int
        } else {
            throw JumpShotNetworkManagerError.unableToDecodeError
        }

        // for whatever reason, the careerSummary dictionary does not have topg ugh - so i calc it
        if playerStatsRankingContainer.allKeys.contains(.topg) {
            topgString = try playerStatsRankingContainer.decode(String.self, forKey: .topg)
            topg = Double(topgString)!
        } else {
            let topgDouble = Double(turnovers)/Double(gamesPlayed)
            let topgRounded = Double(round(10*topgDouble)/10)
            topg = topgRounded
        }
    }
}

extension PlayerStats: Decodable {

    // MARK: Coding Keys

    enum PlayerStatsCodingKeys: String, CodingKey {
        case seasonStageId
        case ppg
        case rpg
        case apg
        case mpg
        case topg
        case spg
        case bpg
        case tpp
        case ftp
        case fgp
        case assists
        case blocks
        case steals
        case turnovers
        case offReb
        case defReb
        case totReb
        case fgm
        case fga
        case tpm
        case tpa
        case ftm
        case fta
        case pFouls
        case points
        case gamesPlayed
        case gamesStarted
        case plusMinus
        case min
        case dd2
        case td3
    }
}

extension PlayerStats: Equatable {

    // MARK: Equatable

    public static func == (lhs: PlayerStats, rhs: PlayerStats) -> Bool {
        return lhs.ppg == rhs.ppg &&
        lhs.rpg == rhs.rpg &&
        lhs.apg == rhs.apg &&
        lhs.mpg == rhs.mpg &&
        lhs.topg == rhs.topg &&
        lhs.spg == rhs.spg &&
        lhs.bpg == rhs.bpg &&
        lhs.tpp == rhs.tpp &&
        lhs.ftp == rhs.ftp &&
        lhs.assists == rhs.assists &&
        lhs.blocks == rhs.blocks &&
        lhs.steals == rhs.steals &&
        lhs.turnovers == rhs.turnovers &&
        lhs.offensiveRebounds == rhs.offensiveRebounds &&
        lhs.defensiveRebounds == rhs.defensiveRebounds &&
        lhs.totalRebounds == rhs.totalRebounds &&
        lhs.fgm == rhs.fgm &&
        lhs.fga == rhs.fga &&
        lhs.tpm == rhs.tpm &&
        lhs.tpa == rhs.tpa &&
        lhs.ftm == rhs.ftm &&
        lhs.fta == rhs.fta &&
        lhs.personalFouls == rhs.personalFouls &&
        lhs.points == rhs.points &&
        lhs.gamesPlayed == rhs.gamesPlayed &&
        lhs.gamesStarted == rhs.gamesStarted &&
        lhs.plusMinus == rhs.plusMinus &&
        lhs.min == rhs.min &&
        lhs.dd2 == rhs.dd2 &&
        lhs.td3 == rhs.td3
    }
}
