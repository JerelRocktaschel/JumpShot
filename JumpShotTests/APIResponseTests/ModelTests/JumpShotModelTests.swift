//
//  JumpShotModelTests.swift
//  JumpShotTests
//
//  Created by Jerel Rocktaschel on 3/29/21.
//

// swiftlint:disable all

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
        let standingModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let standingModelResponse: Standing?

        do {
            standingModelResponse = try JSONDecoder().decode(Standing.self, from: standingModelData)
        } catch {
            standingModelResponse = nil
        }
        XCTAssertNil(standingModelResponse)
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

    // MARK: Team Schedule

    func test_teamScheduleModel_fromTeamScheduleCall_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "TeamScheduleModelFromTeamScheduleCall",
                               ofType: "json")
        let teamScheduleData = try Data(contentsOf: URL(fileURLWithPath: path))
        let dateFormatter = DateFormatter.iso8601Full
        let startTimeUTC = dateFormatter.date(from: "2020-12-12T00:00:00.000Z")
        let teamScheduleResponse = try JSONDecoder().decode(TeamSchedule.self, from: teamScheduleData)
        let visitorScheduledTeamData = """
            {
                "teamId":"1610612753",
                "score":"116"
            }
            """.data(using: .utf8)!
        let visitorTeam = try JSONDecoder().decode(ScheduledTeam.self, from: visitorScheduledTeamData)
        let homeScheduledTeamData = """
            {
                "teamId":"1610612737",
                "score":"112"
            }
            """.data(using: .utf8)!
        let homeTeam = try JSONDecoder().decode(ScheduledTeam.self, from: homeScheduledTeamData)

        let canadianBroadcaster = """
        [
           {
              "shortName":"TSN",
              "longName":"TSN"
           }
        ]
        """.data(using: .utf8)!
        let canadianBroadcasterMediaNames = try JSONDecoder().decode([MediaNames].self, from: canadianBroadcaster)

        let hTeamBroadcaster = """
        [
            {
                "shortName":"FSSE-ATL",
                "longName":"Fox Sports Southeast - Atlanta"
            }
        ]
        """.data(using: .utf8)!
        let hTeamBroadcasterMediaNames = try JSONDecoder().decode([MediaNames].self, from: hTeamBroadcaster)

        let vTeamAudio = """
        [
            {
                "shortName":"WYGM-FM/AM/WNUE-FM",
                "longName":"WYGM-FM/AM/WNUE-FM"
            }
        ]
        """.data(using: .utf8)!
        let vTeamAudioMediaNames = try JSONDecoder().decode([MediaNames].self, from: vTeamAudio)

        let hTeamAudio = """
        [
            {
                "shortName":"WZGC 92.9 FM The Game",
                "longName":"WZGC 92.9 FM The Game"
            }
        ]
        """.data(using: .utf8)!
        let hTeamAudioMediaNames = try JSONDecoder().decode([MediaNames].self, from: hTeamAudio)

        XCTAssertEqual(teamScheduleResponse.gameUrlCode, "20201211/ORLATL")
        XCTAssertEqual(teamScheduleResponse.gameId, "0012000001")
        XCTAssertEqual(teamScheduleResponse.statusNumber, 3)
        XCTAssertEqual(teamScheduleResponse.extendedStatusNum, 0)
        XCTAssertEqual(teamScheduleResponse.startTimeEastern, "7:00 PM ET")
        XCTAssertEqual(teamScheduleResponse.startTimeUTC, startTimeUTC)
        XCTAssertEqual(teamScheduleResponse.startDateEastern, "20201211")
        XCTAssertEqual(teamScheduleResponse.homeStartDate, "20201211")
        XCTAssertEqual(teamScheduleResponse.homeStartTime, "1900")
        XCTAssertEqual(teamScheduleResponse.visitorStartDate, "20201211")
        XCTAssertEqual(teamScheduleResponse.visitorStartTime, "1900")
        XCTAssertEqual(teamScheduleResponse.isHomeTeam, true)
        XCTAssertEqual(teamScheduleResponse.isStartTimeTBD, false)
        XCTAssertEqual(teamScheduleResponse.visitorTeam, visitorTeam)
        XCTAssertEqual(teamScheduleResponse.homeTeam, homeTeam)
        XCTAssertEqual(teamScheduleResponse.regionalBlackoutCodes, "")
        XCTAssertNil(teamScheduleResponse.isNeutralVenue)
        XCTAssertNil(teamScheduleResponse.isBuzzerBeater)
        XCTAssertNil(teamScheduleResponse.period)
        XCTAssertEqual(teamScheduleResponse.isPurchasable, false)
        XCTAssertEqual(teamScheduleResponse.isLeaguePass, true)
        XCTAssertEqual(teamScheduleResponse.isNationalBlackout, false)
        XCTAssertEqual(teamScheduleResponse.isTNTOT, false)
        XCTAssertEqual(teamScheduleResponse.isVR, false)
        XCTAssertEqual(teamScheduleResponse.isTntOTOnAir, false)
        XCTAssertEqual(teamScheduleResponse.isNextVR, false)
        XCTAssertEqual(teamScheduleResponse.isNBAOnTNTVR, false)
        XCTAssertEqual(teamScheduleResponse.isMagicLeap, false)
        XCTAssertEqual(teamScheduleResponse.isOculusVenues, false)
        XCTAssertEqual(teamScheduleResponse.media!.sorted().first!.category, "audio")
        XCTAssertEqual(teamScheduleResponse.media!.sorted().last!.category, "broadcasters")
        XCTAssertEqual(teamScheduleResponse.media!.sorted().last!.details.sorted().first?.subCategory, "canadian")
        XCTAssertEqual(teamScheduleResponse.media!.sorted().last!.details.sorted().last?.subCategory, "hTeam")
        XCTAssertEqual(teamScheduleResponse.media!.sorted().first!.details.sorted().first?.subCategory, "hTeam")
        XCTAssertEqual(teamScheduleResponse.media!.sorted().first!.details.sorted().last?.subCategory, "vTeam")
        XCTAssertEqual(teamScheduleResponse.media!.sorted().first!.details.sorted().first?.names.containsSameElements(as: hTeamAudioMediaNames), true)
        XCTAssertEqual(teamScheduleResponse.media!.sorted().first!.details.sorted().last?.names.containsSameElements(as: vTeamAudioMediaNames), true)
        XCTAssertEqual(teamScheduleResponse.media!.sorted().last!.details.sorted().first?.names.containsSameElements(as: canadianBroadcasterMediaNames), true)
        XCTAssertEqual(teamScheduleResponse.media!.sorted().last!.details.sorted().last?.names.containsSameElements(as: hTeamBroadcasterMediaNames), true)
    }

    func test_teamScheduleModel_withBadData_isNil() throws {
        let path = getPath(forResource: "TeamScheduleModelBadDataFormat",
                               ofType: "json")
        let teamScheduleModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var teamScheduleModelResponse: Leader?

        do {
            teamScheduleModelResponse = try JSONDecoder().decode(Leader.self, from: teamScheduleModelData)
        } catch {
            teamScheduleModelResponse = nil
        }
        XCTAssertNil(teamScheduleModelResponse)
    }

    func test_teamScheduleModel_withMissingData_isNil() throws {
        let path = getPath(forResource: "TeamScheduleModelMissingDataFormat",
                               ofType: "json")
        let teamScheduleModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var teamScheduleModelResponse: Leader?

        do {
            teamScheduleModelResponse = try JSONDecoder().decode(Leader.self, from: teamScheduleModelData)
        } catch {
            teamScheduleModelResponse = nil
        }
        XCTAssertNil(teamScheduleModelResponse)
    }
    
    // MARK: Complete Schedule

    func test_teamScheduleModel_fromCompleteScheduleCall_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "TeamScheduleModelFromCompleteScheduleCall",
                               ofType: "json")
        let teamScheduleData = try Data(contentsOf: URL(fileURLWithPath: path))
        let dateFormatter = DateFormatter.iso8601Full
        let startTimeUTC = dateFormatter.date(from: "2020-12-12T01:00:00.000Z")
        let teamScheduleResponse = try JSONDecoder().decode(TeamSchedule.self, from: teamScheduleData)
        let visitorScheduledTeamData = """
            {
                "teamId":"1610612745",
                "score":"125"
            }
            """.data(using: .utf8)!
        let visitorTeam = try JSONDecoder().decode(ScheduledTeam.self, from: visitorScheduledTeamData)
        let homeScheduledTeamData = """
            {
                "teamId":"1610612741",
                "score":"104"
            }
            """.data(using: .utf8)!
        let homeTeam = try JSONDecoder().decode(ScheduledTeam.self, from: homeScheduledTeamData)

        let canadianBroadcasterData = """
        [
           {
              "shortName":"SNN",
              "longName":"SNN"
           }
        ]
        """.data(using: .utf8)!
        let canadianBroadcasterMediaNames = try JSONDecoder().decode([MediaNames].self, from: canadianBroadcasterData)

        let nationalData = """
        [
            {
                "shortName":"NBA TV",
                "longName":"NBA TV"
            }
        ]
        """.data(using: .utf8)!
        let nationalMediaNames = try JSONDecoder().decode([MediaNames].self, from: nationalData)
        
        let periodData = """
        {
              "current":4,
              "type":0,
              "maxRegular":4
        }
        """.data(using: .utf8)!
        let period = try JSONDecoder().decode(Period.self, from: periodData)
        XCTAssertEqual(teamScheduleResponse.gameUrlCode, "20201211/HOUCHI")
        XCTAssertEqual(teamScheduleResponse.gameId, "0012000003")
        XCTAssertEqual(teamScheduleResponse.statusNumber, 3)
        XCTAssertEqual(teamScheduleResponse.extendedStatusNum, 0)
        XCTAssertEqual(teamScheduleResponse.startTimeEastern, "8:00 PM ET")
        XCTAssertEqual(teamScheduleResponse.startTimeUTC, startTimeUTC)
        XCTAssertEqual(teamScheduleResponse.startDateEastern, "20201211")
        XCTAssertNil(teamScheduleResponse.homeStartDate)
        XCTAssertNil(teamScheduleResponse.homeStartTime)
        XCTAssertNil(teamScheduleResponse.visitorStartDate)
        XCTAssertNil(teamScheduleResponse.visitorStartTime)
        XCTAssertNil(teamScheduleResponse.isHomeTeam)
        XCTAssertEqual(teamScheduleResponse.isStartTimeTBD, false)
        XCTAssertEqual(teamScheduleResponse.visitorTeam, visitorTeam)
        XCTAssertEqual(teamScheduleResponse.homeTeam, homeTeam)
        XCTAssertEqual(teamScheduleResponse.regionalBlackoutCodes, "")
        XCTAssertEqual(teamScheduleResponse.isBuzzerBeater, false)
        XCTAssertEqual(teamScheduleResponse.period, period)
        XCTAssertEqual(teamScheduleResponse.isNeutralVenue, false)
        XCTAssertEqual(teamScheduleResponse.isPurchasable, false)
        XCTAssertEqual(teamScheduleResponse.isLeaguePass, true)
        XCTAssertEqual(teamScheduleResponse.isNationalBlackout, false)
        XCTAssertEqual(teamScheduleResponse.isTNTOT, false)
        XCTAssertEqual(teamScheduleResponse.isVR, false)
        XCTAssertNil(teamScheduleResponse.isTntOTOnAir)
        XCTAssertEqual(teamScheduleResponse.isNextVR, false)
        XCTAssertEqual(teamScheduleResponse.isNBAOnTNTVR, false)
        XCTAssertEqual(teamScheduleResponse.isMagicLeap, false)
        XCTAssertEqual(teamScheduleResponse.isOculusVenues, false)
        XCTAssertEqual(teamScheduleResponse.media!.sorted().first!.category, "video")
        XCTAssertEqual(teamScheduleResponse.media!.sorted().last!.details.sorted().first?.subCategory, "canadian")
        XCTAssertEqual(teamScheduleResponse.media!.sorted().last!.details.sorted().last?.subCategory, "national")
        XCTAssertEqual(teamScheduleResponse.media!.sorted().last!.details.sorted().first?.names.containsSameElements(as: canadianBroadcasterMediaNames), true)
        XCTAssertEqual(teamScheduleResponse.media!.sorted().last!.details.sorted().last?.names.containsSameElements(as: nationalMediaNames), true)
    }
    
    // MARK: Coach

    func test_coachModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "CoachModel",
                               ofType: "json")
        let coachModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let coachModelResponse = try JSONDecoder().decode(Coach.self, from: coachModelData)
        XCTAssertEqual(coachModelResponse.firstName, "Doc")
        XCTAssertEqual(coachModelResponse.lastName, "Rivers")
        XCTAssertEqual(coachModelResponse.isAssistant, false)
        XCTAssertEqual(coachModelResponse.personId, "1941")
        XCTAssertEqual(coachModelResponse.teamId, "1610612755")
        XCTAssertEqual(coachModelResponse.college, "Marquette")
    
    }

    func test_coachModel_withBadData_isNil() throws {
        let path = getPath(forResource: "CoachModelBadDataFormat",
                               ofType: "json")
        let coachModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var coachModelResponse: Coach?

        do {
            coachModelResponse = try JSONDecoder().decode(Coach.self, from: coachModelData)
        } catch {
            coachModelResponse = nil
        }
        XCTAssertNil(coachModelResponse)
    }

     func test_coachModel_withMissingData_isNil() throws {
        let path = getPath(forResource: "CoachModelMissingDataFormat",
                               ofType: "json")
        let coachModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let coachModelResponse: Coach?

        do {
            coachModelResponse = try JSONDecoder().decode(Coach.self, from: coachModelData)
        } catch {
            coachModelResponse = nil
        }
        XCTAssertNil(coachModelResponse)
     }
    
    // MARK: Team Stat Ranking

    func test_teamStatRankingModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "TeamStatRankingModel",
                               ofType: "json")
        let teamStatRankingModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let teamStatRankingModelResponse = try JSONDecoder().decode(TeamStatRanking.self, from: teamStatRankingModelData)
        
        let minData = """
        {
              "avg":"48.0",
              "rank":"3"
        }
        """.data(using: .utf8)!
        let minStatRanking = try JSONDecoder().decode(StatRanking.self, from: minData)
        
        let fgpData = """
        {
              "avg":"0.40",
              "rank":"29"
        }
        """.data(using: .utf8)!
        let fgpStatRanking = try JSONDecoder().decode(StatRanking.self, from: fgpData)
        
        let tppData = """
        {
              "avg":"0.32",
              "rank":"22"
        }
        """.data(using: .utf8)!
        let tppStatRanking = try JSONDecoder().decode(StatRanking.self, from: tppData)
        
        let ftpData = """
        {
              "avg":"0.80",
              "rank":"2"
        }
        """.data(using: .utf8)!
        let ftpStatRanking = try JSONDecoder().decode(StatRanking.self, from: ftpData)
        
        let orpgData = """
        {
              "avg":"11.8",
              "rank":"4"
        }
        """.data(using: .utf8)!
        let orpgStatRanking = try JSONDecoder().decode(StatRanking.self, from: orpgData)
        
        let drpgData = """
        {
              "avg":"42.0",
              "rank":"3"
        }
        """.data(using: .utf8)!
        let drpgStatRanking = try JSONDecoder().decode(StatRanking.self, from: drpgData)
        
        let trpgData = """
        {
              "avg":"53.8",
              "rank":"2"
        }
        """.data(using: .utf8)!
        let trpgStatRanking = try JSONDecoder().decode(StatRanking.self, from: trpgData)
        
        let apgData = """
        {
              "avg":"24.0",
              "rank":"14"
        }
        """.data(using: .utf8)!
        let apgStatRanking = try JSONDecoder().decode(StatRanking.self, from: apgData)
        
        let tpgData = """
        {
              "avg":"17.8",
              "rank":"16"
        }
        """.data(using: .utf8)!
        let tpgStatRanking = try JSONDecoder().decode(StatRanking.self, from: tpgData)
        
        let spgData = """
        {
              "avg":"7.2",
              "rank":"23"
        }
        """.data(using: .utf8)!
        let spgStatRanking = try JSONDecoder().decode(StatRanking.self, from: spgData)
        
        let bpgData = """
        {
              "avg":"3.2",
              "rank":"23"
        }
        """.data(using: .utf8)!
        let bpgStatRanking = try JSONDecoder().decode(StatRanking.self, from: bpgData)
        
        let pfpgData = """
        {
              "avg":"24.0",
              "rank":"15"
        }
        """.data(using: .utf8)!
        let pfpgStatRanking = try JSONDecoder().decode(StatRanking.self, from: pfpgData)
        
        let ppgData = """
        {
              "avg":"112.8",
              "rank":"9"
        }
        """.data(using: .utf8)!
        let ppgStatRanking = try JSONDecoder().decode(StatRanking.self, from: ppgData)
        
        let oppgData = """
        {
              "avg":"116.8",
              "rank":"6"
        }
        """.data(using: .utf8)!
        let oppgStatRanking = try JSONDecoder().decode(StatRanking.self, from: oppgData)
        
        let effData = """
        {
              "avg":"-4.00",
              "rank":"18"
        }
        """.data(using: .utf8)!
        let effStatRanking = try JSONDecoder().decode(StatRanking.self, from: effData)
        
        XCTAssertEqual(teamStatRankingModelResponse.teamId, "1610612737")
        XCTAssertEqual(teamStatRankingModelResponse.min, minStatRanking)
        XCTAssertEqual(teamStatRankingModelResponse.fgp, fgpStatRanking)
        XCTAssertEqual(teamStatRankingModelResponse.tpp, tppStatRanking)
        XCTAssertEqual(teamStatRankingModelResponse.ftp, ftpStatRanking)
        XCTAssertEqual(teamStatRankingModelResponse.orpg, orpgStatRanking)
        XCTAssertEqual(teamStatRankingModelResponse.drpg, drpgStatRanking)
        XCTAssertEqual(teamStatRankingModelResponse.trpg, trpgStatRanking)
        XCTAssertEqual(teamStatRankingModelResponse.apg, apgStatRanking)
        XCTAssertEqual(teamStatRankingModelResponse.tpg, tpgStatRanking)
        XCTAssertEqual(teamStatRankingModelResponse.spg, spgStatRanking)
        XCTAssertEqual(teamStatRankingModelResponse.bpg, bpgStatRanking)
        XCTAssertEqual(teamStatRankingModelResponse.pfpg, pfpgStatRanking)
        XCTAssertEqual(teamStatRankingModelResponse.ppg, ppgStatRanking)
        XCTAssertEqual(teamStatRankingModelResponse.oppg, oppgStatRanking)
        XCTAssertEqual(teamStatRankingModelResponse.eff, effStatRanking)
    }

    func test_teamStatRanking_withBadData_isNil() throws {
        let path = getPath(forResource: "TeamStatRankingModelBadData",
                               ofType: "json")
        let teamStatRankingModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var teamStatRankingModelResponse: TeamStatRanking?

        do {
            teamStatRankingModelResponse = try JSONDecoder().decode(TeamStatRanking.self, from: teamStatRankingModelData)
        } catch {
            teamStatRankingModelResponse = nil
        }
        XCTAssertNil(teamStatRankingModelResponse)
    }

    func test_teamStatRanking_withMissingData_isNil() throws {
        let path = getPath(forResource: "TeamStatRankingModelMissingData",
                               ofType: "json")
        let teamStatRankingModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var teamStatRankingModelResponse: TeamStatRanking?

        do {
            teamStatRankingModelResponse = try JSONDecoder().decode(TeamStatRanking.self, from: teamStatRankingModelData)
        } catch {
            teamStatRankingModelResponse = nil
        }
        XCTAssertNil(teamStatRankingModelResponse)
    }
    
    // MARK: Player Stats

    func test_playerStatsModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "PlayerStatsModel",
                               ofType: "json")
        let playerStatsModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let playerStatsModelResponse = try JSONDecoder().decode(PlayerStats.self, from: playerStatsModelData)
        XCTAssertEqual(playerStatsModelResponse.ppg, 25.0)
        XCTAssertEqual(playerStatsModelResponse.rpg, 7.9)
        XCTAssertEqual(playerStatsModelResponse.apg, 7.8)
        XCTAssertEqual(playerStatsModelResponse.mpg, 33.7)
        XCTAssertEqual(playerStatsModelResponse.topg, 3.8)
        XCTAssertEqual(playerStatsModelResponse.spg, 1.0)
        XCTAssertEqual(playerStatsModelResponse.bpg, 0.6)
        XCTAssertEqual(playerStatsModelResponse.tpp, 36.6)
        XCTAssertEqual(playerStatsModelResponse.ftp, 70.1)
        XCTAssertEqual(playerStatsModelResponse.fgp, 51.3)
        XCTAssertEqual(playerStatsModelResponse.assists, 336)
        XCTAssertEqual(playerStatsModelResponse.blocks, 25)
        XCTAssertEqual(playerStatsModelResponse.steals, 45)
        XCTAssertEqual(playerStatsModelResponse.turnovers, 162)
        XCTAssertEqual(playerStatsModelResponse.offensiveRebounds, 25)
        XCTAssertEqual(playerStatsModelResponse.defensiveRebounds, 313)
        XCTAssertEqual(playerStatsModelResponse.totalRebounds, 338)
        XCTAssertEqual(playerStatsModelResponse.fgm, 400)
        XCTAssertEqual(playerStatsModelResponse.fga, 779)
        XCTAssertEqual(playerStatsModelResponse.tpm, 101)
        XCTAssertEqual(playerStatsModelResponse.tpa, 276)
        XCTAssertEqual(playerStatsModelResponse.ftm, 176)
        XCTAssertEqual(playerStatsModelResponse.fta, 251)
        XCTAssertEqual(playerStatsModelResponse.personalFouls, 68)
        XCTAssertEqual(playerStatsModelResponse.points, 1077)
        XCTAssertEqual(playerStatsModelResponse.gamesPlayed, 43)
        XCTAssertEqual(playerStatsModelResponse.gamesStarted, 43)
        XCTAssertEqual(playerStatsModelResponse.plusMinus, 285)
        XCTAssertEqual(playerStatsModelResponse.min, 1447)
        XCTAssertEqual(playerStatsModelResponse.dd2, 18)
        XCTAssertEqual(playerStatsModelResponse.td3, 5)
    }

    func test_playerStatsModel_withBadData_isNil() throws {
        let path = getPath(forResource: "PlayerStatsModelBadData",
                               ofType: "json")
        let playerStatsModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var playerStatsModelResponse: PlayerStats?

        do {
            playerStatsModelResponse = try JSONDecoder().decode(PlayerStats.self, from: playerStatsModelData)
        } catch {
            playerStatsModelResponse = nil
        }
        XCTAssertNil(playerStatsModelResponse)
    }

    func test_playerStatsModel_withMissingData_isNil() throws {
        let path = getPath(forResource: "PlayerStatsModelMissingData",
                               ofType: "json")
        let playerStatsModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var playerStatsModelResponse: PlayerStats?

        do {
            playerStatsModelResponse = try JSONDecoder().decode(PlayerStats.self, from: playerStatsModelData)
        } catch {
            playerStatsModelResponse = nil
        }
        XCTAssertNil(playerStatsModelResponse)
     }
    
    // MARK: Play
    
    func test_playModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "PlayModel",
                               ofType: "json")
        let playModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let playModelResponse = try JSONDecoder().decode(Play.self, from: playModelData)
        XCTAssertEqual(playModelResponse.clock, "10:31")
        XCTAssertEqual(playModelResponse.eventMsgType, "4")
        XCTAssertEqual(playModelResponse.description, "[DET] Wright Rebound (Off:1 Def:1)")
        XCTAssertEqual(playModelResponse.playerId, "1626153")
        XCTAssertEqual(playModelResponse.teamId, "1610612765")
        XCTAssertEqual(playModelResponse.vTeamScore, 2)
        XCTAssertEqual(playModelResponse.hTeamScore, 6)
        XCTAssertEqual(playModelResponse.isScoreChange, false)
        XCTAssertEqual(playModelResponse.formattedDescription, "DET - Wright Rebound (Off:1 Def:1)")
    }

    func test_playModel_withBadData_isNil() throws {
        let path = getPath(forResource: "PlayModelBadDataFormat",
                               ofType: "json")
        let playModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let playModelResponse: Play?

        do {
            playModelResponse = try JSONDecoder().decode(Play.self, from: playModelData)
        } catch {
            playModelResponse = nil
        }
        XCTAssertNil(playModelResponse)
    }

    func test_playhModel_withMissingData_isNil() throws {
        let path = getPath(forResource: "PlayModelMissingDataFormat",
                               ofType: "json")
        let playModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let playhModelResponse: Play?

        do {
            playhModelResponse = try JSONDecoder().decode(Play.self, from: playModelData)
        } catch {
            playhModelResponse = nil
        }
        XCTAssertNil(playhModelResponse)
    }
    
    // MARK: LeadTracker
    
    func test_leadTrackerModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "LeadTrackerModel",
                               ofType: "json")
        let leadTrackerData = try Data(contentsOf: URL(fileURLWithPath: path))
        let leadTrackerDataResponse = try JSONDecoder().decode(LeadTracker.self, from: leadTrackerData)
        XCTAssertEqual(leadTrackerDataResponse.clock, "11:48")
        XCTAssertEqual(leadTrackerDataResponse.leadTeamId, "1610612761")
        XCTAssertEqual(leadTrackerDataResponse.points, 2)
    }

    func test_leadTrackerModel_withBadData_isNil() throws {
        let path = getPath(forResource: "LeadTrackerBadDataFormat",
                               ofType: "json")
        let leadTrackerData = try Data(contentsOf: URL(fileURLWithPath: path))
        let leadTrackerModelResponse: LeadTracker?

        do {
            leadTrackerModelResponse = try JSONDecoder().decode(LeadTracker.self, from: leadTrackerData)
        } catch {
            leadTrackerModelResponse = nil
        }
        XCTAssertNil(leadTrackerModelResponse)
    }

    func test_leadTrackerModel_withMissingData_isNil() throws {
        let path = getPath(forResource: "LeadTrackerMissingDataFormat",
                               ofType: "json")
        let leadTrackerData = try Data(contentsOf: URL(fileURLWithPath: path))
        let leadTrackerModelResponse: LeadTracker?

        do {
            leadTrackerModelResponse = try JSONDecoder().decode(LeadTracker.self, from: leadTrackerData)
        } catch {
            leadTrackerModelResponse = nil
        }
        XCTAssertNil(leadTrackerModelResponse)
    }
    
    // MARK: GameRecap

    func test_gameRecapModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "GameRecapModel",
                               ofType: "json")
        let gameRecapModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let gameRecapModelResponse = try JSONDecoder().decode(GameRecap.self, from: gameRecapModelData)
        let publishDate = "2021-01-26T04:44:00.000Z".iso8601Date!
        let paragraph = Paragraph(text: "DETROIT (AP)  Delon Wright scored a career-high 28 points and Wayne Ellington had another impressive shooting night for Detroit, leading the Pistons to a 119-104 victory over the Eastern Conference-leading Philadelphia 76ers on Monday.")
        let paragraphs = [paragraph]
        
        
        XCTAssertEqual(gameRecapModelResponse.author, "By NOAH TRISTER")
        XCTAssertEqual(gameRecapModelResponse.authorTitle, "AP Sports Writer")
        XCTAssertEqual(gameRecapModelResponse.copyright, "Copyright 2021 by STATS LLC and Associated Press. Any commercial use or distribution without the express written consent of STATS LLC and Associated Press is strictly prohibited")
        XCTAssertEqual(gameRecapModelResponse.title, "Wright, Ellington lead Pistons over 76ers 119-104")
        XCTAssertEqual(gameRecapModelResponse.publishDate, publishDate)
        XCTAssertEqual(gameRecapModelResponse.paragraphs, paragraphs)
    
    }

    func test_gameRecapModel_withBadData_isNil() throws {
        let path = getPath(forResource: "GameRecapModelBadDataFormat",
                               ofType: "json")
        let gameRecapModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var gameRecapModelResponse: GameRecap?

        do {
            gameRecapModelResponse = try JSONDecoder().decode(GameRecap.self, from: gameRecapModelData)
        } catch {
            gameRecapModelResponse = nil
        }
        XCTAssertNil(gameRecapModelResponse)
    }

     func test_gameRecapModel_withMissingData_isNil() throws {
        let path = getPath(forResource: "GameRecapModelMissingDataFormat",
                               ofType: "json")
        let gameRecapModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let gameRecapModelResponse: GameRecap?

        do {
            gameRecapModelResponse = try JSONDecoder().decode(GameRecap.self, from: gameRecapModelData)
        } catch {
            gameRecapModelResponse = nil
        }
        XCTAssertNil(gameRecapModelResponse)
     }
    
    // MARK: TotalLeagueLeader
    
    func test_totalLeagueLeaderModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "TotalLeagueLeaderModel",
                               ofType: "json")
        let totalLeagueModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let totalLeagueModelResponse = try JSONDecoder().decode(TotalLeagueLeader.self, from: totalLeagueModelData)
        XCTAssertEqual(totalLeagueModelResponse.playerId, "203999")
        XCTAssertEqual(totalLeagueModelResponse.rank, 1)
        XCTAssertEqual(totalLeagueModelResponse.player, "Nikola Jokic")
        XCTAssertEqual(totalLeagueModelResponse.team, "DEN")
        XCTAssertEqual(totalLeagueModelResponse.gamesPlayed, 72)
        XCTAssertEqual(totalLeagueModelResponse.minutes, 2488)
        XCTAssertEqual(totalLeagueModelResponse.fieldGoalsMade, 732)
        XCTAssertEqual(totalLeagueModelResponse.fieldGoalsAttempted, 1293)
        XCTAssertEqual(totalLeagueModelResponse.fieldGoalsPercentage, 0.566)
        XCTAssertEqual(totalLeagueModelResponse.threePointersMade, 92)
        XCTAssertEqual(totalLeagueModelResponse.threePointersAttempted, 237)
        XCTAssertEqual(totalLeagueModelResponse.threePointersPercentage, 0.388)
        XCTAssertEqual(totalLeagueModelResponse.foulShotsMade, 342)
        XCTAssertEqual(totalLeagueModelResponse.foulShotsAttempted, 394)
        XCTAssertEqual(totalLeagueModelResponse.foulShotsPercentage, 0.868)
        XCTAssertEqual(totalLeagueModelResponse.defensiveRebounds, 575)
        XCTAssertEqual(totalLeagueModelResponse.offensiveRebounds, 205)
        XCTAssertEqual(totalLeagueModelResponse.rebounds, 780)
        XCTAssertEqual(totalLeagueModelResponse.assists, 599)
        XCTAssertEqual(totalLeagueModelResponse.steals, 95)
        XCTAssertEqual(totalLeagueModelResponse.blocks, 48)
        XCTAssertEqual(totalLeagueModelResponse.turnovers, 222)
        XCTAssertEqual(totalLeagueModelResponse.personalFouls, 192)
        XCTAssertEqual(totalLeagueModelResponse.playerEfficiency, 2585)
        XCTAssertEqual(totalLeagueModelResponse.points, 1898)
        XCTAssertEqual(totalLeagueModelResponse.assistsToTurnovers, 2.7)
        XCTAssertEqual(totalLeagueModelResponse.stealsToTurnovers, 0.43)
    }

    func test_totalLeagueLeaderModel_withBadData_isNil() throws {
        let path = getPath(forResource: "TotalLeagueLeaderModelBadDataFormat",
                               ofType: "json")
        let totalLeagueModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var totalLeagueModelResponse: TotalLeagueLeader?

        do {
            totalLeagueModelResponse = try JSONDecoder().decode(TotalLeagueLeader.self, from: totalLeagueModelData)
        } catch {
            totalLeagueModelResponse = nil
        }
        XCTAssertNil(totalLeagueModelResponse)
    }

     func test_totalLeagueLeaderModel_withMissingData_isNil() throws {
        let path = getPath(forResource: "TotalLeagueLeaderModelMissingDataFormat",
                               ofType: "json")
        let totalLeagueModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let totalLeagueModelResponse: TotalLeagueLeader?

        do {
            totalLeagueModelResponse = try JSONDecoder().decode(TotalLeagueLeader.self, from: totalLeagueModelData)
        } catch {
            totalLeagueModelResponse = nil
        }
        XCTAssertNil(totalLeagueModelResponse)
     }
    
    // MARK: PerGameLeagueLeader

    func test_perGameLeagueLeaderModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "PerGameLeagueLeaderModel",
                               ofType: "json")
        let perGameLeagueModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let perGameLeagueModelResponse = try JSONDecoder().decode(PerGameLeagueLeader.self, from: perGameLeagueModelData)
        XCTAssertEqual(perGameLeagueModelResponse.playerId, "203999")
        XCTAssertEqual(perGameLeagueModelResponse.rank, 1)
        XCTAssertEqual(perGameLeagueModelResponse.player, "Nikola Jokic")
        XCTAssertEqual(perGameLeagueModelResponse.team, "DEN")
        XCTAssertEqual(perGameLeagueModelResponse.gamesPlayed, 72)
        XCTAssertEqual(perGameLeagueModelResponse.minutes, 34.6)
        XCTAssertEqual(perGameLeagueModelResponse.fieldGoalsMade, 10.2)
        XCTAssertEqual(perGameLeagueModelResponse.fieldGoalsAttempted, 18)
        XCTAssertEqual(perGameLeagueModelResponse.fieldGoalsPercentage, 0.566)
        XCTAssertEqual(perGameLeagueModelResponse.threePointersMade, 1.3)
        XCTAssertEqual(perGameLeagueModelResponse.threePointersAttempted, 3.3)
        XCTAssertEqual(perGameLeagueModelResponse.threePointersPercentage, 0.388)
        XCTAssertEqual(perGameLeagueModelResponse.foulShotsMade, 4.8)
        XCTAssertEqual(perGameLeagueModelResponse.foulShotsAttempted, 5.5)
        XCTAssertEqual(perGameLeagueModelResponse.foulShotsPercentage, 0.868)
        XCTAssertEqual(perGameLeagueModelResponse.defensiveRebounds, 8)
        XCTAssertEqual(perGameLeagueModelResponse.offensiveRebounds, 2.8)
        XCTAssertEqual(perGameLeagueModelResponse.rebounds, 10.8)
        XCTAssertEqual(perGameLeagueModelResponse.assists, 8.3)
        XCTAssertEqual(perGameLeagueModelResponse.steals, 1.3)
        XCTAssertEqual(perGameLeagueModelResponse.blocks, 0.7)
        XCTAssertEqual(perGameLeagueModelResponse.turnovers, 3.1)
        XCTAssertEqual(perGameLeagueModelResponse.playerEfficiency, 35.9)
        XCTAssertEqual(perGameLeagueModelResponse.points, 26.4)
    }

    func test_perGameLeagueLeaderModel_withBadData_isNil() throws {
        let path = getPath(forResource: "PerGameLeagueLeaderModelBadDataFormat",
                               ofType: "json")
        let perGameLeagueModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var perGameLeagueModelResponse: PerGameLeagueLeader?

        do {
            perGameLeagueModelResponse = try JSONDecoder().decode(PerGameLeagueLeader.self, from: perGameLeagueModelData)
        } catch {
            perGameLeagueModelResponse = nil
        }
        XCTAssertNil(perGameLeagueModelResponse)
    }

     func test_perGameLeagueLeaderModel_withMissingData_isNil() throws {
        let path = getPath(forResource: "PerGameLeagueLeaderModelMissingDataFormat",
                               ofType: "json")
        let perGameLeagueModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var perGameLeagueModelResponse: PerGameLeagueLeader?

        do {
            perGameLeagueModelResponse = try JSONDecoder().decode(PerGameLeagueLeader.self, from: perGameLeagueModelData)
        } catch {
            perGameLeagueModelResponse = nil
        }
        XCTAssertNil(perGameLeagueModelResponse)
     }
    
    // MARK: Per48LeagueLeader

   func test_per48LeagueLeaderModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "Per48LeagueLeaderModel",
                               ofType: "json")
        let per48LeagueModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let per48LeagueModelResponse = try JSONDecoder().decode(Per48LeagueLeader.self, from: per48LeagueModelData)
        XCTAssertEqual(per48LeagueModelResponse.playerId, "203999")
        XCTAssertEqual(per48LeagueModelResponse.rank, 1)
        XCTAssertEqual(per48LeagueModelResponse.player, "Nikola Jokic")
        XCTAssertEqual(per48LeagueModelResponse.team, "DEN")
        XCTAssertEqual(per48LeagueModelResponse.gamesPlayed, 72)
        XCTAssertEqual(per48LeagueModelResponse.minutes, 2488)
        XCTAssertEqual(per48LeagueModelResponse.fieldGoalsMade, 14.1)
        XCTAssertEqual(per48LeagueModelResponse.fieldGoalsAttempted, 24.9)
        XCTAssertEqual(per48LeagueModelResponse.fieldGoalsPercentage, 0.566)
        XCTAssertEqual(per48LeagueModelResponse.threePointersMade, 1.8)
        XCTAssertEqual(per48LeagueModelResponse.threePointersAttempted, 4.6)
        XCTAssertEqual(per48LeagueModelResponse.threePointersPercentage, 0.388)
        XCTAssertEqual(per48LeagueModelResponse.foulShotsMade, 6.6)
        XCTAssertEqual(per48LeagueModelResponse.foulShotsAttempted, 7.6)
        XCTAssertEqual(per48LeagueModelResponse.foulShotsPercentage, 0.868)
        XCTAssertEqual(per48LeagueModelResponse.defensiveRebounds, 11.1)
        XCTAssertEqual(per48LeagueModelResponse.offensiveRebounds, 4.0)
        XCTAssertEqual(per48LeagueModelResponse.rebounds, 15.0)
        XCTAssertEqual(per48LeagueModelResponse.assists, 11.6)
        XCTAssertEqual(per48LeagueModelResponse.steals, 1.83)
        XCTAssertEqual(per48LeagueModelResponse.blocks, 0.93)
        XCTAssertEqual(per48LeagueModelResponse.turnovers, 4.28)
        XCTAssertEqual(per48LeagueModelResponse.playerEfficiency, 49.9)
        XCTAssertEqual(per48LeagueModelResponse.personalFouls, 3.7)
    }

    func test_per48LeagueLeaderModel_withBadData_isNil() throws {
        let path = getPath(forResource: "Per48LeagueLeaderModelBadDataFormat",
                               ofType: "json")
        let per48LeagueModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var per48LeagueModelResponse: Per48LeagueLeader?

        do {
            per48LeagueModelResponse = try JSONDecoder().decode(Per48LeagueLeader.self, from: per48LeagueModelData)
        } catch {
            per48LeagueModelResponse = nil
        }
        XCTAssertNil(per48LeagueModelResponse)
    }

     func test_per48LeagueLeaderModel_withMissingData_isNil() throws {
        let path = getPath(forResource: "Per48LeagueLeaderModelMissingDataFormat",
                               ofType: "json")
        let per48LeagueModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var per48LeagueModelResponse: Per48LeagueLeader?

        do {
            per48LeagueModelResponse = try JSONDecoder().decode(Per48LeagueLeader.self, from: per48LeagueModelData)
        } catch {
            per48LeagueModelResponse = nil
        }
        XCTAssertNil(per48LeagueModelResponse)
     }
    
    // MARK: Boxscore - BasicGameData

    func test_boxscoreBasicGameDataModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "BoxscoreBasicGameModel",
                                ofType: "json")
        let boxscoreBasicGameData = try Data(contentsOf: URL(fileURLWithPath: path))
        let boxscoreBasicGameDataResponse = try JSONDecoder().decode(BasicGameData.self, from: boxscoreBasicGameData)
        let dateFormatter: DateFormatter
        dateFormatter = DateFormatter.iso8601Full
        
        let arenaData = """
            {
                "name":"Little Caesars Arena",
                "isDomestic":true,
                "city":"Detroit",
                "stateAbbr":"MI",
                "country":"USA"
            }
            """.data(using: .utf8)!
        let arena = try JSONDecoder().decode(Arena.self, from: arenaData)
        
        let gameDurationData = """
            {
                "hours":"2",
                "minutes":"21"
            }
            """.data(using: .utf8)!
        let gameDuration = try JSONDecoder().decode(GameDuration.self, from: gameDurationData)
        
        let boxscorePeriodData = """
            {
                "current":4,
                "type":0,
                "maxRegular":4,
                "isHalftime":false,
                "isEndOfPeriod":false
            }
            """.data(using: .utf8)!
        let boxscorePeriod = try JSONDecoder().decode(BoxscorePeriod.self, from: boxscorePeriodData)
        
        let officials: [Official] = [Official(fullName: "JB DeRosa"),
                                     Official(fullName: "Rodney Mott"),
                                     Official(fullName: "Andy Nagy")]
        
        let homeTeamBoxscoreData = """
            {
                "teamId":"1610612765",
                "triCode":"DET",
                "win":"4",
                "loss":"13",
                "seriesWin":"1",
                "seriesLoss":"1",
                "score":"119",
                "linescore":[
                    {
                       "score":"34"
                    },
                    {
                       "score":"30"
                    },
                    {
                       "score":"25"
                    },
                    {
                       "score":"30"
                    }
                ]
            }
            """.data(using: .utf8)!
        let homeTeamData = try JSONDecoder().decode(BoxscoreTeamData.self, from: homeTeamBoxscoreData)
        
        let visitorTeamBoxscoreData = """
            {
                "teamId":"1610612755",
                "triCode":"PHI",
                "win":"12",
                "loss":"6",
                "seriesWin":"1",
                "seriesLoss":"1",
                "score":"104",
                "linescore":[
                    {
                       "score":"23"
                    },
                    {
                       "score":"27"
                    },
                    {
                       "score":"25"
                    },
                    {
                       "score":"29"
                    }
                ]
            }
            """.data(using: .utf8)!
        let visitorTeamData = try JSONDecoder().decode(BoxscoreTeamData.self, from: visitorTeamBoxscoreData)
        
        let startTime = dateFormatter.date(from: "2021-01-26T00:00:00.000Z")
        let endTime = dateFormatter.date(from: "2021-01-26T02:39:00.000Z")
        
        XCTAssertEqual(boxscoreBasicGameDataResponse.isGameActivated, false)
        XCTAssertEqual(boxscoreBasicGameDataResponse.status, 3)
        XCTAssertEqual(boxscoreBasicGameDataResponse.extendedStatus, 0)
        XCTAssertEqual(boxscoreBasicGameDataResponse.startTime, startTime)
        XCTAssertEqual(boxscoreBasicGameDataResponse.endTime, endTime)
        XCTAssertEqual(boxscoreBasicGameDataResponse.isBuzzerBeater, false)
        XCTAssertEqual(boxscoreBasicGameDataResponse.isNeutralVenue, false)
        XCTAssertEqual(boxscoreBasicGameDataResponse.arena, arena)
        XCTAssertEqual(boxscoreBasicGameDataResponse.gameDuration, gameDuration)
        XCTAssertEqual(boxscoreBasicGameDataResponse.period, boxscorePeriod)
        XCTAssertEqual(boxscoreBasicGameDataResponse.officials, officials)
        XCTAssertEqual(boxscoreBasicGameDataResponse.homeTeamData, homeTeamData)
        XCTAssertEqual(boxscoreBasicGameDataResponse.visitorTeamData, visitorTeamData)
     }
    
    func test_boxscoreModel_withBadData_isNil() throws {
         let path = getPath(forResource: "BoxscoreBasicGameModelBadDataFormat",
                                ofType: "json")
         let boxscoreBasicGameData = try Data(contentsOf: URL(fileURLWithPath: path))
         var boxscoreBasicGameDataResponse: BasicGameData?

         do {
            boxscoreBasicGameDataResponse = try JSONDecoder().decode(BasicGameData.self, from: boxscoreBasicGameData)
         } catch {
            boxscoreBasicGameDataResponse = nil
         }
         XCTAssertNil(boxscoreBasicGameDataResponse)
     } 

    func test_BoxscoreModel_withMissingData_isNil() throws {
         let path = getPath(forResource: "BoxscoreBasicGameModelMissingDataFormat",
                                ofType: "json")
         let teamScheduleModelData = try Data(contentsOf: URL(fileURLWithPath: path))
         var teamScheduleModelResponse: Leader?

         do {
             teamScheduleModelResponse = try JSONDecoder().decode(Leader.self, from: teamScheduleModelData)
         } catch {
             teamScheduleModelResponse = nil
         }
         XCTAssertNil(teamScheduleModelResponse)
     }
    
    // MARK: Boxscore - BoxscoreStats
    
    func test_boxscoreStatsModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "BoxscoreGameStatsModel",
                                ofType: "json")
        let boxscoreStatsData = try Data(contentsOf: URL(fileURLWithPath: path))
        let boxscoreStatsResponse = try JSONDecoder().decode(BoxscoreStats.self, from: boxscoreStatsData)
        
        let visitorTeamCodedStats = """
            {
                "fastBreakPoints":"11",
                "pointsInPaint":"48",
                "biggestLead":"0",
                "secondChancePoints":"23",
                "pointsOffTurnovers":"33",
                "longestRun":"8",
                "totals":{
                 "points":"104",
                 "fgm":"40",
                 "fga":"94",
                 "fgp":"42.6",
                 "ftm":"15",
                 "fta":"20",
                 "ftp":"75.0",
                 "tpm":"9",
                 "tpa":"28",
                 "tpp":"32.1",
                 "offReb":"13",
                 "defReb":"23",
                 "totReb":"36",
                 "assists":"15",
                 "pFouls":"26",
                 "steals":"12",
                 "turnovers":"9",
                 "blocks":"3",
                 "plusMinus":"-15",
                 "min":"240:00",
                 "short_timeout_remaining":"0",
                 "full_timeout_remaining":"2",
                 "team_fouls":"24"
                },
                "leaders":{
                 "points":{
                    "value":"25",
                    "players":[
                       {
                          "personId":"202699",
                          "firstName":"Tobias",
                          "lastName":"Harris"
                       }
                    ]
                 },
                 "rebounds":{
                    "value":"9",
                    "players":[
                       {
                          "personId":"1628396",
                          "firstName":"Tony",
                          "lastName":"Bradley"
                       }
                    ]
                 },
                 "assists":{
                    "value":"4",
                    "players":[
                       {
                          "personId":"1627732",
                          "firstName":"Ben",
                          "lastName":"Simmons"
                       }
                    ]
                 }
                }
            }
            """.data(using: .utf8)!
        
        let visitorTeamStats = try JSONDecoder().decode(BoxscoreTeamStats.self, from: visitorTeamCodedStats)
        
        let homeTeamCodedStats = """
           {
              "fastBreakPoints":"8",
              "pointsInPaint":"30",
              "biggestLead":"21",
              "secondChancePoints":"15",
              "pointsOffTurnovers":"16",
              "longestRun":"8",
              "totals":{
                 "points":"119",
                 "fgm":"35",
                 "fga":"70",
                 "fgp":"50.0",
                 "ftm":"32",
                 "fta":"38",
                 "ftp":"84.2",
                 "tpm":"17",
                 "tpa":"38",
                 "tpp":"44.7",
                 "offReb":"11",
                 "defReb":"36",
                 "totReb":"47",
                 "assists":"22",
                 "pFouls":"20",
                 "steals":"6",
                 "turnovers":"18",
                 "blocks":"6",
                 "plusMinus":"15",
                 "min":"240:00",
                 "short_timeout_remaining":"0",
                 "full_timeout_remaining":"2",
                 "team_fouls":"19"
              },
              "leaders":{
                 "points":{
                    "value":"28",
                    "players":[
                       {
                          "personId":"1626153",
                          "firstName":"Delon",
                          "lastName":"Wright"
                       }
                    ]
                 },
                 "rebounds":{
                    "value":"10",
                    "players":[
                       {
                          "personId":"203486",
                          "firstName":"Mason",
                          "lastName":"Plumlee"
                       }
                    ]
                 },
                 "assists":{
                    "value":"9",
                    "players":[
                       {
                          "personId":"1626153",
                          "firstName":"Delon",
                          "lastName":"Wright"
                       }
                    ]
                 }
              }
           }
           """.data(using: .utf8)!
        let homeTeamStats = try JSONDecoder().decode(BoxscoreTeamStats.self, from: homeTeamCodedStats)
       
        let activePlayersCoded =
            """
          [
             {
                "personId":"201980",
                "firstName":"Danny",
                "lastName":"Green",
                "jersey":"14",
                "teamId":"1610612755",
                "isOnCourt":false,
                "points":"6",
                "pos":"SF",
                "position_full":"Small Forward",
                "player_code":"danny_green",
                "min":"22:04",
                "fgm":"2",
                "fga":"6",
                "fgp":"33.3",
                "ftm":"0",
                "fta":"0",
                "ftp":"0.0",
                "tpm":"2",
                "tpa":"4",
                "tpp":"50.0",
                "offReb":"1",
                "defReb":"0",
                "totReb":"1",
                "assists":"0",
                "pFouls":"1",
                "steals":"1",
                "turnovers":"0",
                "blocks":"0",
                "plusMinus":"-19",
                "dnp":"",
                "sortKey":{
                   "name":1,
                   "pos":0,
                   "points":15,
                   "min":11,
                   "fgm":13,
                   "fga":13,
                   "fgp":13,
                   "ftm":16,
                   "fta":16,
                   "ftp":16,
                   "tpm":5,
                   "tpa":6,
                   "tpp":4,
                   "offReb":8,
                   "defReb":19,
                   "totReb":18,
                   "assists":17,
                   "pFouls":13,
                   "steals":7,
                   "turnovers":15,
                   "blocks":10,
                   "plusMinus":27
                }
             }
          ]
          """.data(using: .utf8)!
        let activePlayers = try JSONDecoder().decode([ActivePlayer].self, from: activePlayersCoded)

        XCTAssertEqual(boxscoreStatsResponse.timesTied, 0)
        XCTAssertEqual(boxscoreStatsResponse.leadChanges, 0)
        XCTAssertEqual(boxscoreStatsResponse.visitorTeamStats, visitorTeamStats)
        XCTAssertEqual(boxscoreStatsResponse.homeTeamStats, homeTeamStats)
        XCTAssertEqual(boxscoreStatsResponse.activePlayers, activePlayers)
    }
    
    func test_BoxscoreStatsModel_withBadData_isNil() throws {
        let path = getPath(forResource: "BoxscoreGameStatsModelBadDataFormat",
                            ofType: "json")
        let boxscoreStatsData = try Data(contentsOf: URL(fileURLWithPath: path))
        var boxscoreStatsDataResponse: BoxscoreTeamStats?

        do {
            boxscoreStatsDataResponse = try JSONDecoder().decode(BoxscoreTeamStats.self, from: boxscoreStatsData)
        } catch {
            boxscoreStatsDataResponse = nil
        }
        XCTAssertNil(boxscoreStatsDataResponse)
     }

    func test_BoxscoreStatsModel_withMissingData_isNil() throws {
        let path = getPath(forResource: "BoxscoreGameStatsModelMissingDataFormat",
                            ofType: "json")
        let boxscoreStatsData = try Data(contentsOf: URL(fileURLWithPath: path))
        var boxscoreStatsDataResponse: BoxscoreTeamStats?

        do {
           boxscoreStatsDataResponse = try JSONDecoder().decode(BoxscoreTeamStats.self, from: boxscoreStatsData)
        } catch {
           boxscoreStatsDataResponse = nil
        }
        XCTAssertNil(boxscoreStatsDataResponse)
    }
}
