//
//  TeamSchedule.swift
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

// swiftlint:disable all

import Foundation

public struct MediaName {
    let shortName: String
    let longName: String

    public init(from decoder: Decoder) throws {
        let mediaNameCodingKeysContainer = try decoder.container(keyedBy: MediaNameCodingKeys.self)
        shortName = try mediaNameCodingKeysContainer.decode(String.self, forKey: .shortName)
        longName = try mediaNameCodingKeysContainer.decode(String.self, forKey: .longName)
    }
}

extension MediaName: Decodable {

    // MARK: Coding Keys

    enum MediaNameCodingKeys: String, CodingKey {
        case shortName
        case longName
    }
}

public struct Video {
    let regionalBlackoutCodes: String
    let isPurchasable: Bool
    let isLeaguePass: Bool
    let isNationalBlackout: Bool
    let isTNTOT: Bool
    let isVR: Bool
    let isTntOTOnAir: Bool
    let isNextVR: Bool
    let isNBAOnTNTVR: Bool
    let isMagicLeap: Bool
    let isOculusVenues: Bool
    
    public init(from decoder: Decoder) throws {
        let videoContainer = try decoder.container(keyedBy: VideoCodingKeys.self)

        regionalBlackoutCodes = try videoContainer.decode(String.self, forKey: .regionalBlackoutCodes)
        isPurchasable = try videoContainer.decode(Bool.self, forKey: .isPurchasable)
        isLeaguePass = try videoContainer.decode(Bool.self, forKey: .isLeaguePass)
        isNationalBlackout = try videoContainer.decode(Bool.self, forKey: .isNationalBlackout)
        isTNTOT = try videoContainer.decode(Bool.self, forKey: .isTNTOT)
        isVR = try videoContainer.decode(Bool.self, forKey: .isVR)
        isTntOTOnAir = try videoContainer.decode(Bool.self, forKey: .isTntOTOnAir)
        isNextVR = try videoContainer.decode(Bool.self, forKey: .isNextVR)
        isNBAOnTNTVR = try videoContainer.decode(Bool.self, forKey: .isNBAOnTNTVR)
        isMagicLeap = try videoContainer.decode(Bool.self, forKey: .isMagicLeap)
        isOculusVenues = try videoContainer.decode(Bool.self, forKey: .isOculusVenues)
    }
}

extension Video: Decodable {

    // MARK: Coding Keys

    enum VideoCodingKeys: String, CodingKey {
        case regionalBlackoutCodes = "regionalBlackoutCodes"
        case isPurchasable = "canPurchase"
        case isLeaguePass = "isLeaguePass"
        case isNationalBlackout = "isNationalBlackout"
        case isTNTOT = "isTNTOT"
        case isVR = "isVR"
        case isTntOTOnAir = "tntotIsOnAir"
        case isNextVR = "isNextVR"
        case isNBAOnTNTVR = "isNBAOnTNTVR"
        case isMagicLeap = "isMagicLeap"
        case isOculusVenues = "isOculusVenues"
    }
}

public struct Media {
    let category: String
    let locale: String
    let name: MediaName
}

public struct ScheduledTeam {
    let teamId: String
    let score: Int?

    public init(from decoder: Decoder) throws {
        let scheduledTeamContainer = try decoder.container(keyedBy: ScheduledTeamCodingKeys.self)
        let scoreString = try scheduledTeamContainer.decode(String.self, forKey: .score)

        teamId = try scheduledTeamContainer.decode(String.self, forKey: .teamId)
        score = Int(scoreString)!
    }
}

extension ScheduledTeam: Decodable {

    // MARK: Coding Keys

    enum ScheduledTeamCodingKeys: String, CodingKey {
        case teamId = "teamId"
        case score = "score"
    }
}

public struct TeamSchedule {

    // MARK: Internal Properties

    let gameUrlCode: String
    let gameId: String
    let statusNumber: Int // not sure what this is
    let extendedStatusNum: Int // not sure what this is
    let startTimeEastern: String // DO I TO CONVERT - MAYBE ONE DATE ZULU TIME
    let startTimeUTC: String
    let startDateEastern: String
    let homeStartDate: String
    let homeStartTime: String
    let visitorStartDate: String
    let visitorStartTime: String
    let isHomeTeam: Bool
    let isStartTimeTBD: Bool
    let visitorTeam: ScheduledTeam!
    let homeTeam: ScheduledTeam!
 //   let video: Video!
/*    let media: [Media]
    */

    public init(from decoder: Decoder) throws {
        let teamScheduleContainer = try decoder.container(keyedBy: TeamScheduleCodingKeys.self)
  
        gameUrlCode = try teamScheduleContainer.decode(String.self, forKey: .gameUrlCode)
        gameId = try teamScheduleContainer.decode(String.self, forKey: .gameId)
        statusNumber = try teamScheduleContainer.decode(Int.self, forKey: .statusNumber)
        extendedStatusNum = try teamScheduleContainer.decode(Int.self, forKey: .extendedStatusNumber)
        startTimeEastern = try teamScheduleContainer.decode(String.self, forKey: .startTimeEastern)
        startTimeUTC = try teamScheduleContainer.decode(String.self, forKey: .startTimeUTC)
        startDateEastern = try teamScheduleContainer.decode(String.self, forKey: .startDateEastern)
        homeStartDate = try teamScheduleContainer.decode(String.self, forKey: .homeStartDate)
        homeStartTime = try teamScheduleContainer.decode(String.self, forKey: .homeStartTime)
        visitorStartDate = try teamScheduleContainer.decode(String.self, forKey: .visitorStartDate)
        visitorStartTime = try teamScheduleContainer.decode(String.self, forKey: .visitorStartTime)
        isHomeTeam = try teamScheduleContainer.decode(Bool.self, forKey: .isHomeTeam)
        isStartTimeTBD = try teamScheduleContainer.decode(Bool.self, forKey: .isStartTimeTBD)
        visitorTeam = try teamScheduleContainer.decode(ScheduledTeam.self, forKey: .visitorTeam)
        homeTeam = try teamScheduleContainer.decode(ScheduledTeam.self, forKey: .homeTeam)
    }
}

