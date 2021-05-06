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

public struct MediaNames {
    let shortName: String
    let longName: String

    public init(from decoder: Decoder) throws {
        let mediaNamesCodingKeysContainer = try decoder.container(keyedBy: MediaNamesCodingKeys.self)
        shortName = try mediaNamesCodingKeysContainer.decode(String.self, forKey: .shortName)
        longName = try mediaNamesCodingKeysContainer.decode(String.self, forKey: .longName)
    }
}

extension MediaNames: Equatable {
    
    // MARK: Equatable
    
    public static func ==(lhs: MediaNames, rhs: MediaNames) -> Bool {
        return lhs.shortName == rhs.shortName && lhs.longName == rhs.longName
    }
}

extension MediaNames: Comparable {
    
    // MARK: Comparable
    
    public static func <(lhs: MediaNames, rhs: MediaNames) -> Bool {
        return lhs.shortName < rhs.shortName
    }
}

extension MediaNames: Decodable {

    // MARK: Coding Keys

    enum MediaNamesCodingKeys: String, CodingKey {
        case shortName
        case longName
    }
}

public struct MediaDetails {
    let subCategory: String
    let names: [MediaNames]
}


extension MediaDetails: Equatable {
    
    // MARK: Equatable
    
    public static func ==(lhs: MediaDetails, rhs: MediaDetails) -> Bool {
        return lhs.subCategory == rhs.subCategory && lhs.names == rhs.names
    }
}

extension MediaDetails: Comparable {
    
    // MARK: Comparable
    
    public static func <(lhs: MediaDetails, rhs: MediaDetails) -> Bool {
        return lhs.subCategory < rhs.subCategory
    }
}

public struct Media {
    let category: String
    let details: [MediaDetails]
}

extension Media: Equatable {
    
    // MARK: Equatable
    
    public static func ==(lhs: Media, rhs: Media) -> Bool {
        return lhs.category == rhs.category && lhs.details == rhs.details
    }
}

extension Media: Comparable {
    
    // MARK: Comparable
    
    public static func <(lhs: Media, rhs: Media) -> Bool {
        return lhs.category < rhs.category
    }
}

public struct ScheduledTeam {
    let teamId: String
    let score: Int?

    public init(from decoder: Decoder) throws {
        let scheduledTeamContainer = try decoder.container(keyedBy: ScheduledTeamCodingKeys.self)
        let scoreString = try scheduledTeamContainer.decode(String.self, forKey: .score)

        teamId = try scheduledTeamContainer.decode(String.self, forKey: .teamId)
        score = Int(scoreString)
    }
}

extension ScheduledTeam: Equatable {
    
    // MARK: Equatable
    
