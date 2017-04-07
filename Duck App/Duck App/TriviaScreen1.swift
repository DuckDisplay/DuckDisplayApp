//
//  TriviaScreen1.swift
//  Duck App
//
//  Created by John Cancilla on 3/29/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit
import SQLite

class TriviaScreen1: UIViewController {
    //timer to determine when the game is over
    var gameTimer: Timer!
    var score = 0;
    var chances = 3 //game will end when no more chances are available to prevent guess spamming
    
    override func viewDidAppear(_ animated: Bool) {
        //load question and start timer
        getNextQuestion()
        gameTimer = Timer.scheduledTimer(timeInterval: 120, target: self, selector: #selector(gameIsOver), userInfo: nil, repeats: false)
    }
    
    //outlet for the question text to be put into that textview
    @IBOutlet weak var questionText: UITextView!

    
    //outlet for the ImageView for pictures in questions
    @IBOutlet weak var questionImage: UIImageView!

    
    override func viewDidLoad() {
        setBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackground() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "mmbackground")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)

        addBlurEffect()
        
    }
    
    //Function to blur background
    func addBlurEffect()
    {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        view.addSubview(blurEffectView)
        self.view.insertSubview(blurEffectView, at: 0)
        
    }
    
    //Logic for each answer selected will be inside the action methods for the buttons
    //They will decide whether the asnwer is correct and change the buttons to reflect that
    //then score appropriately and call the getNextQuestion function
   
    @IBOutlet weak var buttonA: duckButton!
    @IBAction func answerAChosen(_ sender: Any) {
        if (thisAns1 != thisCorrect) {
            buttonA.backgroundColor = UIColor.red
            chances--
            if (chances = 0) {
                gameIsOver()
            }
        }
        else {
            buttonA.backgroundColor = UIColor.green
            score += thisPoints
        }
        getNextQuestion()
    }

    

    @IBOutlet weak var buttonB: duckButton!
    @IBAction func answerBChosen(_ sender: Any) {
        if (thisAns2 != thisCorrect) {
            buttonB.backgroundColor = UIColor.red
            chances--
            if (chances = 0) {
                gameIsOver()
            }
        }
        else {
            buttonB.backgroundColor = UIColor.green
            score += thisPoints
        }
        getNextQuestion()
    }
    
    

    @IBOutlet weak var buttonC: duckButton!
    @IBAction func answerCChosen(_ sender: Any) {
        if (thisAns3 != thisCorrect) {
            buttonC.backgroundColor = UIColor.red
            chances--
            if (chances = 0) {
                gameIsOver()
            }
        }
        else {
            buttonC.backgroundColor = UIColor.green
            score += thisPoints
        }
        getNextQuestion()
    }
    
    

    @IBOutlet weak var buttonD: duckButton!
    @IBAction func answerDChosen(_ sender: Any) {
        if (thisAns4 != thisCorrect) {
            buttonD.backgroundColor = UIColor.red
            chances--
            if (chances = 0) {
                gameIsOver()
            }
        }
        else {
            buttonD.backgroundColor = UIColor.green
            score += thisPoints
        }
        getNextQuestion()
    }
    
    
    //gets the next question info from the database
    func getNextQuestion() {
        //need to figure out how to get from random row still
        
        let thisQuestion = [DuckDatabase.TriviaDataTable.question]
        let thisAns1 = [DuckDatabase.TriviaDataTable.ans1]
        let thisAns2 = [DuckDatabase.TriviaDataTable.ans2]
        let thisAns3 = [DuckDatabase.TriviaDataTable.ans3]
        let thisAns4 = [DuckDatabase.TriviaDataTable.ans4]
        let thisCorrect = [DuckDatabase.TriviaDataTable.correct]
        let thisPoints = [DuckDatabase.TriviaDataTable.points]
        let thisPicture = [DuckDatabase.TriviaDataTable.picture]
        
        let thisTriviQuestion = TriviaQuestion(question: thisQuestion, ans1: thisAns1, ans2: thisAns2, ans3: thisAns3, ans4: thisAns4, correct: thisCorrect, points: thisPoints, picture: thisPicture)
        
        populateFields()

    }
    
    
    //puts the data intothe proper locations
    func populateFields() {
        questionText.insertText(text: thisTriviQuestion.questionText) //set question text
        
        if (thisTriviQuestion.picture != nil) { //set image, if there is none hide imageview
            questionImage = thisTriviQuestion.picture
        }
        else {
            questionImage.hidden = true
        }
        
        buttonA.setTitle(title: thisAns1, for: .Normal)
        buttonB.setTitle(title: thisAns2, for: .Normal)
        buttonC.setTitle(title: thisAns3, for: .Normal)
        buttonD.setTitle(title: thisAns4, for: .Normal)
        
    }

    //Selector method for game timer
    func gameIsOver() {
        gameTimer.invalidate()
        //segue to the leaderboard screen
    }
}


