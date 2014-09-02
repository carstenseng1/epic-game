//
//  GameScene.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 8/13/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var player: Player? = nil
    
    var world: World? = nil {
        didSet {
            if Game.sharedInstance.mode == GameMode.Play {
                if world? != nil && world!.model? != nil {
                    worldNameLabel.hidden = false
                    worldNameLabel.text = world!.model!.name
                } else {
                    worldNameLabel.hidden = true
                    worldNameLabel.text = nil
                }
            }
            
            Game.sharedInstance.gameViewController?.gameScene(self, didSetWorld: world)
        }
    }
    
    let worldNameLabel = SKLabelNode()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        
        // Add label to display world name
        worldNameLabel.fontSize = 65
        worldNameLabel.hidden = true
        worldNameLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(worldNameLabel)
        
        // Add the player
        let player = Player(imageNamed: "Spaceship")
        let playerScale: CGFloat = 0.5
        
        player.xScale = playerScale
        player.yScale = playerScale
        player.position = CGPoint(x: self.frame.midX, y: self.frame.midY);
        
        /*
        let playerTextureSize = player.texture.size()
        let playerPhysicsRadius = CGFloatMean(playerTextureSize.width * playerScale, playerTextureSize.height * playerScale)
        player.physicsBody = SKPhysicsBody(circleOfRadius: playerPhysicsRadius);
        */
        
        self.addChild(player)
        self.player = player;
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            print("\n\(touch)\n")
            let location = touch.locationInNode(self)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if (player! != nil) {
            player!.update()
        }
    }
}
