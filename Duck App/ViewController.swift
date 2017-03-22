//
//  ViewController.swift
//  Duck App
//
//  Created by Matthew Meade Mabrey on 2/6/17.
//  Copyright © 2017 Matthew Meade Mabrey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userIdle() {
        //set active view to the starting screen
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FirstView") as! ViewController
        present(vc, animated: true, completion: nil)
    }
}
