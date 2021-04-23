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
    var playersJumpShotApiEndPoint: JumpShotApiEndPoint!
    var playerSmallImageJumpShotApiEndPoint: JumpShotApiEndPoint!
    var playerLargeImageJumpShotApiEndPoint: JumpShotApiEndPoint!
    var dailyGameScheduleJumpShotApiEndPoint: JumpShotApiEndPoint!
    var standingsScheduleJumpShotApiEndPoint: JumpShotApiEndPoint!
    var teamLeadersScheduleJumpShotApiEndPoint: JumpShotApiEndPoint!

    override func setUp() {
        teamsJumpShotApiEndPoint = JumpShotApiEndPoint.self.teamList(season: "2020")
        teamImageJumpShotApiEndPoint = JumpShotApiEndPoint.self.teamImage(teamAbbreviation: "BOS")
        playersJumpShotApiEndPoint = JumpShotApiEndPoint.self.playerList(season: "2020")
        playerSmallImageJumpShotApiEndPoint = JumpShotApiEndPoint.self.playerImage(imageSize: .small,
                                                                                   playerId: "1627759")
        playerLargeImageJumpShotApiEndPoint = JumpShotApiEndPoint.self.playerImage(imageSize: .large,
                                                                                   playerId: "1627759")
        dailyGameScheduleJumpShotApiEndPoint = JumpShotApiEndPoint.self.scheduleList(season: "2020", date: "04/17/2021")
        standingsScheduleJumpShotApiEndPoint = JumpShotApiEndPoint.self.standingList
        teamLeadersScheduleJumpShotApiEndPoint = JumpShotApiEndPoint.self.teamLeaderList(teamId: "1610612737")
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

    // MARK: Player

    func test_playerJumpShotApiEndPoint_withEnvironmentalBaseURL_isCorrectValue() {
        XCTAssertEqual(playersJumpShotApiEndPoint.environmentBaseURL, "https://data.nba.net/data/5s/prod/v2/")
    }

    func test_playerJumpShotApiEndPoint_withBaseURL_isCorrectValue() {
        XCTAssertEqual(playersJumpShotApiEndPoint.baseURL, URL(string: "https://data.nba.net/data/5s/prod/v2/"))
    }

    func test_playerJumpShotApiEndPoint_withPath_isCorrectValue() {
        XCTAssertEqual(playersJumpShotApiEndPoint.path, "2020/players.json")
    }

    // MARK: Player Image

    func test_playerSmallImageJumpShotApiEndPoint_withEnvironmentalBaseURL_isCorrectValue() {
        XCTAssertEqual(playerSmallImageJumpShotApiEndPoint.environmentBaseURL,
                       "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/")
    }

    func test_playerSmallImageJumpShotApiEndPoint_withBaseURL_isCorrectValue() {
        XCTAssertEqual(playerSmallImageJumpShotApiEndPoint.baseURL,
                       URL(string: "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/"))
    }

    func test_playerSmallImageJumpShotApiEndPoint_withPath_isCorrectValue() {
        XCTAssertEqual(playerSmallImageJumpShotApiEndPoint.path, "260x190/1627759.png")
    }

    func test_playerLargeImageJumpShotApiEndPoint_withEnvironmentalBaseURL_isCorrectValue() {
        XCTAssertEqual(playerLargeImageJumpShotApiEndPoint.environmentBaseURL,
                       "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/")
    }

    func test_playerLargeImageJumpShotApiEndPoint_withBaseURL_isCorrectValue() {
        XCTAssertEqual(playerLargeImageJumpShotApiEndPoint.baseURL,
                       URL(string: "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/"))
    }

    func test_playerLargeImageJumpShotApiEndPoint_withPath_isCorrectValue() {
        XCTAssertEqual(playerLargeImageJumpShotApiEndPoint.path, "1040x760/1627759.png")
    }

    // MARK: Daily Schedule

    func test_scheduleListJumpShotApiEndPoint_withEnvironmentalBaseURL_isCorrectValue() {
        XCTAssertEqual(dailyGameScheduleJumpShotApiEndPoint.environmentBaseURL, "https://stats.nba.com/stats/")
    }

    func test_scheduleListJumpShotApiEndPoint_withBaseURL_isCorrectValue() {
        XCTAssertEqual(dailyGameScheduleJumpShotApiEndPoint.baseURL, URL(string: "https://stats.nba.com/stats/"))
    }

    func test_scheduleListJumpShotApiEndPoint_withPath_isCorrectValue() {
        XCTAssertEqual(dailyGameScheduleJumpShotApiEndPoint.path,
                       "internationalbroadcasterschedule?LeagueID=00&Season=2020&RegionID=1&Date=04/17/2021&EST=Y")
    }

    // MARK: Standings

    func test_standingsListJumpShotApiEndPoint_withEnvironmentalBaseURL_isCorrectValue() {
        XCTAssertEqual(standingsScheduleJumpShotApiEndPoint.environmentBaseURL, "https://data.nba.net/data/5s/prod/v2/")
    }

    func test_standingsListJumpShotApiEndPoint_withBaseURL_isCorrectValue() {
        XCTAssertEqual(standingsScheduleJumpShotApiEndPoint.baseURL,
                       URL(string: "https://data.nba.net/data/5s/prod/v2/"))
    }

    func test_standingsListJumpShotApiEndPoint_withPath_isCorrectValue() {
        XCTAssertEqual(standingsScheduleJumpShotApiEndPoint.path,
                       "current/standings_all.json")
    }

    // MARK: Team Leaders

    func test_teamLeadersListJumpShotApiEndPoint_withEnvironmentalBaseURL_isCorrectValue() {
        XCTAssertEqual(teamLeadersScheduleJumpShotApiEndPoint.environmentBaseURL,
                       "https://data.nba.com/prod/v1/2020/teams/")
    }

    func test_teamLeadersListJumpShotApiEndPoint_withBaseURL_isCorrectValue() {
        XCTAssertEqual(teamLeadersScheduleJumpShotApiEndPoint.baseURL,
                       URL(string: "https://data.nba.com/prod/v1/2020/teams/"))
    }

    func test_teamLeadersListJumpShotApiEndPoint_withPath_isCorrectValue() {
        XCTAssertEqual(teamLeadersScheduleJumpShotApiEndPoint.path, "1610612737/leaders.json")
    }

}
