//
//  JumpShotAPIResponseTests.swift
//  JumpShotTests
//
//  Created by Jerel Rocktaschel on 3/30/21.
//

import XCTest
@testable import JumpShot

class JumpShotAPIResponseTests: XCTestCase {

    // MARK: TeamApiResponse

    func test_teamApiResponse_withMissingLeagueDictionary_isNil() throws {
        let path = getPath(forResource: "TeamApiResponseMissingLeagueDict",
                           ofType: "json")
        let teamApiResponseJson = try getApiResourceJson(withPath: path)
        let teamApiResponse = TeamApiResponse(json: teamApiResponseJson)
        XCTAssertNil(teamApiResponse)
    }

    func test_teamApiResponse_withMissingStandardDictionary_isNil() throws {
        let path = getPath(forResource: "TeamApiResponseMissingStandardDict",
                           ofType: "json")
        let teamApiResponseJson = try getApiResourceJson(withPath: path)
        let teamApiResponse = TeamApiResponse(json: teamApiResponseJson)
        XCTAssertNil(teamApiResponse)
    }

    func test_teamApiResponse_withOneTeam_isOne() throws {
        let path = getPath(forResource: "TeamApiResponseOneTeam",
                           ofType: "json")
        let teamApiResponseJson = try getApiResourceJson(withPath: path)
        let teamApiResponse = TeamApiResponse(json: teamApiResponseJson)
        XCTAssertEqual(teamApiResponse?.teams.count, 1)
    }

    func test_teamApiResponse_withMissingIsNBAFranchise_isNil() throws {
        let path = getPath(forResource: "TeamApiResponseMissingIsNBAFranchise",
                           ofType: "json")
        let teamApiResponseJson = try getApiResourceJson(withPath: path)
        let teamApiResponse = TeamApiResponse(json: teamApiResponseJson)
        XCTAssertNil(teamApiResponse)
    }

    func test_teamApiResponse_withFalseIsNBAFranchise_isZero() throws {
        let path = getPath(forResource: "TeamApiResponseIsNBAFranchiseIsFalse",
                           ofType: "json")
        let teamApiResponseJson = try getApiResourceJson(withPath: path)
        let teamApiResponse = TeamApiResponse(json: teamApiResponseJson)
        XCTAssertEqual(teamApiResponse?.teams.count, 0)
    }

    func test_teamApiResponse_withMissingAttribute_isZero() throws {
        let path = getPath(forResource: "TeamApiResponseMissingAttribute",
                           ofType: "json")
        let teamApiResponseJson = try getApiResourceJson(withPath: path)
        let teamApiResponse = TeamApiResponse(json: teamApiResponseJson)
        XCTAssertNil(teamApiResponse)
    }

    // MARK: PlayerApiResponse

    func test_playerApiResponse_withMissingLeagueDictionary_isNil() throws {
        let path = getPath(forResource: "PlayerApiResponseMissingLeagueDict",
                           ofType: "json")
        let playerApiResponseJson = try getApiResourceJson(withPath: path)
        let playerApiResponse = PlayerApiResponse(json: playerApiResponseJson)
        XCTAssertNil(playerApiResponse)
    }

    func test_playerApiResponse_withMissingStandardDictionary_isNil() throws {
        let path = getPath(forResource: "PlayerApiResponseMissingStandardDict",
                           ofType: "json")
        let playerApiResponseJson = try getApiResourceJson(withPath: path)
        let playerApiResponse = PlayerApiResponse(json: playerApiResponseJson)
        XCTAssertNil(playerApiResponse)
    }

    func test_playerApiResponse_withTwoPlayers_isOne() throws {
        let path = getPath(forResource: "PlayerApiResponseOnePlayer",
                           ofType: "json")
        let playerApiResponseJson = try getApiResourceJson(withPath: path)
        let playerApiResponse = PlayerApiResponse(json: playerApiResponseJson)
        XCTAssertEqual(playerApiResponse?.players.count, 1)
    }

    func test_playerApiResponse_withMissingIsActive_isNil() throws {
        let path = getPath(forResource: "PlayerApiResponseMissingIsActive",
                           ofType: "json")
        let playerApiResponseJson = try getApiResourceJson(withPath: path)
        let playerApiResponse = PlayerApiResponse(json: playerApiResponseJson)
        XCTAssertNil(playerApiResponse)
    }

