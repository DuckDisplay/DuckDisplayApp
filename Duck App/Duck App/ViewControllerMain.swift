//
//  ViewController.swift
//  Duck App
//
//  Created by Austin Mills on 2/5/17.
//  Copyright © 2017 Austin Mills. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
   

    
    override func viewDidLoad() {
        
        setBackground()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   func setBackground() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "MallardFlying")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
   
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
    
        addBlurEffect()
    
        }
    
    //Function to blur background
    func addBlurEffect()
    {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        view.addSubview(blurEffectView)
        
    }
    

    
}

