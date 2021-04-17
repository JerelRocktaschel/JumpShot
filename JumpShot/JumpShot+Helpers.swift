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

    /// nba uses beginning season year in url
    /// if current date is greater than new season start date - use current year
    /// if current date is less than new season start date - use last year
    /*static func getSeasonYear() -> String {
        let date = Date()
        var year = String(Calendar.current.component(.year, from: Date()))
        let newSeasonDateString = JumpShotNetworkManagerResources.seasonStartMonthAndDay + year
        dateFormatter.dateFormat = JumpShotNetworkManagerResources.urlDateformat
        if let newSeasonDate = dateFormatter.date(from: newSeasonDateString),
            let yearInt = Int(year),
            date < newSeasonDate {
                year = String(yearInt - 1)
        }
        return year
    }*/

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
}
