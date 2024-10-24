//
//  capstoneApp.swift
//  capstone
//
//  Created by Sama Durani on 10/11/24.
//

import SwiftUI
import UserNotifications

@main
struct RingMeRemindersAppApp: App {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                // notification granted
            } else {
                // display message to user
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
