//
//  HUDViewController.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 8/31/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import UIKit

class HUDViewController: UIViewController, MovementTouchViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Hide background */
        self.view.backgroundColor = nil

        /* Setup HUD components */
        self.movementTouchView?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Interface Builder
    
    @IBOutlet var movementTouchView: MovementTouchView?
    
    // MARK: - MovementTouchViewDelegate
    
    func movementTouchViewDidChangeValue(movementTouchView: MovementTouchView, value: CGVector) {
        Game.sharedInstance.gameViewController?.gameScene.player?.velocity = value // invert to transfer to SKScene coordinates
    }
}
