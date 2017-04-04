//
//  TriviaScreen1.swift
//  Duck App
//
//  Created by John Cancilla on 3/29/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit
import SQLite

class Trivia_Screen_1: UIViewController {
    //timer to determine when the game is over
    var gameTimer: Timer!
    
    override func viewDidAppear(_ animated: Bool) {
        gameTimer = Timer.scheduledTimer(timeInterval: 120, target: self, selector: #selector(gameIsOver), userInfo: nil, repeats: true)
    }
    
    //outlet for the question text to be put into that textview
    @IBOutlet weak var questionText: UITextView!
    
    //outlet for the ImageView for pictures in questions
    @IBOutlet weak var questionImage: UIImageView!
    
    override func viewDidLoad() {
        setBackground()
        //load the fisrt question and answer set from the database
        
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
    @IBAction func answerASelected(_ sender: Any) {
    }

    @IBAction func answerBSelected(_ sender: Any) {
    }
    
    @IBAction func asnwerCSelected(_ sender: Any) {
    }
    
    @IBAction func asnwerDSelected(_ sender: Any) {
    }
    
    //gets the next question and answers from the database
    func getNextQuestion() {
    }
    
    //Selector method for time completed
    func gameIsOver() {
        gameTimer.invalidate()
    }
}


