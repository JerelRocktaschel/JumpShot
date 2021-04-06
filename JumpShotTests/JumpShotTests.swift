//
//  JumpShotTests.swift
//  JumpShotTests
//
//  Created by Jerel Rocktaschel on 3/31/21.
//

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
        let expectation = XCTestExpectation(description: "Player Response")

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
}
