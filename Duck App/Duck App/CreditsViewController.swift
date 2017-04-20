//
//  CreditsViewController.swift
//  Duck App
//
//  Created by Mark Gallagher Jr on 4/17/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
    
    //Outlet to vuew that displays information
    @IBOutlet weak var creditsView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var designTeamText: UILabel!
    
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
        UIImage(named: "CreditsBackground")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        
        self.creditsView.backgroundColor = UIColor(patternImage: image)
        
        
        
    }


}
