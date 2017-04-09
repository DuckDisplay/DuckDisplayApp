//
//  ContentViewController.swift
//  Duck App
//
//  Created by Austin Mills on 4/8/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var changeView: UIButton!

    
    var pageIndex: Int!
    var titleText: String!
    var descriptionText: String!
    var changeViews: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = self.titleText
        self.descriptionLabel.text = self.descriptionText
        self.changeView = self.changeViews
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
         

}
