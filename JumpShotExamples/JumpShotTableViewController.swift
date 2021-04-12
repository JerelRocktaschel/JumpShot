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
    let jumpShotFunctions = ["getTeams()","getTeamImage()"]

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
}
