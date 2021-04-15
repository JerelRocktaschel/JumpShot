//
//  JumpShotApiEndPoint.swift
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

// MARK: Typealias

public typealias HTTPHeaders = [String: String]

public enum BaseURL {
    public static var teamList: String { return "https://data.nba.net/data/5s/prod/v2/" }
    public static var teamImage: String { return "https://a.espncdn.com/i/teamlogos/nba/500/" }
    public static var playerList: String { return "https://data.nba.net/data/5s/prod/v2/" }
    public static var playerImage: String { return "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/" }
}
    
public enum Path {
    public static var teamList: String { return "/teams.json" }
    public static var teamImage: String { return ".png" }
    public static var playerList: String { return "/players.json" }
    public static var playerImage: String { return ".png" }
}

enum JumpShotApiEndPoint {
    case teamList(season: String)
    case teamImage(teamAbbreviation: String)
    case playerList(season: String)
    case playerImage(imageSize: JumpShotPlayerImageSize, playerId: String)
}

extension JumpShotApiEndPoint: EndPointType {

    // MARK: Internal Properties

    var environmentBaseURL: String {
        switch self {
        case .teamList: return BaseURL.teamList
        case .teamImage: return BaseURL.teamImage
        case .playerList: return BaseURL.playerList
        case .playerImage: return BaseURL.playerImage
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("Base URL could not be configured.")
        }
        return url
    }

    var path: String {
        switch self {
        case .teamList(let season):
            return season + Path.teamList
        case .teamImage(let teamAbbreviation):
            return teamAbbreviation + Path.teamImage
        case .playerList(let season):
            return season + Path.playerList
        case .playerImage(let imageSize, let playerId):
            return imageSize.rawValue + "/" + playerId + Path.playerImage
        }
    }
}
