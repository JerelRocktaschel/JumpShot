//
//  JumpShotTests.swift
//  JumpShotTests
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
// swiftlint:disable all

import XCTest
@testable import JumpShot

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
            badJsonData(), response(statusCode: 300), nil
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
        guard let path = testBundle.path(forResource: "TeamApiResponseOneTeam", ofType: "json")
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
            badJsonData(), response(statusCode: 300), nil
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
            badJsonData(), response(statusCode: 300), nil
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
            badJsonData(), response(statusCode: 300), nil
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
            badJsonData(), response(statusCode: 300), nil
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
            badJsonData(), response(statusCode: 300), nil
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
            badJsonData(), response(statusCode: 300), nil
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
            badJsonData(), response(statusCode: 300), nil
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

         let path = getPath(forResource: "TeamScheduleModelMissingDataFormat",
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
         guard let path = testBundle.path(forResource: "TeamScheduleApiResponseFromTeamScheduleCall", ofType: "json")
             else { fatalError("Can't find TeamScheduleApiResponseFromTeamScheduleCall.json file") }
         let teamScheduleApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))

         let expectation = XCTestExpectation(description: "TeamSchedule Api Response")

         jumpShot.getTeamSchedules(for: "1610612737") { teamSchedules, _ in
            responseTeamSchedules = teamSchedules!
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
            teamScheduleApiResponseData, response(statusCode: 200), nil
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
        XCTAssertNil(responseTeamSchedules.first!.isNeutralVenue)
        XCTAssertNil(responseTeamSchedules.first!.isBuzzerBeater)
        XCTAssertNil(responseTeamSchedules.first!.period)
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
        XCTAssertEqual(responseTeamSchedules.first!.media!.sorted().first!.category, "audio")
        XCTAssertEqual(responseTeamSchedules.first!.media!.sorted().last!.category, "broadcasters")
        XCTAssertEqual(responseTeamSchedules.first!.media!.sorted().last!.details.sorted().first?.subCategory, "canadian")
        XCTAssertEqual(responseTeamSchedules.first!.media!.sorted().last!.details.sorted().last?.subCategory, "hTeam")
        XCTAssertEqual(responseTeamSchedules.first!.media!.sorted().first!.details.sorted().first?.subCategory, "hTeam")
        XCTAssertEqual(responseTeamSchedules.first!.media!.sorted().first!.details.sorted().last?.subCategory, "vTeam")
        XCTAssertEqual(responseTeamSchedules.first!.media!.sorted().first!.details.sorted().first?.names.containsSameElements(as: hTeamAudioMediaNames), true)
        XCTAssertEqual(responseTeamSchedules.first!.media!.sorted().first!.details.sorted().last?.names.containsSameElements(as: vTeamAudioMediaNames), true)
        XCTAssertEqual(responseTeamSchedules.first!.media!.sorted().last!.details.sorted().first?.names.containsSameElements(as: canadianBroadcasterMediaNames), true)
        XCTAssertEqual(responseTeamSchedules.first!.media!.sorted().last!.details.sorted().last?.names.containsSameElements(as: hTeamBroadcasterMediaNames), true)
     }
    
    // MARK: GetCompleteSchedule

    func test_jumpShot_withGetCompleteSchedule_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getCompleteSchedule { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }

     func test_jumpShot_withGetCompleteSchedule_isRequestFailed() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()
         router.session = mockURLSession

         let expectation = XCTestExpectation(description: "Network Error")

        jumpShot.getCompleteSchedule { _, error in
             errorDescription = error!.localizedDescription
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 300), nil
         )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "The request failed.")
     }

    func test_jumpShot_withGetCompleteSchedule_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getCompleteSchedule { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                            nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
     }

    func test_jumpShot_withGetCompleteSchedule_isUnableToDecode() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()

         let path = getPath(forResource: "TeamScheduleModelMissingDataFormat",
                            ofType: "json")

         let leaderApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
         router.session = mockURLSession

         let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getCompleteSchedule { _, error in
             errorDescription = error!.localizedDescription
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
             leaderApiResponseData, response(statusCode: 200), nil
         )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

    func test_jumpShot_withGetCompleteSchedule_isUnableToDecodeWithError() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()
         router.session = mockURLSession

         let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getCompleteSchedule { _, error in
             errorDescription = error!.localizedDescription
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
             badJsonData(), response(statusCode: 200), nil
         )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

     func test_jumpShot_withGetCompleteSchedule_isOneSchedule() throws {
        let mockURLSession = MockURLSession()
        var responseTeamSchedules = [TeamSchedule]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "TeamScheduleApiResponseFromCompleteScheduleCall", ofType: "json")
            else { fatalError("Can't find TeamScheduleApiResponseFromCompleteScheduleCall.json file") }
        let teamScheduleApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))

        let expectation = XCTestExpectation(description: "TeamSchedule Api Response")

        jumpShot.getCompleteSchedule { teamSchedules, _ in
           responseTeamSchedules = teamSchedules!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
           teamScheduleApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)

        let dateFormatter = DateFormatter.iso8601Full
        let startTimeUTC = dateFormatter.date(from: "2020-12-12T01:00:00.000Z")
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
        XCTAssertEqual(responseTeamSchedules.first!.gameUrlCode, "20201211/HOUCHI")
        XCTAssertEqual(responseTeamSchedules.first!.gameId, "0012000003")
        XCTAssertEqual(responseTeamSchedules.first!.statusNumber, 3)
        XCTAssertEqual(responseTeamSchedules.first!.extendedStatusNum, 0)
        XCTAssertEqual(responseTeamSchedules.first!.startTimeEastern, "8:00 PM ET")
        XCTAssertEqual(responseTeamSchedules.first!.startTimeUTC, startTimeUTC)
        XCTAssertEqual(responseTeamSchedules.first!.startDateEastern, "20201211")
        XCTAssertNil(responseTeamSchedules.first!.homeStartDate)
        XCTAssertNil(responseTeamSchedules.first!.homeStartTime)
        XCTAssertNil(responseTeamSchedules.first!.visitorStartDate)
        XCTAssertNil(responseTeamSchedules.first!.visitorStartTime)
        XCTAssertNil(responseTeamSchedules.first!.isHomeTeam)
        XCTAssertEqual(responseTeamSchedules.first!.isStartTimeTBD, false)
        XCTAssertEqual(responseTeamSchedules.first!.visitorTeam, visitorTeam)
        XCTAssertEqual(responseTeamSchedules.first!.homeTeam, homeTeam)
        XCTAssertEqual(responseTeamSchedules.first!.regionalBlackoutCodes, "")
        XCTAssertEqual(responseTeamSchedules.first!.isBuzzerBeater, false)
        XCTAssertEqual(responseTeamSchedules.first!.period, period)
        XCTAssertEqual(responseTeamSchedules.first!.isNeutralVenue, false)
        XCTAssertEqual(responseTeamSchedules.first!.isPurchasable, false)
        XCTAssertEqual(responseTeamSchedules.first!.isLeaguePass, true)
        XCTAssertEqual(responseTeamSchedules.first!.isNationalBlackout, false)
        XCTAssertEqual(responseTeamSchedules.first!.isTNTOT, false)
        XCTAssertEqual(responseTeamSchedules.first!.isVR, false)
        XCTAssertNil(responseTeamSchedules.first!.isTntOTOnAir)
        XCTAssertEqual(responseTeamSchedules.first!.isNextVR, false)
        XCTAssertEqual(responseTeamSchedules.first!.isNBAOnTNTVR, false)
        XCTAssertEqual(responseTeamSchedules.first!.isMagicLeap, false)
        XCTAssertEqual(responseTeamSchedules.first!.isOculusVenues, false)
        XCTAssertEqual(responseTeamSchedules.first!.media!.sorted().first!.category, "video")
        XCTAssertEqual(responseTeamSchedules.first!.media!.sorted().last!.details.sorted().first?.subCategory, "canadian")
        XCTAssertEqual(responseTeamSchedules.first!.media!.sorted().last!.details.sorted().last?.subCategory, "national")
        XCTAssertEqual(responseTeamSchedules.first!.media!.sorted().last!.details.sorted().first?.names.containsSameElements(as: canadianBroadcasterMediaNames), true)
        XCTAssertEqual(responseTeamSchedules.first!.media!.sorted().last!.details.sorted().last?.names.containsSameElements(as: nationalMediaNames), true)
     }
    
    // MARK: GetCoaches

    func test_jumpShot_withGetCoaches_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getCoaches { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }

    func test_jumpShot_withGetCoaches_isRequestFailed() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()
         router.session = mockURLSession

         let expectation = XCTestExpectation(description: "Network Error")

        jumpShot.getCoaches { _, error in
             errorDescription = error!.localizedDescription
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 300), nil
         )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "The request failed.")
     }

    func test_jumpShot_withGetCoaches_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getCoaches { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                            nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
     }

    func test_jumpShot_withGetCoaches_isUnableToDecode() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()

        let path = getPath(forResource: "CoachApiResponseMissingAttribute",
                            ofType: "json")

        let coachApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getCoaches { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            coachApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

    func test_jumpShot_withGetCoaches_isUnableToDecodeWithError() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getCoaches { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

    func test_jumpShot_withGetCoaches_isOneSchedule() throws {
        let mockURLSession = MockURLSession()
        var responseCoaches = [Coach]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "CoachApiResponseOneCoach", ofType: "json")
            else { fatalError("Can't find CoachApiResponseOneCoach.json file") }
        let coachApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))

        let expectation = XCTestExpectation(description: "Coach Api Response")

        jumpShot.getCoaches { coaches, _ in
            responseCoaches = coaches!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            coachApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)
    
        XCTAssertEqual(responseCoaches.first!.firstName, "Doc")
        XCTAssertEqual(responseCoaches.first!.lastName, "Rivers")
        XCTAssertEqual(responseCoaches.first!.isAssistant, false)
        XCTAssertEqual(responseCoaches.first!.personId, "1941")
        XCTAssertEqual(responseCoaches.first!.teamId, "1610612755")
        XCTAssertEqual(responseCoaches.first!.college, "Marquette")
     }
    
    // MARK: GetTeamStatRankings

    func test_jumpShot_withGetTeamStatRankings_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeamStatRankings { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }

    func test_jumpShot_withGetTeamStatRankings_isRequestFailed() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()
         router.session = mockURLSession

         let expectation = XCTestExpectation(description: "Network Error")

        jumpShot.getTeamStatRankings { _, error in
             errorDescription = error!.localizedDescription
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 300), nil
         )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "The request failed.")
     }

    func test_jumpShot_withGetTeamStatRankings_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeamStatRankings { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                            nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
     }

    func test_jumpShot_withGetTeamStatRankings_isUnableToDecode() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()

        let path = getPath(forResource: "TeamStatRankingApiResponseMissingAttribute",
                            ofType: "json")

        let teamStatRankingApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeamStatRankings { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            teamStatRankingApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

    func test_jumpShot_withGetTeamStatRankings_isUnableToDecodeWithError() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTeamStatRankings { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

    func test_jumpShot_withGetTeamStatRankings_isOneSchedule() throws {
        let mockURLSession = MockURLSession()
        var responseTeamStatRankings = [TeamStatRanking]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "TeamStatRankingApiResponseOneTeamRanking", ofType: "json")
            else { fatalError("Can't find TeamStatRankingApiResponseOneTeamRanking.json file") }
        let teamStatRanking = try Data(contentsOf: URL(fileURLWithPath: path))

        let expectation = XCTestExpectation(description: "TeamStatRanking Api Response")

        jumpShot.getTeamStatRankings { teamStatRankings, _ in
            responseTeamStatRankings = teamStatRankings!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            teamStatRanking, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)
        
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
    
        XCTAssertEqual(responseTeamStatRankings.first!.teamId, "1610612737")
        XCTAssertEqual(responseTeamStatRankings.first!.min, minStatRanking)
        XCTAssertEqual(responseTeamStatRankings.first!.fgp, fgpStatRanking)
        XCTAssertEqual(responseTeamStatRankings.first!.tpp, tppStatRanking)
        XCTAssertEqual(responseTeamStatRankings.first!.ftp, ftpStatRanking)
        XCTAssertEqual(responseTeamStatRankings.first!.orpg, orpgStatRanking)
        XCTAssertEqual(responseTeamStatRankings.first!.drpg, drpgStatRanking)
        XCTAssertEqual(responseTeamStatRankings.first!.trpg, trpgStatRanking)
        XCTAssertEqual(responseTeamStatRankings.first!.apg, apgStatRanking)
        XCTAssertEqual(responseTeamStatRankings.first!.tpg, tpgStatRanking)
        XCTAssertEqual(responseTeamStatRankings.first!.spg, spgStatRanking)
        XCTAssertEqual(responseTeamStatRankings.first!.bpg, bpgStatRanking)
        XCTAssertEqual(responseTeamStatRankings.first!.pfpg, pfpgStatRanking)
        XCTAssertEqual(responseTeamStatRankings.first!.ppg, ppgStatRanking)
        XCTAssertEqual(responseTeamStatRankings.first!.oppg, oppgStatRanking)
        XCTAssertEqual(responseTeamStatRankings.first!.eff, effStatRanking)
     }
    
    // MARK: GetPlayerStatsSummary

   func test_jumpShot_withGetPlayerStatsSummary_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetPlayerStatsSummary(for: "203085") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }
    
    func test_jumpShot_withGetPlayerStatsSummary_isRequestFailed() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()
         router.session = mockURLSession

        let expectation = XCTestExpectation(description: "Network Error")

         jumpShot.getGetPlayerStatsSummary(for: "203085") { _, error in
             errorDescription = error!.localizedDescription
             expectation.fulfill()
         }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
           badJsonData(), response(statusCode: 300), nil
        )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "The request failed.")
     }

    func test_jumpShot_withGetPlayerStatsSummary_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetPlayerStatsSummary(for: "203085") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                            nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
     }

    func test_jumpShot_withGetPlayerStatsSummary_isUnableToDecode() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()

        let path = getPath(forResource: "PlayerStatsSummaryApiResponseMissingAttribute",
                            ofType: "json")

        let coachApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetPlayerStatsSummary(for: "203085") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            coachApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

    func test_jumpShot_withGetPlayerStatsSummary_isUnableToDecodeWithError() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetPlayerStatsSummary(for: "203085") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

    func test_jumpShot_withGetPlayerStatsSummary_isOneSummary() throws {
        let mockURLSession = MockURLSession()
        var responseSummary = [PlayerStatsSummary]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "PlayerStatsSummaryApiResponseOneSummary", ofType: "json")
            else { fatalError("Can't find PlayerStatsSummaryApiResponseOneSummary.json file") }
        let playerStatsSummaryApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))

        let expectation = XCTestExpectation(description: "PlayerStatsSummary Api Response")

        jumpShot.getGetPlayerStatsSummary(for: "203085") {  playerStatsSummary, _  in
            responseSummary.append(playerStatsSummary!)
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            playerStatsSummaryApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)
        
        let careerStatsSummaryData = """
        {
           "tpp":"34.5",
           "ftp":"73.4",
           "fgp":"50.4",
           "ppg":"27",
           "rpg":"7.4",
           "apg":"7.4",
           "bpg":"0.8",
           "mpg":"38.2",
           "spg":"1.6",
           "assists":"9682",
           "blocks":"982",
           "steals":"2060",
           "turnovers":"4586",
           "offReb":"1534",
           "defReb":"8209",
           "totReb":"9743",
           "fgm":"12881",
           "fga":"25560",
           "tpm":"1976",
           "tpa":"5729",
           "ftm":"7580",
           "fta":"10333",
           "pFouls":"2393",
           "points":"35318",
           "gamesPlayed":"1308",
           "gamesStarted":"1307",
           "plusMinus":"7131",
           "min":"49997",
           "dd2":"507",
           "td3":"99"
        }
        """.data(using: .utf8)!
        let careerStatsSummary = try JSONDecoder().decode(PlayerStats.self, from: careerStatsSummaryData)
        
        let currentStatsSummaryData = """
        {
            "seasonYear":2020,
            "seasonStageId":2,
            "ppg":"25",
            "rpg":"7.9",
            "apg":"7.8",
            "mpg":"33.7",
            "topg":"3.8",
            "spg":"1",
            "bpg":"0.6",
            "tpp":"36.6",
            "ftp":"70.1",
            "fgp":"51.3",
            "assists":"336",
            "blocks":"25",
            "steals":"45",
            "turnovers":"162",
            "offReb":"25",
            "defReb":"313",
            "totReb":"338",
            "fgm":"400",
            "fga":"779",
            "tpm":"101",
            "tpa":"276",
            "ftm":"176",
            "fta":"251",
            "pFouls":"68",
            "points":"1077",
            "gamesPlayed":"43",
            "gamesStarted":"43",
            "plusMinus":"285",
            "min":"1447",
            "dd2":"18",
            "td3":"5"
        }
        """.data(using: .utf8)!
        let currentStatsSummary = try JSONDecoder().decode(PlayerStats.self, from: currentStatsSummaryData)
        
        let teamStatsSummaryData = """
        {
           "teamId":"1610612747",
           "ppg":"25",
           "rpg":"7.9",
           "apg":"7.8",
           "mpg":"33.7",
           "topg":"3.8",
           "spg":"1",
           "bpg":"0.6",
           "tpp":"36.6",
           "ftp":"70.1",
           "fgp":"51.3",
           "assists":"336",
           "blocks":"25",
           "steals":"45",
           "turnovers":"162",
           "offReb":"25",
           "defReb":"313",
           "totReb":"338",
           "fgm":"400",
           "fga":"779",
           "tpm":"101",
           "tpa":"276",
           "ftm":"176",
           "fta":"251",
           "pFouls":"68",
           "points":"1077",
           "gamesPlayed":"43",
           "gamesStarted":"43",
           "plusMinus":"285",
           "min":"1447",
           "dd2":"18",
           "td3":"5"
        }
        """.data(using: .utf8)!
        let teamStatsSummary = try JSONDecoder().decode(PlayerStats.self, from: teamStatsSummaryData)
        
        let totalStatsSummaryData = """
        {
            "ppg":"25",
            "rpg":"7.9",
            "apg":"7.8",
            "mpg":"33.7",
            "topg":"3.8",
            "spg":"1",
            "bpg":"0.6",
            "tpp":"36.6",
            "ftp":"70.1",
            "fgp":"51.3",
            "assists":"336",
            "blocks":"25",
            "steals":"45",
            "turnovers":"162",
            "offReb":"25",
            "defReb":"313",
            "totReb":"338",
            "fgm":"400",
            "fga":"779",
            "tpm":"101",
            "tpa":"276",
            "ftm":"176",
            "fta":"251",
            "pFouls":"68",
            "points":"1077",
            "gamesPlayed":"43",
            "gamesStarted":"43",
            "plusMinus":"285",
            "min":"1447",
            "dd2":"18",
            "td3":"5"
        }
        """.data(using: .utf8)!
        let totalStatsSummary = try JSONDecoder().decode(PlayerStats.self, from: totalStatsSummaryData)
        let playerTeamStats = PlayerTeamStats(teamId: "1610612747", playerStats: teamStatsSummary)
        var playerTeamStatsList = [PlayerTeamStats]()
        playerTeamStatsList.append(playerTeamStats)
        let playerTeamStatsSeason = PlayerTeamStatsSeason(seasonYear: 2020, playerStatTeams: playerTeamStatsList, seasonTotalStats: totalStatsSummary)
        var playerTeamStatsSeasonList = [PlayerTeamStatsSeason]()
        playerTeamStatsSeasonList.append(playerTeamStatsSeason)
        let playerStatsSummary = PlayerStatsSummary(careerStatsSummary: careerStatsSummary,
                                                     currentSeasonStatsSummary: currentStatsSummary,
                                                     playerTeamStatsSeasons: playerTeamStatsSeasonList)
        XCTAssertEqual(responseSummary.first!, playerStatsSummary)
     }
    
    // MARK: GetGamePlays

    func test_jumpShot_withGetGamePlays_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)
        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetGamePlays(for: gameDate!, with: "0022000257") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }

    func test_jumpShot_withGetGamePlays_isRequestFailed() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)
        let expectation = XCTestExpectation(description: "Network Error")

        jumpShot.getGetGamePlays(for: gameDate!, with: "0022000257") { _, error in
         errorDescription = error!.localizedDescription
         expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
        badJsonData(), response(statusCode: 300), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The request failed.")
     }

    func test_jumpShot_withGetGamePlays_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetGamePlays(for: gameDate!, with: "0022000257") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                            nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
     }

    func test_jumpShot_withGetGamePlays_isUnableToDecode() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()

        let path = getPath(forResource: "PlayApiResponseMissingAttribute",
                            ofType: "json")
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)

        let playApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetGamePlays(for: gameDate!, with: "0022000257") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            playApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

    func test_jumpShot_withGetGamePlays_isUnableToDecodeWithError() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetGamePlays(for: gameDate!, with: "0022000257") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

    func test_jumpShot_withGetPlays_isOnePlay() throws {
        let mockURLSession = MockURLSession()
        var responsePlays = [Play]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "PlayApiResponseOnePlay", ofType: "json")
            else { fatalError("Can't find PlayApiResponseOnePlay.json file") }
        let playApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "Play Api Response")

        jumpShot.getGetGamePlays(for: gameDate!, with: "0022000257") { plays, _ in
            responsePlays = plays!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            playApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)
    
        XCTAssertEqual(responsePlays.first!.clock, "10:31")
        XCTAssertEqual(responsePlays.first!.eventMsgType, "4")
        XCTAssertEqual(responsePlays.first!.description, "[DET] Wright Rebound (Off:1 Def:1)")
        XCTAssertEqual(responsePlays.first!.playerId, "1626153")
        XCTAssertEqual(responsePlays.first!.teamId, "1610612765")
        XCTAssertEqual(responsePlays.first!.vTeamScore, 2)
        XCTAssertEqual(responsePlays.first!.hTeamScore, 6)
        XCTAssertEqual(responsePlays.first!.isScoreChange, false)
        XCTAssertEqual(responsePlays.first!.formattedDescription, "DET - Wright Rebound (Off:1 Def:1)")
     }
    
    // MARK: GetLeadTrackers

    func test_jumpShot_withGetLeadTrackers_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        
        var dateComponents = DateComponents()
        dateComponents.year = 2017
        dateComponents.month = 2
        dateComponents.day = 1
        let gameDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetLeadTrackers(for: gameDate!, with: "0021600732", and: "1") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }

    func test_jumpShot_withGetLeadTrackers_isRequestFailed() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()
         router.session = mockURLSession
        
        var dateComponents = DateComponents()
        dateComponents.year = 2017
        dateComponents.month = 2
        dateComponents.day = 1
        let gameDate = Calendar.current.date(from: dateComponents)

         let expectation = XCTestExpectation(description: "Network Error")

        jumpShot.getGetLeadTrackers(for: gameDate!, with: "0021600732", and: "1") { _, error in
             errorDescription = error!.localizedDescription
             expectation.fulfill()
         }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 300), nil
         )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "The request failed.")
     }

    func test_jumpShot_withGetLeadTrackers_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        
        var dateComponents = DateComponents()
        dateComponents.year = 2017
        dateComponents.month = 2
        dateComponents.day = 1
        let gameDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetLeadTrackers(for: gameDate!, with: "0021600732", and: "1") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                            nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
     }

    func test_jumpShot_withGetLeadTrackers_isUnableToDecode() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()

        let path = getPath(forResource: "LeadTrackerApiResponseMissingAttribute",
                            ofType: "json")
        
        var dateComponents = DateComponents()
        dateComponents.year = 2017
        dateComponents.month = 2
        dateComponents.day = 1
        let gameDate = Calendar.current.date(from: dateComponents)

        let playApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetLeadTrackers(for: gameDate!, with: "0021600732", and: "1") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            playApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

    func test_jumpShot_withGetLeadTrackers_isUnableToDecodeWithError() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        
        var dateComponents = DateComponents()
        dateComponents.year = 2017
        dateComponents.month = 2
        dateComponents.day = 1
        let gameDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetLeadTrackers(for: gameDate!, with: "0021600732", and: "1") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

    func test_jumpShot_withGetLeadTrackers_isOnePlay() throws {
        let mockURLSession = MockURLSession()
        var responseLeadTrackers = [LeadTracker]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "LeadTrackerApiResponseOnePlay", ofType: "json")
            else { fatalError("Can't find LeadTrackerResponseOnePlay.json file") }
        let leadTrackerResponseData = try Data(contentsOf: URL(fileURLWithPath: path))

        let expectation = XCTestExpectation(description: "LeadTracker Api Response")
        
        var dateComponents = DateComponents()
        dateComponents.year = 2017
        dateComponents.month = 2
        dateComponents.day = 1
        let gameDate = Calendar.current.date(from: dateComponents)

        jumpShot.getGetLeadTrackers(for: gameDate!, with: "0021600732", and: "1")  { leadTrackers, _ in
            responseLeadTrackers = leadTrackers!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            leadTrackerResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)
    
        XCTAssertEqual(responseLeadTrackers.first!.clock, "11:48")
        XCTAssertEqual(responseLeadTrackers.first!.leadTeamId, "1610612761")
        XCTAssertEqual(responseLeadTrackers.first!.points, 2)
     }
    
    // MARK: GetGameRecap

    func test_jumpShot_withGetGameRecap_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetGameRecap(for: gameDate!, with: "0022000257") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }

    func test_jumpShot_withGetGameRecap_isRequestFailed() throws {
         let mockURLSession = MockURLSession()
         var errorDescription = String()
         router.session = mockURLSession
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)

         let expectation = XCTestExpectation(description: "Network Error")

        jumpShot.getGetGameRecap(for: gameDate!, with: "0022000257") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

         mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 300), nil
         )

         wait(for: [expectation], timeout: 1.0)
         XCTAssertEqual(errorDescription, "The request failed.")
     }

    func test_jumpShot_withGetGameRecap_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetGameRecap(for: gameDate!, with: "0022000257") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                            nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
     }

    func test_jumpShot_withGetGameRecap_isUnableToDecode() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()

        let path = getPath(forResource: "LeadTrackerApiResponseMissingAttribute",
                            ofType: "json")
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)

        let playApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetGameRecap(for: gameDate!, with: "0022000257") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            playApiResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

    func test_jumpShot_withGetGameRecap_isUnableToDecodeWithError() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getGetGameRecap(for: gameDate!, with: "0022000257") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            badJsonData(), response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
     }

    func test_jumpShot_withGetGameRecap_isOnePlay() throws {
        let mockURLSession = MockURLSession()
        var responseGameRecap = [GameRecap]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        let publishDate = "2021-01-26T04:44:00.000Z".iso8601Date!
        let paragraph = Paragraph(text: "DETROIT (AP)  Delon Wright scored a career-high 28 points and Wayne Ellington had another impressive shooting night for Detroit, leading the Pistons to a 119-104 victory over the Eastern Conference-leading Philadelphia 76ers on Monday.")
        let paragraphs = [paragraph]
        guard let path = testBundle.path(forResource: "GameRecapApiResponseOneRecap", ofType: "json")
            else { fatalError("Can't find GameRecapApiResponseOneRecap.json file") }
        let leadTrackerResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "GameRecap Api Response")
        
        jumpShot.getGetGameRecap(for: gameDate!, with: "0022000257") { gameRecap, _ in
            responseGameRecap.append(gameRecap!)
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            leadTrackerResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)
    
        XCTAssertEqual(responseGameRecap.first!.author, "By NOAH TRISTER")
        XCTAssertEqual(responseGameRecap.first!.authorTitle, "AP Sports Writer")
        XCTAssertEqual(responseGameRecap.first!.copyright, "Copyright 2021 by STATS LLC and Associated Press. Any commercial use or distribution without the express written consent of STATS LLC and Associated Press is strictly prohibited")
        XCTAssertEqual(responseGameRecap.first!.title, "Wright, Ellington lead Pistons over 76ers 119-104")
        XCTAssertEqual(responseGameRecap.first!.publishDate, publishDate)
        XCTAssertEqual(responseGameRecap.first!.paragraphs, paragraphs)
     }
    
    // MARK: GetTotalLeagueLeaders

    func test_jumpShot_withGetTotalLeagueLeaders_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTotalLeagueLeaders(for: 2020, with: .regularSeason, and: .playerEfficiency) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }
    
    func test_jumpShot_withGetTotalLeagueLeaders_isRequestFailed() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTotalLeagueLeaders(for: 2020, with: .regularSeason, and: .playerEfficiency) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
           badJsonData(), response(statusCode: 300), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The request failed.")
    }
    
    func test_jumpShot_withGetTotalLeagueLeaders_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTotalLeagueLeaders(for: 2020, with: .regularSeason, and: .playerEfficiency) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                            nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
    }
    
    func test_jumpShot_withGetTotalLeagueLeaders_isUnableToDecode() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()

        let path = getPath(forResource: "TotalLeagueLeaderApiResponseMissingAttribute",
                            ofType: "json")

        let totalLeagueLeaderResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getTotalLeagueLeaders(for: 2020, with: .regularSeason, and: .playerEfficiency) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            totalLeagueLeaderResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withGetTotalLeagueLeaders_isOneLeagueLeader() throws {
        let mockURLSession = MockURLSession()
        var responseTotalLeagueLeaders = [TotalLeagueLeader]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "TotalLeagueLeaderApiResponseOneLeagueLeader", ofType: "json")
            else { fatalError("Can't find TotalLeagueLeaderApiResponseOneLeagueLeader.json file") }
        let totalLeagueLeaderResponseData = try Data(contentsOf: URL(fileURLWithPath: path))

        let expectation = XCTestExpectation(description: "TotalLeagueLeaderApiResponse")

        jumpShot.getTotalLeagueLeaders(for: 2020, with: .regularSeason, and: .playerEfficiency) { totalLeagueLeaders, _ in
            responseTotalLeagueLeaders = totalLeagueLeaders!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            totalLeagueLeaderResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.playerId, "203999")
        XCTAssertEqual(responseTotalLeagueLeaders.first!.rank, 1)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.player, "Nikola Jokic")
        XCTAssertEqual(responseTotalLeagueLeaders.first!.team, "DEN")
        XCTAssertEqual(responseTotalLeagueLeaders.first!.gamesPlayed, 72)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.minutes, 2488)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.fieldGoalsMade, 732)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.fieldGoalsAttempted, 1293)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.fieldGoalsPercentage, 0.566)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.threePointersMade, 92)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.threePointersAttempted, 237)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.threePointersPercentage, 0.388)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.foulShotsMade, 342)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.foulShotsAttempted, 394)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.foulShotsPercentage, 0.868)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.defensiveRebounds, 575)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.offensiveRebounds, 205)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.rebounds, 780)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.assists, 599)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.steals, 95)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.blocks, 48)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.turnovers, 222)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.personalFouls, 192)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.playerEfficiency, 2585)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.points, 1898)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.assistsToTurnovers, 2.7)
        XCTAssertEqual(responseTotalLeagueLeaders.first!.stealsToTurnovers, 0.43)
     }
    
    // MARK: PerGameLeagueLeaders

    func test_jumpShot_withGetPerGameLeagueLeaders_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getPerGameLeagueLeaders(for: 2020, with: .regularSeason, and: .playerEfficiency) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }
    
    func test_jumpShot_withGetPerGameLeagueLeaders_isRequestFailed() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getPerGameLeagueLeaders(for: 2020, with: .regularSeason, and: .playerEfficiency) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
           badJsonData(), response(statusCode: 300), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The request failed.")
    }
    
    func test_jumpShot_withGetPerGameLeagueLeaders_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getPerGameLeagueLeaders(for: 2020, with: .regularSeason, and: .playerEfficiency) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                            nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
    }
    
    func test_jumpShot_withGetPerGameLeagueLeaders_isUnableToDecode() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()

        let path = getPath(forResource: "PerGameLeagueLeaderApiResponseMissingAttribute",
                            ofType: "json")

        let perGameLeagueLeaderResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getPerGameLeagueLeaders(for: 2020, with: .regularSeason, and: .playerEfficiency) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            perGameLeagueLeaderResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withGetPerGameLeagueLeaders_isOneLeagueLeader() throws {
        let mockURLSession = MockURLSession()
        var responsePerGameLeagueLeaders = [PerGameLeagueLeader]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "PerGameLeagueLeaderApiResponseOneLeagueLeader", ofType: "json")
            else { fatalError("Can't find PerGameLeagueLeaderApiResponseOneLeagueLeader.json file") }
        let perGameLeagueLeaderResponseData = try Data(contentsOf: URL(fileURLWithPath: path))

        let expectation = XCTestExpectation(description: "PerGameLeagueLeaderApiResponse")

        jumpShot.getPerGameLeagueLeaders(for: 2020, with: .regularSeason, and: .playerEfficiency) { perGameLeagueLeaders, _ in
            responsePerGameLeagueLeaders = perGameLeagueLeaders!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            perGameLeagueLeaderResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.playerId, "203999")
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.rank, 1)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.player, "Nikola Jokic")
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.team, "DEN")
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.gamesPlayed, 72)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.minutes, 34.6)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.fieldGoalsMade, 10.2)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.fieldGoalsAttempted, 18)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.fieldGoalsPercentage, 0.566)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.threePointersMade, 1.3)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.threePointersAttempted, 3.3)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.threePointersPercentage, 0.388)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.foulShotsMade, 4.8)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.foulShotsAttempted, 5.5)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.foulShotsPercentage, 0.868)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.defensiveRebounds, 8)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.offensiveRebounds, 2.8)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.rebounds, 10.8)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.assists, 8.3)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.steals, 1.3)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.blocks, 0.7)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.turnovers, 3.1)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.playerEfficiency, 35.9)
        XCTAssertEqual(responsePerGameLeagueLeaders.first!.points, 26.4)
     }
    
    
    
    // MARK: Per48TotalLeagueLeaders

    func test_jumpShot_withGetPer48LeagueLeaders_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getPer48LeagueLeaders(for: 2020, with: .regularSeason, and: .playerEfficiency) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }
    
    func test_jumpShot_withGetPer48LeagueLeaders_isRequestFailed() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getPer48LeagueLeaders(for: 2020, with: .regularSeason, and: .playerEfficiency) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
           badJsonData(), response(statusCode: 300), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The request failed.")
    }
    
    func test_jumpShot_withGetPer48LeagueLeaders_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getPer48LeagueLeaders(for: 2020, with: .regularSeason, and: .playerEfficiency) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                        nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
    }
    
    func test_jumpShot_withGetPer48LeagueLeaders_isUnableToDecode() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()

        let path = getPath(forResource: "Per48LeagueLeaderApiResponseMissingAttribute",
                            ofType: "json")

        let totalLeagueLeaderResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        router.session = mockURLSession

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getPer48LeagueLeaders(for: 2020, with: .regularSeason, and: .playerEfficiency) { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            totalLeagueLeaderResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withGetPer48LeagueLeaders_isOneLeagueLeader() throws {
        let mockURLSession = MockURLSession()
        var responsePer48LeagueLeaders = [Per48LeagueLeader]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "Per48LeagueLeaderApiResponseOneLeagueLeader", ofType: "json")
            else { fatalError("Can't find Per48LeaderApiResponseOneLeagueLeader.json file") }
        let per48LeagueLeaderResponseData = try Data(contentsOf: URL(fileURLWithPath: path))

        let expectation = XCTestExpectation(description: "Per48LeagueLeaderApiResponse")

        jumpShot.getPer48LeagueLeaders(for: 2020, with: .regularSeason, and: .playerEfficiency) { perLeagueLeaders, _ in
            responsePer48LeagueLeaders = perLeagueLeaders!
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            per48LeagueLeaderResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.playerId, "203999")
        XCTAssertEqual(responsePer48LeagueLeaders.first!.rank, 1)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.player, "Nikola Jokic")
        XCTAssertEqual(responsePer48LeagueLeaders.first!.team, "DEN")
        XCTAssertEqual(responsePer48LeagueLeaders.first!.gamesPlayed, 72)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.minutes, 2488)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.fieldGoalsMade, 14.1)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.fieldGoalsAttempted, 24.9)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.fieldGoalsPercentage, 0.566)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.threePointersMade, 1.8)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.threePointersAttempted, 4.6)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.threePointersPercentage, 0.388)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.foulShotsMade, 6.6)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.foulShotsAttempted, 7.6)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.foulShotsPercentage, 0.868)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.defensiveRebounds, 11.1)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.offensiveRebounds, 4.0)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.rebounds, 15.0)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.assists, 11.6)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.steals, 1.83)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.blocks, 0.93)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.turnovers, 4.28)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.playerEfficiency, 49.9)
        XCTAssertEqual(responsePer48LeagueLeaders.first!.personalFouls, 3.7)
     }
    
    // MARK: Boxscore

    func test_jumpShot_withGetBoxscore_isNetworkUnavailable() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getBoxscore(for: gameDate!,
                             with: "0022000257") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            nil, nil, TestError.testError
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The network is unavailable.")
    }
    
    func test_jumpShot_withGetBoxscore_isRequestFailed() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getBoxscore(for: gameDate!,
                             with: "0022000257") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
           badJsonData(), response(statusCode: 300), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The request failed.")
    }
    
    func test_jumpShot_withGetBoxscore_isNoDataReturned() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()
        router.session = mockURLSession
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getBoxscore(for: gameDate!,
                             with: "0022000257") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
                        nil, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "No NBA data was returned.")
    }
    
    func test_jumpShot_withGetBoxscore_isUnableToDecode() throws {
        let mockURLSession = MockURLSession()
        var errorDescription = String()

        let path = getPath(forResource: "BoxscoreApiResponseMissingBasicGameData",
                            ofType: "json")

        let totalLeagueLeaderResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        router.session = mockURLSession
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "HTTP Response Error")

        jumpShot.getBoxscore(for: gameDate!,
                             with: "0022000257") { _, error in
            errorDescription = error!.localizedDescription
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            totalLeagueLeaderResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorDescription, "The source data could not be decoded.")
    }

    func test_jumpShot_withGetBoxscore_isOneBoxscore() throws {
        let mockURLSession = MockURLSession()
        var responseBoxscore = [Boxscore]()
        router.session = mockURLSession
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "BoxscoreApiResponseOneBoxscore", ofType: "json")
            else { fatalError("Can't find BoxscoreApiResponseOneBoxscore.json file") }
        let boxscoreResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)

        let expectation = XCTestExpectation(description: "BoxscoreApiResponse")

        jumpShot.getBoxscore(for: gameDate!,
                             with: "0022000257") { boxscore, _ in
            responseBoxscore.append(boxscore!)
            expectation.fulfill()
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            boxscoreResponseData, response(statusCode: 200), nil
        )

        wait(for: [expectation], timeout: 5.0)
        
        let statsModelPath = getPath(forResource: "BoxscoreGameStatsModel",
                                ofType: "json")
        let boxscoreStatsData = try Data(contentsOf: URL(fileURLWithPath: statsModelPath))
        let boxscoreStatsResponse = try JSONDecoder().decode(BoxscoreStats.self, from: boxscoreStatsData)
        
        let basicGamePath = getPath(forResource: "BoxscoreBasicGameModel",
                                ofType: "json")
        let boxscoreBasicGameData = try Data(contentsOf: URL(fileURLWithPath: basicGamePath))
        let boxscoreBasicGameDataResponse = try JSONDecoder().decode(BasicGameData.self, from: boxscoreBasicGameData)
        
        XCTAssertEqual(responseBoxscore.first!.boxscoreStats.timesTied, boxscoreStatsResponse.timesTied)
        XCTAssertEqual(responseBoxscore.first!.boxscoreStats.leadChanges, boxscoreStatsResponse.leadChanges)
        XCTAssertEqual(responseBoxscore.first!.boxscoreStats.visitorTeamStats, boxscoreStatsResponse.visitorTeamStats)
        XCTAssertEqual(responseBoxscore.first!.boxscoreStats.homeTeamStats, boxscoreStatsResponse.homeTeamStats)
        XCTAssertEqual(responseBoxscore.first!.boxscoreStats.activePlayers.first!, boxscoreStatsResponse.activePlayers.first!)
        XCTAssertEqual(responseBoxscore.first!.basicGameData.isGameActivated, boxscoreBasicGameDataResponse.isGameActivated)
        XCTAssertEqual(responseBoxscore.first!.basicGameData.status, boxscoreBasicGameDataResponse.status)
        XCTAssertEqual(responseBoxscore.first!.basicGameData.extendedStatus, boxscoreBasicGameDataResponse.extendedStatus)
        XCTAssertEqual(responseBoxscore.first!.basicGameData.startTime, boxscoreBasicGameDataResponse.startTime)
        XCTAssertEqual(responseBoxscore.first!.basicGameData.endTime, boxscoreBasicGameDataResponse.endTime)
        XCTAssertEqual(responseBoxscore.first!.basicGameData.isBuzzerBeater, boxscoreBasicGameDataResponse.isBuzzerBeater)
        XCTAssertEqual(responseBoxscore.first!.basicGameData.isNeutralVenue, boxscoreBasicGameDataResponse.isNeutralVenue)
        XCTAssertEqual(responseBoxscore.first!.basicGameData.arena, boxscoreBasicGameDataResponse.arena)
        XCTAssertEqual(responseBoxscore.first!.basicGameData.gameDuration, boxscoreBasicGameDataResponse.gameDuration)
        XCTAssertEqual(responseBoxscore.first!.basicGameData.period, boxscoreBasicGameDataResponse.period)
        XCTAssertEqual(responseBoxscore.first!.basicGameData.officials, boxscoreBasicGameDataResponse.officials)
        XCTAssertEqual(responseBoxscore.first!.basicGameData.homeTeamData, boxscoreBasicGameDataResponse.homeTeamData)
        XCTAssertEqual(responseBoxscore.first!.basicGameData.visitorTeamData, boxscoreBasicGameDataResponse.visitorTeamData)
     }
}