    func test_playerApiResponse_withFalseIsActive_isZero() throws {
        let path = getPath(forResource: "PlayerApiResponseIsActiveIsFalse",
                           ofType: "json")
        let playerApiResponseJson = try getApiResourceJson(withPath: path)
        let playerApiResponse = PlayerApiResponse(json: playerApiResponseJson)
        XCTAssertEqual(playerApiResponse?.players.count, 0)
    }

    func test_playerApiResponse_withMissingAttribute_isZero() throws {
        let path = getPath(forResource: "PlayerApiResponseMissingAttribute",
                           ofType: "json")
        let playerApiResponseJson = try getApiResourceJson(withPath: path)
        let playerApiResponse = PlayerApiResponse(json: playerApiResponseJson)
        XCTAssertNil(playerApiResponse)
    }

    // MARK: GameScheduleApiResponse

    func test_gameScheduleApiResponse_withMissingResultSetsDictionary_isNil() throws {
        let path = getPath(forResource: "GameScheduleApiResponseMissingResultSets",
                           ofType: "json")
        let gameScheduleApiResponseJson = try getApiResourceJson(withPath: path)
        let gameScheduleApiResponse = GameScheduleApiResponse(json: gameScheduleApiResponseJson)
        XCTAssertNil(gameScheduleApiResponse)
    }

    func test_gameScheduleApiResponse_withMissingCompleteGameListDictionary_isNil() throws {
        let path = getPath(forResource: "GameScheduleApiResponseMissingCompleteGameSet",
                           ofType: "json")
        let gameScheduleApiResponseJson = try getApiResourceJson(withPath: path)
        let gameScheduleApiResponse = GameScheduleApiResponse(json: gameScheduleApiResponseJson)
        XCTAssertNil(gameScheduleApiResponse)
    }

    func test_gameScheduleApiResponse_withSixGames_isSix() throws {
        let path = getPath(forResource: "GameScheduleApiResponse",
                           ofType: "json")
        let gameScheduleApiResponseJson = try getApiResourceJson(withPath: path)
        let gameScheduleApiResponse = GameScheduleApiResponse(json: gameScheduleApiResponseJson)
        XCTAssertEqual(gameScheduleApiResponse?.gameSchedules.count, 6)
    }

    func test_gameScheduleApiResponse_withMissingAttribute_isNil() throws {
        let path = getPath(forResource: "GameScheduleApiResponseMissingAttribute",
                            ofType: "json")
        let gameScheduleApiResponseJson = try getApiResourceJson(withPath: path)
        let gameScheduleApiResponse = GameScheduleApiResponse(json: gameScheduleApiResponseJson)
        XCTAssertNil(gameScheduleApiResponse)
    }

    // MARK: StandingApiResponse

    func test_standingApiResponse_withMissingLeagueDictionary_isNil() throws {
        let path = getPath(forResource: "StandingApiResponseMissingLeague",
                           ofType: "json")
        let gameScheduleApiResponseJson = try getApiResourceJson(withPath: path)
        let gameScheduleApiResponse = GameScheduleApiResponse(json: gameScheduleApiResponseJson)
        XCTAssertNil(gameScheduleApiResponse)
    }

    func test_standingApiResponse_withMissingStandardDictionary_isNil() throws {
        let path = getPath(forResource: "StandingApiResponseMissingStandard",
                           ofType: "json")
        let gameScheduleApiResponseJson = try getApiResourceJson(withPath: path)
        let gameScheduleApiResponse = GameScheduleApiResponse(json: gameScheduleApiResponseJson)
        XCTAssertNil(gameScheduleApiResponse)
    }

    func test_standingApiResponse_withMissingTeamsDictionary_isNil() throws {
        let path = getPath(forResource: "StandingApiResponseMissingTeams",
                           ofType: "json")
        let gameScheduleApiResponseJson = try getApiResourceJson(withPath: path)
        let gameScheduleApiResponse = GameScheduleApiResponse(json: gameScheduleApiResponseJson)
        XCTAssertNil(gameScheduleApiResponse)
    }

