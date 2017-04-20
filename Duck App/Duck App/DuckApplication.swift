//
//  DuckApplication.swift
//  Duck App
//
//  Created by Benjamin Cyr on 4/19/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit
import Foundation

class DuckApplication: UIApplication
{
    var timer: Timer?
    let idleTimoutSeconds : TimeInterval = 300
    
    override func sendEvent(_ event: UIEvent)
    {
        super.sendEvent(event)
        if let all_touches = event.allTouches {
            for touch in all_touches {
                if touch.phase == UITouchPhase.began {
                    self.resetTimer()
                }
            }
        }
    }
    
    //Function that detects touches and resets timer when detected
    func resetTimer() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: idleTimoutSeconds, target: self, selector: #selector(showScreenSaver), userInfo: nil, repeats: false)
    }
    
    //Presents screen saver ViewController when timer runs out
    func showScreenSaver() {
        self.timer?.invalidate()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryboardIpad = UIStoryboard(name: "Main", bundle: nil)
        let initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "ScreenSaverView") as UIViewController
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window?.rootViewController = initialViewControlleripad
        appDelegate.window?.makeKeyAndVisible()
    }
}
