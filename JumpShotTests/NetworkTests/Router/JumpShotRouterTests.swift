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

    // MARK: Team Image

    func test_teamImageRouter_shouldMakeRequestToTeamsImageAPIURL() {
        router.request(.teamImage(teamAbbreviation: "BOS")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://a.espncdn.com/i/teamlogos/nba/500/BOS.png")!))
    }

    // MARK: Player

    func test_playerRouter_shouldMakeRequestToPlayersAPIURL() {
        router.request(.playerList(season: "2020")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://data.nba.net/data/5s/prod/v2/2020/players.json")!))
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

    // MARK: Get Daily Schedule

    func test_dailyScheduleRouter_shouldMakeRequestToScheduleURL() {
        router.request(.scheduleList(season: "2020", date: "04/17/2021")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/internationalbroadcasterschedule?LeagueID=00&Season=2020&RegionID=1&Date=04/17/2021&EST=Y")!))
    }

    // MARK: Get Standings

    func test_standingsRouter_shouldMakeRequestToStandingsAPIURL() {
        router.request(.standingList) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://data.nba.net/data/5s/prod/v2/current/standings_all.json")!))
    }

    // MARK: Get Team Leaders

    func test_teamLeadersRouter_shouldMakeRequestToTeamLeadersAPIURL() {
        router.request(.teamLeaderList(teamId: "1610612737")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://data.nba.com/prod/v1/2020/teams/1610612737/leaders.json")!))
    }

    // MARK: Get Team Schedule

    func test_teamScheduleRouter_shouldMakeRequestToTeamScheduleAPIURL() {
        router.request(.teamScheduleList(teamId: "1610612737")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://data.nba.com/prod/v1/2020/teams/1610612737/schedule.json")!))
    }

    // MARK: Get Complete Schedule

    func test_completeScheduleRouter_shouldMakeRequestToTeamScheduleAPIURL() {
        router.request(.completeScheduleList(season: "2020")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://data.nba.net/prod/v2/2020/schedule.json")!))
    }

    // MARK: Coach

    func test_coachRouter_shouldMakeRequestToCoachAPIURL() {
        router.request(.coachList(season: "2020")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://data.nba.net/prod/v1/2020/coaches.json")!))
    }

    // MARK: TeamStatRanking

    func test_teamStatRankingRouter_shouldMakeRequestToTeamStatRankingAPIURL() {
        router.request(.teamStatRankingList(season: "2020")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://data.nba.com/prod/v1/2020/team_stats_rankings.json")!))
    }

    // MARK: PlayerStats

    func test_playerStatsRouter_shouldMakeRequestToPlayerStatsAPIURL() {
        router.request(.playerStatsSummary(season: "2020", playerId: "2544")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://data.nba.com/prod/v1/2020/players/2544_profile.json")!))
    }

    // MARK: GamePlayByPlay

    func test_gamePlayByPlayRouter_shouldMakeRequestToPlayerStatsAPIURL() {
        router.request(.gamePlayList(date: "20210125", gameId: "0022000257")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://data.nba.net/prod/v1/20210125/0022000257_pbp_1.json")!))
    }
}
