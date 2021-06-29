//
//  MediaNames.swift
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

public struct MediaNames {
    let shortName: String
    let longName: String

    public init(from decoder: Decoder) throws {
        let mediaNamesCodingKeysContainer = try decoder.container(keyedBy: MediaNamesCodingKeys.self)
        shortName = try mediaNamesCodingKeysContainer.decode(String.self, forKey: .shortName)
        longName = try mediaNamesCodingKeysContainer.decode(String.self, forKey: .longName)
    }
}

extension MediaNames: Equatable {

    // MARK: Equatable

    public static func == (lhs: MediaNames, rhs: MediaNames) -> Bool {
        return lhs.shortName == rhs.shortName && lhs.longName == rhs.longName
    }
}

extension MediaNames: Comparable {

    // MARK: Comparable

    public static func < (lhs: MediaNames, rhs: MediaNames) -> Bool {
        return lhs.shortName < rhs.shortName
    }
}

extension MediaNames: Decodable {

    // MARK: Coding Keys

    enum MediaNamesCodingKeys: String, CodingKey {
        case shortName
        case longName
    }
}
