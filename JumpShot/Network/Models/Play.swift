//
//  Play.swift
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

public struct Play {

    // MARK: Internal Properties

    let clock: String
    let eventMsgType: String
    let description: String
    let playerId: String
    let teamId: String
    let vTeamScore: Int
    let hTeamScore: Int
    let isScoreChange: Bool
    let formattedDescription: String

    public init(from decoder: Decoder) throws {

        // MARK: Init

        let playContainer = try decoder.container(keyedBy: PlayCodingKeys.self)
        let vTeamScoreString = try playContainer.decode(String.self, forKey: .vTeamScore)
        let hTeamScoreString = try playContainer.decode(String.self, forKey: .hTeamScore)
        let formatted = try playContainer.decode([String: String].self, forKey: .formatted)
        clock = try playContainer.decode(String.self, forKey: .clock)
        eventMsgType = try playContainer.decode(String.self, forKey: .eventMsgType)
        description = try playContainer.decode(String.self, forKey: .description)
        playerId = try playContainer.decode(String.self, forKey: .personId)
        teamId = try playContainer.decode(String.self, forKey: .teamId)
        isScoreChange = try playContainer.decode(Bool.self, forKey: .isScoreChange)

        if let vTeamScoreInt = Int(vTeamScoreString),
           let hTeamScoreInt = Int(hTeamScoreString),
           let description = formatted["description"] {
            vTeamScore = vTeamScoreInt
            hTeamScore = hTeamScoreInt
            formattedDescription = description
        } else {
            throw JumpShotNetworkManagerError.unableToDecodeError
        }
    }
}

extension Play: Decodable {

    // MARK: Coding Keys

    enum PlayCodingKeys: String, CodingKey {
        case clock
        case eventMsgType
        case description
        case personId
        case teamId
        case vTeamScore
        case hTeamScore
        case isScoreChange
        case formatted
        case formattedDescription
    }
}

struct PlayApiResponse {

    // MARK: Internal Properties

    var plays: [Play]
}

extension PlayApiResponse {

    // MARK: Init

    init?(json: [String: Any]) {

        guard let playDictionaries = json["plays"] as? [JSONDictionary] else {
            return nil
        }

        self.plays = [Play]()
        for playDictionary in playDictionaries {
            do {
                guard let jsonPlayData = try? JSONSerialization.data(withJSONObject: playDictionary,
                                                                                 options: []) else {
                        return nil
                }

                let play = try JSONDecoder().decode(Play.self, from: jsonPlayData)
                self.plays.append(play)
            } catch {
                return nil
            }
        }
    }
}
