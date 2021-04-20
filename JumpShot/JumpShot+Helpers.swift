//
//  JumpShot+Helpers.swift
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

    // MARK: Helpers

    /// image response logic for both Player and Team image functions
    internal func handleImageResponse(data: Data?, error: Error?) -> (UIImage?, LocalizedError?) {
        guard error == nil else {
            return (nil, JumpShotNetworkManagerError.networkConnectivityError)
        }

        guard let data = data else {
            return (nil, JumpShotNetworkManagerError.noDataError)
        }

        if let image = UIImage(data: data) {
            return (image, nil)
        } else {
            return (nil, JumpShotNetworkManagerError.unableToDecodeError)
        }
    }
}

extension String {
    /// formats and returns date for NBA game time
    func getGameDate() -> Date? {
        JumpShot.dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        JumpShot.dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        if let gameDate = JumpShot.dateFormatter.date(from: self) {
            return gameDate
        } else {
            return nil
        }
    }
}

extension Date {
    /// nba uses beginning season year in url
    /// if current date is greater than new season start date - use current year
    /// if current date is less than new season start date - use last year
    func getSeasonYear() -> String {
        var year = String(Calendar.current.component(.year, from: Date()))
        let newSeasonDateString = JumpShotNetworkManagerResources.seasonStartMonthAndDay + year
        JumpShot.dateFormatter.dateFormat = JumpShotNetworkManagerResources.urlDateformat
        if let newSeasonDate = JumpShot.dateFormatter.date(from: newSeasonDateString),
            let yearInt = Int(year),
            self < newSeasonDate {
                year = String(yearInt - 1)
        }
        return year
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func toNBADateURLFormat() -> String {
        let day = String(self.get(.day).day!)
        let month = String(self.get(.month).month!)
        let year = String(self.get(.year).year!)
        return month + "/" + day + "/" + year
    }
}
