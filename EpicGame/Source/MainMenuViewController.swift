//
//  MainMenuViewController.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 8/13/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

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
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        super.prepareForSegue(segue, sender: sender)
        
        let identifier: String = segue.identifier
        switch identifier {
            case "play":
                Game.sharedInstance.mode = GameMode.Play
            case "edit":
                Game.sharedInstance.mode = GameMode.Edit
            default:
                println("Default Game Mode")
        }
    }
}
