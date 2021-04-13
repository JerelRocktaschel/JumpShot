//
//  JumpShotGetPlayerImage.swift
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

public enum JumpShotPlayerImageSize: String {
    case small = "260x190"
    case large = "1040x760"
}

public extension JumpShot {
    
    /**
        Returns a current player image in PNG format.
     
        URL called:  ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/JUMPSHOTIMAGESIZE/NBA PLAYER ID.png
     
        - Parameter imageSize: Sizes stored in JumpShotImageSize enum - either 1040x760 or 260x190.
        - Parameter playerid: PlayerID returned from NBA API stored in Player.PlayerID.
        - Parameter completion: The callback after retrieval.
        - Parameter teamImage: Player image in PNG format.
        - Parameter error: Error should one occur.
        - Returns: Player Image in PNG format or error.
            
        # Notes: #
        1. Handle UIImage return due to being optional.
     */
    
    typealias GetPlayerImageCompletion = (_ playerImage: UIImage?, _ error: LocalizedError?) -> Void

    func getPlayerImage(for imageSize: JumpShotPlayerImageSize, and playerid: String, completion: @escaping GetPlayerImageCompletion) {
        JumpShotNetworkManager.shared.router.request(.playerImage(imageSize: imageSize, playerId: playerid)) { [unowned self] data, _, error  in
            var imageResponse: (playerImage: UIImage?, error: LocalizedError?)
            imageResponse = self.handleImageResponse(data: data, error: error)
            completion(imageResponse.playerImage, imageResponse.error)
        }
    }
    
}
