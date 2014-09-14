//
//  EditorViewController.swift
//  EpicGame
//
//  Created by Garret Carstensen on 9/13/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import UIKit
import SpriteKit

class EditorViewController: UIViewController, EditorLibraryDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        /* Pick a size for the scene */
//        let scene = GameScene(fileNamed:"GameScene")
        let scene = GameScene(size: CGSize(width: 1000, height: 1000));
        
        // Configure the view.
        let skView = self.view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        /* Present the scene */
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var gameScene: GameScene {
        let skView = self.view as SKView
            return skView.scene as GameScene
    }
    
    // MARK: - GameSceneDelegate
    
    func gameScene(gameScene: GameScene, didSetWorld world: World?) {
        if world? != nil && world!.model? != nil {
            // TODO: Display world name
        } else {
            
        }
    }
    
    // MARK: - EditorLibraryDelegate
    func editorLibraryDidSelectWorldCellModel(model: WorldCellModel) {
        
    }
    
    func editorLibraryDidSelectNewWorldCellModel() {
        self.performSegueWithIdentifier("toCreateWorldCell", sender: nil)
    }
    
    // MARK: - Interface Builder
    
    @IBAction func quitAction() {
        Game.sharedInstance.quit()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "embedLibrary" {
            let library = segue.destinationViewController as EditorLibraryViewController
            library.delegate = self
        }
    }

}
