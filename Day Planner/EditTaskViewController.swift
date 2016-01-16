//
//  EditTaskViewController.swift
//  Day Planner
//
//  Created by Chris Archibald on 1/15/16.
//  Copyright © 2016 Chris Archibald. All rights reserved.
//

import UIKit
import CoreData

class EditTaskViewController: UIViewController, UITextFieldDelegate {

    var newTask: Bool = true
    var taskItem: AnyObject? = nil
    
    var appDel: AppDelegate = AppDelegate()
    var context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
    
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var taskStatusLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDel.managedObjectContext
        
        taskTextField.delegate = self
        
        if newTask == true {
            saveButton.setTitle("Save", forState: UIControlState.Normal)
        } else {
            saveButton.setTitle("Update", forState: UIControlState.Normal)
        }

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func statusSwitchChanged(sender: UISwitch) {
        if sender.on {
            taskStatusLabel.text = "Complete"
        } else {
            taskStatusLabel.text = "Open"
        }
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
