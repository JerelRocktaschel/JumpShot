//
//  JumpShotGetTeamImage.swift
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
import UIKit

public extension JumpShot {
    
    /**
        Returns a current team image in PNG format.
     
        URL called:  a.espncdn.com/i/teamlogos/nba/500/TEAM ABBREVIATION.png
     
        - Parameter teamAbbreviation: Abbreviation returned from NBA API stored at Team.abbreviation from getTeams().
        - Parameter completion: The callback after retrieval.
        - Parameter teamImage: Team image in PNG format.
        - Parameter error: Error should one occur.
        - Returns: Team Image in PNG format or error.
            
        # Notes: #
        1. TeamAbbreviation must match team abbreviation returned from the NBA API.
        2. Team logo is pulled from ESPN since the NBA stores team logos in SVG format.
        3. ESPN uses different abbreviations for UTA and NOP.
        4. Handle UIImage return due to being optional.
     */

    typealias GetTeamImageCompletion = (_ teamImage: UIImage?, _ error: LocalizedError?) -> Void
    
    func getTeamImage(for teamAbbreviation: String, completion: @escaping GetTeamImageCompletion) {
        let convertedAbbreviation = convertTeamAbbreviation(for: teamAbbreviation)
        JumpShotNetworkManager.shared.router.request(.teamImage(teamAbbreviation: convertedAbbreviation)) { [unowned self] data, _, error in
            var imageResponse: (teamImage: UIImage?, error: LocalizedError?)
            imageResponse = self.handleImageResponse(data: data, error: error)
            completion(imageResponse.teamImage, imageResponse.error)
        }
    }
    
    private func convertTeamAbbreviation(for abbreviation: String) -> String {
        ///conversion between NBA and ESPN abbreviations
        let convertedAbbreviation: String
        switch abbreviation {
        case "NOP":
            convertedAbbreviation = "NO"
        case "UTA":
            convertedAbbreviation = "UTAH"
        default:
            convertedAbbreviation = abbreviation
        }
        return convertedAbbreviation
    }
}


