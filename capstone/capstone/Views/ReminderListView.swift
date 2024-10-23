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
            ReminderCellView(reminder: reminder)
        }
    }
}

//struct ReminderListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderListView()
//    }
//}
