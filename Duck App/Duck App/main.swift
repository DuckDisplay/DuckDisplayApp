//
//  main.swift
//  Duck App
//
//  Created by Auburn University Senior Design on 4/19/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import Foundation
import UIKit

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(DuckApplication.self),
    NSStringFromClass(AppDelegate.self)
)
