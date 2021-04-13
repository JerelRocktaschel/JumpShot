//
//  JumpShotApiEndPointTests.swift
//  JumpShotTests
//
//  Created by Jerel Rocktaschel on 3/30/21.
//

import XCTest
@testable import JumpShot

class JumpShotApiEndPointTests: XCTestCase {

    var teamsJumpShotApiEndPoint: JumpShotApiEndPoint!
    var teamImageJumpShotApiEndPoint: JumpShotApiEndPoint!
    var playerSmallImageJumpShotApiEndPoint: JumpShotApiEndPoint!
    var playerLargeImageJumpShotApiEndPoint: JumpShotApiEndPoint!

    override func setUp() {
        teamsJumpShotApiEndPoint = JumpShotApiEndPoint.self.teamList(season: "2020")
        teamImageJumpShotApiEndPoint = JumpShotApiEndPoint.self.teamImage(teamAbbreviation: "BOS")
        playerSmallImageJumpShotApiEndPoint = JumpShotApiEndPoint.self.playerImage(imageSize: .small, playerId: "1627759")
        playerLargeImageJumpShotApiEndPoint = JumpShotApiEndPoint.self.playerImage(imageSize: .large, playerId: "1627759")
    }

    // MARK: Team

    func test_teamJumpShotApiEndPoint_withEnvironmentalBaseURL_isCorrectValue() {
        XCTAssertEqual(teamsJumpShotApiEndPoint.environmentBaseURL, "https://data.nba.net/data/5s/prod/v2/")
    }

    func test_teamJumpShotApiEndPoint_withBaseURL_isCorrectValue() {
        XCTAssertEqual(teamsJumpShotApiEndPoint.baseURL, URL(string: "https://data.nba.net/data/5s/prod/v2/"))
    }

    func test_teamJumpShotApiEndPoint_withPath_isCorrectValue() {
        XCTAssertEqual(teamsJumpShotApiEndPoint.path, "2020/teams.json")
    }
    
    // MARK: Team Image
    
    func test_teamImageJumpShotApiEndPoint_withEnvironmentalBaseURL_isCorrectValue() {
        XCTAssertEqual(teamImageJumpShotApiEndPoint.environmentBaseURL, "https://a.espncdn.com/i/teamlogos/nba/500/")
    }

    func test_teamImageJumpShotApiEndPoint_withBaseURL_isCorrectValue() {
        XCTAssertEqual(teamImageJumpShotApiEndPoint.baseURL, URL(string: "https://a.espncdn.com/i/teamlogos/nba/500/"))
    }

    func test_teamImageJumpShotApiEndPoint_withPath_isCorrectValue() {
        XCTAssertEqual(teamImageJumpShotApiEndPoint.path, "BOS.png")
    }
    
    // MARK: Player Image
    
    func test_playerSmallImageJumpShotApiEndPoint_withEnvironmentalBaseURL_isCorrectValue() {
        XCTAssertEqual(playerSmallImageJumpShotApiEndPoint.environmentBaseURL, "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/")
    }

    func test_playerSmallImageJumpShotApiEndPoint_withBaseURL_isCorrectValue() {
        XCTAssertEqual(playerSmallImageJumpShotApiEndPoint.baseURL, URL(string: "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/"))
    }

    func test_playerSmallImageJumpShotApiEndPoint_withPath_isCorrectValue() {
        XCTAssertEqual(playerSmallImageJumpShotApiEndPoint.path, "260x190/1627759.png")
    }
    
    func test_playerLargeImageJumpShotApiEndPoint_withEnvironmentalBaseURL_isCorrectValue() {
        XCTAssertEqual(playerLargeImageJumpShotApiEndPoint.environmentBaseURL, "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/")
    }

    func test_playerLargeImageJumpShotApiEndPoint_withBaseURL_isCorrectValue() {
        XCTAssertEqual(playerLargeImageJumpShotApiEndPoint.baseURL, URL(string: "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/"))
    }

    func test_playerLargeImageJumpShotApiEndPoint_withPath_isCorrectValue() {
        XCTAssertEqual(playerLargeImageJumpShotApiEndPoint.path, "1040x760/1627759.png")
    }
    
}
