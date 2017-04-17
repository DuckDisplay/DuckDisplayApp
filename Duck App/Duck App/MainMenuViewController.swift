//
//  MainMenuViewController.swift
//  Duck App
//
//  Created by Austin Mills on 4/8/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, UIPageViewControllerDataSource {

    
    var pageViewController : UIPageViewController!
    var newViewController : UIViewController!
    var pageTitles : NSArray!
    var pageDesciption: NSArray!
    var segueIdentifiers: NSArray!
    var changeView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationController!.viewControllers.removeAll()
        self.pageTitles = NSArray (objects: "Duck Species", "Trivia Game", "Conservation")
        self.pageDesciption = NSArray(objects:"Learn about 15 different species of ducks.", "Test you knowledge on ducks and their habibtat!", "Our nations wetlands face their greatest risk in 35 years.")
        self.segueIdentifiers = NSArray(objects: "DuckSpecies", "TriviaGame", "Conservation")
        
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as? UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(index: 0) as ContentViewController
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
    
    
     

    func viewControllerAtIndex(index: Int) -> ContentViewController
    {
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count)){
        
        return ContentViewController()
    }
        let vc: ContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        
        vc.titleText = self.pageTitles[index] as! String
        vc.descriptionText = self.pageDesciption[index] as! String
        vc.segueID = self.segueIdentifiers[index] as! String
        vc.pageIndex = index
        
        return vc
}
    
    //MARK: Page View Controller Datace
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if ((index == 0) || (index == NSNotFound)){
            return nil
        }
        index = index - 1
        return self.viewControllerAtIndex(index: index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound)
        {
            return nil
        }
        
        index = index + 1
        
        if (index == self.pageTitles.count)
        {
            return nil
        }
        
        return self.viewControllerAtIndex(index: index)
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func changeViewed(index: Int){
        if (index == 1){
            self.performSegue(withIdentifier: "DuckSpecies", sender: self)
        }
        else if (index == 2){
            self.performSegue(withIdentifier: "TriviaGame", sender: self)
        }
    }
    
}


