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

    override func setUp() {
        teamsJumpShotApiEndPoint = JumpShotApiEndPoint.self.teamList(season: "2020")
        teamImageJumpShotApiEndPoint = JumpShotApiEndPoint.self.teamImage(teamAbbreviation: "BOS")
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
    
}
