//
//  WorldSelectTableViewController.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 8/28/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import UIKit
import CoreData

class WorldSelectTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    var worlds: [NSString] = []
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        if Game.sharedInstance.mode == GameMode.Edit {
            self.navigationItem.rightBarButtonItem = self.editButtonItem()
        }
        
        // Fetch existing world models
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - CoreData
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: worldFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func worldFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "World")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        if (fetchedResultController.sections? != nil) {
            let sections = fetchedResultController.sections!
            return sections.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        // Number of world models saved plus a cell to create a new world
        let sectionInfo: NSFetchedResultsSectionInfo = fetchedResultController.sections?[section] as NSFetchedResultsSectionInfo
        let numberOfWorlds = sectionInfo.numberOfObjects
        self.editButtonItem().enabled = self.editing || numberOfWorlds > 0
        
        switch Game.sharedInstance.mode {
        case GameMode.Play:
            return numberOfWorlds
        case GameMode.Edit:
            if tableView.editing {
                return numberOfWorlds
            } else {
                return numberOfWorlds + 1
            }
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var reuseIdentifier: String = "Cell"
        var text: String = ""
        
        // Configure the cell...
        let sectionInfo: NSFetchedResultsSectionInfo = fetchedResultController.sections?[indexPath.section] as NSFetchedResultsSectionInfo
        if indexPath.row == sectionInfo.numberOfObjects {
            reuseIdentifier = "New World Cell"
            text = "Create New (Empty World)"
        } else {
            let worldModel = fetchedResultController.objectAtIndexPath(indexPath) as WorldModel
            text = worldModel.name
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = text;
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if cell.reuseIdentifier == "New World Cell" {
            self.performSegueWithIdentifier("toCreateWorld", sender: cell)
        } else {
            let worldModel = fetchedResultController.objectAtIndexPath(indexPath) as WorldModel
            let world = World(model: worldModel)
            println("world model: \(worldModel)")
            Game.sharedInstance.loadGame(worldModel)
        }
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if cell?.reuseIdentifier == "Cell" {
            self.performSegueWithIdentifier("toGame", sender: nil)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
        tableView.reloadData()
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.reloadData() // Reload to exclude cells unavailable for editing
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        let cell: UITableViewCell? = self.tableView.cellForRowAtIndexPath(indexPath)
        if cell != nil && cell!.reuseIdentifier == "New World Cell" {
            return false
        }
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the world managed object
            let managedObject:NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as NSManagedObject
            managedObjectContext?.deleteObject(managedObject)
            managedObjectContext?.save(nil)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let identifier = segue.identifier!
    }
    */
}
