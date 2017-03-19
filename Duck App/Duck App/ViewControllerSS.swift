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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        
        
    }
    
    override func setBackground() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "PairMallards")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
    }
}
