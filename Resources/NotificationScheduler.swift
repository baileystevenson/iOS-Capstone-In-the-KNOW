//
//  NotificationScheduler.swift
//  IntheKnow1
//
//  Created by mac on 2/22/23.
//

import UserNotifications

class NotificationScheduler {
    //
    func scheduleNotifications(for activity: ActivitySaved) {
        guard activity.id != nil
                
        else { return }
        
        //        let center = UNUserNotificationCenter.current()
        
        //    center.requestAuthorization(options: [.alert, .sound]) { (grant, error) in
        //        }
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "\(activity.name ?? "") this week."
        content.sound = .default
        
        //        let date = Date().addingTimeInterval(10)
        
        let fireDateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: activity.date ?? Date())
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDateComponents, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        //        center.add(request) { (error) in
        
        //        let request = UNNotificationRequest(identifier: activity.id ?? "", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print("Unable to add notification request")
            }
        }
    }
    
    func cancelNotifications() {
        
    }
    
}
