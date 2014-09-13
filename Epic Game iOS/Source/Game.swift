//
//  Game.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 8/31/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import UIKit

enum GameMode {
    case Default
    case Play
    case Edit
}

class Game: NSObject {
    class var sharedInstance : Game {
        struct Static {
            static let instance : Game = Game()
        }
        return Static.instance
    }
    
    var mode: GameMode = GameMode.Default
    
    weak var gameViewController: GameViewController?
    
    func quit() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = mainStoryboard.instantiateViewControllerWithIdentifier("Main Navigation Controller") as UINavigationController
        UIApplication.sharedApplication().keyWindow.rootViewController = navigationController;
    }
    
    func loadGame(worldModel: WorldModel) {
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as GameViewController
        viewController.gameScene.world = World(model: worldModel)
        
        UIApplication.sharedApplication().keyWindow.rootViewController = viewController;
        gameViewController = viewController
    }
}