//
//  Standing.swift
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

struct TeamSitesOnly: Decodable {
    let teamKey: String
    let teamName: String
    let teamCode: String
    let teamNickname: String
    let teamTricode: String
    let clinchedConference: String
    let clinchedDivision: String
    let clinchedPlayoffs: String
    let streakText: String
}

public struct Standing {

    // MARK: Internal Properties

    let teamId: String
    let wins: Int
    let losses: Int
    let winPct: Double
    let lossPct: Double
    let gamesBehind: Double
    let divisionGamesBehind: Double
    let isClinchedPlayoffs: Bool
    let conferenceWins: Int
    let conferenceLosses: Int
    let homeWins: Int
    let homeLosses: Int
    let divisionWins: Int
    let divisionLosses: Int
    let awayWins: Int
    let awayLosses: Int
    let lastTenWins: Int
    let lastTenLosses: Int
    let streak: Int
    var divisionRank: Int?
    let isWinStreak: Bool
    let teamSitesOnly: TeamSitesOnly
    let isClinchedConference: Bool
    let isclinchedDivision: Bool

    // MARK: Init

    public init(from decoder: Decoder) throws {
        let standingContainer = try decoder.container(keyedBy: GameScheduleCodingKeys.self)
        let winsString = try standingContainer.decode(String.self, forKey: .wins)
        let lossesString = try standingContainer.decode(String.self, forKey: .losses)
        let winPctString = try standingContainer.decode(String.self, forKey: .winPct)
        let lossPctString = try standingContainer.decode(String.self, forKey: .lossPct)
        let gamesBehindString = try standingContainer.decode(String.self, forKey: .gamesBehind)
        let divisionGamesBehindString = try standingContainer.decode(String.self, forKey: .divisionGamesBehind)
        let clinchedPlayoffsString = try standingContainer.decode(String.self, forKey: .isClinchedPlayoffs)
        let conferenceWinsString = try standingContainer.decode(String.self, forKey: .conferenceWins)
        let conferenceLossesString = try standingContainer.decode(String.self, forKey: .conferenceLosses)
        let homeWinsString = try standingContainer.decode(String.self, forKey: .homeWins)
        let homeLossesString = try standingContainer.decode(String.self, forKey: .homeLosses)
        let divisionWinsString = try standingContainer.decode(String.self, forKey: .divisionWins)
        let divisionLossesString = try standingContainer.decode(String.self, forKey: .divisionLosses)
        let awayWinsString = try standingContainer.decode(String.self, forKey: .awayWins)
        let awayLossesString = try standingContainer.decode(String.self, forKey: .awayLosses)
        let lastTenWinsString = try standingContainer.decode(String.self, forKey: .lastTenWins)
        let lastTenLossesString = try standingContainer.decode(String.self, forKey: .lastTenLosses)
        let streakString = try standingContainer.decode(String.self, forKey: .streak)
        let divisionRankString = try standingContainer.decode(String.self, forKey: .divisionRank)

        teamId = try standingContainer.decode(String.self, forKey: .teamId)
        wins = Int(winsString)!
        losses = Int(lossesString)!
        winPct = Double(winPctString)!
        lossPct = Double(lossPctString)!
        gamesBehind = Double(gamesBehindString)!
        divisionGamesBehind = Double(divisionGamesBehindString)!
        isClinchedPlayoffs = clinchedPlayoffsString.bool
        conferenceWins = Int(conferenceWinsString)!
        conferenceLosses = Int(conferenceLossesString)!
        homeWins = Int(homeWinsString)!
        homeLosses = Int(homeLossesString)!
        divisionWins = Int(divisionWinsString)!
        divisionLosses = Int(divisionLossesString)!
        awayWins = Int(awayWinsString)!
        awayLosses = Int(awayLossesString)!
        lastTenWins = Int(lastTenWinsString)!
        lastTenLosses = Int(lastTenLossesString)!
        streak = Int(streakString)!
        divisionRank = divisionRankString.int
        isWinStreak = try standingContainer.decode(Bool.self, forKey: .isWinStreak)
        teamSitesOnly = try standingContainer.decode(TeamSitesOnly.self, forKey: .teamSitesOnly)
        isClinchedConference = teamSitesOnly.clinchedConference.bool
        isclinchedDivision = teamSitesOnly.clinchedDivision.bool
    }
}

extension Standing: Decodable {

    // MARK: Coding Keys

    enum GameScheduleCodingKeys: String, CodingKey {
        case teamId = "teamId"
        case wins = "win"
        case losses = "loss"
        case winPct = "winPct"
        case lossPct = "lossPct"
        case gamesBehind = "gamesBehind"
        case divisionGamesBehind = "divGamesBehind"
        case isClinchedPlayoffs = "clinchedPlayoffsCode"
        case conferenceWins = "confWin"
        case conferenceLosses = "confLoss"
        case homeWins = "homeWin"
        case homeLosses = "homeLoss"
        case divisionWins = "divWin"
        case divisionLosses = "divLoss"
        case awayWins = "awayWin"
        case awayLosses = "awayLoss"
        case lastTenWins = "lastTenWin"
        case lastTenLosses = "lastTenLoss"
        case streak = "streak"
        case divisionRank = "divRank"
        case isWinStreak = "isWinStreak"
        case teamSitesOnly = "teamSitesOnly"
    }
}

struct StandingApiResponse {

    // MARK: Internal Properties

    var standings: [Standing]
}

extension StandingApiResponse {

    // MARK: Init

    init?(json: [String: Any]) {

        guard let leagueDictionary = json["league"] as? JSONDictionary else {
            return nil
        }

        guard let standardDictionary = leagueDictionary["standard"] as? JSONDictionary else {
            return nil
        }

        guard let teamsStandingsDictionary = standardDictionary["teams"] as? [JSONDictionary] else {
            return nil
        }

        self.standings = [Standing]()
        for teamStandingDictionary in teamsStandingsDictionary {
            guard let jsonStandingData = try? JSONSerialization.data(withJSONObject: teamStandingDictionary,
                                                                             options: []) else {
                    return nil
            }

            do {
                let standing = try JSONDecoder().decode(Standing.self, from: jsonStandingData)
                self.standings.append(standing)
            } catch {
                return nil
            }
        }
    }
}
