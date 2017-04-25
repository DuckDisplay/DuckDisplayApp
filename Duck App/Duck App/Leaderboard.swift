//
//  Leaderboard.swift
//  Duck App
//
//  Created by Auburn University Senior Design on 3/30/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit
import os.log

class Leaderboard : UIViewController {
    
    // MARK: Properties
    var lastScreen: String?
    
    // Reference embedded table view controller
    private var leaderboardTable: LeaderboardTableViewController!
    
    override func viewDidLoad() {
        
        // Load a saved Leaderboard, if non-existent, load sample data
        if users.isEmpty {
            if let savedLeaderboard = loadLeaderboard() {
                users += savedLeaderboard
            } else {
                // Load sample data
                let devUser = Users(place: 1, name: "Development Squad", state: "Domination Station", score: 10)
                users.append(devUser)
            }
        }
        
        let myScore = score
        let bottomScore = users.last?.score
        
        if (lastScreen ?? "") == "StartScreen" {
            // Do nothing
        }
        else {
            if(myScore > bottomScore! || users.count < 10) {
                createHighScoreAlert(title: "NEW HIGH SCORE!", message: "Your Score: " + String(myScore))
            }
            else {
                createGameOverAlert(title: "GAME OVER", message: "Your Score: " + String(myScore))
            }
        }
        
    }
    
    // Prepare for segue to get the embedded view controller pointer
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? LeaderboardTableViewController, segue.identifier == "LeaderboardTableViewEmbed" {
            self.leaderboardTable = vc
        }
    }
    
    // MARK: Alerts
    
    //Creates Alert when trivia game ends
    func createGameOverAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Creates a pop up when user has a new high score
    func createHighScoreAlert(title:String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            //This is called when the user presses the cancel button.
            //print("You've pressed the cancel button");
        }
        
        let actionSubmit = UIAlertAction(title: "Submit", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            //This is called when the user presses the submit button.
            
            let textUser = alertController.textFields![0] as UITextField
            let textState = alertController.textFields![1] as UITextField   //Variable where users state is saved
            
            let thisUser = Users(place: 0, name: textUser.text!, state: textState.text!, score: score)
            
            //put user into the table
            self.placeUser(thisUser: thisUser)
            
            // Save the new leaderboard data
            self.saveLeaderboard()
            
            self.leaderboardTable.tableView.reloadData()
            
        }
        
        //Add the buttons
        alertController.addAction(actionCancel)
        alertController.addAction(actionSubmit)
        
        
        alertController.addTextField { (textField) -> Void in
            //Configure the attributes of the first text box.
            textField.placeholder = "Name"
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main) { (notification) in
                actionSubmit.isEnabled = textField.text!.characters.count < 12
            }
        }
        
        alertController.addTextField { (textField) -> Void in
            //Configure the attributes of the second text box.
            textField.placeholder = "State Initials"
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main) { (notification) in
                actionSubmit.isEnabled = textField.text!.characters.count < 3
            }
        }
            
        //Present the alert controller
        self.present(alertController, animated: true, completion:nil)
        
    }
    
    // MARK: Private Methods
    
    // Places the user on the leaderboard in the appropriae place
    private func placeUser(thisUser: Users) {
        
        //less than 10 on the board, add always
        if (users.count < 10) {
            users.append(thisUser)
        }
        //10 users already, put this one on the bottom and sort by score
        else {
            users[9] = thisUser
        }
        //sort by score
        users.sort { $0.score > $1.score}
        
        //re-create the place column here so that we don't have multiples of 1st place, etc.
        var i: Int = 0
        for _ in users {
            users[i].place = i + 1
            i += 1
        }
        
    }
    
    // Save leaderboard data
    private func saveLeaderboard() {
        
        // Attempt to save to file
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(users, toFile: Users.ArchiveURL.path)
        
        // Depending on results, write to console 
        if isSuccessfulSave {
            os_log("Leaderboard successfully saved!", log: OSLog.default, type: .debug)
        } else {
            os_log("Leaderboard failed to save", log: OSLog.default, type: .debug)
        }
    }
    
    // Load leaderboard data from file
    private func loadLeaderboard() -> [Users]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Users.ArchiveURL.path) as? [Users]
    }

}
