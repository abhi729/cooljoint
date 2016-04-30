//
//  LaunchViewController.swift
//  Cool Joint
//
//  Created by Zoojoobe on 01/04/16.
//  Copyright © 2016 Abhishek Agarwal. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LaunchViewController.skipToLogin), userInfo: nil, repeats: false)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func skipToLogin() {
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.CURRENT_USER_REF.authData != nil {
            self.performSegueWithIdentifier("SegueToHome", sender: self)
        } else {
            self.performSegueWithIdentifier("SegueToSignIn", sender: self)
        }
    }
    
}
