//
//  WorldModel.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 8/30/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import Foundation
import CoreData

class WorldModel: NSManagedObject {

    @NSManaged var cells: AnyObject
    @NSManaged var name: String
    @NSManaged var width: NSNumber
    @NSManaged var height: NSNumber

}