extension TeamSchedule: Decodable {

    // MARK: Coding Keys

    enum TeamScheduleCodingKeys: String, CodingKey {
        case gameUrlCode = "gameUrlCode"
        case gameId = "gameId"
        case statusNumber = "statusNum"
        case extendedStatusNumber = "extendedStatusNum"
        case startTimeEastern = "startTimeEastern"
        case startTimeUTC = "startTimeUTC"
        case startDateEastern = "startDateEastern"
        case homeStartDate = "homeStartDate"
        case homeStartTime = "homeStartTime"
        case visitorStartDate = "visitorStartDate"
        case visitorStartTime = "visitorStartTime"
        case isHomeTeam = "isHomeTeam"
        case isStartTimeTBD = "isStartTimeTBD"
        //Scheduled Team & Media
        
        case isLeaguePass = "isLeaguePass"
        case isTNTOT = "isTNTOT"
        case isVR = "isVR"
        case tntotIsOnAir = "tntotIsOnAir"
        case isNextVR = "isNextVR"
        case isNBAOnTNTVR = "isNBAOnTNTVR"
        case isMagicLeap = "isMagicLeap"
        case isOculusVenues = "isOculusVenues"
        case visitorTeam = "vTeam"
        case homeTeam = "hTeam"
    }
}

struct TeamScheduleApiResponse {

    // MARK: Internal Properties

    var teamScheduleLeaders: [TeamSchedule]

    init?(json: [String: Any]) {
        
        guard let leagueDictionary = json["league"] as? JSONDictionary else {
            return nil
        }

        guard let standardDictionary = leagueDictionary["standard"] as? [JSONDictionary] else {
            return nil
        }

        self.teamScheduleLeaders = [TeamSchedule]()
        for teamScheduleDictionary in standardDictionary {
            
            print(teamScheduleDictionary)

            // MEDIA
            guard let watchDictionary = teamScheduleDictionary["watch"] as? JSONDictionary else {
                return nil
            }

            guard let broadcastDictionary = watchDictionary["broadcast"] as? JSONDictionary else {
                return nil
            }

            guard let broadcastersDictionary = broadcastDictionary["broadcasters"] as? JSONDictionary else {
                return nil
            }
            
            var mediaArray = [Media]()
            
            for (key, value) in broadcastersDictionary {
                
                guard let mediaTeamDictionaryArray = value as? [JSONDictionary] else {
                    continue
                }
                

                guard let mediaTeamDictionary = mediaTeamDictionaryArray.first else {
                    continue
                }

                guard let mediaJSONData = try? JSONSerialization.data(withJSONObject: mediaTeamDictionary as Any,
                                                                             options: []) else {
                        return nil
                }
                
                do {
                    let mediaName = try JSONDecoder().decode(MediaName.self, from: mediaJSONData)
                    let media = Media(category: "Broadcaster", locale: key, name: mediaName)
                    mediaArray.append(media)
                } catch {
                    continue
                }
            }
            
            guard let videoDictionary = broadcastDictionary["video"] as? JSONDictionary else {
                return nil
            }
            
            guard let videoJSONData = try? JSONSerialization.data(withJSONObject: videoDictionary,
                                                                         options: []) else {
                    return nil
            }
            
            var video: Video
            do {
                let videoDecoded = try JSONDecoder().decode(Video.self, from: videoJSONData)
                video = videoDecoded
                print(teamScheduleLeaders.count)
            } catch {
                return nil
            }
            
            //need to get full media array
            //pass to [Media] to TeamSchedule
            print(mediaArray)
            
            guard let teamScheduleJSONData = try? JSONSerialization.data(withJSONObject: teamScheduleDictionary,
                                                                         options: []) else {
                    return nil
            }
  
            do {
                let teamSchedule = try JSONDecoder().decode(TeamSchedule.self, from: teamScheduleJSONData)
                teamScheduleLeaders.append(teamSchedule)
                print(teamScheduleLeaders.count)
            } catch {
                return nil
            }
        }

        
       /* for (key, value) in standardDictionary {
            if let statCategoryKey = StatCategory(rawValue: key) {
                guard let leaderDictionaries = value as? [JSONDictionary] else {
                    return nil
                }

                for leaderDictionary in leaderDictionaries {
                    guard let leaderJSONData = try? JSONSerialization.data(withJSONObject: leaderDictionary,
                                                                                 options: []) else {
                            return nil
                    }

                    do {
                        let leader = try JSONDecoder().decode(Leader.self, from: leaderJSONData)
                        let statLeader = StatLeader(category: statCategoryKey, leader: leader)
                        teamScheduleLeaders.append(statL)
                    } catch {
                        return nil
                    }
                }
            }
        }*/
    }
}
