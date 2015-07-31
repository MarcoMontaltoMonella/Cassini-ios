//
//  ImageViewController.swift
//  Cassini
//
//  Created by Marco Montalto Monella on 29/07/2015.
//  Copyright (c) 2015 Marco Montalto Monella. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    //model
    var imageURL: NSURL? {
        didSet{
            image = nil
            //window is nil if I am not currently looking at the window (no waste of cellular data)
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private func fetchImage(){
        if let url = imageURL {
            // NSData is just a bag of bits
            
            spinner?.startAnimating()
            
            let qos = Int(QOS_CLASS_USER_INITIATED.value)
            let queue = dispatch_get_global_queue(qos, 0)
            
            dispatch_async(queue) { () -> Void in
                let imageData = NSData(contentsOfURL: url)
                
                dispatch_async(dispatch_get_main_queue()){
                    // N.B. The UI must be handled in the main queue
                    if url == self.imageURL {
                        // if the user is still waiting for the requested image
                        
                        if imageData != nil {
                            self.image = UIImage(data: imageData!)
                        } else {
                            self.image = nil
                            // is calling the computed property
                        }
                    }
                }
            }
        }
    }
    
    // image in which I want to zoom on
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet{
            // great place to set the delegate of outlets
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    
  // Create an user view in code (without storyboard)

    private var imageView = UIImageView()
    
    //computed property
    private var image: UIImage? {
        get{ return imageView.image }
        set{
            //do something when the image change
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    // Good place to build the view hierarchy
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //if someone is currently looking at the window -> download image
        if image == nil {
            fetchImage()
        }
    }

}
