//
//  ViewControllerSS.swift
//  Duck App
//
//  Created by Austin Mills on 2/21/17.
//  Copyright © 2017 Austin Mills. All rights reserved.
//

import Foundation
import UIKit

class ViewScreenSaver : ViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var ssAction: UILabel!
    
    // Assign Variables Below
    var screenTimer: Timer!
    var blinkTimer: Timer!
    var ducks = ["AmericanBlackDuck","AmericanWigeon","BlueWingedTeal","Canvasback","cinnamonteal","Mallard",
                 "Gadwall","GreenWingTeal","LesserScaup","NorthernPintail","NorthernShoveler","RedHead","RingNeck", "WoodDuck"]
    var ss = Int(arc4random_uniform(14))
    var blinkingStatus = 0
    var backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //blinkTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(blinkingLabel), userInfo: nil, repeats: true)
        screenTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(transitionBackground), userInfo: nil, repeats: true)
        background()
        
        self.ssAction.layer.borderWidth = 2
        self.ssAction.layer.cornerRadius = 6
        self.ssAction.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
    }
    
    func background(){
        backgroundImage.image = UIImage(named: ducks[ss])
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func transitionBackground(){
        var ss2 = ss
        if (ss2 < 13) {
            ss2 = ss2 + 1
        }
        else {
            ss2 = 0
        }
        
        let oldImage = UIImageView(frame: UIScreen.main.bounds)
        oldImage.image = UIImage(named:ducks[ss])
        oldImage.contentMode = UIViewContentMode.scaleAspectFill
        let newImage = UIImageView(frame: UIScreen.main.bounds)
        newImage.image = UIImage(named: ducks[ss2])
        newImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(newImage, aboveSubview: backgroundImage)
        self.view.insertSubview(oldImage, aboveSubview: newImage)
        
        UIView.animate(withDuration: 5, delay: 5, options: .curveEaseInOut, animations: {
            oldImage.alpha = 0
            newImage.alpha = 1
        }, completion: { completed in
            newImage.removeFromSuperview()
            oldImage.removeFromSuperview()
            //self.backgroundImage.removeFromSuperview()
            
        })
        
        ss = ss2
    }
    
    func blinkingLabel () {
        if (blinkingStatus == 0) {
            ssAction.backgroundColor = UIColor.clear
            blinkingStatus = 1
        }
        else {
            ssAction.backgroundColor = UIColor.blue
            blinkingStatus = 0
        }
    }
    
}
