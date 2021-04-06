//
//  Team.swift
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

public struct Team {

    // MARK: Internal Properties

    let isAllStar: Bool
    let city: String
    let altCityName: String
    let fullName: String
    let abbreviation: String
    let teamId: String
    let name: String
    let urlName: String
    let shortName: String
    let conference: String
    let division: String

    // MARK: Init

    public init(from decoder: Decoder) throws {
        let teamContainer = try decoder.container(keyedBy: TeamCodingKeys.self)
        isAllStar = try teamContainer.decode(Bool.self, forKey: .isAllStar)
        city = try teamContainer.decode(String.self, forKey: .city)
        altCityName = try teamContainer.decode(String.self, forKey: .altCityName)
        fullName = try teamContainer.decode(String.self, forKey: .fullName)
        abbreviation = try teamContainer.decode(String.self, forKey: .abbreviation)
        teamId = try teamContainer.decode(String.self, forKey: .teamId)
        name = try teamContainer.decode(String.self, forKey: .name)
        urlName = try teamContainer.decode(String.self, forKey: .urlName)
        shortName = try teamContainer.decode(String.self, forKey: .shortName)
        conference = try teamContainer.decode(String.self, forKey: .conference)
        division = try teamContainer.decode(String.self, forKey: .division)
    }
}

extension Team: Decodable {

    // MARK: Coding Keys

    enum TeamCodingKeys: String, CodingKey {
        case isAllStar = "isAllStar"
        case city = "city"
        case altCityName = "altCityName"
        case fullName = "fullName"
        case abbreviation = "tricode"
        case teamId = "teamId"
        case name = "nickname"
        case urlName = "urlName"
        case shortName = "teamShortName"
        case conference = "confName"
        case division = "divName"
    }
}

struct TeamApiResponse {

    // MARK: Internal Properties

    var teams: [Team]
}

extension TeamApiResponse {

    // MARK: Init

    init?(json: JSONDictionary) {
        guard let leagueDictionary = json["league"] as? JSONDictionary else {
            return nil
        }

        guard let standardDictionary = leagueDictionary["standard"] as? [JSONDictionary] else {
            return nil
        }

        self.teams = [Team]()
        for teamDictionary in standardDictionary {

            // non nba data exists in response
            guard let isNBAFranchise = teamDictionary["isNBAFranchise"] as? Bool else {
                return nil
            }

            guard isNBAFranchise == true else {
                continue
            }

            do {
                let jsonTeamData = try JSONSerialization.data(withJSONObject: teamDictionary, options: [])
                let team = try JSONDecoder().decode(Team.self, from: jsonTeamData)
                self.teams.append(team)
            } catch {
                return nil
            }
        }
    }
}
