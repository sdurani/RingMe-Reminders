//
//  ReminderListView.swift
//  capstone
//
//  Created by Sama Durani on 10/23/24.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    private func reminderCheckedChanged(reminder: Reminder) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = !reminder.isCompleted
        
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder) { event in
                switch event {
                    case .onSelect(let reminder):
                        print("ON SELECTED")
                    case .onCheckedChange(let reminder):
                        reminderCheckedChanged(reminder: reminder)
                    case .onInfo:
                        print("onInfo")
                }
            }
        }
    }
}

//struct ReminderListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderListView()
//    }
//}
