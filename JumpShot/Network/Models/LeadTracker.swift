//
//  LeadTracker.swift
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

public struct LeadTracker {

    // MARK: Internal Properties

    let clock: String
    let leadTeamId: String
    let points: Int

    public init(from decoder: Decoder) throws {

        // MARK: Init

        let leadTrackerCodingKeysContainer = try decoder.container(keyedBy: LeadTrackerCodingKeys.self)
        let pointsString = try leadTrackerCodingKeysContainer.decode(String.self, forKey: .points)
        clock = try leadTrackerCodingKeysContainer.decode(String.self, forKey: .clock)
        leadTeamId = try leadTrackerCodingKeysContainer.decode(String.self, forKey: .leadTeamId)

        if let pointsInt = Int(pointsString) {
            points = pointsInt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .points,
                                                   in: leadTrackerCodingKeysContainer,
                                                   debugDescription: "Formatted points not in expected format.")
        }
    }
}

extension LeadTracker: Decodable {

    // MARK: Coding Keys

    enum LeadTrackerCodingKeys: String, CodingKey {
        case clock
        case leadTeamId
        case points
    }
}

struct LeadTrackerApiResponse {

    // MARK: Internal Properties

    var leadTrackers: [LeadTracker]
}

extension LeadTrackerApiResponse {

    // MARK: Init

    init?(json: [String: Any]) {

        guard let leadTrackerDictionaries = json["plays"] as? [JSONDictionary] else {
            return nil
        }

        self.leadTrackers = [LeadTracker]()
        for leadTrackerDictionary in leadTrackerDictionaries {
            do {
                guard let jsonLeadTrackerData = try? JSONSerialization.data(withJSONObject: leadTrackerDictionary,
                                                                                 options: []) else {
                        return nil
                }

                let leadTracker = try JSONDecoder().decode(LeadTracker.self, from: jsonLeadTrackerData)
                self.leadTrackers.append(leadTracker)
            } catch {
                return nil
            }
        }
    }
}
