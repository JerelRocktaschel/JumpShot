//
//  JumpShotGetPlayerStats.swift
//  JumpShot
//
//  Created by Jerel Rocktaschel on 5/10/21.
//

import Foundation

public extension JumpShot {
    /**
        Returns a PlayerStatSummary for the player queried
     
        URL called:  data.nba.com/prod/v1/2020/players/2544_profile.json
   
        - Parameter playerId: The callback after retrieval.
        - Parameter completion: The callback after retrieval.
        - Parameter teamStatRankings: An array of Coach model objects.
        - Parameter error: Error should one occur.
        - Returns: An array of TeamStatRanking model objects or error.
            
        # Notes: #
        1. Handle PlayerStatSummary return due to being optional.
     */
    func getGetPlayerStatsSummary(for playerId: String, completion: @escaping (_ playerStatsSummary: PlayerStatsSummary?, _ error: LocalizedError?) -> Void) {
        let season = Date().getSeasonYear()
        JumpShotNetworkManager.shared.router.request(.playerStatsSummary(season: season, playerId: playerId)) { data, response, error in
            guard error == nil else {
                completion(nil, JumpShotNetworkManagerError.networkConnectivityError)
                return
            }

            if let response = response as? HTTPURLResponse {
                let result = JumpShotNetworkManager.shared.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, JumpShotNetworkManagerError.noDataError)
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                        guard let apiResponse = PlayerStatsSummaryApiResponse(json: json!) else {
                            completion(nil, JumpShotNetworkManagerError.unableToDecodeError)
                            return
                        }
                        completion(apiResponse.playerStatsSummary!, nil)
                    } catch {
                        completion(nil, JumpShotNetworkManagerError.unableToDecodeError)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }

}