    public static func ==(lhs: ScheduledTeam, rhs: ScheduledTeam) -> Bool {
        return lhs.teamId == rhs.teamId && lhs.score == rhs.score
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
    let statusNumber: Int /// not sure what this is
    let extendedStatusNum: Int /// not sure what this is
    let startTimeEastern: String
    let startTimeUTC: Date
    let startDateEastern: String
    let homeStartDate: String
    let homeStartTime: String
    let visitorStartDate: String
    let visitorStartTime: String
    let isHomeTeam: Bool
    let isStartTimeTBD: Bool
    let visitorTeam: ScheduledTeam!
    let homeTeam: ScheduledTeam!
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
    let media: [Media]
    
    public init(from decoder: Decoder) throws {
        let teamScheduleContainer = try decoder.container(keyedBy: TeamScheduleCodingKeys.self)
        let watchNestedContainer = try teamScheduleContainer.nestedContainer(keyedBy: TeamScheduleCodingKeys.self, forKey: .watch)
        let broadcastNestedContainer = try watchNestedContainer.nestedContainer(keyedBy: TeamScheduleCodingKeys.self, forKey: .broadcast)
        let broadcastersNestedContainer = try broadcastNestedContainer.nestedContainer(keyedBy: TeamScheduleCodingKeys.self, forKey: .broadcasters)
        let videoDetailsNestedContainer = try broadcastNestedContainer.nestedContainer(keyedBy: TeamScheduleCodingKeys.self, forKey: .video)
        let audioDetailsNestedContainer = try broadcastNestedContainer.nestedContainer(keyedBy: TeamScheduleCodingKeys.self, forKey: .audio)
        let nationalAudioDetailsNestedContainer = try audioDetailsNestedContainer.nestedContainer(keyedBy: TeamScheduleCodingKeys.self,
                                                                                                  forKey: .national)
        let homeAudioDetailsNestedContainer = try audioDetailsNestedContainer.nestedContainer(keyedBy: TeamScheduleCodingKeys.self,
                                                                                              forKey: .homeTeam)
        let visitorAudioDetailsNestedContainer = try audioDetailsNestedContainer.nestedContainer(keyedBy: TeamScheduleCodingKeys.self,
                                                                                                 forKey: .visitorTeam)
        gameUrlCode = try teamScheduleContainer.decode(String.self, forKey: .gameUrlCode)
        gameId = try teamScheduleContainer.decode(String.self, forKey: .gameId)
        statusNumber = try teamScheduleContainer.decode(Int.self, forKey: .statusNumber)
        extendedStatusNum = try teamScheduleContainer.decode(Int.self, forKey: .extendedStatusNumber)
        startTimeEastern = try teamScheduleContainer.decode(String.self, forKey: .startTimeEastern)
        startDateEastern = try teamScheduleContainer.decode(String.self, forKey: .startDateEastern)
        homeStartDate = try teamScheduleContainer.decode(String.self, forKey: .homeStartDate)
        homeStartTime = try teamScheduleContainer.decode(String.self, forKey: .homeStartTime)
        visitorStartDate = try teamScheduleContainer.decode(String.self, forKey: .visitorStartDate)
        visitorStartTime = try teamScheduleContainer.decode(String.self, forKey: .visitorStartTime)
        isHomeTeam = try teamScheduleContainer.decode(Bool.self, forKey: .isHomeTeam)
        isStartTimeTBD = try teamScheduleContainer.decode(Bool.self, forKey: .isStartTimeTBD)
        visitorTeam = try teamScheduleContainer.decode(ScheduledTeam.self, forKey: .visitorTeam)
        homeTeam = try teamScheduleContainer.decode(ScheduledTeam.self, forKey: .homeTeam)
    
        var mediaCategory: String
        mediaCategory = broadcastersNestedContainer.codingPath.first!.stringValue
        let broadcastMediaDetails = try getMediaDetails(in: broadcastersNestedContainer,
                                                           using: TeamScheduleCodingKeys.self)
        let broadcastMedia = Media(category: mediaCategory, details: broadcastMediaDetails)
        regionalBlackoutCodes = try videoDetailsNestedContainer.decode(String.self, forKey: .regionalBlackoutCodes)
        isPurchasable = try videoDetailsNestedContainer.decode(Bool.self, forKey: .isPurchasable)
        isLeaguePass = try videoDetailsNestedContainer.decode(Bool.self, forKey: .isLeaguePass)
        isNationalBlackout = try videoDetailsNestedContainer.decode(Bool.self, forKey: .isNationalBlackout)
        isTNTOT = try videoDetailsNestedContainer.decode(Bool.self, forKey: .isTNTOT)
        isVR = try videoDetailsNestedContainer.decode(Bool.self, forKey: .isVR)
        isTntOTOnAir = try videoDetailsNestedContainer.decode(Bool.self, forKey: .tntotIsOnAir)
        isNextVR = try videoDetailsNestedContainer.decode(Bool.self, forKey: .isNextVR)
        isNBAOnTNTVR = try videoDetailsNestedContainer.decode(Bool.self, forKey: .isNBAOnTNTVR)
        isMagicLeap = try videoDetailsNestedContainer.decode(Bool.self, forKey: .isMagicLeap)
        isOculusVenues = try videoDetailsNestedContainer.decode(Bool.self, forKey: .isOculusVenues)

        mediaCategory = audioDetailsNestedContainer.codingPath.first!.stringValue
        let nationalAudioSubCategory = nationalAudioDetailsNestedContainer.codingPath.first!.stringValue
        let nationalAudioMediaDetails = try getMediaDetails(with: nationalAudioSubCategory,
                                                            in: nationalAudioDetailsNestedContainer,
                                                           using: TeamScheduleCodingKeys.self)
        
        let homeAudioSubCategory = homeAudioDetailsNestedContainer.codingPath.first!.stringValue
        let homeAudioMediaDetails = try getMediaDetails(with: homeAudioSubCategory,
                                                        in: homeAudioDetailsNestedContainer,
                                                        using: TeamScheduleCodingKeys.self)
        
        let visitorAudioSubCategory = visitorAudioDetailsNestedContainer.codingPath.first!.stringValue
        let visitorAudioMediaDetails = try getMediaDetails(with: visitorAudioSubCategory,
                                                           in: visitorAudioDetailsNestedContainer,
                                                           using: TeamScheduleCodingKeys.self)

        
        let audioMediaDetails = nationalAudioMediaDetails + homeAudioMediaDetails + visitorAudioMediaDetails
        let audioMedia = Media(category: mediaCategory, details: audioMediaDetails)
        let mediaList = [broadcastMedia, audioMedia]
        media = mediaList
        
        /// on occasion the utc start date is returned in yyy-mm-dd format - i don't know why
        let startTimeUTCString = try teamScheduleContainer.decode(String.self, forKey: .startTimeUTC)
        if let startTimeUTCDate = getStartTimeUTC(from: startTimeUTCString) {
            startTimeUTC = startTimeUTCDate
        } else {
            throw DecodingError.dataCorruptedError(forKey: .startTimeUTC,
                                                   in: teamScheduleContainer,
                                                   debugDescription: "Date string does not match expected format.")
        }
    }
}

private func getStartTimeUTC(from dateString: String) -> Date? {
    /// every once in a while, a game date does not have a time and needs a different format
    let pattern = "^[0-9]{4}-[0-9]{2}-[0-9]{2}$"
    let startTimeUTCResult = dateString.range(of: pattern, options: .regularExpression)
    let isstartTimeUTCDateOnly = (startTimeUTCResult != nil)
    
    let dateFormatter: DateFormatter
    if isstartTimeUTCDateOnly == true {
        dateFormatter = DateFormatter.yyyyMMdd
    } else {
        dateFormatter = DateFormatter.iso8601Full
    }
    
    return dateFormatter.date(from: dateString)
}

private func getMediaDetails<T, Key>(with subCategory: String? = nil,
                                     in container: KeyedDecodingContainer<T>,
                                     using codingKeys: Key.Type) throws -> [MediaDetails] where Key : CodingKey {
    var mediaDetailsList = [MediaDetails]()
    var subCategoryDetail: String
    for key in container.allKeys {
        /// sometimes the subcategory is in the container - sometimes in node above container (passed into function)
        if subCategory == nil {
            subCategoryDetail = key.stringValue
        } else {
            subCategoryDetail = subCategory!
        }
        
        let mediaNames = try container.decode([MediaNames].self, forKey: codingKeys.self.init(stringValue: key.stringValue) as! T)
        if mediaNames.count > 0 {
            let mediaDetails = MediaDetails(subCategory: subCategoryDetail, names: mediaNames)
            mediaDetailsList.append(mediaDetails)
        }
    }
    return mediaDetailsList
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
        case regionalBlackoutCodes = "regionalBlackoutCodes"
        case isPurchasable = "canPurchase"
        case isLeaguePass = "isLeaguePass"
        case isNationalBlackout = "isNationalBlackout"
        case isTNTOT = "isTNTOT"
        case isVR = "isVR"
        case tntotIsOnAir = "tntotIsOnAir"
        case isNextVR = "isNextVR"
        case isNBAOnTNTVR = "isNBAOnTNTVR"
        case isMagicLeap = "isMagicLeap"
        case isOculusVenues = "isOculusVenues"
        case visitorTeam = "vTeam"
        case homeTeam = "hTeam"
        case watch = "watch"
        case broadcast = "broadcast"
        case broadcasters = "broadcasters"
        case national = "national"
        case canadian = "canadian"
        case video = "video"
        case audio = "audio"
    }
}

struct TeamScheduleApiResponse {

    // MARK: Internal Properties

    var teamSchedules: [TeamSchedule]

    init?(json: [String: Any]) {
    
        guard let leagueDictionary = json["league"] as? JSONDictionary else {
            return nil
        }

        guard let standardDictionary = leagueDictionary["standard"] as? [JSONDictionary] else {
            return nil
        }

        self.teamSchedules = [TeamSchedule]()
        for teamScheduleDictionary in standardDictionary {
            guard let teamScheduleJSONData = try? JSONSerialization.data(withJSONObject: teamScheduleDictionary,
                                                                         options: []) else {
                    return nil
            }
  
            do {
                let teamSchedule = try JSONDecoder().decode(TeamSchedule.self, from: teamScheduleJSONData)
                teamSchedules.append(teamSchedule)
            } catch {
                return nil
            }
        }
    }
}
