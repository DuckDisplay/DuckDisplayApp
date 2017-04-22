//
//  TriviaStartScreenViewController.swift
//  Duck App
//
//  Created by John Cancilla on 4/3/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class TriviaStartScreenViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var playButton: UIButton!
    
    var buttonTimer: Timer!
    var blinkingStatus = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        //Timer for blinking button
        buttonTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(blinkingLabel), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        
        //initial user to prevent nil...
        if(users.count < 1) {
            let devUser = Users(place: 1, name: "Development Squad", state: "Domination Station", score: 5000)
            users.append(devUser)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setBackground() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "Duck-CamoBlur")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        
        
    }
    
    
    func blinkingLabel () {
        if (blinkingStatus == 0){
            self.playButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            blinkingStatus = 1
        }
        else {
            self.playButton.setTitleColor(UIColor.black, for: UIControlState.normal)
            blinkingStatus = 0
        }
    }
    
}
