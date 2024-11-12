//
//  UIColorTransformer.swift
//  capstone
//
//  Created by Sama Durani on 10/23/24.
//

import Foundation
import UIKit

class UIColorTransformer: ValueTransformer {
    
    
    // serialize the color, returns the data
    override func transformedValue(_ value: Any?) -> Any? {
        
        guard let color = value as? UIColor else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
    }
    
    // takes the data and unarchives it back to the UI color
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        
        guard let data = value as? Data else { return nil }
        
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
            return color
        } catch {
            return nil
        }
        
    }
    
}
