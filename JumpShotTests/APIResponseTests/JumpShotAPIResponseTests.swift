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
        let path = getPath(forResource: "TeamApiResponse",
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

    func test_playerApiResponse_withTwoPlayers_isTwo() throws {
        let path = getPath(forResource: "PlayerApiResponse",
                           ofType: "json")
        let playerApiResponseJson = try getApiResourceJson(withPath: path)
        let playerApiResponse = PlayerApiResponse(json: playerApiResponseJson)
        XCTAssertEqual(playerApiResponse?.players.count, 2)
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
}
