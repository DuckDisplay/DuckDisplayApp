//
//  DuckDatabase.swift
//  Duck App
//
//  Contains constants to access all database files
//
//  Created by Mark Gallagher Jr on 3/30/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import Foundation
import SQLite

class DuckDatabase {
    // Holds connection to database file
    static var duckDB: Connection?
    
    // MARK: Constants to access databases
    // Used to access the database file itself
    struct DuckDBfile {
        static let dbFilePath = Bundle.main.path(forResource: "duck", ofType: "db")
    }
    
    // Constants to access duck facts table and the columns within it
    struct DuckFactsTable {
        static let duckFacts = Table("duck_facts")
        static let id = Expression<Int32>("ID")
        static let name = Expression<String>("Name")
        static let scientificName = Expression<String>("ScientificName")
        static let conservation = Expression<String>("Conservation")
        static let conservationStatus = Expression<String>("ConservationStatus")
        static let size = Expression<String>("Size")
        static let description = Expression<String>("Description")
        static let habitat = Expression<String>("Habitat")
        static let food = Expression<String>("Food")
        static let nesting = Expression<String>("Nesting")
        static let behavior = Expression<String>("Behavior")
        static let funFacts = Expression<String>("FunFacts")
        static let photoPath = Expression<String>("PhotoPath")
        static let soundPath = Expression<String>("SoundPath")
        static let mapPath = Expression<String>("MapPath")
    }
    
    // Constants to access trivia questions/answers
    struct TriviaDataTable {
        static let triviaData = Table("trivia_data")
        static let id = Expression<Int32>("Entry")
        static let question = Expression<String>("Question")
        static let ans1 = Expression<String>("Ans1")
        static let ans2 = Expression<String>("Ans2")
        static let ans3 = Expression<String>("Ans3")
        static let ans4 = Expression<String>("Ans4")
        static let correct = Expression<String>("Correct")
        static let points = Expression<Int32>("Points")
        static let picture = Expression<String>("Picture")
    }
    
    
    // MARK: Initialize
    init() {
        // Connect to database
        do {
            DuckDatabase.duckDB = try Connection(DuckDBfile.dbFilePath!)
        } catch {
            print("Error: Cannot open database file: \(error)")
        }
        
        // Attempt to access data to ensure connection
        for duck in try! DuckDatabase.duckDB!.prepare(DuckFactsTable.duckFacts) {
            print("name: \(duck[DuckFactsTable.name])\n\tscience name: \(duck[DuckFactsTable.scientificName])")
        }
    }
}
