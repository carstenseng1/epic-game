//
//  World.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 8/17/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import SpriteKit
import CoreData

class World: SKNode {
    var cells = [WorldCell]()
    var model: WorldModel? = nil {
        didSet {
            if model? != nil {
                cells = []
                for var x: UInt = 0; x < model!.width; ++x {
                    for var y: UInt = 0; y < model!.height; ++y {
                        cells.append(WorldCell())
                    }
                }
            }
        }
    }
    
    convenience init(model: WorldModel) {
        self.init()
        self.model = model
    }
    
    class func createModel(name: String, width: UInt, height: UInt) -> WorldModel {
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext:NSManagedObjectContext = appDelegate.managedObjectContext!
        
        let entityDescripition = NSEntityDescription.entityForName("World", inManagedObjectContext: managedObjectContext)!
        let model: WorldModel = WorldModel(entity: entityDescripition, insertIntoManagedObjectContext: managedObjectContext)
        model.name = name
        model.width = width
        model.height = height
        
        managedObjectContext.save(nil)
        
        return model
    }
}
