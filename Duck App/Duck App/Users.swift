//
//  Users.swift
//  Duck App
//
//  Created by Auburn University Senior Design on 4/2/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class Users {
    
    //MARK: Properties
    var name: String
    var score: Int
    var state: String
    var place: Int
    
    //MARK: Initilization
    
    init(place: Int, name: String, state: String, score: Int){
    
    self.place = place
    self.name = name
    self.score = score
    self.state = state
    }
    
}
