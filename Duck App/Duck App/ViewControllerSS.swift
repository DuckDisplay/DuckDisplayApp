//
//  ViewControllerSS.swift
//  Duck App
//
//  Created by Auburn Univerity Senior Design on 2/21/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import Foundation
import UIKit

class ViewScreenSaver : UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var ssAction: UILabel!
    
    // Assign Variables Below
    var screenTimer: Timer!
    var blinkTimer: Timer!
    var ducks = ["AmericanBlackDuck","AmericanWigeon","BlueWingedTeal","Canvasback","cinnamonteal","Mallard",
                 "Gadwall","GreenWingTeal","LesserScaup","NorthernPintail","NorthernShoveler","RedHead","RingNeck", "WoodDuck","WinterMaleAmericanWigeon","BlueWingedTealFlying","CanvasbackMale","GreenWingTealMale","MallardPair","NorthernShovelerGroup","RedHeadMale","WoodDuckMale"]
    var ss = Int(arc4random_uniform(14))
    var blinkingStatus = 0
    var backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(transitionBackground), userInfo: nil, repeats: true)
        background()
        
        self.ssAction.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4
        )
    }
    
    func background(){
        backgroundImage.image = UIImage(named: ducks[ss])
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func transitionBackground(){
        var ss2 = ss
        if (ss2 < 21) {
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
    
}
