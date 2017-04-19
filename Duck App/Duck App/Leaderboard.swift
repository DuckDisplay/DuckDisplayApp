//
//  Leaderboard.swift
//  Duck App
//
//  Created by Austin Mills on 3/30/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit
    


class Leaderboard : ViewController {
    
    override func viewDidLoad() {
        //let vc = storyboard?.instantiateViewController(withIdentifier: "TriviaScreen1") as! TriviaScreen1
        let myScore = score
        let bottomScore = users.last?.score
        
        /*if (myScore > bottomScore! || users.count < 10) {
            
            createHighScoreAlert(title: "NEW HIGH SCORE!", message: "Your Score: " + String(myScore))
            
        }
        else {
            createGameOverAlert(title: "GAME OVER", message: "Your Score: " + String(myScore))
        }*/
        
    }


    //Creates Alert when trivia game ends
    func createGameOverAlert(title: String, message: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in alert.dismiss(animated: true, completion: nil)
    }))
        self.present(alert, animated: true, completion: nil)
}
    
    //Creates a pop up when user has a new high score
    
    func createHighScoreAlert(title:String, message: String){
    
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            //This is called when the user presses the cancel button.
            //print("You've pressed the cancel button");
        }
        
        let actionSubmit = UIAlertAction(title: "Submit", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            //This is called when the user presses the login button.
            
            let textUser = alertController.textFields![0] as UITextField;   //Variable where users name is saved
            let textState = alertController.textFields![1] as UITextField   //Variable where users state is saved
            
            print("The user entered:%@ & %@", textUser.text!, textState.text!);
            let thisUser = Users(name: textUser.text!, state: textState.text!, score: score)
            
            
            //if theres less than 10 users check to see if this one goes on the end
            if(users.endIndex < 9) {
                if(thisUser.score < users[users.count - 1].score) {
                    //add user to the end
                    users.append(thisUser)
                }
            }
            
            self.placeUser(thisUser: thisUser)
        }
        
        alertController.addTextField { (textField) -> Void in
            //Configure the attributes of the first text box.
            textField.placeholder = "Name"
        }
        
        alertController.addTextField { (textField) -> Void in
            //Configure the attributes of the second text box.
            textField.placeholder = "State Initials"
        }
        
        //Add the buttons
        alertController.addAction(actionCancel)
        alertController.addAction(actionSubmit)
        
        //Present the alert controller
        self.present(alertController, animated: true, completion:nil)
        
    }
    
    //places the user on the leaderboard in the appropriae place
    func placeUser(thisUser: Users) {
        var i = 0;
        
        for user in users {
            if(user.score > thisUser.score) {
                i += 1
            }
            else {
                users[i] = thisUser
            }
        }
    }
}

