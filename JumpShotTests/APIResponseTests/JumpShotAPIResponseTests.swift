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
}
