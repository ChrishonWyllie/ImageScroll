//
//  ViewController.swift
//  ImageScroll
//
//  Created by Chrishon Wyllie on 3/26/17.
//  Copyright © 2017 Chrishon Wyllie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // This is done programmatically for 'simplicity'
    
    // These are used to determine the placement of images in the scroll view. Even if they are off the screen and out of view
    let deviceScreenWidth = UIScreen.main.bounds.width
    let deviceScreenHeight = UIScreen.main.bounds.height
    
    var imageScrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        
        // We will set the frame for the scrollView in the setupImageScrollView() function
        
        // This will be a horizontal scroll view, so this is unnecessary
        //scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        
        // This makes the scroll view have a 'page-like' effect. Imagine an effect similar to snapchat.
        // This is truly the important part
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.bounces = true
        
        scrollView.clipsToBounds = true
        
        return scrollView
        
    }()
    
    var pageControlForScrollView: UIPageControl = {
        
        let pageControl = UIPageControl()
        
        // We will set the frame for the pageControl in the setupImageScrollView() function
        
        // Must be equal to the number of images you expect to display. This will update as the pages are scrolled
        pageControl.numberOfPages = 5
        
        // Set the currentPage once this object is instantiated to the first page
        pageControl.currentPage = 0
        
        // Optional
        //pageControl.hidesForSinglePage = true
        
        // The color of any page that is not currently selected
        pageControl.pageIndicatorTintColor = UIColor.orange
        
        // The color of the selected page indicator
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        
        return pageControl
        
    }()
    
    
    // Not the prettiest named function but its purpose is obviouse
    private func setupImageScrollView() {
        
        // add as a subview of this view controller's default view
        view.addSubview(imageScrollView)
        view.addSubview(pageControlForScrollView)
        
        // Add constraints for the image scroll view so that it fits the entire background of the screen
        imageScrollView.frame = CGRect(x: 0, y: 0, width: deviceScreenWidth, height: deviceScreenHeight)
        
        /*
        let originPoint = CGPoint(x: deviceScreenWidth / 2, y: deviceScreenHeight / 2)
        let sizeForPageControl = CGSize(width: 100, height: 50)
        pageControlForScrollView.frame = CGRect(origin: originPoint, size: sizeForPageControl)
        */
        
        pageControlForScrollView.center.x = deviceScreenWidth / 2
        pageControlForScrollView.center.y = deviceScreenHeight / 2
        
        
        
        
        
        
        
        
        /* 
         Now this is quite important.
         These are the UIImageView objects that will displayed side by side in a horizontal manner
         Notice that x-position for each subsequent UIImageView corresponds to the page it will be displayed on
         
         
         In order to display the second page and every after next to each other,
         you need to multiply the deviceScreenWidth (which is also the same width of the imageScrollView)
         by the page number you expect the image to be on
         page 1     page 2
         +-----+    +-----+
         |     |    |
         | img1|    | img 2
         |     |    |           .... .... . ..
         +-----+    +-----+
         
         deviceScreenWidth * (pageNumber)
         
        */
        
        let imgOne = UIImageView(frame: CGRect(x: 0, y: 0, width: deviceScreenWidth, height: deviceScreenHeight))
        let imgTwo = UIImageView(frame: CGRect(x: deviceScreenWidth, y: 1, width: deviceScreenWidth, height: deviceScreenHeight))
        let imgThree = UIImageView(frame: CGRect(x: deviceScreenWidth * 2, y: 0, width: deviceScreenWidth, height: deviceScreenHeight))
        let imgFour = UIImageView(frame: CGRect(x: deviceScreenWidth * 3, y: 0, width: deviceScreenWidth, height: deviceScreenHeight))
        let imgFive = UIImageView(frame: CGRect(x: deviceScreenWidth * 4, y: 0, width: deviceScreenWidth, height: deviceScreenHeight))
        
        
        
        
        
        
        
        
        // These are the actual images that will be displayed in each UIImageView for the scroll view.
        // The actual jpg or png images are in the assets.xcassets
        imgOne.image = UIImage(named: "Image1.jpg")
        imgTwo.image = UIImage(named: "Image2.jpg")
        imgThree.image = UIImage(named: "Image3.jpg")
        imgFour.image = UIImage(named: "Image4.jpg")
        imgFive.image = UIImage(named: "Image5.jpg")
        
        
        
        
        
        
        
        
        // Add all the UIImageView objects as subviews of the UIScrollView
        imageScrollView.addSubview(imgOne)
        imageScrollView.addSubview(imgTwo)
        imageScrollView.addSubview(imgThree)
        imageScrollView.addSubview(imgFour)
        imageScrollView.addSubview(imgFive)
        
        
        
        
        
        
        
        // The ' * 5 ' is to set the size of the image scroll view to fit all the images
        imageScrollView.contentSize = CGSize(width: deviceScreenWidth * 5, height: deviceScreenHeight)
        
        
        
        
        
        
        // This allows you to use some delegate functions for the UIScrollView
        // Defined in extension below
        imageScrollView.delegate = self
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // finally call the setup function in viewdidload
        
        setupImageScrollView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



// Instead of implementing the UIScrollView delegate functions in the above class declaration, I have chosen to put 
// thise delegate functions in an 'extension' of the ViewController.swift class in order to "keep it clean"

extension ViewController: UIScrollViewDelegate {
    
    // This function is called on its own, being a protocol function. 
    // There is no need to call it manually
    
    /* 
     Whenever the image scroll view has been scrolled, it begins to decelerate
     until finally ending. At such point, this function is called.
     Here, we change the active page of the page control we defined above
     */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // Determine which page we are currently on AFTER the scrolling ends
        let pageNumber = round(imageScrollView.contentOffset.x / scrollView.frame.size.width)
        
        // Set the current page to page we determined
        pageControlForScrollView.currentPage = Int(pageNumber)
        
        
    }
    
}

