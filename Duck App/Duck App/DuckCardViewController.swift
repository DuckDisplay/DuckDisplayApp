//
//  DuckCardViewController.swift
//  Duck App
//
//  Created by Mark Gallagher Jr on 4/6/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class DuckCardViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var duckCardImageView: UIImageView!
    @IBOutlet weak var duckCardImageLabel: UILabel!
    @IBOutlet weak var duckCardAudioButton: UIButton!
    
    @IBOutlet weak var duckCardName: UILabel!
    @IBOutlet weak var duckCardScienceName: UILabel!
    
    @IBOutlet weak var duckCardDesc: UITextView!
    @IBOutlet weak var duckCardBehavior: UITextView!
    @IBOutlet weak var duckCardFood: UITextView!
    @IBOutlet weak var duckCardHabitat: UITextView!
    @IBOutlet weak var duckCardNesting: UITextView!
    @IBOutlet weak var duckCardConservation: UITextView!
    @IBOutlet weak var duckCardFunFacts: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
