//
//  CreateWorldCellViewController.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 9/7/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import UIKit
import CoreData

class CreateWorldCellViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Interface Builder
    @IBOutlet var nameTextField: UITextField?
    @IBOutlet var imageNameTextField: UITextField?
    
    @IBAction func doneAction(AnyObject) {
        var worldCellName = ""
        if nameTextField != nil {
            worldCellName = nameTextField!.text
        }
        if worldCellName == "" {
            worldCellName = "New Cell"
        }
        
        var imageName: String = ""
        if imageNameTextField? != nil {
            imageName = imageNameTextField!.text
        }
        
        WorldCell.createModel(worldCellName, imageName: imageName)
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
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
}
