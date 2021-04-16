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
    }

    // MARK: Team

    func test_teamRouter_shouldMakeRequestToTeamsAPIURL() {
        router.request(.teamList(season: "2020")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://data.nba.net/data/5s/prod/v2/2020/teams.json")!))
    }

    func test_teamRouter_withJSONData_isEqualToCanonical() throws {
        let path = getPath(forResource: "TeamApiResponse",
                           ofType: "json")
        let teamApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        XCTAssertEqual(teamApiResponseData, teamJsonData())
    }

    // MARK: Team Image

    func test_teamImageRouter_shouldMakeRequestToTeamsImageAPIURL() {
        router.request(.teamImage(teamAbbreviation: "BOS")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://a.espncdn.com/i/teamlogos/nba/500/BOS.png")!))
    }

    // MARK: Player

    func test_playerRouter_shouldMakeRequestToTeamsAPIURL() {
        router.request(.playerList(season: "2020")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://data.nba.net/data/5s/prod/v2/2020/players.json")!))
    }

    func test_playerRouter_withJSONData_isEqualToCanonical() throws {
        let path = getPath(forResource: "PlayerApiResponse",
                           ofType: "json")
        let playerApiResponseData = try Data(contentsOf: URL(fileURLWithPath: path))
        XCTAssertEqual(playerApiResponseData, playerJsonData())
    }

    // MARK: Player Image

    func test_playerSmallImageRouter_shouldMakeRequestToTeamsImageAPIURL() {
        router.request(.playerImage(imageSize: .small, playerId: "1627759")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1627759.png")!))
    }

    func test_playerLargeImageRouter_shouldMakeRequestToTeamsImageAPIURL() {
        router.request(.playerImage(imageSize: .large, playerId: "1627759")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/1040x760/1627759.png")!))
    }
}
