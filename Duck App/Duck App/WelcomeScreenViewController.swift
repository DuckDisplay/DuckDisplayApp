//
//  WelcomeScreenViewController.swift
//  Duck App
//
//  Created by Mark Gallagher Jr on 4/17/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController, PageScreenProtocol {

    // MARK: Properties
    
    // Required to conform to PageScreenProtocol
    var pageIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setBackground() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "WelcomeBackground")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        
        
        
    }
    
}
