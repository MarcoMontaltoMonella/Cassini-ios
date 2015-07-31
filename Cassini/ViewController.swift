//
//  ViewController.swift
//  Cassini
//
//  Created by Marco Montalto Monella on 29/07/2015.
//  Copyright (c) 2015 Marco Montalto Monella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let ivc = segue.destinationViewController as? ImageViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case "Earth":
                        ivc.imageURL = DemoURL.NASA.Earth
                        ivc.title = "Earth"
                    case "Saturn":
                        ivc.imageURL = DemoURL.NASA.Saturn
                        ivc.title = "Saturn"
                    case "Cassini":
                        ivc.imageURL = DemoURL.NASA.Cassini
                        ivc.title = "Cassini"
                        timerTest()
                    default: break
                }
            }
        }
    }
    
    func timerTest(){
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "fire:", userInfo: nil, repeats: true)
        timer.tolerance = 0.1
    }
    
    var counter = 10
    
    func fire(timer: NSTimer){
        if counter == 0 {
            timer.invalidate()
            println("Launched!")
        } else {
            println("countdown: \(counter--)")
        }
    }
    

}

