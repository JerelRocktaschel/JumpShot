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

    override func setUp() {
        teamsJumpShotApiEndPoint = JumpShotApiEndPoint.self.teamList(season: "2020")
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
}
