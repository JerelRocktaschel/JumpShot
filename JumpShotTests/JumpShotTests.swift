//
//  JumpShotTests.swift
//  JumpShotTests
//
//  Created by Jerel Rocktaschel on 3/31/21.
//

import XCTest
@testable import JumpShot

// swiftlint:disable type_body_length

class JumpShotTests: XCTestCase {

    let jumpShot = JumpShot()
    let router = JumpShotNetworkManager.shared.router

    // MARK: GetTeams

    func test_jumpShot_withGetTeams_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeams { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }

    func test_jumpShot_withGetTeams_isRequestFailed() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "Network Error")

        jumpShot.getTeams { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            teamJsonData(), response(statusCode: 300), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The request failed.")
    }

    func test_jumpShot_withGetTeams_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeams { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                           nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
    }

    func test_jumpShot_withGetTeams_isUnableToDecode() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()

        let path = getPath(forResource: "TeamApiResponseMissingAttribute",
                           ofType: "json")

        let teamApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeams { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            teamApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withGetTeams__isUnableToDecodeWithError() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeams { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withGetTeams_isOneTeam() throws {
        let mockURLSession = MockURLSession()
        var responseTeams = [Team]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "TeamApiResponse", ofType: "json")
            else { fatalError("Can't find TeamApiResponse.json file") }
        let teamApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        let expectation = XCTestExpectation(description: "Team Response")

        jumpShot.getTeams { teams, _ in
            responseTeams = teams!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            teamApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)

        XCTAssertEqual(responseTeams.count, 1)
        XCTAssertEqual(responseTeams.first!.isAllStar, false)
        XCTAssertEqual(responseTeams.first!.city, "Atlanta")
        XCTAssertEqual(responseTeams.first!.altCityName, "Atlanta")
        XCTAssertEqual(responseTeams.first!.fullName, "Atlanta Hawks")
        XCTAssertEqual(responseTeams.first!.abbreviation, "ATL")
        XCTAssertEqual(responseTeams.first!.teamId, "1610612737")
        XCTAssertEqual(responseTeams.first!.name, "Hawks")
        XCTAssertEqual(responseTeams.first!.urlName, "hawks")
        XCTAssertEqual(responseTeams.first!.shortName, "Atlanta")
        XCTAssertEqual(responseTeams.first!.conference, "East")
        XCTAssertEqual(responseTeams.first!.division, "Southeast")
    }

    // MARK: Team Image

    func test_jumpShot_withGetTeamImage_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeamImage(for: "BOS") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }

    func test_jumpShot_withGetTeamImage_isRequestCouldNotBeDecoded() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "Network Error")

        jumpShot.getTeamImage(for: "BOS") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            teamJsonData(), response(statusCode: 300), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withGetTeamImage_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeamImage(for: "BOS") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                           nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
    }

    func test_jumpShot_withGetTeamImage_isUnableToDecodeWithError() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeamImage(for: "BOS") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withGetTeamImage_isBOSLogo() throws {
        let mockURLSession = MockURLSession()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "BOS", ofType: "png")
            else { fatalError("Can't find UTA.png file") }
        let teamImageData = try Data(contentsOf: URL(fileURLWithPath: path))
        var responseTeamImage = UIImage()
        let expectation = XCTestExpectation(description: "Team Image Response")

        jumpShot.getTeamImage(for: "BOS") { image, _ in
            responseTeamImage = image!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            teamImageData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(responseTeamImage.pngData()!.count, 86373)
    }

    func test_jumpShot_withGetTeamImage_isUTALogo() throws {
        let mockURLSession = MockURLSession()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "UTA", ofType: "png")
            else { fatalError("Can't find UTA.png file") }
        let teamImageData = try Data(contentsOf: URL(fileURLWithPath: path))
        var responseTeamImage = UIImage()
        let expectation = XCTestExpectation(description: "Team Image Response")

        jumpShot.getTeamImage(for: "UTA") { image, _ in
            responseTeamImage = image!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            teamImageData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(responseTeamImage.pngData()!.count, 15494)
    }

    func test_jumpShot_withGetTeamImage_isUNOPLogo() throws {
        let mockURLSession = MockURLSession()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "NOP", ofType: "png")
            else { fatalError("Can't find NOP.png file") }
        let teamImageData = try Data(contentsOf: URL(fileURLWithPath: path))
        var responseTeamImage = UIImage()
        let expectation = XCTestExpectation(description: "Team Image Response")

        jumpShot.getTeamImage(for: "NOP") { image, _ in
            responseTeamImage = image!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            teamImageData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(responseTeamImage.pngData()!.count, 35550)
    }

     // MARK: GetPlayers

     func test_jumpShot_withGetPlayers_isNetworkUnavailable() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()
         router.session = mockURLSession

         let expectation = XCTestExpectation(description: "HTTP Response Error")

         jumpShot.getPlayers { _, error in
             errorDescription = error!.localizedDescription
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
             nil, nil, TestError.testError
         )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "The network is unavailable.")
     }

     func test_jumpShot_withGetPlayers_isRequestFailed() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()
         router.session = mockURLSession

         let expectation = XCTestExpectation(description: "Network Error")

         jumpShot.getPlayers { _, error in
             errorDescription = error!.localizedDescription
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
             teamJsonData(), response(statusCode: 300), nil
         )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "The request failed.")
     }

     func test_jumpShot_withGetPlayers_isNoDataReturned() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()
         router.session = mockURLSession

         let expectation = XCTestExpectation(description: "HTTP Response Error")

         jumpShot.getPlayers { _, error in
             errorDescription = error!.localizedDescription
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
                            nil, response(statusCode: 200), nil
         )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "No NBA data was returned.")
     }

     func test_jumpShot_withGetPlayers_isUnableToDecode() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()

         let path = getPath(forResource: "PlayerApiResponseMissingAttribute",
                            ofType: "json")

         let teamApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
         router.session = mockURLSession

         let expectation = XCTestExpectation(description: "HTTP Response Error")

         jumpShot.getPlayers { _, error in
             errorDescription = error!.localizedDescription
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
             teamApiResponseData, response(statusCode: 200), nil
         )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

     func test_jumpShot_withGetPlayers__isUnableToDecodeWithError() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()
         router.session = mockURLSession

         let expectation = XCTestExpectation(description: "HTTP Response Error")

         jumpShot.getPlayers { _, error in
             errorDescription = error!.localizedDescription
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
             badJsonData(), response(statusCode: 200), nil
         )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

     func test_jumpShot_withGetPlayers_isOnePlayer() throws {
        let mockURLSession = MockURLSession()
        var responsePlayers = [Player]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "PlayerApiResponseOnePlayer", ofType: "json")
            else { fatalError("Can't find PlayerApiResponse.json file") }
        let playerApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        let expectation = XCTestExpectation(description: "Player Response")

        jumpShot.getPlayers { players, _ in
            responsePlayers = players!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            playerApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateOfBirth = dateFormatter.date(from: "1993-07-20")!

        var testTeamsArray = [Player.Team]()
        let testTeam1 = Player.Team(teamId: "1610612760", seasonStart: 2013, seasonEnd: 2019)
        let testTeam2 = Player.Team(teamId: "1610612740", seasonStart: 2020, seasonEnd: 2020)
        testTeamsArray.append(testTeam1)
        testTeamsArray.append(testTeam2)

        XCTAssertEqual(responsePlayers.count, 1)
        XCTAssertEqual(responsePlayers.first!.firstName, "Steven")
        XCTAssertEqual(responsePlayers.first!.lastName, "Adams")
        XCTAssertEqual(responsePlayers.first!.displayName, "Adams, Steven")
        XCTAssertEqual(responsePlayers.first!.playerId, "203500")
        XCTAssertEqual(responsePlayers.first!.teamId, "1610612740")
        XCTAssertEqual(responsePlayers.first!.jersey, 12)
        XCTAssertEqual(responsePlayers.first!.position, "C")
        XCTAssertEqual(responsePlayers.first!.feet, 6)
        XCTAssertEqual(responsePlayers.first!.inches, 11)
        XCTAssertEqual(responsePlayers.first!.meters, 2.11)
        XCTAssertEqual(responsePlayers.first!.pounds, 265)
        XCTAssertEqual(responsePlayers.first!.kilograms, 120.2)
        XCTAssertEqual(responsePlayers.first!.dateOfBirth, dateOfBirth)

        for team in 0..<responsePlayers.first!.teams.count {
            let responseTeam = responsePlayers.first!.teams[team]
            let testTeam = testTeamsArray[team]
            XCTAssertEqual(responseTeam.teamId, testTeam.teamId)
            XCTAssertEqual(responseTeam.seasonStart, testTeam.seasonStart)
            XCTAssertEqual(responseTeam.seasonEnd, testTeam.seasonEnd)
        }

        XCTAssertEqual(responsePlayers.first!.draftTeamId, "1610612760")
        XCTAssertEqual(responsePlayers.first!.draftPosition, 12)
        XCTAssertEqual(responsePlayers.first!.draftRound, 1)
        XCTAssertEqual(responsePlayers.first!.draftYear, 2013)
        XCTAssertEqual(responsePlayers.first!.nbaDebutYear, 2013)
        XCTAssertEqual(responsePlayers.first!.yearsPro, 7)
        XCTAssertEqual(responsePlayers.first!.collegeName, "Pittsburgh")
        XCTAssertEqual(responsePlayers.first!.lastAffiliation, "Pittsburgh/New Zealand")
        XCTAssertEqual(responsePlayers.first!.country, "New Zealand")
     }

    // MARK: Player Image

    func test_jumpShot_withGetPlayerImage_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getPlayerImage(for: .small, and: "1627759") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }

    func test_jumpShot_withGetPlayerImage_isRequestCouldNotBeDecoded() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "Network Error")

        jumpShot.getPlayerImage(for: .small, and: "1627759") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            teamJsonData(), response(statusCode: 300), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withGetPlayerImage_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getPlayerImage(for: .small, and: "1627759") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                           nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
    }

    func test_jumpShot_withGetPlayerImage_isUnableToDecodeWithError() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getPlayerImage(for: .small, and: "1627759") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withSmallPlayerImage_issmall_1627759Logo() throws {
        let mockURLSession = MockURLSession()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "small_1627759", ofType: "png")
            else { fatalError("Can't find small_1627759.png file") }
        let playerImageData = try Data(contentsOf: URL(fileURLWithPath: path))
        var responseTeamImage = UIImage()
        let expectation = XCTestExpectation(description: "Player Image Response")

        jumpShot.getPlayerImage(for: .small, and: "1627759") { image, _ in
            responseTeamImage = image!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            playerImageData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(responseTeamImage.pngData()!.count, 27606)
    }

    func test_jumpShot_withSmallPlayerImage_islarge_1627759Logo() throws {
        let mockURLSession = MockURLSession()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "large_1627759", ofType: "png")
            else { fatalError("Can't find large_1627759.png file") }
        let playerImageData = try Data(contentsOf: URL(fileURLWithPath: path))
        var responseTeamImage = UIImage()
        let expectation = XCTestExpectation(description: "Player Image Response")

        jumpShot.getPlayerImage(for: .large, and: "1627759") { image, _ in
            responseTeamImage = image!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            playerImageData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(responseTeamImage.pngData()!.count, 384454)
    }

    // MARK: GetDailySchedule

    func test_jumpShot_withGetDailySchedule_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 4
        dateComponents.day = 20
        let scheduleDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getDailySchedule(for: scheduleDate!) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }

    func test_jumpShot_withGetDailySchedule_isRequestFailed() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 4
        dateComponents.day = 20
        let scheduleDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "Network Error")

        jumpShot.getDailySchedule(for: scheduleDate!) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            gameDailyScheduleData(), response(statusCode: 300), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The request failed.")
    }

    func test_jumpShot_withGetDailySchedule_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 4
        dateComponents.day = 20
        let scheduleDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getDailySchedule(for: scheduleDate!) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                           nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
    }

    func test_jumpShot_withGetDailySchedule_isUnableToDecode() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 4
        dateComponents.day = 20
        let scheduleDate = Calendar.current.date(from: dateComponents)

        let path = getPath(forResource: "GameScheduleApiResponseMissingAttribute",
                           ofType: "json")

        let teamApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getDailySchedule(for: scheduleDate!) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            teamApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withGetDailySchedule_isUnableToDecodeWithError() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 4
        dateComponents.day = 20
        let scheduleDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getDailySchedule(for: scheduleDate!) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withGetDailySchedule_isOneGame() throws {
        let mockURLSession = MockURLSession()
        var responseGameSchedules = [GameSchedule]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "GameScheduleApiResponseOneGame", ofType: "json")
            else { fatalError("Can't find GameScheduleApiResponseOneGame.json file") }
        let gameScheduleApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 4
        dateComponents.day = 20
        let scheduleDate = Calendar.current.date(from: dateComponents)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        let dateString = "04/20/2021 07:30 PM"
        let gameDate =  dateFormatter.date(from: dateString)!

        let expectation = XCTestExpectation(description: "Game Schedule Response")

        jumpShot.getDailySchedule(for: scheduleDate!) { gameSchedules, _ in
            responseGameSchedules = gameSchedules!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            gameScheduleApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)

        XCTAssertEqual(responseGameSchedules.count, 1)
        XCTAssertEqual(responseGameSchedules.first!.gameId, "0022000878")
        XCTAssertEqual(responseGameSchedules.first!.visitorCity, "Brooklyn")
        XCTAssertEqual(responseGameSchedules.first!.visitorNickName, "Nets")
        XCTAssertEqual(responseGameSchedules.first!.visitorShortName, "Brooklyn")
        XCTAssertEqual(responseGameSchedules.first!.visitorAbbreviation, "BKN")
        XCTAssertEqual(responseGameSchedules.first!.homeCity, "New Orleans")
        XCTAssertEqual(responseGameSchedules.first!.homeNickName, "Pelicans")
        XCTAssertEqual(responseGameSchedules.first!.homeShortName, "New Orleans")
        XCTAssertEqual(responseGameSchedules.first!.homeAbbreviation, "NOP")
        XCTAssertEqual(responseGameSchedules.first!.gameDate, gameDate)
        XCTAssertEqual(responseGameSchedules.first!.gameDay, "Tue")
        XCTAssertEqual(responseGameSchedules.first!.broadcastId, "10")
        XCTAssertEqual(responseGameSchedules.first!.broadcasterName, "TNT")
        XCTAssertEqual(responseGameSchedules.first!.tapeDelayComments, "")
    }

    // MARK: GetDailySchedule

    func test_jumpShot_withGetStandings_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getStandings { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }

    func test_jumpShot_withGetStandings_isRequestFailed() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "Network Error")

        jumpShot.getStandings { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            gameDailyScheduleData(), response(statusCode: 300), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The request failed.")
    }

    func test_jumpShot_withGetStandings_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getStandings { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                           nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
    }

    func test_jumpShot_withGetStandings_isUnableToDecode() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()

        let path = getPath(forResource: "StandingApiResponseMissingAttribute",
                           ofType: "json")

        let teamApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getStandings { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            teamApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withGetStandings_isUnableToDecodeWithError() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getStandings { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withGetStandings_isOneStanding() throws {
        let mockURLSession = MockURLSession()
        var responseStandings = [Standing]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "StandingApiResponseOneStanding", ofType: "json")
            else { fatalError("Can't find StandingApiResponseOneStanding.json file") }
        let standingApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))

        let expectation = XCTestExpectation(description: "Standing Response")

        jumpShot.getStandings { standings, _ in
            responseStandings = standings!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            standingApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)

        XCTAssertEqual(responseStandings.first!.teamId, "1610612762")
        XCTAssertEqual(responseStandings.first!.wins, 44)
        XCTAssertEqual(responseStandings.first!.losses, 15)
        XCTAssertEqual(responseStandings.first!.winPct, 0.746)
        XCTAssertEqual(responseStandings.first!.lossPct, 0.254)
        XCTAssertEqual(responseStandings.first!.gamesBehind, 0.0)
        XCTAssertEqual(responseStandings.first!.divisionGamesBehind, 0.0)
        XCTAssertEqual(responseStandings.first!.isClinchedPlayoffs, false)
        XCTAssertEqual(responseStandings.first!.conferenceWins, 21)
        XCTAssertEqual(responseStandings.first!.conferenceLosses, 9)
        XCTAssertEqual(responseStandings.first!.homeWins, 26)
        XCTAssertEqual(responseStandings.first!.homeLosses, 3)
        XCTAssertEqual(responseStandings.first!.divisionWins, 5)
        XCTAssertEqual(responseStandings.first!.divisionLosses, 2)
        XCTAssertEqual(responseStandings.first!.awayWins, 18)
        XCTAssertEqual(responseStandings.first!.awayLosses, 12)
        XCTAssertEqual(responseStandings.first!.lastTenWins, 6)
        XCTAssertEqual(responseStandings.first!.lastTenLosses, 4)
        XCTAssertEqual(responseStandings.first!.streak, 2)
        XCTAssertNil(responseStandings.first!.divisionRank)
        XCTAssertEqual(responseStandings.first!.isWinStreak, true)
        XCTAssertEqual(responseStandings.first!.isClinchedConference, false)
        XCTAssertEqual(responseStandings.first!.isclinchedDivision, false)
    }

    // MARK: GetTeamLeaders

    func test_jumpShot_withGetTeamLeaders_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeamLeaders(for: "1610612737") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }

    func test_jumpShot_withGetTeamLeaders_isRequestFailed() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "Network Error")

        jumpShot.getTeamLeaders(for: "1610612737") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            gameDailyScheduleData(), response(statusCode: 300), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The request failed.")
    }

    func test_jumpShot_withGetTeamLeaders_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeamLeaders(for: "1610612737") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                           nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
    }

    func test_jumpShot_withGetTeamLeaders_isUnableToDecode() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()

        let path = getPath(forResource: "LeaderApiResponseMissingAttribute",
                           ofType: "json")

        let leaderApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeamLeaders(for: "1610612737") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            leaderApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withGetTeamLeaders_isUnableToDecodeWithError() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeamLeaders(for: "1610612737") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withGetTeamLeaders_isOneStatLeader() throws {
        let mockURLSession = MockURLSession()
        var responseStandings = [StatLeader]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "LeaderApiResponseOneLeader", ofType: "json")
            else { fatalError("Can't find LeaderApiResponseOneLeader.json file") }
        let leaderApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))

        let expectation = XCTestExpectation(description: "Leader Api Response")

        jumpShot.getTeamLeaders(for: "1610612737") { teamLeaders, _ in
            responseStandings = teamLeaders!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            leaderApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)

        XCTAssertEqual(responseStandings.first!.category, .ppg)
        XCTAssertEqual(responseStandings.first!.leader.playerId, "1629027")
        XCTAssertEqual(responseStandings.first!.leader.value, 25.3)
    }

    // MARK: GetTeamSchedule

    func test_jumpShot_withGetTeamSchedules_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeamSchedules(for: "1610612737") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }

     func test_jumpShot_withGetTeamSchedules_isRequestFailed() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()
         router.session = mockURLSession

         let expectation = XCTestExpectation(description: "Network Error")

         jumpShot.getTeamSchedules(for: "1610612737") { _, error in
             errorDescription = error!.localizedDescription
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
             gameDailyScheduleData(), response(statusCode: 300), nil
         )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "The request failed.")
     }

     func test_jumpShot_withGetTeamSchedules_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeamSchedules(for: "1610612737") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                            nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
     }

    func test_jumpShot_withGetTeamSchedules_isUnableToDecode() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()

         let path = getPath(forResource: "LeaderApiResponseMissingAttribute",
                            ofType: "json")

         let leaderApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
         router.session = mockURLSession

         let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeamSchedules(for: "1610612737") { _, error in
             errorDescription = error!.localizedDescription
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
             leaderApiResponseData, response(statusCode: 200), nil
         )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

    func test_jumpShot_withGetTeamSchedules_isUnableToDecodeWithError() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()
         router.session = mockURLSession

         let expectation = XCTestExpectation(description: "HTTP Response Error")

         jumpShot.getTeamSchedules(for: "1610612737") { _, error in
             errorDescription = error!.localizedDescription
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
             badJsonData(), response(statusCode: 200), nil
         )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

     func test_jumpShot_withGetTeamSchedules_isOneSchedule() throws {
         let mockURLSession = MockURLSession()
         var responseTeamSchedules = [TeamSchedule]()
         router.session = mockURLSession
         let testBundle = Bundle(for: type(of: self))
         guard let path = testBundle.path(forResource: "TeamScheduleApiResponseOneSchedule", ofType: "json")
             else { fatalError("Can't find TeamScheduleApiResponseOneSchedule.json file") }
         let leaderApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))

         let expectation = XCTestExpectation(description: "TeamSchedule Api Response")

         jumpShot.getTeamSchedules(for: "1610612737") { teamSchedules, _ in
            responseTeamSchedules = teamSchedules!
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
             leaderApiResponseData, response(statusCode: 200), nil
         )

         wait(for: [expectation], timeout: 5.0)

        let dateFormatter = DateFormatter.iso8601Full
        let startTimeUTC = dateFormatter.date(from: "2020-12-12T00:00:00.000Z")
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

        XCTAssertEqual(responseTeamSchedules.first!.gameUrlCode, "20201211/ORLATL")
        XCTAssertEqual(responseTeamSchedules.first!.gameId, "0012000001")
        XCTAssertEqual(responseTeamSchedules.first!.statusNumber, 3)
        XCTAssertEqual(responseTeamSchedules.first!.extendedStatusNum, 0)
        XCTAssertEqual(responseTeamSchedules.first!.startTimeEastern, "7:00 PM ET")
        XCTAssertEqual(responseTeamSchedules.first!.startTimeUTC, startTimeUTC)
        XCTAssertEqual(responseTeamSchedules.first!.startDateEastern, "20201211")
        XCTAssertEqual(responseTeamSchedules.first!.homeStartDate, "20201211")
        XCTAssertEqual(responseTeamSchedules.first!.homeStartTime, "1900")
        XCTAssertEqual(responseTeamSchedules.first!.visitorStartDate, "20201211")
        XCTAssertEqual(responseTeamSchedules.first!.visitorStartTime, "1900")
        XCTAssertEqual(responseTeamSchedules.first!.isHomeTeam, true)
        XCTAssertEqual(responseTeamSchedules.first!.isStartTimeTBD, false)
        XCTAssertEqual(responseTeamSchedules.first!.visitorTeam, visitorTeam)
        XCTAssertEqual(responseTeamSchedules.first!.homeTeam, homeTeam)
        XCTAssertEqual(responseTeamSchedules.first!.regionalBlackoutCodes, "")
        XCTAssertEqual(responseTeamSchedules.first!.isPurchasable, false)
        XCTAssertEqual(responseTeamSchedules.first!.isLeaguePass, true)
        XCTAssertEqual(responseTeamSchedules.first!.isNationalBlackout, false)
        XCTAssertEqual(responseTeamSchedules.first!.isTNTOT, false)
        XCTAssertEqual(responseTeamSchedules.first!.isVR, false)
        XCTAssertEqual(responseTeamSchedules.first!.isTntOTOnAir, false)
        XCTAssertEqual(responseTeamSchedules.first!.isNextVR, false)
        XCTAssertEqual(responseTeamSchedules.first!.isNBAOnTNTVR, false)
        XCTAssertEqual(responseTeamSchedules.first!.isMagicLeap, false)
        XCTAssertEqual(responseTeamSchedules.first!.isOculusVenues, false)
        XCTAssertEqual(responseTeamSchedules.first!.media.sorted().first!.category, "audio")
        XCTAssertEqual(responseTeamSchedules.first!.media.sorted().last!.category, "broadcasters")
        XCTAssertEqual(responseTeamSchedules.first!.media.sorted().last!.details.sorted().first?.subCategory, "canadian")
        XCTAssertEqual(responseTeamSchedules.first!.media.sorted().last!.details.sorted().last?.subCategory, "hTeam")
        XCTAssertEqual(responseTeamSchedules.first!.media.sorted().first!.details.sorted().first?.subCategory, "hTeam")
        XCTAssertEqual(responseTeamSchedules.first!.media.sorted().first!.details.sorted().last?.subCategory, "vTeam")
        XCTAssertEqual(responseTeamSchedules.first!.media.sorted().first!.details.sorted().first?.names.containsSameElements(as: hTeamAudioMediaNames), true)
        XCTAssertEqual(responseTeamSchedules.first!.media.sorted().first!.details.sorted().last?.names.containsSameElements(as: vTeamAudioMediaNames), true)
        XCTAssertEqual(responseTeamSchedules.first!.media.sorted().last!.details.sorted().first?.names.containsSameElements(as: canadianBroadcasterMediaNames), true)
        XCTAssertEqual(responseTeamSchedules.first!.media.sorted().last!.details.sorted().last?.names.containsSameElements(as: hTeamBroadcasterMediaNames), true)
     }
}
