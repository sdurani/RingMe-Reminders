//
//  NotificationManager.swift
//  capstone
//
//  Created by Sama Durani on 10/24/24.
//

import Foundation
import UserNotifications
import CoreData

struct UserData {
    let title: String?
    let body: String?
    let date: Date?
    let time: Date?
    let reminderID: NSManagedObjectID? // link the notification to the specific reminder
}

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    static func scheduleNotification(userData: UserData, reminderID: NSManagedObjectID) {
        let content = UNMutableNotificationContent()
        content.title = userData.title ?? ""
        content.body = userData.body ?? "" // body is the notes section of reminder
        
        // Date components
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: userData.date ?? Date())
        
        if let reminderTime = userData.time {
//            let reminderTimeDateComponents = reminderTime.dateComponents
            let reminderTimeDateComponents = Calendar.current.dateComponents([.hour, .minute], from: reminderTime)
            dateComponents.hour = reminderTimeDateComponents.hour
            dateComponents.minute = reminderTimeDateComponents.minute
        }
        
        // add the reminder ID to the userInfo dictionary as a string
        content.userInfo = ["reminderID": reminderID.uriRepresentation().absoluteString]
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "Reminder Notification \(reminderID)", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
//    // delegate method to handle notification response
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        guard let reminderIDString = response.notification.request.content.userInfo["reminderID"] as? String,
//              let reminderURL = URL(string: reminderIDString) else {
//            completionHandler()
//            return
//        }
//        
//        // retrieve the NSManagedObjectID from the URL
//        guard let reminderID = reminderURL.nsManagedObjectID() else {
//            print("Invalid NSManagedObjectID from URL")
//            completionHandler()
//            return
//        }
//        
//        // fetch the reminder using the ID
//        fetchReminder(by: reminderID) { reminder in
//            guard let reminder = reminder else {
//                print("Reminder not found")
//                completionHandler()
//                return
//            }
//
//            // Call the sendReminderToBackend function
//            ReminderService.sendReminderToBackend(reminder: reminder) { aiResponse in
//                if let responseMessage = aiResponse {
//                    // Update the reminder's notes with the AI response
//                    do {
//                        reminder.notes = responseMessage
//                        try ReminderService.save() // Save changes to Core Data
//                    } catch {
//                        print("Failed to save updated reminder: \(error.localizedDescription)")
//                    }
//                }
//                completionHandler()
//            }
//        }
//    }
//    
//    // fetch the reminder by ID
//    private func fetchReminder(by id: NSManagedObjectID, completion: @escaping (Reminder?) -> Void) {
//        let context = ReminderService.viewContext
//        context.perform {
//            do {
//                let reminder = try context.existingObject(with: id) as? Reminder
//                completion(reminder)
//            } catch {
//                print("Failed to fetch reminder: \(error.localizedDescription)")
//                completion(nil)
//            }
//        }
//    }
//}
//
// //  Convert URL to NSManagedObjectID
//extension URL {
//    func nsManagedObjectID() -> NSManagedObjectID? {
//        // Access the persistentContainer from CoreDataProvider
//        let persistentStoreCoordinator = CoreDataProvider.shared.persistentContainer.persistentStoreCoordinator
//        
//        return persistentStoreCoordinator.managedObjectID(forURIRepresentation: self)
//    }
}
