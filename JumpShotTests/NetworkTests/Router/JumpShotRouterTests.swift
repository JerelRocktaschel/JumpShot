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

    // MARK: LeadTracker

    func test_leadTrackerRouter_shouldMakeRequestToPlayerStatsAPIURL() {
        router.request(.leadTrackerList(date: "20170201",
                                        gameId: "0021600732",
                                        period: "1")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://data.nba.net/prod/v1/20170201/0021600732_lead_tracker_1.json")!))
    }

    // MARK: LeagueLeaders

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_PerModeIs_Totals() {
        router.request(.leagueLeadersList(perMode: .totals,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "EFF")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
                with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=Totals&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=EFF")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_PerModeIs_Per48() {
        router.request(.leagueLeadersList(perMode: .per48,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "EFF")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=Per48&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=EFF")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_PerModeIs_PerGame() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "EFF")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=EFF")!))
    }
    
    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_SeasonIs_PreSeason() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .preSeason,
                                          category: "EFF")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Pre+Season&StatCategory=EFF")!))
        }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_SeasonIs_RegularSeason() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "EFF")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=EFF")!))
        }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_SeasonIs_Playoffs() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .playoffs,
                                          category: "EFF")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Playoffs&StatCategory=EFF")!))
    }
    
    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_MIN() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "MIN")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=MIN")!))
    }
    
    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_FGM() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "FGM")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=FGM")!))
    }
    
    
    
    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_FGA() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "FGA")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=FGA")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_FG_PCT() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "FG_PCT")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=FG_PCT")!))
    }
    
    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_FG3M() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "FG3M")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=FG3M")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_FG3A() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "FG3A")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=FG3A")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_FG3_PCT() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "FG3_PCT")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=FG3_PCT")!))
    }
    
    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_FTM() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "FTM")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=FTM")!))
    }
    
    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_FTA() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "FTA")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=FTA")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_FT_PCT() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "FT_PCT")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=FT_PCT")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_OREB() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "OREB")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=OREB")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_DREB() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "DREB")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=DREB")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_REB() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "REB")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=REB")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_AST() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "AST")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=AST")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_STL() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "STL")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=STL")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_BLK() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "BLK")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=BLK")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_TOV() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "TOV")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=TOV")!))
    }
    
    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_EFF() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "EFF")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=EFF")!))
    }
    
    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_PTS() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "PTS")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=PTS")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_AST_TOV() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "AST_TOV")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=AST_TOV")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_STL_TOV() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "STL_TOV")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=STL_TOV")!))
    }

    func test_leagueLeadersRouter_shouldMakeRequestToLeagueLeadersAPIURL_StatCategoryIs_PF() {
        router.request(.leagueLeadersList(perMode: .perGame,
                                          season: "2020-21",
                                          seasonType: .regularSeason,
                                          category: "PF")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=2020-21&SeasonType=Regular+Season&StatCategory=PF")!))
    }

    // MARK: Boxscore

    func test_boxscoreRouter_shouldMakeRequestToBoxscoreAPIURL() {
        router.request(.boxscore(date: "20210125", gameId: "0022000257")) { _, _, _ in
        }
        mockURLSession.verifyDataTask(
            with: URLRequest(url: URL(string: "https://data.nba.net/prod/v1/20210125/0022000257_boxscore.json")!))
    }
}
