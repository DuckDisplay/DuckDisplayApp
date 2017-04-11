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
        cell.cellLabel.text = duckPreview.duckName

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

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier ?? "") == "ShowDuckInfo" {
            // Get segue properties, ensure they are correct for this screen
            // Destination:
            guard let duckInfoViewController = segue.destination as? DuckCardViewController else {
                fatalError("Unexpected Destination: \(segue.destination)")
            }
            
            // Sender (source):
            guard let selectedDuck = sender as? DuckCardTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            // Index of chosen duck in the table view
            guard let indexPath = tableView.indexPath(for: selectedDuck) else {
                fatalError("The selected duck is not being displayed in the table")
            }
            
            let selectedDuckPreview = ducksPreviewList[indexPath.section][indexPath.row]
            
            // Create a duck info object with this data, send to Duck Card View Controller
            duckInfoViewController.duckInfo = getSelectedDuckInformation(duckPreview: selectedDuckPreview)
            
        } else {
            //fatalError("Unexpected segue identifier: \(segue.identifier ?? "")")
        }
    }

    
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
    
    private func getSelectedDuckInformation(duckPreview: DuckPreview) -> DuckInfo? {
        // Create query to get selected duck's information, based on provided name
        let passedDuckName = duckPreview.duckName
        let query_byName = DuckDatabase.DuckFactsTable.duckFacts.filter(DuckDatabase.DuckFactsTable.name == passedDuckName)
        
        // Init array to number of information slots needed
        var duckInfoArray = [String](repeating: "", count: DuckInfo.NUM_TEXT_SLOTS)
        var duckImage: UIImage?
        
        // Access database and get duck's information
        do {
            if let duckData = try DuckDatabase.duckDB?.pluck(query_byName) {
                
                // Create array of data needed
                if let duckName = String(duckData[DuckDatabase.DuckFactsTable.name]) {
                    duckInfoArray[DuckInfo.TextInfoIndices.name.rawValue] = duckName
                }
                if let duckScienceName = String(duckData[DuckDatabase.DuckFactsTable.scientificName]) {
                    duckInfoArray[DuckInfo.TextInfoIndices.scienceName.rawValue] = duckScienceName
                }
                if let duckImageLabel = String(duckData[DuckDatabase.DuckFactsTable.name]) {
                    duckInfoArray[DuckInfo.TextInfoIndices.imageLabel.rawValue] = duckImageLabel
                }
                if let duckAudioPath = String(duckData[DuckDatabase.DuckFactsTable.soundPath]) {
                    duckInfoArray[DuckInfo.TextInfoIndices.audioPath.rawValue] = duckAudioPath
                }
                if let duckDesc = String(duckData[DuckDatabase.DuckFactsTable.description]) {
                    duckInfoArray[DuckInfo.TextInfoIndices.desc.rawValue] = duckDesc
                }
                if let duckBehavior = String(duckData[DuckDatabase.DuckFactsTable.behavior]) {
                    duckInfoArray[DuckInfo.TextInfoIndices.behavior.rawValue] = duckBehavior
                }
                if let duckFood = String(duckData[DuckDatabase.DuckFactsTable.food]) {
                    duckInfoArray[DuckInfo.TextInfoIndices.food.rawValue] = duckFood
                }
                if let duckHabitat = String(duckData[DuckDatabase.DuckFactsTable.habitat]) {
                    duckInfoArray[DuckInfo.TextInfoIndices.habitat.rawValue] = duckHabitat
                }
                if let duckNesting = String(duckData[DuckDatabase.DuckFactsTable.nesting]) {
                    duckInfoArray[DuckInfo.TextInfoIndices.nesting.rawValue] = duckNesting
                }
                if let duckConservation = String(duckData[DuckDatabase.DuckFactsTable.conservation]) {
                    duckInfoArray[DuckInfo.TextInfoIndices.conservation.rawValue] = duckConservation
                }
                if let duckFunFacts = String(duckData[DuckDatabase.DuckFactsTable.funFacts]) {
                    duckInfoArray[DuckInfo.TextInfoIndices.funFacts.rawValue] = duckFunFacts
                }
                
                // Grab image
                duckImage = UIImage(named: duckData[DuckDatabase.DuckFactsTable.photoPath])
                
            } else {
                print("Error reading duck's data with name: \(passedDuckName), from database")
            }
            
            
        } catch {
            print("Error, cannot find duck with name: \(passedDuckName), from database")
        }
        
        // Create a DuckInfo object
        let resultDuckInfo = DuckInfo.init(duckImage: duckImage, textInfoArray: duckInfoArray)
        
        return resultDuckInfo
    }

}
