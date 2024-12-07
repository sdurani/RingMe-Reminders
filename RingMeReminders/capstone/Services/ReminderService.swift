//
//  ReminderService.swift
//  capstone
//
//  Created by Sama Durani on 10/23/24.
//

import Foundation
import CoreData
import UIKit

class ReminderService {
    
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    static func save() throws {
        try viewContext.save()
    }
    
    static func saveMyList(_ name: String, _ color: UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        try save()
    }
    
    static func updateReminder(reminder: Reminder, editConfig: ReminderEditConfig) throws -> Bool {
        
        let reminderToUpdate = reminder
        reminderToUpdate.isCompleted = editConfig.isCompleted
        reminderToUpdate.title = editConfig.title
        reminderToUpdate.notes = editConfig.notes
        reminderToUpdate.reminderDate = editConfig.hasDate ? editConfig.reminderDate: nil
        reminderToUpdate.reminderTime = editConfig.hasTime ? editConfig.reminderTime: nil
        
        try save()
        return true
    }
    
    static func deleteReminder(_ reminder: Reminder) throws {
        viewContext.delete(reminder)
        try save()
    }
    
    static func getRemindersBySearchTerm(_ searchTerm: String) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchTerm)
        return request
    }
    
    static func saveReminderToMyList(myList: MyList, reminderTitle: String) throws {
        let reminder = Reminder(context: viewContext)
        reminder.title = reminderTitle
        myList.addToReminders(reminder)
        try save()
    }
    
    static func remindersByStatType(statType: ReminderStatType) -> NSFetchRequest<Reminder> {
        
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        
        switch statType {
            case .all:
                request.predicate = NSPredicate(format: "isCompleted = false")
            case .today:
                let today = Date()
                let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
                request.predicate = NSPredicate(format: "(reminderDate >= %@) AND (reminderDate < %@)", today as NSDate, tomorrow! as NSDate)
            case .scheduled:
                request.predicate = NSPredicate(format: "(reminderDate != nil OR reminderTime != nil) AND isCompleted = false")
            case .completed:
                request.predicate = NSPredicate(format: "isCompleted = true")
        }
        return request
    }
    
    static func getRemindersByList(myList: MyList) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "list = %@ AND isCompleted = false", myList)
        return request
    }
    
    static func sendReminderToBackend(reminder: Reminder, completion: @escaping (String?) -> Void) {
            guard let url = URL(string: "http://127.0.0.1:5555/generate-reminder") else {
                print("Invalid URL")
                completion(nil)
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            // convert Date to String with day of the week and time
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE" // day of the week
            var scheduledTimeString = ""

            if let reminderDate = reminder.reminderDate {
                scheduledTimeString = dateFormatter.string(from: reminderDate)
            }

            if let reminderTime = reminder.reminderTime {
                dateFormatter.dateFormat = "h:mm a" // 12-hour format with AM/PM
                let timeString = dateFormatter.string(from: reminderTime)
                scheduledTimeString += " at " + timeString
            }

        
            let parameters: [String: Any] = [
                "user_name": "John",
                "task": reminder.title ?? "",
                "scheduled_time": scheduledTimeString
            ]

            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = error {
                        print("Error: \(error.localizedDescription)")
                        completion(nil)
                        return
                    }
                
                guard let data = data, error == nil else {
                    print("No data received")
                    completion(nil)
                    return
                }

//                if let json = try? JSONSerialization.jsonObject(with: data, options: []),
//                   let dict = json as? [String: String],
//                   let aiResponse = dict["ai_response"] {
//                    completion(aiResponse)
//                } else {
//                    completion(nil)
//                }
//                if let aiResponse = String(data: data, encoding: .utf8) {
//                    completion(aiResponse)
//                } else {
//                    completion(nil)
//                }
                if let aiResponse = try? JSONDecoder().decode(String.self, from: data) {
                    DispatchQueue.main.async {
                        completion(aiResponse)
                    }
                } else {
                    print("Failed to parse JSON response")
                }
            }

            task.resume()
        }
    
}
