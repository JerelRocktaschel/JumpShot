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
}
