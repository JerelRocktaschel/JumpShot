//
//  TeamStatRanking.swift
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

public struct StatRanking {

    // MARK: Internal Properties

    let average: Double
    let rank: Int

    public init(from decoder: Decoder) throws {
        let statRankingContainer = try decoder.container(keyedBy: StatRankingCodingKeys.self)
        let averageString = try statRankingContainer.decode(String.self, forKey: .average)
        let rankString = try statRankingContainer.decode(String.self, forKey: .rank)
        average = Double(averageString)!
        rank = Int(rankString)!
    }
}

extension StatRanking: Decodable {

    // MARK: Coding Keys

    enum StatRankingCodingKeys: String, CodingKey {
        case average = "avg"
        case rank
    }
}

extension StatRanking: Equatable {

    // MARK: Equatable

    public static func == (lhs: StatRanking, rhs: StatRanking) -> Bool {
        return lhs.average == rhs.average && lhs.rank == rhs.rank
    }
}

public struct TeamStatRanking {

    // MARK: Internal Properties

    let teamId: String
    let min: StatRanking
    let fgp: StatRanking
    let tpp: StatRanking
    let ftp: StatRanking
    let orpg: StatRanking
    let drpg: StatRanking
    let trpg: StatRanking
    let apg: StatRanking
    let tpg: StatRanking
    let spg: StatRanking
    let bpg: StatRanking
    let pfpg: StatRanking
    let ppg: StatRanking
    let oppg: StatRanking
    let eff: StatRanking

    public init(from decoder: Decoder) throws {
        let teamStatRankingContainer = try decoder.container(keyedBy: TeamStatRankingCodingKeys.self)
        teamId = try teamStatRankingContainer.decode(String.self, forKey: .teamId)
        min = try teamStatRankingContainer.decode(StatRanking.self, forKey: .min)
        fgp = try teamStatRankingContainer.decode(StatRanking.self, forKey: .fgp)
        tpp = try teamStatRankingContainer.decode(StatRanking.self, forKey: .tpp)
        ftp = try teamStatRankingContainer.decode(StatRanking.self, forKey: .ftp)
        orpg = try teamStatRankingContainer.decode(StatRanking.self, forKey: .orpg)
        drpg = try teamStatRankingContainer.decode(StatRanking.self, forKey: .drpg)
        trpg = try teamStatRankingContainer.decode(StatRanking.self, forKey: .trpg)
        apg = try teamStatRankingContainer.decode(StatRanking.self, forKey: .apg)
        tpg = try teamStatRankingContainer.decode(StatRanking.self, forKey: .tpg)
        spg = try teamStatRankingContainer.decode(StatRanking.self, forKey: .spg)
        bpg = try teamStatRankingContainer.decode(StatRanking.self, forKey: .bpg)
        pfpg = try teamStatRankingContainer.decode(StatRanking.self, forKey: .pfpg)
        ppg = try teamStatRankingContainer.decode(StatRanking.self, forKey: .ppg)
        oppg = try teamStatRankingContainer.decode(StatRanking.self, forKey: .oppg)
        eff = try teamStatRankingContainer.decode(StatRanking.self, forKey: .eff)
    }
}

extension TeamStatRanking: Decodable {

    // MARK: Coding Keys

    enum TeamStatRankingCodingKeys: String, CodingKey {
        case teamId
        case min
        case fgp
        case tpp
        case ftp
        case orpg
        case drpg
        case trpg
        case apg
        case tpg
        case spg
        case bpg
        case pfpg
        case ppg
        case oppg
        case eff
    }
}

struct TeamStatRankingApiResponse {

    // MARK: Internal Properties

    var teamStatRankings: [TeamStatRanking]
}

extension TeamStatRankingApiResponse {

    // MARK: Init

    init?(json: [String: Any]) {

        guard let leagueDictionary = json["league"] as? JSONDictionary else {
            return nil
        }

        guard let standardDictionary = leagueDictionary["standard"] as? JSONDictionary else {
            return nil
        }

        guard let regularSeasonDictionary = standardDictionary["regularSeason"] as? JSONDictionary else {
            return nil
        }

        guard let teamsDictionary = regularSeasonDictionary["teams"] as? [JSONDictionary] else {
            return nil
        }

        self.teamStatRankings = [TeamStatRanking]()
        for teamStatRankingDictionary in teamsDictionary {
            guard let teamStatRankingData = try? JSONSerialization.data(withJSONObject: teamStatRankingDictionary,
                                                                             options: []) else {
                    return nil
            }

            do {
                let teamStatRanking = try JSONDecoder().decode(TeamStatRanking.self, from: teamStatRankingData)
                self.teamStatRankings.append(teamStatRanking)
            } catch {
                return nil
            }
        }
    }
}
