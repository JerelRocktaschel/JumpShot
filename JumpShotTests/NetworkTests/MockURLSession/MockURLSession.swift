//
//  MockURLSession.swift
//  JumpShotTests
//
//  Created by Jerel Rocktaschel on 2/8/21.
//

import Foundation
import XCTest
@testable import JumpShot

class MockURLSession: URLSessionProtocol {
    var dataTaskCallCount = 0
    var dataTaskArgsRequest: [URLRequest] = []
    var dataTaskArgsCompletionHandler: [(Data?, URLResponse?, Error?) -> Void] = []

    func dataTask(
            with request: URLRequest,
            completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        dataTaskCallCount += 1
        dataTaskArgsRequest.append(request)
        dataTaskArgsCompletionHandler.append(completionHandler)
        return DummyURLSessionDataTask()
    }

    func verifyDataTask(with request: URLRequest, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(dataTaskCallCount,
                       1,
                       "call count",
                       file: file,
                       line: line)
        XCTAssertEqual(dataTaskArgsRequest.first?.debugDescription,
                       request.debugDescription,
                       "request",
                       file: file,
                       line: line)
    }
}

private class DummyURLSessionDataTask: URLSessionDataTask {
    override init() {}
    override func resume() {}
}
