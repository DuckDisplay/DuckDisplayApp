//
//  ViewController.swift
//  Duck App
//
//  Created by Austin Mills on 2/5/17.
//  Copyright © 2017 Austin Mills. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    //@IBOutlet weak var mainMenuLImage: UIImageView! //left image view
   // @IBOutlet weak var mainMenuRImage: UIImageView! //right image view
    var timer: Timer?
    
    override func viewDidLoad() {
        
       // setBackground()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       // timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(showScreenSaver), userInfo: nil, repeats: false)
        
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
       // mainMenuLImage.layer.borderWidth = 5
        //mainMenuRImage.layer.borderWidth = 5
        
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
    
    //Function that detects touches and resets timer when detected
    override func touchesBegan(_ touches: Set<UITouch>?, with event: UIEvent?) {
        if (touches != nil) {
            //reset timer
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(showScreenSaver), userInfo: nil, repeats: false)
        }
    }
    
    //Presents screen saver ViewController when timer runs out
    func showScreenSaver() {
        timer?.invalidate()
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ScreenSaverView") as! ViewController
        
        self.present(vc, animated: true, completion: nil)
    }
}

