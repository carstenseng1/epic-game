//
//  CreateWorldViewController.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 8/30/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import UIKit
import CoreData

class CreateWorldViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - IBOutlets
    
    @IBOutlet var worldNameTextField: UITextField? = nil
    
    // MARK: - IBActions
    
    @IBAction func doneAction(AnyObject) {
        var worldName: NSString? = self.worldNameTextField?.text
        if worldName == nil || worldName!.isEqualToString("") {
            worldName = "New World"
        }
        
        World.createModel(worldName!, width: 100, height: 100)
        self.navigationController?.popViewControllerAnimated(true)
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
}
