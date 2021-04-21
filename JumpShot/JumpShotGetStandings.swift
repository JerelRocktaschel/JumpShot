//
//  JumpShotGetStandings.swift
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
        Returns an array of Standing model objects.
     
        URL called:  data.nba.net/prod/v2/current/standings_conference.json
    
        - Parameter completion: The callback after retrieval.
        - Parameter standings: An array of Standing model objects.
        - Parameter error: Error should one occur.
        - Returns: An array of GameSchedule model objects or error.
            
        # Notes: #
        1. Handle [Standing] return due to being optional.
     */

    func getStandings(completion: @escaping (_ gameSchedules: [Standing]?, _ error: LocalizedError?) -> Void) {
        JumpShotNetworkManager.shared.router.request(.standingList) { data, response, error in
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
                        guard let apiResponse = StandingApiResponse(json: json!) else {
                            completion(nil, JumpShotNetworkManagerError.unableToDecodeError)
                            return
                        }
                        completion(apiResponse.standings, nil)
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
