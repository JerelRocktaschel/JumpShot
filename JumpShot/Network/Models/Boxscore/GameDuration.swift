//
//  GameDuration.swift
//  JumpShot
//
//  Created by Jerel Rocktaschel on 6/23/21.
//

import Foundation

public struct GameDuration {
    let hours: Int
    let minutes: Int

    public init(from decoder: Decoder) throws {
        let gameDurationContainer = try decoder.container(keyedBy: GameDurationCodingKeys.self)
        let hoursString = try gameDurationContainer.decode(String.self, forKey: .hours)
        let minutesString = try gameDurationContainer.decode(String.self, forKey: .minutes)

        if let hoursInt = Int(hoursString),
           let minutesInt = Int(minutesString) {
            hours = hoursInt
            minutes = minutesInt
        } else {
            throw JumpShotNetworkManagerError.unableToDecodeError
        }
    }
}

extension GameDuration: Decodable {

    // MARK: Coding Keys

    enum GameDurationCodingKeys: String, CodingKey {
        case hours
        case minutes
    }
}

extension GameDuration: Equatable {

    // MARK: Equatable

    public static func == (lhs: GameDuration, rhs: GameDuration) -> Bool {
        return lhs.hours == rhs.hours &&
        lhs.minutes == rhs.minutes
    }
}
