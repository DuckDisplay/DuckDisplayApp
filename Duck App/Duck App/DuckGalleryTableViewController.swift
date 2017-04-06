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
    var ducksPreviewSections = [String]()
    var ducksPreviewList = [[DuckPreview]]()

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
        return ducksPreviewSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ducksPreviewList[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DuckCardTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DuckCardTableViewCell else {
            fatalError("The dequeued cell is not an instance of DuckCardTableViewCell")
        }

        // Fetch duck preview from previews array
        let duckPreview = ducksPreviewList[indexPath.section][indexPath.row]
        
        // Set properties of table cell with fetched data
        cell.cellImage.image = duckPreview.duckImage
        cell.cellButton.setTitle(duckPreview.duckName, for: .normal)

        return cell
    }

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
        // Create query to access duck data, alphabetically. Only need name, image path, and duck type
        let query_nameImageType_alpha = DuckDatabase.DuckFactsTable.duckFacts.select(DuckDatabase.DuckFactsTable.name,
                                                                                     DuckDatabase.DuckFactsTable.photoPath,
                                                                                     DuckDatabase.DuckFactsTable.type)
                                                                                    // Select Name, Photo Path, Type
                                                                            .order(DuckDatabase.DuckFactsTable.type,
                                                                                   DuckDatabase.DuckFactsTable.name)
                                                                                    // Sort Alphabetically, by section & name
        
        // Access database, add to duck list
        do {
            for duck in try DuckDatabase.duckDB!.prepare(query_nameImageType_alpha) {
                let thisDuckPhoto = UIImage(named: duck[DuckDatabase.DuckFactsTable.photoPath])
                let thisDuckName = duck[DuckDatabase.DuckFactsTable.name]
                let thisDuckType = duck[DuckDatabase.DuckFactsTable.type]
                
                guard let thisDuckPreview = DuckPreview(duckName: thisDuckName, duckImage: thisDuckPhoto) else {
                    fatalError("Unable to instantiate duck: \(duck[DuckDatabase.DuckFactsTable.name]) with image: \(duck[DuckDatabase.DuckFactsTable.photoPath])")
                }
                
                if !ducksPreviewSections.contains(thisDuckType) {
                    // If section headers do not have this type, add it to the list
                    ducksPreviewSections += [thisDuckType]
                    ducksPreviewList.append([DuckPreview]())
                }
                
                // Get index of section heading in array
                let typeIndex = ducksPreviewSections.index(of: thisDuckType)
                
                // Add to duck preview list, depending on type of duck
                if typeIndex! < ducksPreviewList.count {
                    ducksPreviewList[typeIndex!] += [thisDuckPreview]
                } else {
                    fatalError("Unable to find section heading, \(thisDuckType), for duck: \(thisDuckPreview.duckName)")
                }
            }
        } catch {
            print("Error populating duck list from database")
        }
    }

}
