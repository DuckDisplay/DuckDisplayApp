//
//  TriviaStartScreenViewController.swift
//  Duck App
//
//  Created by John Cancilla on 4/3/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class TriviaStartScreenViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    
    var buttonTimer: Timer!
    var blinkingStatus = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
          setBackground()
        
          buttonTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(blinkingLabel), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    func setBackground() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "Duck-Camo")?.draw(in: self.view.bounds)
        
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


