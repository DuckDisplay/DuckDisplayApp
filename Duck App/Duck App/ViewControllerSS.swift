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
    
    @IBOutlet weak var ssTitle: UILabel!
    @IBOutlet weak var ssAction: UILabel!
    
//Assign Variables Below
    var screenTimer: Timer!
    var blinkTimer: Timer!
    var ducks = ["AmericanBlackDuck","AmericanWigeon","BlueWingedTeal","Canvasback","cinnamonteal","Mallard",
                 "Gadwall","GreenWingedTeal","LesserScaup","NorthernPintail","NorthernShoveler","RedHead","RingNeck", "WoodDuck"]
    var ss = 0
    var blinkingStatus = 0
    var backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blinkTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(blinkingLabel), userInfo: nil, repeats: true)
        screenTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(transitionBackground), userInfo: nil, repeats: true)
        background()
        
        
    }
    
    func background(){
        backgroundImage.image = UIImage(named: ducks[ss])
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func transitionBackground(){
        let ss2 = ss + 1
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
       
        
        
        if (ss < 12) {
            ss = ss + 1
        }
        else {
        ss = 0
        }
    }
    
    func blinkingLabel () {
        if (blinkingStatus == 0){
            ssTitle.textColor = UIColor.white
            ssAction.textColor = UIColor.white
            blinkingStatus = 1
        }
        else {
            ssTitle.textColor = UIColor.black
            ssAction.textColor = UIColor.black
            blinkingStatus = 0
        }
    }
}

