//
//  JumpShotTableViewController.swift
//  JumpShotExamples
//
//  Created by Jerel Rocktaschel on 4/1/21.
//

import Foundation
import UIKit

// MARK: Import the JumpShot Framework

import JumpShot

class JumpShotTableViewController: UITableViewController {

    // MARK: 1 - Instantiate an instance of JumpShot

    let jumpShot = JumpShot()
    let jumpShotFunctions = ["getTeams()",
                             "getTeamImage()",
                             "getPlayerImage() - Small",
                             "getPlayerImage() - Large",
                             "getPlayers()",
                             "getGameSchedule(for: \"04/20/2021\")",
                             "getStandings()",
                             "getTeamLeaders(for: \"1610612737\")",
                             "getTeamSchedules(for: \"1610612737\")",
                             "getCompleteSchedule()",
                             "getCoaches()",
                             "getTeamStatRankings()"]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jumpShotFunctions.count
     }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = jumpShotFunctions[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            getTeams()
        case 1:
            getTeamImage(for: "BOS")
        case 2:
            getPlayerImage(for: .small, and: "1627759")
        case 3:
            getPlayerImage(for: .large, and: "1627759")
        case 4:
            getPlayers()
        case 5:
            var dateComponents = DateComponents()
            dateComponents.year = 2021
            dateComponents.month = 4
            dateComponents.day = 20
            let scheduleDate = Calendar.current.date(from: dateComponents)
            getDailySchedule(for: scheduleDate!)
        case 6:
            getStandings()
        case 7:
            getTeamLeaders(for: "1610612737")
        case 8:
            getTeamSchedules(for: "1610612737")
        case 9:
            getCompleteSchedule()
        case 10:
            getCoaches()
        case 11:
            getTeamStatRankings()
        default:
            print("No function selected")
        }
    }

    private func getTeams() {

        // MARK: 2 - Call a JumpShot function and handle the response via a closure

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

    private func getTeamImage(for teamAbbreviation: String) {
        jumpShot.getTeamImage(for: teamAbbreviation) { teamImage, error in
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

    private func getPlayerImage(for size: JumpShotPlayerImageSize, and playerId: String) {
        jumpShot.getPlayerImage(for: size, and: playerId) { playerImage, error in
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

    private func getDailySchedule(for date: Date) {
        jumpShot.getDailySchedule(for: date) { gameSchedules, error in
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

    private func getTeamLeaders(for teamId: String) {
        jumpShot.getTeamLeaders(for: teamId) { teamLeaders, error in
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

    private func getTeamSchedules(for teamId: String) {
        jumpShot.getTeamSchedules(for: teamId) { teamSchedules, error in
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
}
