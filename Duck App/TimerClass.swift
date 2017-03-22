//
//  TimerClass.swift
//  Duck App
//
//  Created by Matthew Meade Mabrey on 2/16/17.
//  Copyright © 2017 Matthew Meade Mabrey. All rights reserved.
//

import UIKit
import Foundation

class TimerClass : UIApplication {
    
    // The timeout in seconds for when to fire the idle timer.
    let timeoutInSeconds: TimeInterval = 2
    
    var idleTimer: Timer?
    
    // Listen for any touch. If the screen receives a touch, the timer is reset.
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        
        if idleTimer != nil {
            self.resetIdleTimer()
        }
        
        if let touches = event.allTouches {
            for touch in touches {
                if touch.phase == UITouchPhase.began {
                    self.resetIdleTimer()
                }
            }
        }
    }
    
    // Reset the timer because there was user interaction.
    func resetIdleTimer() {
        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }
        
        //reinitialize timer
        idleTimer = Timer.scheduledTimer(timeInterval: timeoutInSeconds, target: self, selector: #selector(idleTimerExceeded), userInfo: nil, repeats: false)
    }
    
    // If the timer reaches the limit as defined in timeoutInSeconds, do stuff.
    @objc func idleTimerExceeded() {
        //nothing for now, needed selector method for constructor
    }
    
}
