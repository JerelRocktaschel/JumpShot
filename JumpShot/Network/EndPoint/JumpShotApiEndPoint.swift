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
    public static var scheduleList: String { return "https://stats.nba.com/stats/" }
    public static var standingList: String { return "https://data.nba.net/data/5s/prod/v2/" }
    public static var teamLeaderList: String { return "https://data.nba.com/prod/v1/2020/teams/" }
    public static var teamScheduleList: String { return "https://data.nba.com/prod/v1/2020/teams/" }
    public static var completeScheduleList: String { return "https://data.nba.net/prod/v2/" }
    public static var coachList: String { return "https://data.nba.net/prod/v1/" }
    public static var teamStatRankingList: String { return "https://data.nba.com/prod/v1/" }
    public static var playerStatsSummary: String { return "https://data.nba.com/prod/v1/" }
    public static var gamePlayList: String { return "https://data.nba.net/prod/v1/" }
    public static var leadTrackerList: String { return "https://data.nba.net/prod/v1/" }
    public static var gameRecap: String { return "https://data.nba.net/prod/v1/" }
    public static var leagueLeadersList: String { return "https://stats.nba.com/stats/" }
    public static var boxscore: String { return "https://data.nba.net/prod/v1/" }
}

public enum Path {
    public static var teamList: String { return "/teams.json" }
    public static var teamImage: String { return ".png" }
    public static var playerList: String { return "/players.json" }
    public static var playerImage: String { return ".png" }
    public static var scheduleList: String { return "&EST=Y" }
    public static var standingList: String { return "current/standings_all.json" }
    public static var teamLeaderList: String { return "/leaders.json" }
    public static var teamScheduleList: String { return "/schedule.json" }
    public static var completeScheduleList: String { return "/schedule.json" }
    public static var coachList: String { return "/coaches.json" }
    public static var teamStatRankingList: String { return "/team_stats_rankings.json" }
    public static var playerStatsSummary: String { return "_profile.json" }
    public static var gamePlayList: String { return "_pbp_1.json" }
    public static var leadTrackerList: String { return ".json" }
    public static var gameRecap: String { return "_recap_article.json" }
    public static var boxscore: String { return "_boxscore.json" }
}

enum JumpShotApiEndPoint {
    case teamList(season: String)
    case teamImage(teamAbbreviation: String)
    case playerList(season: String)
    case playerImage(imageSize: JumpShotPlayerImageSize, playerId: String)
    case scheduleList(season: String, date: String)
    case standingList
    case teamLeaderList(teamId: String)
    case teamScheduleList(teamId: String)
    case completeScheduleList(season: String)
    case coachList(season: String)
    case teamStatRankingList(season: String)
    case playerStatsSummary(season: String, playerId: String)
    case gamePlayList(date: String, gameId: String)
    case leadTrackerList(date: String, gameId: String, period: String)
    case gameRecap(date: String, gameId: String)
    case leagueLeadersList(perMode: LeagueLeaders.PerMode,
                           season: String,
                           seasonType: LeagueLeaders.SeasonType,
                           category: String)
    case boxscore(date: String, gameId: String)
}

extension JumpShotApiEndPoint: EndPointType {

    // MARK: Internal Properties

    var environmentBaseURL: String {
        switch self {
        case .teamList: return BaseURL.teamList
        case .teamImage: return BaseURL.teamImage
        case .playerList: return BaseURL.playerList
        case .playerImage: return BaseURL.playerImage
        case .scheduleList: return BaseURL.scheduleList
        case .standingList: return BaseURL.standingList
        case .teamLeaderList: return BaseURL.teamLeaderList
        case .teamScheduleList: return BaseURL.teamLeaderList
        case .completeScheduleList: return BaseURL.completeScheduleList
        case .coachList: return BaseURL.coachList
        case .teamStatRankingList: return BaseURL.teamStatRankingList
        case .playerStatsSummary: return BaseURL.playerStatsSummary
        case .gamePlayList: return BaseURL.gamePlayList
        case .leadTrackerList: return BaseURL.leadTrackerList
        case .gameRecap: return BaseURL.gameRecap
        case .leagueLeadersList: return BaseURL.leagueLeadersList
        case .boxscore: return BaseURL.boxscore
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
        case .scheduleList(let season, let date):
            return "internationalbroadcasterschedule?LeagueID=00&Season=" + season + "&RegionID=1&Date=" + date + Path.scheduleList
        case .standingList:
            return Path.standingList
        case .teamLeaderList(let teamId):
            return teamId + Path.teamLeaderList
        case .teamScheduleList(let teamId):
            return teamId + Path.teamScheduleList
        case .completeScheduleList(let season):
            return season + Path.completeScheduleList
        case .coachList(let season):
            return season + Path.coachList
        case .teamStatRankingList(let season):
            return season + Path.teamStatRankingList
        case .playerStatsSummary(let season, let playerId):
            return season + "/players/" + playerId + Path.playerStatsSummary
        case .gamePlayList(let date, let gameId):
            return date + "/" + gameId + Path.gamePlayList
        case .leadTrackerList(let date, let gameId, let quarter):
            return date + "/" + gameId + "_lead_tracker_" + quarter + Path.leadTrackerList
        case .gameRecap(let date, let gameId):
            return date + "/" + gameId + Path.gameRecap
        case .leagueLeadersList(let perMode, let season, let seasonType, let category):
            let leagueLeadersUrlString = "leagueLeaders?LeagueID=00&PerMode=" + perMode.rawValue +
                "&Scope=S&Season=" + season +
                "&SeasonType=" + seasonType.rawValue +
                "&StatCategory=" + category
            return leagueLeadersUrlString
        case .boxscore(let date, let gameId):
            return date + "/" + gameId + Path.boxscore
        }
    }
}
