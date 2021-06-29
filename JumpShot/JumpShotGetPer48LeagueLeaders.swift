//
//  JumpShotGetPer48LeagueLeaders.swift
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

public extension JumpShot {

    /**
        Returns an array of PerLeagueLeader model objects for the season, category and season type passed
     
        URL called: stats.nba.com/stats/leagueLeaders?LeagueID=00&PerMode=PerGame&Scope=S&Season=BASEYEAR-SECONDYEAR&SeasonType=SEASON_TYPE&StatCategory=CATEGORY
   
        - Parameter season: Year for when season began - year 2020 = season 2020-21.  Default to current season.
        - Parameter seasonType: LeagueLeaders.SeasonType
        - Parameter category: LeagueLeader.PerGameStatCategory
        - Parameter completion: The callback after retrieval.
        - Parameter perLeagueLeaders: An array of PerLeagueLeader objects.
        - Parameter error: Error should one occur.
        - Returns: An array of PerLeagueLeader model objects or error.
            
        # Notes: #
        1. Handle perGameLeagueLeaders return due to being optional.
     */

    typealias Per48LeagueLeadersCompletion = (_ perLeagueLeaders: [Per48LeagueLeader]?,
                                              _ error: LocalizedError?) -> Void

     func getPer48LeagueLeaders(for seasonStartYear: Int = Date().getSeasonYearInt(),
                                with seasonType: LeagueLeaders.SeasonType,
                                and category: LeagueLeaders.Per48StatCategory,
                                completion: @escaping Per48LeagueLeadersCompletion) {
        let currentSeasonStartYear = Date().getSeasonYearInt()
        guard seasonStartYear > 1946 && seasonStartYear <= currentSeasonStartYear else {
            completion(nil, JumpShotNetworkManagerError.incorrectStartYearError)
            return
        }

        let seasonString = String(seasonStartYear) + "-" + String(seasonStartYear+1)[2...]

        JumpShotNetworkManager.shared.router.request(.leagueLeadersList(perMode: .per48,
                                                                        season: seasonString,
                                                                        seasonType: seasonType,
                                                                        category: category.rawValue)) { data, response, error in
            var dataResponse: (json: [String: Any]?, error: LocalizedError?)
            dataResponse = self.handleDataResponse(data: data, response: response, error: error)
            if let json = dataResponse.json {
                guard let apiResponse = Per48LeagueLeaderApiResponse(json: json) else {
                    completion(nil, JumpShotNetworkManagerError.unableToDecodeError)
                    return
                }
                completion(apiResponse.per48LeagueLeaders, nil)
            } else {
                completion(nil, dataResponse.error)
            }
        }
    }
}
