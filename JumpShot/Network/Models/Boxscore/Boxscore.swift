//
//  Boxscore.swift
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

public struct Boxscore {

    // MARK: Internal Properties

    let basicGameData: BasicGameData
    let boxscoreStats: BoxscoreStats
}

struct BoxscoreApiResponse {

    // MARK: Internal Properties

    var boxscore: Boxscore
}

extension BoxscoreApiResponse {

    // MARK: Init

    init?(json: [String: Any]) {

        guard let basicGameDataDictionary = json["basicGameData"] as? JSONDictionary else {
            return nil
        }

        guard let gameStatsDictionary = json["stats"] as? JSONDictionary else {
            return nil
        }

        var basicGameData: BasicGameData
        do {
            guard let jsonBoxscoreData = try? JSONSerialization.data(withJSONObject: basicGameDataDictionary,
                                                                     options: []) else {
                    return nil
            }

            let basicGameDataDecoded = try JSONDecoder().decode(BasicGameData.self, from: jsonBoxscoreData)
            basicGameData = basicGameDataDecoded
            } catch {
                return nil
        }

        var boxscoreStats: BoxscoreStats
        do {
            guard let jsonBoxscoreStatsData = try? JSONSerialization.data(withJSONObject: gameStatsDictionary,
                                                                     options: []) else {
                    return nil
            }

            let boxscoreStatsDataDecoded = try JSONDecoder().decode(BoxscoreStats.self, from: jsonBoxscoreStatsData)
            boxscoreStats = boxscoreStatsDataDecoded
            } catch {
                return nil
        }

        
        self.boxscore = Boxscore(basicGameData: basicGameData, boxscoreStats: boxscoreStats)
    }
}
