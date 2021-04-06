//
//  JumpShotRouterTests.swift
//  JumpShotTests
//
//  Created by Jerel Rocktaschel on 3/31/21.
//

import XCTest
@testable import JumpShot

class JumpShotRouterTests: XCTestCase {

    let mockURLSession = MockURLSession()
    let router = JumpShotNetworkManager.shared.router

    override func setUp() {
        router.session = mockURLSession
        router.request(.teamList(season: "2020")) { _, _, _ in
        }
    }

    // MARK: Team

    func test_teamRouter_shouldMakeRequestToTeamsAPIURL() {
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://data.nba.net/data/5s/prod/v2/2020/teams.json")!))
    }

    func test_teamRouter_withJSONData_isEqualToCanonical() throws {
        let path = getPath(forResource: "TeamApiResponse",
                           ofType: "json")
        let teamApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        XCTAssertEqual(teamApiResponseData, teamJsonData())
    }
}
