//
//  Player.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 8/17/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    var velocity: CGVector = CGVector.zeroVector
    
    func update() {
        let moveAction = SKAction.moveBy(self.velocity, duration: 0)
        self.runAction(moveAction)
    }
}
