//
//  TriviaQuestion.swift
//  Duck App
//
//  Created by Auburn University Senior Design on 4/5/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import Foundation

//Object to load the trivia questions into to manage them
class TriviaQuestion: NSObject {
    
    // MARK: Properties
    var question : String
    var ans1 : String
    var ans2 : String
    var ans3 : String
    var ans4 : String
    var correct : String
    var points : Int
    var picture : String?
    
    // MARK: Initialization
    init? (question: String, ans1: String, ans2: String, ans3: String, ans4: String, correct: String, points: Int, picture: String?) {
        // Init fails if no question provided
        guard !question.isEmpty else {
            return nil
        }
        
        // Initialize stored properties
        self.question = question
        self.ans1 = ans1
        self.ans2 = ans2
        self.ans3 = ans3
        self.ans4 = ans4
        self.correct = correct
        self.points = points
        self.picture = picture
    }
    
}
