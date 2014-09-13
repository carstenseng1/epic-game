//
//  GameEditorCollectionViewController.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 9/7/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import UIKit
import CoreData

let reuseIdentifier = "Cell"

class GameEditorCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {
    var worlds: [NSString] = []
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView?.registerClass(GameEditorCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Fetch existing world models
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CoreData
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: worldCellFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func worldCellFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "WorldCell")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func numberOfWorldCells(section: Int) -> Int {
        let sectionInfo: NSFetchedResultsSectionInfo = fetchedResultController.sections?[section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    func worldCellAtIndexPath(indexPath: NSIndexPath) -> WorldCellModel {
        return fetchedResultController.objectAtIndexPath(indexPath) as WorldCellModel
    }
    
    func deleteWorldCell(indexPath: NSIndexPath) {
        let managedObject:NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as NSManagedObject
        managedObjectContext?.deleteObject(managedObject)
        managedObjectContext?.save(nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    
    // MARK: UICollectionViewDataSource
    func collectionViewCellResuseIdentifier(indexPath: NSIndexPath) -> String {
        if indexPath.row == numberOfWorldCells(indexPath.section) {
            return "Add"
        } else {
            return "Cell"
        }
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return fetchedResultController.numberOfSections
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return number of world cell models saved plus a cell to create a new one
        return self.numberOfWorldCells(section) + 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let reuseIdentifier = collectionViewCellResuseIdentifier(indexPath)
        
    
        // Configure the cell
        if reuseIdentifier == "Cell" {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as GameEditorCollectionViewCell
            let worldCellModel = worldCellAtIndexPath(indexPath)
            println("cell: name: \(worldCellModel.name), imageName: \(worldCellModel.imageName)")
            
            var image: UIImage? = UIImage(named: worldCellModel.imageName)
            if image != nil {
                cell.imageView?.image = image
            } else {
                println("Image not found in bundle: \(worldCellModel.imageName)")
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell
            
            return cell
        }
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let reuseIdentifier = collectionView.cellForItemAtIndexPath(indexPath)?.reuseIdentifier
        if reuseIdentifier == "Cell" {
            let worldCellModel = worldCellAtIndexPath(indexPath)
            println("Sected world cell: \(worldCellModel.name)")
            
            // Delete the world cell, re-fetch world cell models, then reload the collection view
            deleteWorldCell(indexPath)
            fetchedResultController.performFetch(nil)
            collectionView.reloadData()
        } else if reuseIdentifier == "Add" {
            self.performSegueWithIdentifier("toCreateCell", sender: self)
        }
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(collectionView: UICollectionView!, shouldHighlightItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    func collectionView(collectionView: UICollectionView!, shouldSelectItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    func collectionView(collectionView: UICollectionView!, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return false
    }

    func collectionView(collectionView: UICollectionView!, canPerformAction action: String!, forItemAtIndexPath indexPath: NSIndexPath!, withSender sender: AnyObject!) -> Bool {
        return false
    }

    func collectionView(collectionView: UICollectionView!, performAction action: String!, forItemAtIndexPath indexPath: NSIndexPath!, withSender sender: AnyObject!) {
    
    }
    */

}
