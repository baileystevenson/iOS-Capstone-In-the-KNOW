//
//  AddActivityViewController.swift
//  IntheKnow
//
//  Created by mac on 2/15/23.
//
import CoreData
import UIKit
import UserNotifications


class AddActivityViewController: UIViewController {
    
    
    //Mark Outlets
    
    //    @IBOutlet weak var groupName: GroupName!
    @IBOutlet weak var activityNameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var dateChanged: UIDatePicker!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var groupSelected: GroupSaved?
    
    let notificationScheduler = NotificationScheduler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityNameTextField.delegate = self
        locationTextField.delegate = self
        detailsTextField.delegate = self
        navigationItem.title = groupSelected?.name
        
    }
    @IBAction func addActivityTapped(_ sender: Any) {
        print("Add activity tapped")
        //create group object
        
        //create
        let newActivity = ActivitySaved(context: self.context)
        newActivity.name = activityNameTextField.text
        newActivity.location = locationTextField.text
        newActivity.details = detailsTextField.text
        newActivity.date = dateChanged.date
        newActivity.group = groupSelected
        newActivity.id = UUID()
        
        //Schedule Notification
        notificationScheduler.scheduleNotifications(for: newActivity)
        
        //save the data
        do {
            try self.context.save()
        } catch {
            print("hello")
            
        }
    }
}
extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

@IBDesignable extension UINavigationController {
    @IBInspectable var barTintColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            navigationBar.barTintColor = uiColor
        }
        get {
            guard let color = navigationBar.barTintColor else { return nil }
            return color
        }
    }
}
