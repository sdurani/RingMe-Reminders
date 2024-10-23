//
//  ReminderListView.swift
//  capstone
//
//  Created by Sama Durani on 10/23/24.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder) { event in
                switch event {
                    case .onSelect(let reminder):
                        print("ON SELECTED")
                    case .onCheckedChange(let reminder):
                        print("onCheckedChange")
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
