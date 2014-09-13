//
//  CoreDataExtensions.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 9/7/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import Foundation
import CoreData

extension NSFetchedResultsController  {
    
    var numberOfSections: Int {
        get {
            // Return the number of sections.
            if (sections? != nil) {
                return sections!.count
            }
            return 0
        }
    }
    
}