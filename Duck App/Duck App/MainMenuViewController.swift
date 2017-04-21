//
//  MainMenuViewController.swift
//  Duck App
//
//  Created by Austin Mills on 4/8/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, UIPageViewControllerDataSource {
    
    // MARK: Properties
    
    var pageViewController : UIPageViewController!
    
    // Arrays store data for each page on the Main Menu
    var pageTitles : NSArray!
    var backgrounds: NSArray!
    var pageDesciption: NSArray!
    var segueIdentifiers: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize arrays with details for each screen (currently using 5 screens)
        self.pageTitles = NSArray (objects: "Welcome Screen",
                                            "Duck Species",
                                            "Trivia Game",
                                            "Conservation",
                                            "Credits")
        self.backgrounds = NSArray(objects: "",
                                            "mmbackground",
                                            "Duck-Camo",
                                            "conservationBackground",
                                            "")
        
        // The following is only for ContentViewController's (the stuff in between WelcomeScreen and Credits)
        self.pageDesciption = NSArray(objects: "Learn about 15 different species of ducks.",
                                               "Test you knowledge on ducks and their habitat!",
                                               "Our nations wetlands face their greatest risk in 35 years.")
        // These are segues from Main Menu to the different parts of the app
        self.segueIdentifiers = NSArray(objects: "DuckSpecies",
                                                 "TriviaGame",
                                                 "Conservation")
        
        // Instantiate page view controller
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as? UIPageViewController
        
        self.pageViewController.dataSource = self
        
        // Get first page view
        let startVC = self.viewControllerAtIndex(index: 0) as! WelcomeScreenViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRect(x:0, y:30, width:self.view.frame.width, height:self.view.frame.size.height - 30)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func viewControllerAtIndex(index: Int) -> UIViewController?
    {
        // Error checking: ensure not out of bounds or empty page view
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count)) {
            return ContentViewController()
        }
        
        // If first page, populate the Welcome Screen
        if (index == 0) {
            let vc: WelcomeScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeScreenViewController") as! WelcomeScreenViewController
            
            vc.pageIndex = index
            return vc
        }
        // Pages 1-3 direct to other parts of the app, the Duck Species, Trivia, or Conservation
        else if (index > 0 && index < self.pageTitles.count - 1) {
            let vc: ContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
            
            vc.titleText = self.pageTitles[index] as! String
            vc.background = self.backgrounds[index] as! String
            vc.descriptionText = self.pageDesciption[index - 1] as! String
            vc.segueID = self.segueIdentifiers[index - 1] as! String
            vc.pageIndex = index
            return vc
        }
        // Final page is the credits page
        else if (index == self.pageTitles.count - 1) {
            let vc: CreditsViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreditsViewController") as! CreditsViewController
            vc.pageIndex = index
            return vc
        }
        
        // Should never get here
        return nil
    }
    
    
    //MARK: Page View Controller Data source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // Get the index of this view controller
        let vc = viewController as? PageScreenProtocol
        var index = (vc?.pageIndex)!
        
        // Error checking: ensure not first view or not found object
        if ((index == 0) || (index == NSNotFound)){
            
            index = self.pageTitles.count
        }
        
        // Decrement index
        index = index - 1
        return self.viewControllerAtIndex(index: index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // Get the index of this view controller
        let vc = viewController as? PageScreenProtocol
        var index = (vc?.pageIndex)!
        
        // Error checking: ensure object is found
        if (index == NSNotFound)
        {
            return nil
        }
        
        // Increment index
        index = index + 1
        
        // Check if out-of-bounds
        if (index == self.pageTitles.count)
        {
            index = 0
        }
        
        return self.viewControllerAtIndex(index: index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
