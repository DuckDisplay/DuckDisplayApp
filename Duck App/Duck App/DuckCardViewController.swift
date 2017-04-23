//
//  DuckCardViewController.swift
//  Duck App
//
//  Created byAuburn University Senior Design on 4/6/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit
import AVFoundation

class DuckCardViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var pictureScrollView: UIScrollView!
    @IBOutlet weak var picturePageControl: UIPageControl!

    @IBOutlet weak var duckCardAudioButton: UIButton!
    @IBOutlet weak var duckCardName: UILabel!
    @IBOutlet weak var duckCardScienceName: UILabel!
    
    @IBOutlet weak var duckCardDesc: UITextView!
    @IBOutlet weak var duckCardBehavior: UITextView!
    @IBOutlet weak var duckCardFood: UITextView!
    @IBOutlet weak var duckCardHabitat: UITextView!
    @IBOutlet weak var duckCardNesting: UITextView!
    @IBOutlet weak var duckCardConservation: UITextView!
    @IBOutlet weak var duckCardFunFacts: UITextView!
    
    
    var duckSound: AVAudioPlayer!
    
    // Stores the duck info object displayed on screen
    var duckInfo: DuckInfo?
    
    // Setup views for a Duck
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBackground(backgroundImage: #imageLiteral(resourceName: "duckBackgroundBlur"))
        
        configurePageControl()
        
        if let duck = duckInfo {
            var imageList : [UIImage] = [duck.duckImage!]
            for extraPhoto in duck.duckExtraPhotos.components(separatedBy: ","){
                if let photo = UIImage(named: extraPhoto) {
                    imageList.append(photo)
                }
            }
            configureImages(imageList: imageList)
            
            duckCardName.text = duck.duckName
            duckCardScienceName.text = duck.duckScienceName
            
            duckCardDesc.text = duck.duckDesc
            duckCardBehavior.text = duck.duckBehavior
            duckCardFood.text = duck.duckFood
            duckCardHabitat.text = duck.duckHabitat
            duckCardNesting.text = duck.duckNesting
            duckCardConservation.text = duck.duckConservation
            duckCardFunFacts.text = duck.duckFunFacts
        }
        
        duckCardAudioButton.setImage(#imageLiteral(resourceName: "PlayIcon"), for: UIControlState.normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if duckSound != nil {
            duckSound.stop()
            duckSound = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func audioButtonPressed(_ sender: Any) {
        if duckSound != nil {
            duckSound.stop()
            duckCardAudioButton.setImage(#imageLiteral(resourceName: "PlayIcon"), for: UIControlState.normal)
            duckSound = nil
        }
        else if let duck = duckInfo {
            duckSound = playSound(nameOfAudioFileInAssetCatalog: duck.duckAudioPath)
            duckCardAudioButton.setImage(#imageLiteral(resourceName: "PauseIcon"), for: UIControlState.normal)
        }
    }
    
    func addBackground(backgroundImage: UIImage) {
        // screen width and height:
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = backgroundImage
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        
        self.view.addSubview(imageViewBackground)
        self.view.sendSubview(toBack: imageViewBackground)
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.picturePageControl.currentPage = 0
        self.picturePageControl.tintColor = UIColor.red
        self.picturePageControl.pageIndicatorTintColor = UIColor.darkGray
        self.picturePageControl.currentPageIndicatorTintColor = UIColor.white
        self.picturePageControl.backgroundColor = UIColor.gray.withAlphaComponent(0.75)
        self.picturePageControl.addTarget(self, action: #selector(changePage), for: UIControlEvents.valueChanged)
    }
    
    func configureImages(imageList : [UIImage]){
        var index : CGFloat = 0
        for image in imageList {
            let imageView = UIImageView(image: image)
            imageView.frame.origin.x = self.pictureScrollView.frame.size.width * index
            imageView.frame.size = self.pictureScrollView.frame.size
            imageView.contentMode = UIViewContentMode.scaleAspectFit;
            self.pictureScrollView.addSubview(imageView)
            index += 1
        }
        self.pictureScrollView.delegate = self
        self.picturePageControl.numberOfPages = Int(index)
        self.pictureScrollView.contentSize = CGSize(width: self.pictureScrollView.frame.size.width * index, height: self.pictureScrollView.frame.size.height)
    }
    
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(picturePageControl.currentPage) * pictureScrollView.frame.size.width
        pictureScrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        picturePageControl.currentPage = Int(pageNumber)
    }
    
    func resize(){
        let textView: Array<UITextView>! = [duckCardDesc, duckCardBehavior, duckCardFood, duckCardHabitat, duckCardNesting, duckCardConservation, duckCardFunFacts]
        for view in textView {
            let fixedWidth = view.frame.size.width
            let newSize = view.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            view.frame.size = CGSize(width: fixedWidth, height: newSize.height)
        }
    }
    
    func playSound(nameOfAudioFileInAssetCatalog: String) -> AVAudioPlayer? {
        var audioPlayer: AVAudioPlayer?
        if let sound = NSDataAsset(name: nameOfAudioFileInAssetCatalog) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data, fileTypeHint: AVFileTypeMPEGLayer3)
                audioPlayer!.play()
            } catch {
                print("error initializing AVAudioPlayer")
            }
        }
        return audioPlayer
    }

}