    func test_standingApiResponse_withThirtyStandings_isOne() throws {
        let path = getPath(forResource: "StandingApiResponseOneStanding",
                           ofType: "json")
        let standingApiResponseJson = try getApiResourceJson(withPath: path)
        let standingApiResponse = StandingApiResponse(json: standingApiResponseJson)
        XCTAssertEqual(standingApiResponse?.standings.count, 1)
    }

   func test_standingApiResponse_withMissingAttribute_isNil() throws {
        let path = getPath(forResource: "StandingApiResponseMissingAttribute",
                            ofType: "json")
        let standingApiResponseJson = try getApiResourceJson(withPath: path)
        let standingApiResponse = StandingApiResponse(json: standingApiResponseJson)
        XCTAssertNil(standingApiResponse)
    }

    // MARK: LeaderApiResponse

    func test_leaderApiResponse_withMissingLeagueDictionary_isNil() throws {
        let path = getPath(forResource: "LeaderApiResponseMissingLeague",
                           ofType: "json")
        let leaderApiResponseJson = try getApiResourceJson(withPath: path)
        let leaderApiResponse = GameScheduleApiResponse(json: leaderApiResponseJson)
        XCTAssertNil(leaderApiResponse)
    }

    func test_leaderApiResponse_withMissingStandardDictionary_isNil() throws {
        let path = getPath(forResource: "LeaderApiResponseMissingStandard",
                           ofType: "json")
        let leaderApiResponseJson = try getApiResourceJson(withPath: path)
        let leaderApiResponse = GameScheduleApiResponse(json: leaderApiResponseJson)
        XCTAssertNil(leaderApiResponse)
    }

    func test_leaderApiResponse_withTenLeaders_isOne() throws {
        let path = getPath(forResource: "LeaderApiResponseOneLeader",
                           ofType: "json")
        let leaderApiResponseJson = try getApiResourceJson(withPath: path)
        let leaderApiResponse = LeaderApiResponse(json: leaderApiResponseJson)
        XCTAssertEqual(leaderApiResponse?.statLeaders.count, 1)
    }

      func test_leaderApiResponse_withMissingAttribute_isNil() throws {
        let path = getPath(forResource: "LeaderApiResponseMissingAttribute",
                            ofType: "json")
        let leaderApiResponseJson = try getApiResourceJson(withPath: path)
        let leaderApiResponse = StandingApiResponse(json: leaderApiResponseJson)
        XCTAssertNil(leaderApiResponse)
    }

    // MARK: TeamScheduleApiResponse

    func test_teamScheduleApiResponse_withMissingLeagueDictionary_isNil() throws {
        let path = getPath(forResource: "TeamScheduleApiResponseMissingLeague",
                           ofType: "json")
        let teamScheduleApiResponseJson = try getApiResourceJson(withPath: path)
        let teamScheduleApiResponse = TeamScheduleApiResponse(json: teamScheduleApiResponseJson)
        XCTAssertNil(teamScheduleApiResponse)
    }

    func test_teamScheduleApiResponse_withMissingStandardDictionary_isNil() throws {
        let path = getPath(forResource: "TeamScheduleApiResponseMissingStandard",
                           ofType: "json")
        let teamScheduleApiResponseJson = try getApiResourceJson(withPath: path)
        let teamScheduleApiResponse = TeamScheduleApiResponse(json: teamScheduleApiResponseJson)
        XCTAssertNil(teamScheduleApiResponse)
    }

    func test_teamScheduleApiResponse_withTenLeaders_isOne() throws {
        let path = getPath(forResource: "TeamScheduleApiResponseFromTeamScheduleCall",
                           ofType: "json")
        let teamScheduleApiResponseJson = try getApiResourceJson(withPath: path)
        let teamScheduleApiResponse = TeamScheduleApiResponse(json: teamScheduleApiResponseJson)
        XCTAssertEqual(teamScheduleApiResponse?.teamSchedules.count, 1)
    }

      func test_teamScheduleApiResponse_withMissingAttribute_isNil() throws {
        let path = getPath(forResource: "TeamScheduleApiResponseMissingAttribute",
                            ofType: "json")
        let teamScheduleApiResponseJson = try getApiResourceJson(withPath: path)
        let teamScheduleApiResponse = TeamScheduleApiResponse(json: teamScheduleApiResponseJson)
        XCTAssertNil(teamScheduleApiResponse)
    }

