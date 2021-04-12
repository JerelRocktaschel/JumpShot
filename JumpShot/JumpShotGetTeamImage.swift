//
//  JumpShotGetTeamImage.swift
//  JumpShot
//
//  Created by Jerel Rocktaschel on 4/7/21.
//

import Foundation
import UIKit

public extension JumpShot {
    
    /**
        GET    getTeamImage
         
        Returns a current team image in SVG format.
     
        API:   V2
        
        URL:  a.espncdn.com/i/teamlogos/nba/500/TEAM ABBREVIATION.png
     */
    
    func getTeamImage(for teamAbbreviation: String, completion: @escaping (_ teamImage: UIImage?, _ error: LocalizedError?) -> Void ){
        let convertedAbbreviation = convertTeamAbbreviation(for: teamAbbreviation)
        JumpShotNetworkManager.shared.router.request(.teamImage(teamAbbreviation: convertedAbbreviation)) { data, response, error in
                guard error == nil else {
                    completion(nil, JumpShotNetworkManagerError.networkConnectivityError)
                    return
                }
                
                guard let data = data else {
                    completion(nil, JumpShotNetworkManagerError.noDataError)
                    return
                }
            
                if let image = UIImage(data: data)  {
                    completion(image, nil)
                } else {
                    completion(nil, JumpShotNetworkManagerError.unableToDecodeError)
                }
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


