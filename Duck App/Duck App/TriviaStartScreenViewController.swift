//
//  TriviaStartScreenViewController.swift
//  Duck App
//
//  Created by John Cancilla on 4/3/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class TriviaStartScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
          setBackground()
        // Do any additional setup after loading the view.
        
        //initial user to prevent nil...
        if(users.count < 1) {
            let devUser = Users(place: 1, name: "Development Squad", state: "Domination Station", score: 5000)
            users.append(devUser)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackground() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "mmbackground")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        
        addBlurEffect()
        
    }
    //Function to blur background
    func addBlurEffect()
    {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        view.addSubview(blurEffectView)
        self.view.insertSubview(blurEffectView, at: 0)
        
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


