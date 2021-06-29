//
//  JumpShotTableViewController.swift
//  JumpShotExamples
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

// MARK: 1 - Import the JumpShot Framework

import JumpShot

// swiftlint:disable all

class JumpShotTableViewController: UITableViewController {

    // MARK: 2 - Instantiate an instance of JumpShot

    let jumpShot = JumpShot()
    let jumpShotFunctions = ["getTeams()",
                             "getTeamImage()",
                             "getPlayerImage() - Small",
                             "getPlayerImage() - Large",
                             "getPlayers()",
                             "getDailySchedule(for: \"04/20/2021\")",
                             "getStandings()",
                             "getTeamLeaders(for: \"1610612737\")",
                             "getTeamSchedules(for: \"1610612737\")",
                             "getCompleteSchedule()",
                             "getCoaches()",
                             "getTeamStatRankings()",
                             "playerStatsSummary(for: \"2544\")",
                             "getGamePlays(for: \"20210125\", and \"0022000257\")",
                             "getLeadTrackers(for: \"20170201\", and \"0022000257\", and \"1\")",
                             "getGameRecap(for: \"20210125\", and \"0022000257\")",
                             "getTotalLeagueLeaders(for: \"2020\", and .regularSeason, and .playerEfficiency)",
                             "getPerGameLeagueLeaders(for: \"2020\", and .regularSeason, and .playerEfficiency)",
                             "getPer48LeagueLeaders(for: \"2020\", and .regularSeason, and .playerEfficiency)",
                             "getBoxscore(for: \"20210125\", and \"0022000257\")"]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jumpShotFunctions.count
     }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = jumpShotFunctions[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            getTeams()
        case 1:
            getTeamImage()
        case 2:
            getPlayerImageSmall()
        case 3:
            getPlayerImageLarge()
        case 4:
            getPlayers()
        case 5:
            getDailySchedule()
        case 6:
            getStandings()
        case 7:
            getTeamLeaders()
        case 8:
            getTeamSchedules()
        case 9:
            getCompleteSchedule()
        case 10:
            getCoaches()
        case 11:
            getTeamStatRankings()
        case 12:
            getPlayerStatsSummary()
        case 13:
            getGamePlays()
        case 14:
            getLeadTrackers()
        case 15:
            getGameRecap()
        case 16:
            getTotalLeagueLeaders()
        case 17:
            getPerGameLeagueLeaders()
        case 18:
            getPer48LeagueLeaders()
        case 19:
            getBoxscore()
        default:
            print("No function selected")
        }
    }

    private func getTeams() {

        // MARK: 3 - Call a JumpShot function and handle the response via a closure

        jumpShot.getTeams { teams, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let teams = teams else {
                print("No teams returned.")
                return
            }

            print(teams)
        }
    }

    private func getTeamImage() {
        jumpShot.getTeamImage(for: "BOS") { teamImage, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let teamImage = teamImage else {
                print("No image returned.")
                return
            }

            print(teamImage)
        }
    }

    private func getPlayers() {
        jumpShot.getPlayers { players, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let players = players else {
                print("No players returned.")
                return
            }

            print(players)
        }
    }

    private func getPlayerImageSmall() {
        jumpShot.getPlayerImage(for: .small, and: "1627759") { playerImage, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let playerImage = playerImage else {
                print("No image returned.")
                return
            }

            print(playerImage)
        }
    }
    
    private func getPlayerImageLarge() {
        jumpShot.getPlayerImage(for: .large, and: "1627759") { playerImage, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let playerImage = playerImage else {
                print("No image returned.")
                return
            }

            print(playerImage)
        }
    }

    private func getDailySchedule() {
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 4
        dateComponents.day = 20
        let scheduleDate = Calendar.current.date(from: dateComponents)
        jumpShot.getDailySchedule(for: scheduleDate!) { gameSchedules, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let gameSchedules = gameSchedules else {
                print("No schedules returned.")
                return
            }

            print(gameSchedules)
        }
    }

    private func getStandings() {
        jumpShot.getStandings { standings, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let standings = standings else {
                print("No standings returned.")
                return
            }

            print(standings)
        }
    }

    private func getTeamLeaders() {
        jumpShot.getTeamLeaders(for: "1610612737") { teamLeaders, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let teamLeaders = teamLeaders else {
                print("No leaders returned.")
                return
            }

            print(teamLeaders)
        }
    }

    private func getTeamSchedules() {
        jumpShot.getTeamSchedules(for: "1610612737") { teamSchedules, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let teamSchedules = teamSchedules else {
                print("No schedules returned.")
                return
            }

            print(teamSchedules)
        }
    }

    private func getCompleteSchedule() {
        jumpShot.getCompleteSchedule { teamSchedules, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let teamSchedules = teamSchedules else {
                print("No schedules returned.")
                return
            }

            print(teamSchedules)
        }
    }

    private func getCoaches() {
        jumpShot.getCoaches { coaches, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let coaches = coaches else {
                print("No coaches returned.")
                return
            }

            print(coaches)
        }
    }

    private func getTeamStatRankings() {
        jumpShot.getTeamStatRankings { teamStatRankings, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let teamStatRankings = teamStatRankings else {
                print("No rankings returned.")
                return
            }

            print(teamStatRankings)
        }
    }

    private func getPlayerStatsSummary() {
        jumpShot.getGetPlayerStatsSummary(for: "203085") { playerStatsSummary, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let playerStatsSummary = playerStatsSummary else {
                print("No rankings returned.")
                return
            }

            print(playerStatsSummary)
        }
    }

    private func getGamePlays() {
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)
        jumpShot.getGetGamePlays(for: gameDate!,
                                 with: "0022000257") { plays, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let plays = plays else {
                print("No rankings returned.")
                return
            }

            print(plays)
        }
    }

    private func getLeadTrackers() {
        var dateComponents = DateComponents()
        dateComponents.year = 2017
        dateComponents.month = 2
        dateComponents.day = 1
        let gameDate = Calendar.current.date(from: dateComponents)
        jumpShot.getGetLeadTrackers(for: gameDate!,
                                    with: "0021600732",
                                    and: "1") { leadTrackers, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let leadTrackers = leadTrackers else {
                print("No Lead Trackers returned.")
                return
            }

            print(leadTrackers)
        }
    }

    private func getGameRecap() {
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)
        jumpShot.getGetGameRecap(for: gameDate!,
                                 with: "0022000257") { gameRecap, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let gameRecap = gameRecap else {
                print("No Game Recap returned.")
                return
            }

            print(gameRecap)
        }
    }

    private func getTotalLeagueLeaders() {
        jumpShot.getTotalLeagueLeaders(for: 2020,
                                       with: .regularSeason,
                                       and: .playerEfficiency) { totalLeagueLeaders, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let totalLeagueLeaders = totalLeagueLeaders else {
                print("No Total League Leaders returned.")
                return
            }

            print(totalLeagueLeaders)
        }
    }
    
    private func getPerGameLeagueLeaders() {
        jumpShot.getPerGameLeagueLeaders(for: 2020,
                                         with: .regularSeason,
                                         and: .playerEfficiency) { perGameLeagueLeaders, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let perGameLeagueLeaders = perGameLeagueLeaders else {
                print("No Game League Leaders returned.")
                return
            }

            print(perGameLeagueLeaders)
        }
    }
    
    private func getPer48LeagueLeaders() {
        jumpShot.getPer48LeagueLeaders(for: 2020,
                                       with: .regularSeason,
                                       and: .playerEfficiency) { per48LeagueLeaders, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let per48LeagueLeaders = per48LeagueLeaders else {
                print("No Per48 League Leaders returned.")
                return
            }

            print(per48LeagueLeaders)
        }
    }
    
    private func getBoxscore() {
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 25
        let gameDate = Calendar.current.date(from: dateComponents)
        jumpShot.getBoxscore(for: gameDate!,
                             with: "0022000257") { boxscore, error in
            guard error == nil else {
                print(error!)
                return
            }

            guard let boxscore = boxscore else {
                print("No Boxscore returned.")
                return
            }

            print(boxscore)
        }
    }
}
