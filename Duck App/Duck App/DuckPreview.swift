//
//  DuckPreview.swift
//  Duck App
//
//  This class creates data objects that store data for the Duck Card Gallery
//
//  Created by Auburn University Senior Design on 4/3/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class DuckPreview: NSObject {
    
    // MARK: Properties
    var duckImage: UIImage?
    var duckName: String
    
    // MARK: Initialization
    init? (duckName: String, duckImage: UIImage?) {
        // Init fails if no name provided
        guard !duckName.isEmpty else {
            return nil
        }
        
        // Initialize stored properties
        self.duckName = duckName
        self.duckImage = duckImage
    }
    
}
