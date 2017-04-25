//
//  Users.swift
//  Duck App
//
//  Created by Auburn University Senior Design on 4/2/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit
import os.log

class Users: NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String
    var score: Int
    var state: String
    var place: Int
    
    //MARK: Archiving Paths
    static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("users")
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let place = "place"
        static let score = "score"
        static let state = "state"
    }
    
    //MARK: Initilization
    
    init(place: Int, name: String, state: String, score: Int){
        self.place = place
        self.name = name
        self.score = score
        self.state = state
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(place, forKey: PropertyKey.place)
        aCoder.encode(score, forKey: PropertyKey.score)
        aCoder.encode(state, forKey: PropertyKey.state)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // Name and state are required. Unable to decode these will cause failure
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode name of Users object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let state = aDecoder.decodeObject(forKey: PropertyKey.state) as? String else {
            os_log("Unable ot decode state of Users object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let place = aDecoder.decodeInteger(forKey: PropertyKey.place)
        let score = aDecoder.decodeInteger(forKey: PropertyKey.score)
        
        // Must call designated initializer 
        self.init(place: place, name: name, state: state, score: score)
        
    }
    
}
