//
//  Player.swift
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

struct TeamResponse: Decodable {
    let teamId: String
    let seasonStart: String
    let seasonEnd: String
}

struct Draft: Decodable {
    let teamId: String
    let pickNum: String
    let roundNum: String
    let seasonYear: String
}

public struct Player {

    // MARK: Internal Properties

    struct Team {
        let teamId: String
        let seasonStart: Int
        let seasonEnd: Int
    }

    let firstName: String
    let lastName: String
    let displayName: String
    let playerId: String
    let teamId: String
    var jersey: Int?
    let position: String
    var feet: Int?
    var inches: Int?
    var meters: Double?
    var pounds: Int?
    var kilograms: Double?
    var dateOfBirth: Date?
    let teams: [Team]
    var draftTeamId: String?
    var draftPosition: Int?
    var draftRound: Int?
    var draftYear: Int?
    var nbaDebutYear: Int?
    var yearsPro: Int?
    let collegeName: String
    let lastAffiliation: String
    let country: String
    let dateFormatter = DateFormatter()

    // MARK: Init

    public init(from decoder: Decoder) throws {
        let playerContainer = try decoder.container(keyedBy: PlayerCodingKeys.self)
        let jerseyString = try playerContainer.decode(String.self, forKey: .jersey)
        let feetString = try playerContainer.decode(String.self, forKey: .feet)
        let inchesString = try playerContainer.decode(String.self, forKey: .inches)
        let metersString = try playerContainer.decode(String.self, forKey: .meters)
        let poundsString = try playerContainer.decode(String.self, forKey: .pounds)
        let kilogramsString = try playerContainer.decode(String.self, forKey: .kilograms)
        let dateOfBirthString = try playerContainer.decode(String.self, forKey: .dateOfBirth)
        let nbaDebutYearString = try playerContainer.decode(String.self, forKey: .nbaDebutYear)
        let yearsProString = try playerContainer.decode(String.self, forKey: .yearsPro)
        let teamsDictionaries = try playerContainer.decode([TeamResponse].self, forKey: .teams)
        let draftDictionary = try playerContainer.decode(Draft.self, forKey: .draft)

        firstName = try playerContainer.decode(String.self, forKey: .firstName)
        lastName = try playerContainer.decode(String.self, forKey: .lastName)
        displayName = try playerContainer.decode(String.self, forKey: .displayName)
        playerId = try playerContainer.decode(String.self, forKey: .playerId)
        teamId = try playerContainer.decode(String.self, forKey: .teamId)

        // sometimes newer players do not have a jersey number
        if let jerseyInt = Int(jerseyString) {
            jersey = jerseyInt
        }

        position = try playerContainer.decode(String.self, forKey: .position)

        // sometimes newer players are missing height/weight information
        if let feetInt = Int(feetString) {
            feet = feetInt
        }

        if let inchesInt = Int(inchesString) {
            inches = inchesInt
        }

        if let metersDouble = Double(metersString) {
            meters = metersDouble
        }

        if let poundsInt = Int(poundsString) {
            pounds = poundsInt
        }

        if let kilogramsDouble = Double(kilogramsString) {
            kilograms = kilogramsDouble
        }

        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let dateOfBirthFormatted = dateFormatter.date(from: dateOfBirthString) {
            dateOfBirth = dateOfBirthFormatted
        }

        var teamArray = [Team]()
        for teamDictionary in teamsDictionaries {
            let teamId = teamDictionary.teamId
            let seasonStart = Int(teamDictionary.seasonStart)!
            let seasonEnd = Int(teamDictionary.seasonEnd)!
            var team: Team

            team = Team(teamId: teamId,
                        seasonStart: seasonStart,
                        seasonEnd: seasonEnd)
            teamArray.append(team)
        }

        teams = teamArray
        draftTeamId = draftDictionary.teamId

        // undrafted players have no draft information
        if let draftPositionInt = Int(draftDictionary.pickNum) {
            draftPosition = draftPositionInt
        }

        if let draftRoundInt = Int(draftDictionary.roundNum) {
            draftRound = draftRoundInt
        }

        if let draftYearInt = Int(draftDictionary.seasonYear) {
            draftYear = draftYearInt
        }

        // sometimes newer players are missing debut year and years pro information
        if let nbaDebutYearInt = Int(nbaDebutYearString) {
            nbaDebutYear = nbaDebutYearInt
        }

        if let yearsProInt = Int(yearsProString) {
            yearsPro = yearsProInt
        }

        collegeName = try playerContainer.decode(String.self, forKey: .collegeName)
        lastAffiliation = try playerContainer.decode(String.self, forKey: .lastAffiliation)
        country = try playerContainer.decode(String.self, forKey: .country)
    }
}

extension Player: Decodable {

    // MARK: Coding Keys

    enum PlayerCodingKeys: String, CodingKey {
        case firstName = "firstName"
        case lastName = "lastName"
        case displayName = "temporaryDisplayName"
        case playerId = "personId"
        case teamId = "teamId"
        case jersey = "jersey"
        case position = "pos"
        case feet = "heightFeet"
        case inches = "heightInches"
        case meters = "heightMeters"
        case pounds = "weightPounds"
        case kilograms = "weightKilograms"
        case dateOfBirth = "dateOfBirthUTC"
        case teams = "teams"
        case draft = "draft"
        case nbaDebutYear = "nbaDebutYear"
        case yearsPro = "yearsPro"
        case collegeName = "collegeName"
        case lastAffiliation = "lastAffiliation"
        case country = "country"
    }
}

struct PlayerApiResponse {

    // MARK: Internal Properties

    var players: [Player]
}

extension PlayerApiResponse {

    // MARK: Init

    init?(json: [String: Any]) {
        guard let leagueDictionary = json["league"] as? JSONDictionary else {
            return nil
        }

        guard let standardDictionary = leagueDictionary["standard"] as? [JSONDictionary] else {
            return nil
        }

        self.players = [Player]()
        for playerDictionary in standardDictionary {
            guard let isActive = playerDictionary["isActive"] as? Bool else {
                return nil
            }

            // inactive players exist
            guard isActive == true else {
                continue
            }

            guard let jsonPlayerData = try? JSONSerialization.data(withJSONObject: playerDictionary, options: []) else {
                return nil
            }

            do {
                let player = try JSONDecoder().decode(Player.self, from: jsonPlayerData)
                self.players.append(player)
            } catch {
                return nil
            }
        }
    }
}
