//
//  ViewController.swift
//  Duck App
//
//  Created by Austin Mills on 2/5/17.
//  Copyright © 2017 Austin Mills. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var mainMenuLImage: UIImageView! //left image view
    @IBOutlet weak var mainMenuRImage: UIImageView! //right image view

    
    override func viewDidLoad() {
        
        setBackground()
       
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
        mainMenuLImage.layer.borderWidth = 5
        mainMenuRImage.layer.borderWidth = 5
    
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
    

    
}

