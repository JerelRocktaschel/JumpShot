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
        XCTAssertEqual(playerModelResponse.teamId, "1610612740")
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

    // MARK: Game Schedule

    func test_gameScheduleModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "GameScheduleModel",
                               ofType: "json")
        let gameScheduleModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let gameScheduleModelResponse = try JSONDecoder().decode(GameSchedule.self, from: gameScheduleModelData)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        let dateString = "04/20/2021 07:30 PM"
        let gameDate =  dateFormatter.date(from: dateString)!

        XCTAssertEqual(gameScheduleModelResponse.gameId, "0022000878")
        XCTAssertEqual(gameScheduleModelResponse.visitorCity, "Brooklyn")
        XCTAssertEqual(gameScheduleModelResponse.visitorNickName, "Nets")
        XCTAssertEqual(gameScheduleModelResponse.visitorShortName, "Brooklyn")
        XCTAssertEqual(gameScheduleModelResponse.visitorAbbreviation, "BKN")
        XCTAssertEqual(gameScheduleModelResponse.homeCity, "New Orleans")
        XCTAssertEqual(gameScheduleModelResponse.homeNickName, "Pelicans")
        XCTAssertEqual(gameScheduleModelResponse.homeShortName, "New Orleans")
        XCTAssertEqual(gameScheduleModelResponse.homeAbbreviation, "NOP")
        XCTAssertEqual(gameScheduleModelResponse.gameDate, gameDate)
        XCTAssertEqual(gameScheduleModelResponse.gameDay, "Tue")
        XCTAssertEqual(gameScheduleModelResponse.broadcastId, "10")
        XCTAssertEqual(gameScheduleModelResponse.broadcasterName, "TNT")
        XCTAssertEqual(gameScheduleModelResponse.tapeDelayComments, "")
    }

    func test_gameScheduleModel_withBadData_isNil() throws {
        let path = getPath(forResource: "GameScheduleModelBadDataFormat",
                               ofType: "json")
        let gameScheduleModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var gameScheduleModelResponse: GameSchedule?

        do {
            gameScheduleModelResponse = try JSONDecoder().decode(GameSchedule.self, from: gameScheduleModelData)
        } catch {
            gameScheduleModelResponse = nil
        }
        XCTAssertNil(gameScheduleModelResponse)
    }

     func test_gameScheduleModel_withMissingData_isNil() throws {
        let path = getPath(forResource: "GameScheduleModelMissingDataFormat",
                               ofType: "json")
        let gameScheduleModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let gameScheduleModelResponse: GameSchedule?

        do {
            gameScheduleModelResponse = try JSONDecoder().decode(GameSchedule.self, from: gameScheduleModelData)
        } catch {
            gameScheduleModelResponse = nil
        }
        XCTAssertNil(gameScheduleModelResponse)
     }

    // MARK: Standing

    func test_standingModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "StandingModel",
                               ofType: "json")
        let standingModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let standingModelResponse = try JSONDecoder().decode(Standing.self, from: standingModelData)

        XCTAssertEqual(standingModelResponse.teamId, "1610612762")
        XCTAssertEqual(standingModelResponse.wins, 44)
        XCTAssertEqual(standingModelResponse.losses, 15)
        XCTAssertEqual(standingModelResponse.winPct, 0.746)
        XCTAssertEqual(standingModelResponse.lossPct, 0.254)
        XCTAssertEqual(standingModelResponse.gamesBehind, 0.0)
        XCTAssertEqual(standingModelResponse.divisionGamesBehind, 0.0)
        XCTAssertEqual(standingModelResponse.isClinchedPlayoffs, false)
        XCTAssertEqual(standingModelResponse.conferenceWins, 21)
        XCTAssertEqual(standingModelResponse.conferenceLosses, 9)
        XCTAssertEqual(standingModelResponse.homeWins, 26)
        XCTAssertEqual(standingModelResponse.homeLosses, 3)
        XCTAssertEqual(standingModelResponse.divisionWins, 5)
        XCTAssertEqual(standingModelResponse.divisionLosses, 2)
        XCTAssertEqual(standingModelResponse.awayWins, 18)
        XCTAssertEqual(standingModelResponse.awayLosses, 12)
        XCTAssertEqual(standingModelResponse.lastTenWins, 6)
        XCTAssertEqual(standingModelResponse.lastTenLosses, 4)
        XCTAssertEqual(standingModelResponse.streak, 2)
        XCTAssertNil(standingModelResponse.divisionRank)
        XCTAssertEqual(standingModelResponse.isWinStreak, true)
        XCTAssertEqual(standingModelResponse.isClinchedConference, false)
        XCTAssertEqual(standingModelResponse.isclinchedDivision, false)
    }

    func test_standingModel_withBadData_isNil() throws {
        let path = getPath(forResource: "StandingModelBadDataFormat",
                               ofType: "json")
        let standingModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var standingModelResponse: Standing?

        do {
            standingModelResponse = try JSONDecoder().decode(Standing.self, from: standingModelData)
        } catch {
            standingModelResponse = nil
        }
        XCTAssertNil(standingModelResponse)
    }

     func test_standingModel_withMissingData_isNil() throws {
        let path = getPath(forResource: "StandingModelMissingDataFormat",
                               ofType: "json")
        let gameScheduleModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let gameScheduleModelResponse: GameSchedule?

        do {
            gameScheduleModelResponse = try JSONDecoder().decode(GameSchedule.self, from: gameScheduleModelData)
        } catch {
            gameScheduleModelResponse = nil
        }
        XCTAssertNil(gameScheduleModelResponse)
     }

    // MARK: Leader

    func test_leaderModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "LeaderModel",
                               ofType: "json")
        let leaderModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let leaderModelResponse = try JSONDecoder().decode(Leader.self, from: leaderModelData)
        XCTAssertEqual(leaderModelResponse.playerId, "1629027")
        XCTAssertEqual(leaderModelResponse.value, 25.3)
    }

    func test_leaderModel_withBadData_isNil() throws {
        let path = getPath(forResource: "LeaderModelBadDataFormat",
                               ofType: "json")
        let leaderModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var leaderModelResponse: Leader?

        do {
            leaderModelResponse = try JSONDecoder().decode(Leader.self, from: leaderModelData)
        } catch {
            leaderModelResponse = nil
        }
        XCTAssertNil(leaderModelResponse)
    }

     func test_leaderModel_withMissingData_isNil() throws {
        let path = getPath(forResource: "LeaderModelMissingDataFormat",
                               ofType: "json")
        let leaderModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let leaderModelResponse: Leader?

        do {
            leaderModelResponse = try JSONDecoder().decode(Leader.self, from: leaderModelData)
        } catch {
            leaderModelResponse = nil
        }
        XCTAssertNil(leaderModelResponse)
     }
}
