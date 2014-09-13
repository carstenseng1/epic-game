//
//  WorldCell.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 8/17/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import SpriteKit
import CoreData

class WorldCell: SKSpriteNode {
    var model: WorldCellModel? = nil
    
    convenience init(model: WorldCellModel) {
        self.init()
        self.model! = model
    }
    
    class func createModel(name: String, imageName: String) -> WorldCellModel {
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext:NSManagedObjectContext = appDelegate.managedObjectContext!
        
        let entityDescripition = NSEntityDescription.entityForName("WorldCell", inManagedObjectContext: managedObjectContext)!
        let model: WorldCellModel = WorldCellModel(entity: entityDescripition, insertIntoManagedObjectContext: managedObjectContext)
        model.name = name
        model.imageName = imageName
        
        managedObjectContext.save(nil)
        
        return model
    }
}
