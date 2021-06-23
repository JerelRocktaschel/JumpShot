//
//  PlayerStatsSummary.swift
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

public struct PlayerStatsSummary {
    let careerStatsSummary: PlayerStats
    let currentSeasonStatsSummary: PlayerStats
    let playerTeamStatsSeasons: [PlayerTeamStatsSeason]
}

extension PlayerStatsSummary: Equatable {

    // MARK: Equatable

    public static func == (lhs: PlayerStatsSummary, rhs: PlayerStatsSummary) -> Bool {
        return lhs.careerStatsSummary == rhs.careerStatsSummary &&
            lhs.currentSeasonStatsSummary == rhs.currentSeasonStatsSummary &&
            lhs.playerTeamStatsSeasons == rhs.playerTeamStatsSeasons
    }
}

public struct PlayerStatsSummaryApiResponse {

    // MARK: Internal Properties

    var playerStatsSummary: PlayerStatsSummary?
}

public extension PlayerStatsSummaryApiResponse {

    // MARK: Init

    init?(json: [String: Any]) {

        guard let leagueDictionary = json["league"] as? JSONDictionary else {
            return nil
        }

        guard let standardDictionary = leagueDictionary["standard"] as? JSONDictionary else {
            return nil
        }

        guard let statsDictionary = standardDictionary["stats"] as? JSONDictionary else {
            return nil
        }

        guard let latestDictionary = statsDictionary["latest"] as? JSONDictionary else {
            return nil
        }

        guard let careerSummaryDictionary = statsDictionary["careerSummary"] as? JSONDictionary else {
            return nil
        }

        guard let regularSeasonDictionary = statsDictionary["regularSeason"] as? JSONDictionary else {
            return nil
        }

        guard let seasonDictionaries = regularSeasonDictionary["season"] as? [JSONDictionary] else {
            return nil
        }

        var playerTeamStatsSeasonList = [PlayerTeamStatsSeason]()
        var playerTeamStatsList = [PlayerTeamStats]()
        var seasonYear: Int
        for seasonDictionary in seasonDictionaries {
            seasonYear = (seasonDictionary["seasonYear"] as? Int)!

            guard let teamDictionaries = seasonDictionary["teams"] as? [JSONDictionary] else {
                return nil
            }

            playerTeamStatsList.removeAll()
            for teamDictionary in teamDictionaries {
                let teamId = teamDictionary["teamId"] as? String
                do {
                    guard let teamData = try? JSONSerialization.data(withJSONObject: teamDictionary,
                                                                                  options: []) else {
                         return nil
                    }

                    let teamPlayerStats = try JSONDecoder().decode(PlayerStats.self, from: teamData)
                    let playerTeamStats = PlayerTeamStats(teamId: teamId!, playerStats: teamPlayerStats)
                    playerTeamStatsList.append(playerTeamStats)
                } catch {
                    return nil
                }
            }

            guard let totalDictionary = seasonDictionary["total"] as? JSONDictionary else {
                return nil
            }

            do {

                guard let totalData = try? JSONSerialization.data(withJSONObject: totalDictionary,
                                                                              options: []) else {
                     return nil
                }

                let totalSeasonPlayerStats = try JSONDecoder().decode(PlayerStats.self, from: totalData)
                let playerTeamStatsSeason = PlayerTeamStatsSeason(seasonYear: seasonYear,
                                                                  playerStatTeams: playerTeamStatsList,
                                                                  seasonTotalStats: totalSeasonPlayerStats)
                playerTeamStatsSeasonList.append(playerTeamStatsSeason)
            } catch {
                return nil
            }
        }

        do {
            guard let latestData = try? JSONSerialization.data(withJSONObject: latestDictionary,
                                                                             options: []) else {
                    return nil
            }

            guard let careerData = try? JSONSerialization.data(withJSONObject: careerSummaryDictionary,
                                                           options: []) else {
                    return nil
            }

            let latestPlayerStats = try JSONDecoder().decode(PlayerStats.self, from: latestData)
            let careerPlayerStats = try JSONDecoder().decode(PlayerStats.self, from: careerData)

            let playerStatsSummary = PlayerStatsSummary(careerStatsSummary: careerPlayerStats,
                                                        currentSeasonStatsSummary: latestPlayerStats,
                                                        playerTeamStatsSeasons: playerTeamStatsSeasonList)
            self.playerStatsSummary = playerStatsSummary
        } catch {
            return nil
        }
    }
}
