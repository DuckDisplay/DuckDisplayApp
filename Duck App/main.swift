//
//  main.swift
//  Duck App
//
//  Created by Matthew Meade Mabrey on 2/16/17.
//  Copyright © 2017 Matthew Meade Mabrey. All rights reserved.
//

import Foundation
import UIKit

UIApplicationMain(
    CommandLine.argc, UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)), NSStringFromClass(TimerClass.self), NSStringFromClass(AppDelegate.self)
)
