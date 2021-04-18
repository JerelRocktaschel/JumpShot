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

    //game time response in 12h format - convert to 24h
    static func getGameDate(from responseDateString: String) -> Date {
        JumpShot.dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        JumpShot.dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        if let responseDate = JumpShot.dateFormatter.date(from: responseDateString) {
            let gameDate = responseDate.addHours(12)
            return gameDate
        } else {
            return Date()
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

    func addHours(_ hours: Int) -> Date {
        let previousDate = Calendar.current.date(byAdding: .hour, value: hours, to: self)
        return previousDate!
    }

    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func toNBADateURLFormat() -> String {
        let twentyFourFormatDate = self.addHours(12)
        let day = String(twentyFourFormatDate.get(.day).day!)
        let month = String(twentyFourFormatDate.get(.month).month!)
        let year = String(twentyFourFormatDate.get(.year).year!)
        return month + "/" + day + "/" + year
    }
}