    // MARK: CoachApiResponse

    func test_coachApiResponse_withMissingLeagueDictionary_isNil() throws {
        let path = getPath(forResource: "CoachApiResponseMissingLeague",
                           ofType: "json")
        let coachApiResponseJson = try getApiResourceJson(withPath: path)
        let coachApiResponse = CoachApiResponse(json: coachApiResponseJson)
        XCTAssertNil(coachApiResponse)
    }

    func test_coachApiResponse_withMissingStandardDictionary_isNil() throws {
        let path = getPath(forResource: "CoachApiResponseMissingStandard",
                           ofType: "json")
        let coachApiResponseJson = try getApiResourceJson(withPath: path)
        let coachApiResponse = CoachApiResponse(json: coachApiResponseJson)
        XCTAssertNil(coachApiResponse)
    }

    func test_coachApiResponse_withOneCoach_isOne() throws {
        let path = getPath(forResource: "CoachApiResponseOneCoach",
                           ofType: "json")
        let coachApiResponseJson = try getApiResourceJson(withPath: path)
        let coachApiResponse = CoachApiResponse(json: coachApiResponseJson)
        XCTAssertEqual(coachApiResponse?.coaches.count, 1)
    }

    func test_coachApiResponse_withMissingAttribute_isNil() throws {
        let path = getPath(forResource: "CoachApiResponseMissingAttribute",
                            ofType: "json")
        let coachApiResponseJson = try getApiResourceJson(withPath: path)
        let coachApiResponse = CoachApiResponse(json: coachApiResponseJson)
        XCTAssertNil(coachApiResponse)
    }

    // MARK: TeamStatRankingApiResponse

    func test_teamStatRankingApiResponse_withMissingLeagueDictionary_isNil() throws {
        let path = getPath(forResource: "TeamStatRankingApiResponseMissingLeague",
                           ofType: "json")
        let teamStatRankingApiResponseJson = try getApiResourceJson(withPath: path)
        let teamStatRankingApiResponse = CoachApiResponse(json: teamStatRankingApiResponseJson)
        XCTAssertNil(teamStatRankingApiResponse)
    }

    func test_teamStatRankingApiResponse_withMissingStandardDictionary_isNil() throws {
        let path = getPath(forResource: "TeamStatRankingApiResponseMissingStandard",
                           ofType: "json")
        let teamStatRankingApiResponseJson = try getApiResourceJson(withPath: path)
        let teamStatRankingApiResponse = CoachApiResponse(json: teamStatRankingApiResponseJson)
        XCTAssertNil(teamStatRankingApiResponse)
    }

    func test_teamStatRankingApiResponse_withMissingTeamsDictionary_isNil() throws {
        let path = getPath(forResource: "TeamStatRankingApiResponseMissingTeams",
                           ofType: "json")
        let teamStatRankingApiResponseJson = try getApiResourceJson(withPath: path)
        let teamStatRankingApiResponse = CoachApiResponse(json: teamStatRankingApiResponseJson)
        XCTAssertNil(teamStatRankingApiResponse)
    }

    func test_teamStatRankingApiResponse_withOneTeamStatRanking_isOne() throws {
        let path = getPath(forResource: "TeamStatRankingApiResponseOneTeamRanking",
                           ofType: "json")
        let teamStatRankingApiResponseJson = try getApiResourceJson(withPath: path)
        let teamStatRankingApiResponse = TeamStatRankingApiResponse(json: teamStatRankingApiResponseJson)
        XCTAssertEqual(teamStatRankingApiResponse?.teamStatRankings.count, 1)
    }

    func test_teamStatRankingApiResponse_withMissingAttribute_isNil() throws {
        let path = getPath(forResource: "TeamStatRankingApiResponseMissingAttribute",
                            ofType: "json")
        let teamStatRankingApiResponseJson = try getApiResourceJson(withPath: path)
        let teamStatRankingApiResponse = TeamStatRankingApiResponse(json: teamStatRankingApiResponseJson)
        XCTAssertNil(teamStatRankingApiResponse)
    }
}
