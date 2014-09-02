//
//  PauseMenuViewController.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 8/13/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import UIKit

class PauseMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func resumeAction(sender: AnyObject) {
        [self.dismissViewControllerAnimated(true, completion: { () -> Void in
            NSLog("resumeAction \(sender)", 0);
        })];
    }
    
    @IBAction func quitAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        Game.sharedInstance.quit()
    }
}
