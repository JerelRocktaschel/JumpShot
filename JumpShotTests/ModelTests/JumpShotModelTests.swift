//
//  JumpShotModelTests.swift
//  JumpShotTests
//
//  Created by Jerel Rocktaschel on 3/29/21.
//

import XCTest
@testable import JumpShot

class JumpShotModelTests: XCTestCase {

    // MARK: TeamModel

    func test_teamModel_withCompleteData_isSuccessful() throws {
        let path = getPath(forResource: "TeamModel",
                               ofType: "json")
        let teamModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        let teamModelResponse = try JSONDecoder().decode(Team.self, from: teamModelData)
        XCTAssertEqual(teamModelResponse.isAllStar, false)
        XCTAssertEqual(teamModelResponse.city, "Boston")
        XCTAssertEqual(teamModelResponse.altCityName, "Boston")
        XCTAssertEqual(teamModelResponse.fullName, "Boston Celtics")
        XCTAssertEqual(teamModelResponse.abbreviation, "BOS")
        XCTAssertEqual(teamModelResponse.teamId, "1610612738")
        XCTAssertEqual(teamModelResponse.name, "Celtics")
        XCTAssertEqual(teamModelResponse.urlName, "celtics")
        XCTAssertEqual(teamModelResponse.shortName, "Boston")
        XCTAssertEqual(teamModelResponse.conference, "East")
        XCTAssertEqual(teamModelResponse.division, "Atlantic")
    }

    func test_teamModel_withBadData_isNil() throws {
        let path = getPath(forResource: "TeamModelBadDataFormat",
                               ofType: "json")
        let teamModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var teamModelResponse: Team?

        do {
            teamModelResponse = try JSONDecoder().decode(Team.self, from: teamModelData)
        } catch {
            teamModelResponse = nil
        }
        XCTAssertNil(teamModelResponse)
    }

     func test_teamModel_withMissingData_isNil() throws {
        let path = getPath(forResource: "TeamModelMissingDataFormat",
                               ofType: "json")
        let teamModelData = try Data(contentsOf: URL(fileURLWithPath: path))
        var teamModelResponse: Team?

        do {
            teamModelResponse = try JSONDecoder().decode(Team.self, from: teamModelData)
        } catch {
            teamModelResponse = nil
        }
        XCTAssertNil(teamModelResponse)
     }
}
