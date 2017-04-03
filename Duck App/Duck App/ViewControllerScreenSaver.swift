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
    
//Assign Variables Below
    var ducks = ["AmericanBlackDuck","AmericanWigeon","BlueWingedTeal"]
    var ss = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        
        
    }
    
    override func setBackground() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: ducks[ss])?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        if ss <= 1 {
            ss = ss+1
        }
        else {
            ss = 0
        }
    }
    
}
