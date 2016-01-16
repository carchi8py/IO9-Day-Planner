//
//  ViewController.swift
//  Day Planner
//
//  Created by Chris Archibald on 1/9/16.
//  Copyright © 2016 Chris Archibald. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var todaysPrecentageLabel: UILabel!
    @IBOutlet weak var totalPrecentageLabel: UILabel!
    
    var appDel: AppDelegate = AppDelegate()
    var context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDel.managedObjectContext
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let today = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        
        let request = NSFetchRequest(entityName: "Tasks")
        request.resultType = NSFetchRequestResultType.DictionaryResultType
        
        var results: [AnyObject]?
        
        do {
            results = try context.executeFetchRequest(request)
        } catch _ {
            let alertController = UIAlertController(title: "Error", message: "Error Fetching Data", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        let total = results?.count
        
        request.predicate = NSPredicate(format: "taskStatus = %@", "Complete")
        do {
            results = try context.executeFetchRequest(request)
        } catch _ {
            let alertController = UIAlertController(title: "Error", message: "Error Fetching Data", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        let totalComplete = results?.count
        
        request.predicate = NSPredicate(format: "taskDate = %@", "\(formatter.stringFromDate(today))")
        do {
            results = try context.executeFetchRequest(request)
        } catch _ {
            let alertController = UIAlertController(title: "Error", message: "Error Fetching Data", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        let todaysTotal = results?.count
        
        request.predicate = NSPredicate(format: "taskStatus = %@ && taskDate = %@", "Complete", "\(formatter.stringFromDate(today))")
        do {
            results = try context.executeFetchRequest(request)
        } catch _ {
            let alertController = UIAlertController(title: "Error", message: "Error Fetching Data", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        let todaysComplete = results?.count
        
        let todayPercentage = todaysTotal! > 0 ? Int(Float(todaysComplete!) / Float(todaysTotal!) * 100): 0
        let totalPercentage = total! > 0 ? Int(Float(totalComplete!) / Float(total!) * 100) : 0
        
        todaysPrecentageLabel.text = "\(todayPercentage)%"
        totalPrecentageLabel.text = "\(totalPercentage)%"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

