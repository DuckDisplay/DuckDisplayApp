//
//  Users.swift
//  Duck App
//
//  Created by Austin Mills on 4/2/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class Users {
    
    //MARK: Properties
    var name: String
    var score: String
    var state: String
    var place: String
    
    //MARK: Initilization
    
    init(place: String, name: String, state: String, score: String) {
        self.name = name
        self.score = score
        self.state = state
        self.place = place
    }
    
}
