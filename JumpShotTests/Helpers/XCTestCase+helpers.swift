//
//  XCTestCase+helpers.swift
//  JumpShotTests
//
//  Created by Jerel Rocktaschel on 3/30/21.
//

// swiftlint:disable all

import Foundation
import XCTest
import UIKit

public extension XCTestCase {

    // MARK: Helpers

    func getPath(forResource: String, ofType: String) -> String {
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: forResource,
                                         ofType: ofType)
            else { fatalError("Can't find " + forResource + " resource file") }
        return path
    }

    func getApiResourceJson(withPath: String) throws -> [String: Any] {
        let apiResponseData = try Data(contentsOf: URL(fileURLWithPath: withPath))
        let apiResponseJson = try JSONSerialization.jsonObject(with: apiResponseData,
                                                                   options: []) as? [String: Any]
        return apiResponseJson!
    }

    func response(statusCode: Int) -> HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "http://PLACEHODLER")!,
                        statusCode: statusCode,
                        httpVersion: nil,
                        headerFields: nil)
    }

    enum TestError: Error {
        case testError
    }

    // MARK: JSON

    func badJsonData() -> Data {
        """
        {{{}
        """.data(using: .utf8)!
    }
}


