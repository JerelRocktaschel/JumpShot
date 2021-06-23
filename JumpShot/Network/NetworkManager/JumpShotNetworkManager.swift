//
//  JumpShotNetworkManager.swift
//  JumpShot
//
//  Copyright (c) 2021 Jerel Rocktaschel
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

// MARK: Typealias

typealias JSONDictionary = [String: Any]

// MARK: Result

enum Result<T> {
    case success(T?)
    case failure(LocalizedError)
}

// MARK: Network Manager Resources

enum JumpShotNetworkManagerResources {
    /// should be set to before 1st game of season
    public static var seasonStartMonthAndDay: String { return "12/01/" }
}

// MARK: Network Manager Error Conditions

enum JumpShotNetworkManagerError: Error {
    case networkConnectivityError
    case noDataError
    case unableToDecodeError
    case authenticationError
    case badRequestError
    case outdatedRequestError
    case failedRequestError
    case incorrectStartYearError
}

enum JumpShotNetworkManagerErrorDescription {
    public static var networkConnectivityError: String { return "The network is unavailable." }
    public static var noDataError: String { return "No NBA data was returned." }
    public static var unableToDecodeError: String { return "The source data could not be decoded." }
    public static var authenticationError: String { return "An authentication error occurred." }
    public static var badRequestError: String { return "A bad request was made." }
    public static var outdatedRequestError: String { return "The request is outdated." }
    public static var failedRequestError: String { return "The request failed." }
    public static var encodingError: String { return "The encoding failed with this request." }
    public static var incorrectStartYearError: String { return "The start year is before 1946 or after the current season." }
}

extension JumpShotNetworkManagerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .networkConnectivityError:
            return JumpShotNetworkManagerErrorDescription.networkConnectivityError
        case .noDataError:
            return JumpShotNetworkManagerErrorDescription.noDataError
        case .unableToDecodeError:
            return JumpShotNetworkManagerErrorDescription.unableToDecodeError
        case .authenticationError:
            return JumpShotNetworkManagerErrorDescription.authenticationError
        case .badRequestError:
            return JumpShotNetworkManagerErrorDescription.badRequestError
        case .outdatedRequestError:
            return JumpShotNetworkManagerErrorDescription.outdatedRequestError
        case .failedRequestError:
            return JumpShotNetworkManagerErrorDescription.failedRequestError
        case .incorrectStartYearError:
            return JumpShotNetworkManagerErrorDescription.incorrectStartYearError
        }
    }
}

struct JumpShotNetworkManager {

    // MARK: Properties

    static let shared = JumpShotNetworkManager()
    var router = Router<JumpShotApiEndPoint>()

    // MARK: Helpers

    public func handleNetworkResponse (_ response: HTTPURLResponse) -> Result<LocalizedError> {
        switch response.statusCode {
        case 200...299: return .success(nil)
        case 401...500: return .failure(JumpShotNetworkManagerError.authenticationError)
        case 501...599: return .failure(JumpShotNetworkManagerError.badRequestError)
        case 600: return .failure(JumpShotNetworkManagerError.outdatedRequestError)
        default: return .failure(JumpShotNetworkManagerError.failedRequestError)
        }
    }
}
