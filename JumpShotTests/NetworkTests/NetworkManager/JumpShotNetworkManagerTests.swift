//
//  JumpShotNetworkManagerTests.swift
//  JumpShotTests
//
//  Created by Jerel Rocktaschel on 3/29/21.
//

import XCTest
@testable import JumpShot

class JumpShotNetworkTests: XCTestCase {

    let networkManager = JumpShotNetworkManager.shared

    func test_jumpShotNetworkManagerResources_withUrlDateformat_isCorrectValue() {
        XCTAssertEqual(JumpShotNetworkManagerResources.urlDateformat, "MM/dd/yyyy")
    }

    func test_jumpShotNetworkManagerResources_withSeasonStartMonthAndDay_isCorrectValue() {
        XCTAssertEqual(JumpShotNetworkManagerResources.seasonStartMonthAndDay, "12/01/")
    }
    func test_jumpShotNetworkManagerErrorDescription_withNetworkConnectivityError_isCorrectValue() {
        XCTAssertEqual(JumpShotNetworkManagerErrorDescription.networkConnectivityError, "The network is unavailable.")
    }

    func test_jumpShotNetworkManagerErrorDescription_withNoDataError_isCorrectValue() {
        XCTAssertEqual(JumpShotNetworkManagerErrorDescription.noDataError, "No NBA data was returned.")
    }

    func test_jumpShotNetworkManagerErrorDescription_withUnableToDecodeError_isCorrectValue() {
        XCTAssertEqual(JumpShotNetworkManagerErrorDescription.unableToDecodeError,
                       "The source data could not be decoded.")
    }

    func test_jumpShotNetworkManagerErrorDescription_withAuthenticationError_isCorrectValue() {
        XCTAssertEqual(JumpShotNetworkManagerErrorDescription.authenticationError, "An authentication error occurred.")
    }

    func test_jumpShotNetworkManagerErrorDescription_withBadRequestError_isCorrectValue() {
        XCTAssertEqual(JumpShotNetworkManagerErrorDescription.badRequestError, "A bad request was made.")
    }

    func test_jumpShotNetworkManagerErrorDescription_withOutdatedRequestError_isCorrectValue() {
        XCTAssertEqual(JumpShotNetworkManagerErrorDescription.outdatedRequestError, "The request is outdated.")
    }

    func test_jumpShotNetworkManagerErrorDescription_withFailedRequestError_isCorrectValue() {
        XCTAssertEqual(JumpShotNetworkManagerErrorDescription.failedRequestError, "The request failed.")
    }

    func test_jumpShotNetworkManagerErrorDescription_withEncodingError_isCorrectValue() {
        XCTAssertEqual(JumpShotNetworkManagerErrorDescription.encodingError, "The encoding failed with this request.")
    }

    func test_jumpShotNetworkManager_withNetworkResponse_is200() {
        let response = HTTPURLResponse(url: URL(string: "https://www.nba.com")!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)!

        let resultResponse = networkManager.handleNetworkResponse(response)
        guard case .success(nil) = resultResponse else {
            return XCTFail("Expected a result of success but got a failure with \(resultResponse)")
        }
    }

    func test_jumpShotNetworkManager_withNetworkResponse_is500() {
        let response = HTTPURLResponse(url: URL(string: "https://www.nba.com")!,
                                       statusCode: 500,
                                       httpVersion: nil,
                                       headerFields: nil)!

        let resultResponse = networkManager.handleNetworkResponse(response)
        guard case .failure(let error) = resultResponse else {
            return XCTFail("Expected a result of failure but got a success with \(resultResponse)")
        }

        XCTAssertEqual(error.errorDescription, "An authentication error occurred.")
    }

    func test_jumpShotNetworkManager_withNetworkResponse_is501() {
        let response = HTTPURLResponse(url: URL(string: "https://www.nba.com")!,
                                       statusCode: 501,
                                       httpVersion: nil,
                                       headerFields: nil)!

        let resultResponse = networkManager.handleNetworkResponse(response)
        guard case .failure(let error) = resultResponse else {
            return XCTFail("Expected a result of failure but got a success with \(resultResponse)")
        }

        XCTAssertEqual(error.errorDescription, "A bad request was made.")
    }

    func test_jumpShotNetworkManager_withNetworkResponse_is600() {
        let response = HTTPURLResponse(url: URL(string: "https://www.nba.com")!,
                                       statusCode: 600,
                                       httpVersion: nil,
                                       headerFields: nil)!

        let resultResponse = networkManager.handleNetworkResponse(response)
        guard case .failure(let error) = resultResponse else {
            return XCTFail("Expected a result of failure but got a success with \(resultResponse)")
        }

        XCTAssertEqual(error.errorDescription, "The request is outdated.")
    }

    func test_jumpShotNetworkManager_withNetworkResponse_is800() {
        let response = HTTPURLResponse(url: URL(string: "https://www.nba.com")!,
                                       statusCode: 800,
                                       httpVersion: nil,
                                       headerFields: nil)!

        let resultResponse = networkManager.handleNetworkResponse(response)
        guard case .failure(let error) = resultResponse else {
            return XCTFail("Expected a result of failure but got a success with \(resultResponse)")
        }

        XCTAssertEqual(error.errorDescription, "The request failed.")
    }
}
