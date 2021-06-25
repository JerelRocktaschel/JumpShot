//
//  JumpShotGetCoaches.swift
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
        Returns an array of TeamStatRanking model objects for the regular season
     
        URL called:  data.nba.com/prod/v1/2020/team_stats_rankings.json
   
        - Parameter completion: The callback after retrieval.
        - Parameter teamStatRankings: An array of Coach model objects.
        - Parameter error: Error should one occur.
        - Returns: An array of TeamStatRanking model objects or error.
            
        # Notes: #
        1. Handle [TeamStatRanking] return due to being optional.
     */

    typealias GetTeamStatRankingsCompletion = (_ teamStatRankings: [TeamStatRanking]?,
                                               _ error: LocalizedError?) -> Void
    
    func getTeamStatRankings(completion: @escaping GetTeamStatRankingsCompletion) {
        let season = Date().getSeasonYear()
        JumpShotNetworkManager.shared.router.request(.teamStatRankingList(season: season)) { data, response, error in
            var dataResponse: (json: [String: Any]?, error: LocalizedError?)
            dataResponse = self.handleDataResponse(data: data, response: response, error: error)
            if let json = dataResponse.json {
                guard let apiResponse = TeamStatRankingApiResponse(json: json) else {
                    completion(nil, JumpShotNetworkManagerError.unableToDecodeError)
                    return
                }
                completion(apiResponse.teamStatRankings, nil)
            } else {
                completion(nil, dataResponse.error)
            }
        }
    }
}
