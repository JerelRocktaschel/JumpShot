//
//  JumpShotModelTests.swift
//  JumpShotTests
//
//  Created by Jerel Rocktaschel on 3/29/21.
//

import XCTest
@testable import JumpShot

class JumpShotModelTests: XCTestCase {

    // MARK: TeamModel

    func test_teamModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "TeamModel",
                               ofType: "json")
        let teamModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let teamModelResponse = try JSONDecoder().decode(Team.self, from: teamModelData)
        XCTAssertEqual(teamModelResponse.isAllStar, false)
        XCTAssertEqual(teamModelResponse.city, "Boston")
        XCTAssertEqual(teamModelResponse.altCityName, "Boston")
        XCTAssertEqual(teamModelResponse.fullName, "Boston Celtics")
        XCTAssertEqual(teamModelResponse.abbreviation, "BOS")
        XCTAssertEqual(teamModelResponse.teamId, "1610612738")
        XCTAssertEqual(teamModelResponse.name, "Celtics")
        XCTAssertEqual(teamModelResponse.urlName, "celtics")
        XCTAssertEqual(teamModelResponse.shortName, "Boston")
        XCTAssertEqual(teamModelResponse.conference, "East")
        XCTAssertEqual(teamModelResponse.division, "Atlantic")
    }

    func test_teamModel_withBadData_isNil() throws {
        let path = getPath(forResource: "TeamModelBadDataFormat",
                               ofType: "json")
        let teamModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var teamModelResponse: Team?

        do {
            teamModelResponse = try JSONDecoder().decode(Team.self, from: teamModelData)
        } catch {
            teamModelResponse = nil
        }
        XCTAssertNil(teamModelResponse)
    }

     func test_teamModel_withMissingData_isNil() throws {
        let path = getPath(forResource: "TeamModelMissingDataFormat",
                               ofType: "json")
        let teamModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var teamModelResponse: Team?

        do {
            teamModelResponse = try JSONDecoder().decode(Team.self, from: teamModelData)
        } catch {
            teamModelResponse = nil
        }
        XCTAssertNil(teamModelResponse)
     }

     // MARK: PlayerModel

     func test_playerModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "PlayerModel",
                                ofType: "json")
        let playerModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let playerModelResponse = try JSONDecoder().decode(Player.self, from: playerModelData)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateOfBirth = dateFormatter.date(from: "1993-07-20")!

        var testTeamsArray = [Player.Team]()
        let testTeam1 = Player.Team(teamId: "1610612760", seasonStart: 2013, seasonEnd: 2019)
        let testTeam2 = Player.Team(teamId: "1610612740", seasonStart: 2020, seasonEnd: 2020)
        testTeamsArray.append(testTeam1)
        testTeamsArray.append(testTeam2)

        XCTAssertEqual(playerModelResponse.firstName, "Steven")
        XCTAssertEqual(playerModelResponse.lastName, "Adams")
        XCTAssertEqual(playerModelResponse.displayName, "Adams, Steven")
        XCTAssertEqual(playerModelResponse.playerId, "203500")
        XCTAssertEqual(playerModelResponse.teamID, "1610612740")
        XCTAssertEqual(playerModelResponse.jersey, 12)
        XCTAssertEqual(playerModelResponse.position, "C")
        XCTAssertEqual(playerModelResponse.feet, 6)
        XCTAssertEqual(playerModelResponse.inches, 11)
        XCTAssertEqual(playerModelResponse.meters, 2.11)
        XCTAssertEqual(playerModelResponse.pounds, 265)
        XCTAssertEqual(playerModelResponse.kilograms, 120.2)
        XCTAssertEqual(playerModelResponse.dateOfBirth, dateOfBirth)

        for team in 0..<playerModelResponse.teams.count {
            let responseTeam = playerModelResponse.teams[team]
            let testTeam = testTeamsArray[team]
            XCTAssertEqual(responseTeam.teamId, testTeam.teamId)
            XCTAssertEqual(responseTeam.seasonStart, testTeam.seasonStart)
            XCTAssertEqual(responseTeam.seasonEnd, testTeam.seasonEnd)
        }

        XCTAssertEqual(playerModelResponse.draftTeamId, "1610612760")
        XCTAssertEqual(playerModelResponse.draftPosition, 12)
        XCTAssertEqual(playerModelResponse.draftRound, 1)
        XCTAssertEqual(playerModelResponse.draftYear, 2013)
        XCTAssertEqual(playerModelResponse.nbaDebutYear, 2013)
        XCTAssertEqual(playerModelResponse.yearsPro, 7)
        XCTAssertEqual(playerModelResponse.collegeName, "Pittsburgh")
        XCTAssertEqual(playerModelResponse.lastAffiliation, "Pittsburgh/New Zealand")
        XCTAssertEqual(playerModelResponse.country, "New Zealand")
     }

     func test_playerModel_withBadData_isNil() throws {
         let path = getPath(forResource: "PlayerModelBadDataFormat",
                                ofType: "json")
         let playerModelData = try Data(contentsOf: URL(fileURLWithPath: path))
         var playerModelResponse: Player?

         do {
            playerModelResponse = try JSONDecoder().decode(Player.self, from: playerModelData)
         } catch {
            playerModelResponse = nil
         }
         XCTAssertNil(playerModelResponse)
     }

      func test_playerModel_withMissingData_isNil() throws {
         let path = getPath(forResource: "PlayerModelMissingDataFormat",
                                ofType: "json")
         let playerModelData = try Data(contentsOf: URL(fileURLWithPath: path))
         var playerModelResponse: Player?

         do {
            playerModelResponse = try JSONDecoder().decode(Player.self, from: playerModelData)
         } catch {
            playerModelResponse = nil
         }
         XCTAssertNil(playerModelResponse)
      }
}
