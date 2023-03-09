//
//  ActivityTableTableViewController.swift
//  IntheKnow1
//
//  Created by mac on 2/17/23.
//
import CoreData
import UIKit

class ActivityTableTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var activityTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Represents all our activities
    var itemsActivity: [ActivitySaved] = []
    
    var groupSelected: GroupSaved?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = groupSelected?.name ?? ""
        
        activityTableView.dataSource = self
        activityTableView.delegate = self
        
        itemsActivity = (groupSelected?.activities?.allObjects as? [ActivitySaved] ?? [])
        
        activityTableView.reloadData()
    }
    // MARK: - Table view data source
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchActivitySaved()
    }
    func fetchActivitySaved() {
        let myFetch: NSFetchRequest<ActivitySaved> = ActivitySaved.fetchRequest()
        let myPredicate = NSPredicate(format: "group.name == %@", (groupSelected!.name)!)
        myFetch.predicate = myPredicate
        
        do{
            itemsActivity = try context.fetch(myFetch)
            self.activityTableView.reloadData()
        } catch {
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemsActivity.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as? ActivityTableViewCell
        
        // Configure the cell...
        let activity = self.itemsActivity[indexPath.row]
        
        cell?.configure(with: activity)
        
        
        return cell!
    }
    //Delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            //Which person to remove
            let activityToRemove = self.itemsActivity[indexPath.row]
            
            //Remove the person
            self.context.delete(activityToRemove)
            //Save the data
            
            do {
                try self.context.save()
            }
            catch {
            }
            
            //Re-fetch the data
            self.fetchActivitySaved()
        }
        
        //Return swipe actions
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? AddActivityViewController
        destination?.groupSelected = groupSelected
    }
    //Edit Activity
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Select Group
        let activity =  self.itemsActivity[indexPath.row]
        
        //Create Alert
        let alert = UIAlertController(title: "Edit Activity", message: "Edit Activity:", preferredStyle: .alert)
        alert.addTextField()
        
        let textfield = alert.textFields![0]
        textfield.text = activity.name
        
        //Configure button handler
        _ = UIAlertAction(title: "Save", style: .default) { (action) in
            
            //Get the textfield for the alert
            let textfield = alert.textFields![0]
            
            activity.name = textfield.text
            
            //Save the data
            do{
                try self.context.save()
            }
            catch {
                
            }
            //Refetch Data
            self.fetchActivitySaved()
            
        }
    }
}
