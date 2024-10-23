//
//  capstoneApp.swift
//  capstone
//
//  Created by Sama Durani on 10/11/24.
//

import SwiftUI

@main
struct CapstoneAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
