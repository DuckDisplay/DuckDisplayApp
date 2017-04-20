//
//  LeaderboardTableViewController.swift
//  Duck App
//
//  Created by Austin Mills on 4/2/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class LeaderboardTableViewController: UITableViewController{
    
    //MARK: Properties
    var users = [Users]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Load Users
        loadUsers()
        tableView.rowHeight = 90
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "LeaderboardTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LeaderboardTableViewCell else {
            fatalError("The dequeued cell is not an instance of LeaderboardTableViewCell.")
        }
        if (indexPath.row % 2 == 0)
        {
            cell.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        let user = users[indexPath.row]
        
        cell.leaderboardPlace.text = user.place
        cell.leaderboardName.text = user.name
        cell.leaderboardState.text = user.state
        cell.leaderboardScore.text = user.score
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    private func loadUsers(){
    
        
        let user1 = Users(place: "1.", name: "User 1", state: "AL", score: "100")
        //else {fatalError("Unable to instantiate user1")
        //}
        
        let user2 = Users(place: "2.", name: "User 2", state: "GA", score: "99")
        //else {fatalError("Unable to instantiate user2")
        //}
        
        let user3 = Users(place: "3.", name: "User 3", state: "TN", score: "98")
        //else {fatalError("Unable to instantiate user3")
        //}
        
        users += [user1,user2,user3]
        
    
    }
    
}
