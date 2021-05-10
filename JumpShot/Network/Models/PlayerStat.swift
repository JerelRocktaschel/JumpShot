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

struct PlayerStats {
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
    let offReb: Int
    let defReb: Int
    let totReb: Int
    let fgm: Int
    let fga: Int
    let tpm: Int
    let tpa: Int
    let ftm: Int
    let fta: Int
    let pFouls: Int
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
        let topgString = try playerStatsRankingContainer.decode(String.self, forKey: .topg)
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

        ppg = Double(ppgString)!
        rpg = Double(rpgString)!
        apg = Double(apgString)!
        mpg = Double(mpgString)!
        topg = Double(topgString)!
        spg = Double(spgString)!
        bpg = Double(bpgString)!
        tpp = Double(tppString)!
        ftp = Double(ftpString)!
        fgp = Double(fgpString)!
        assists = Int(assistsString)!
        blocks = Int(blocksString)!
        steals = Int(stealsString)!
        turnovers = Int(turnoversString)!
        offReb = Int(offRebString)!
        defReb = Int(defRebString)!
        totReb = Int(totRebString)!
        fgm = Int(fgmString)!
        fga = Int(fgaString)!
        tpm = Int(tpmString)!
        tpa = Int(tpaString)!
        ftm = Int(ftmString)!
        fta = Int(ftaString)!
        pFouls = Int(pFoulsString)!
        points = Int(pointsString)!
        gamesPlayed = Int(gamesPlayedString)!
        gamesStarted = Int(gamesStartedString)!
        plusMinus = Int(plusMinusString)!
        min = Int(minString)!
        dd2 = Int(dd2String)!
        td3 = Int(td3String)!
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

struct PlayerTeamStats {
    let teamId: String
    let playerStats: PlayerStats
}

struct PlayerTeamStatsSeason {
    let seasonYear: Int
    let playerStatTeams: [PlayerTeamStats]
    let seasonTotalStats: PlayerStats
}

struct PlayerStatsSummary {
    let careerStatsSummary: PlayerStats
    let currentSeasonStatsSummary: PlayerStats
    let playerTeamStatsSeasons: PlayerTeamStatsSeason
}
