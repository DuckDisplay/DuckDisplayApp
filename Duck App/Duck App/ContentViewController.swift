//
//  ContentViewController.swift
//  Duck App
//
//  Created by Austin Mills on 4/8/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController, PageScreenProtocol {

    
    // MARK: Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var changeView: UIButton!

    // Required to conform to Page Screen Protocol
    var pageIndex: Int!
    
    var titleText: String!
    var descriptionText: String!
    var segueID: String!
    var background: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = self.titleText
        self.descriptionLabel.text = self.descriptionText
        setBackground(background: background)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackground(background: String) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: background)?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        
        
    }
    
    @IBAction func segueToSelectedScreen(_ sender: Any) {
        performSegue(withIdentifier: segueID, sender: sender)
    }
    
}
