//
//  MyList+CoreDataClass.swift
//  capstone
//
//  Created by Sama Durani on 10/23/24.
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    
    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap { ($0 as! Reminder) } ?? []
    }
    
}
