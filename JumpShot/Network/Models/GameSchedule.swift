//
//  GameSchedule.swift
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

public struct GameSchedule {

    // MARK: Internal Properties

    let gameId: String
    let visitorCity: String
    let visitorNickName: String
    let visitorShortName: String
    let visitorAbbreviation: String
    let homeCity: String
    let homeNickName: String
    let homeShortName: String
    let homeAbbreviation: String
    var gameDate: Date?
    let gameDay: String
    let broadcastId: String
    let broadcasterName: String
    let tapeDelayComments: String

    // MARK: Init

    public init(from decoder: Decoder) throws {
        let gameScheduleContainer = try decoder.container(keyedBy: GameScheduleCodingKeys.self)
        let dateString = try gameScheduleContainer.decode(String.self, forKey: .date)
        let timeString = try gameScheduleContainer.decode(String.self, forKey: .time)
        gameId = try gameScheduleContainer.decode(String.self, forKey: .gameId)
        visitorCity = try gameScheduleContainer.decode(String.self, forKey: .visitorCity)
        visitorNickName = try gameScheduleContainer.decode(String.self, forKey: .visitorNickName)
        visitorShortName = try gameScheduleContainer.decode(String.self, forKey: .visitorShortName)
        visitorAbbreviation = try gameScheduleContainer.decode(String.self, forKey: .visitorAbbreviation)
        homeCity = try gameScheduleContainer.decode(String.self, forKey: .homeCity)
        homeNickName = try gameScheduleContainer.decode(String.self, forKey: .homeNickName)
        homeShortName = try gameScheduleContainer.decode(String.self, forKey: .homeShortName)
        homeAbbreviation = try gameScheduleContainer.decode(String.self, forKey: .homeAbbreviation)

        if let gameFormattedDate = (dateString + " " + timeString).getGameDate() {
            gameDate = gameFormattedDate
        }

        gameDay = try gameScheduleContainer.decode(String.self, forKey: .gameDay)
        broadcastId = try gameScheduleContainer.decode(String.self, forKey: .broadcastId)
        broadcasterName = try gameScheduleContainer.decode(String.self, forKey: .broadcasterName)
        tapeDelayComments = try gameScheduleContainer.decode(String.self, forKey: .tapeDelayComments)
    }
}

extension GameSchedule: Decodable {

    // MARK: Coding Keys

    enum GameScheduleCodingKeys: String, CodingKey {
        case gameId = "gameID"
        case visitorCity = "vtCity"
        case visitorNickName = "vtNickName"
        case visitorShortName = "vtShortName"
        case visitorAbbreviation = "vtAbbreviation"
        case homeCity = "htCity"
        case homeNickName = "htNickName"
        case homeShortName = "htShortName"
        case homeAbbreviation = "htAbbreviation"
        case date = "date"
        case time = "time"
        case gameDay = "day"
        case broadcastId = "broadcastID"
        case broadcasterName = "broadcasterName"
        case tapeDelayComments = "tapeDelayComments"
    }
}

struct GameScheduleApiResponse {

    // MARK: Internal Properties

    var gameSchedules: [GameSchedule]
}

extension GameScheduleApiResponse {

    // MARK: Init

    init?(json: [String: Any]) {

        guard let resultSetsDictionaryArray = json["resultSets"] as? [JSONDictionary] else {
            return nil
        }

        var completeGameListDictionary = [JSONDictionary]()
        for resultSetsDictionary in resultSetsDictionaryArray {
            if let completeGamesResultsDictionary = resultSetsDictionary["CompleteGameList"] as? [JSONDictionary] {
                completeGameListDictionary = completeGamesResultsDictionary
            } else {
                continue
            }
        }

        if completeGameListDictionary.count == 0 {
            return nil
        }

        self.gameSchedules = [GameSchedule]()
        for gameScheduleDictionary in completeGameListDictionary {
            guard let jsonGameScheduleData = try? JSONSerialization.data(withJSONObject: gameScheduleDictionary,
                                                                         options: []) else {
                return nil
            }

            do {
                print(json)
                let gameSchedule = try JSONDecoder().decode(GameSchedule.self, from: jsonGameScheduleData)
                self.gameSchedules.append(gameSchedule)
            } catch {
                return nil
            }
        }
    }
}
