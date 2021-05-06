//
//  Coach.swift
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

public struct Coach {

    // MARK: Internal Properties

    let firstName: String
    let lastName: String
    let isAssistant: Bool
    let personId: String
    let teamId: String
    let college: String

    public init(from decoder: Decoder) throws {
        let coachContainer = try decoder.container(keyedBy: CoachCodingKeys.self)
        firstName = try coachContainer.decode(String.self, forKey: .firstName)
        lastName = try coachContainer.decode(String.self, forKey: .lastName)
        isAssistant = try coachContainer.decode(Bool.self, forKey: .isAssistant)
        personId = try coachContainer.decode(String.self, forKey: .personId)
        teamId = try coachContainer.decode(String.self, forKey: .teamId)
        college = try coachContainer.decode(String.self, forKey: .college)
    }
}

extension Coach: Decodable {

    // MARK: Coding Keys

    enum CoachCodingKeys: String, CodingKey {
        case firstName
        case lastName
        case isAssistant
        case personId
        case teamId
        case college
    }
}

struct CoachApiResponse {

    // MARK: Internal Properties

    var coaches: [Coach]
}

extension CoachApiResponse {

    // MARK: Init

    init?(json: [String: Any]) {

        guard let leagueDictionary = json["league"] as? JSONDictionary else {
            return nil
        }

        guard let standardDictionary = leagueDictionary["standard"] as? [JSONDictionary] else {
            return nil
        }

        self.coaches = [Coach]()
        for coachDictionary in standardDictionary {
            guard let jsonCoachData = try? JSONSerialization.data(withJSONObject: coachDictionary,
                                                                             options: []) else {
                    return nil
            }

            do {
                let coach = try JSONDecoder().decode(Coach.self, from: jsonCoachData)
                self.coaches.append(coach)
            } catch {
                return nil
            }
        }
    }
}
