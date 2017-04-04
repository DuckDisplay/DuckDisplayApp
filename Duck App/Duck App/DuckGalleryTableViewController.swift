//
//  DuckGalleryTableViewController.swift
//  Duck App
//
//  Created by Mark Gallagher Jr on 4/3/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit
import SQLite

class DuckGalleryTableViewController: UITableViewController {
    
    // MARK: Properties
    var ducksPreviewSections = ["Section 1"]
    var ducksPreviewList = [DuckPreview]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load duck previews from database
        loadDucksFromDatabase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ducksPreviewSections[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Attempting 1 section here
        return ducksPreviewSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return ducksPreviewList[section].count
        return ducksPreviewList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DuckCardTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DuckCardTableViewCell else {
            fatalError("The dequeued cell is not an instance of DuckCardTableViewCell")
        }

        // Fetch duck preview from previews array
        //let duckPreview = ducksPreviewList[indexPath.section][indexPath.row]
        let duckPreview = ducksPreviewList[indexPath.row]
        
        // Set properties of table cell with fetched data
        cell.cellImage.image = duckPreview.duckImage
        cell.cellButton.setTitle(duckPreview.duckName, for: .normal)

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
    
    // MARK: Private Methods
    
    private func loadDucksFromDatabase() {
        // Create query to access duck data, alphabetically. Only need name and image path
        let query_nameImage_alpha = DuckDatabase.DuckFactsTable.duckFacts.select(DuckDatabase.DuckFactsTable.name,
                                                                                 DuckDatabase.DuckFactsTable.photoPath)  // Select Name, Photo Path
                                                                         .order(DuckDatabase.DuckFactsTable.name)   // Alphabetical
        
        // Access database, add to duck list
        do {
            for duck in try DuckDatabase.duckDB!.prepare(query_nameImage_alpha) {
                let thisDuckPhoto = UIImage(named: duck[DuckDatabase.DuckFactsTable.photoPath])
                let thisDuckName = duck[DuckDatabase.DuckFactsTable.name]
                
                guard let thisDuckPreview = DuckPreview(duckName: thisDuckName, duckImage: thisDuckPhoto) else {
                    fatalError("Unable to instantiate duck: \(duck[DuckDatabase.DuckFactsTable.name]) with image: \(duck[DuckDatabase.DuckFactsTable.photoPath])")
                }
                
                // Add to duck preview list
                ducksPreviewList += [thisDuckPreview]
            }
        } catch {
            print("Error populating duck list from database")
        }
            
        
//        // Start by sample ducks first, just to get code working
//        let duckPhoto1 = UIImage(named: "AmericanBlackDuck")
//        let duckPhoto2 = UIImage(named: "AmericanWigeon")
//        let duckPhoto3 = UIImage(named: "BlueWingedTeal")
//        let duckPhoto4 = UIImage(named: "Canadagoose")
//        
//        // Init the duck preview objects
//        guard let duckPreview1 = DuckPreview(duckName: "American Black Duck", duckImage: duckPhoto1) else {
//            fatalError("Unable to instantiate duck preview 1")
//        }
//        
//        guard let duckPreview2 = DuckPreview(duckName: "American Wigeon", duckImage: duckPhoto2) else {
//            fatalError("Unable to instantiate duck preview 2")
//        }
//        
//        guard let duckPreview3 = DuckPreview(duckName: "Blue Winged Teal", duckImage: duckPhoto3) else {
//            fatalError("Unable to instantiate duck preview 3")
//        }
//        
//        guard let duckPreview4 = DuckPreview(duckName: "Canada Goose", duckImage: duckPhoto4) else {
//            fatalError("Unable to instantiate duck preview 4")
//        }
//        
//        // Add sample duck previews to the array
//        ducksPreviewList += [[duckPreview1, duckPreview2], [duckPreview3, duckPreview4]]
    }

}
