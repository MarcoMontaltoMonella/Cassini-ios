//
//  ImageViewController.swift
//  Cassini
//
//  Created by Marco Montalto Monella on 29/07/2015.
//  Copyright (c) 2015 Marco Montalto Monella. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

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
    
    private func fetchImage(){
        if let url = imageURL {
            // NSData is just a bag of bits
            // It can be slow. Or the phone can disconnect from the network
            let imageData = NSData(contentsOfURL: url)
            if imageData != nil {
                image = UIImage(data: imageData!)
            } else {
                image = nil
                //is calling the computed property
            }
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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //if someone is currently looking at the window -> download image
        if image == nil {
            fetchImage()
        }
    }

}
