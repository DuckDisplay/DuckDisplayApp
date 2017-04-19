//
//  PageScreenProtocol.swift
//  Duck App
//
//  This protocol defines what any view controller used as a page in a Page View Controller 
//  should follow.
//
//  Created by Mark Gallagher Jr on 4/19/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import Foundation

//  Define the PageScreenProtocol
//      Should be implemented by any View Controller used as a page
//      Needs a page index to determine which page this view controller is in
protocol PageScreenProtocol {
    var pageIndex: Int! { get set }
}
