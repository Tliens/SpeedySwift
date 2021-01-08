//
//  DLCategory.swift
//  DLLocalNotifications
//
//  Created by Devesh Laungani on 6/10/18.
//  Copyright © 2018 Devesh Laungani. All rights reserved.
//

// A wrapper class for creating a Category
import Foundation
import UserNotifications

@available(iOS 10.0, *)
public class DLCategory {

    // Holds the actions you want available for this category type
    private var actions: [UNNotificationAction]?
    
    // Hold the actual cateogry
    internal var categoryInstance: UNNotificationCategory?
    
    // Holds the identifier of the category type
    var identifier: String
    
    public init (categoryIdentifier: String) {
        
        identifier = categoryIdentifier
        actions = [UNNotificationAction]()
        
    }
    
    public func addActionButton(identifier: String?, title: String?) {

        let action = UNNotificationAction(identifier: identifier!, title: title!, options: [])
        actions?.append(action)
        categoryInstance = UNNotificationCategory(identifier: self.identifier, actions: self.actions!, intentIdentifiers: [], options: [])
        
    }
    
}

