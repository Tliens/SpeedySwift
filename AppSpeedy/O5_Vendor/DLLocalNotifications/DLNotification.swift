//
//  DLNotification.swift
//  DLLocalNotifications
//
//  Created by Devesh Laungani on 6/10/18.
//  Copyright © 2018 Devesh Laungani. All rights reserved.
//

// A wrapper class for creating a User Notification
import UserNotifications
import MapKit

@available(iOS 10.0, *)
public class DLNotification {
    
    // Contains the internal instance of the notification
    internal var localNotificationRequest: UNNotificationRequest?
    
    // Holds the repeat interval of the notification with Enum Type Repeats
    var repeatInterval: RepeatingInterval = .none
    
    // Holds the body of the message of the notification
    var alertBody: String?
    
    // Holds the title of the message of the notification
    var alertTitle: String?
    
    // Holds name of the music file of the notification
    var soundName: String = ""
    
    // Holds the date that the notification will be first fired
    var fireDate: Date?
    
    // Know if a notification repeats from this value
    var repeats: Bool = false
    
    // Keep track if a notification is scheduled
    var scheduled: Bool = false
    
    // Hold the identifier of the notification to keep track of it
    public var identifier: String?
    
    // Hold the attachments for the notifications
    var attachments: [UNNotificationAttachment]?
    
    // Hold the launch image of a notification
    var launchImageName: String?
    
    // Hold the category of the notification if you want to set one
    public var category: String?
    
    // If it is a region based notification then you can access the notification
    var region: CLRegion?
    
    // Internal variable needed when changint Notification types
    var hasDataFromBefore = false
    
    enum CodingKeys: String, CodingKey {
        case localNotificationRequest
        case repeatInterval
        case alertBody
        case alertTitle
        case soundName
        case fireDate
        case repeats
        case scheduled
        case identifier
        case attachments
        case launchImageName
        case category
        case region
        case hasDataFromBefore
    }
    
    
    public init(request: UNNotificationRequest) {
        
        self.hasDataFromBefore = true
        self.localNotificationRequest = request
        if let calendarTrigger =  request.trigger as? UNCalendarNotificationTrigger {
            self.fireDate = calendarTrigger.nextTriggerDate()
        } else if let  intervalTrigger =  request.trigger as? UNTimeIntervalNotificationTrigger {
            self.fireDate = intervalTrigger.nextTriggerDate()
        }
    }
    
    public init (identifier: String, alertTitle: String, alertBody: String, date: Date?, repeats: RepeatingInterval ) {
        
        self.alertBody = alertBody
        self.alertTitle = alertTitle
        self.fireDate = date
        self.repeatInterval = repeats
        self.identifier = identifier
        if (repeats == .none) {
            self.repeats = false
        } else {
            self.repeats = true
        }
        
    }
    
    public init (identifier: String, alertTitle: String, alertBody: String, date: Date?, repeats: RepeatingInterval, soundName: String ) {
        
        self.alertBody = alertBody
        self.alertTitle = alertTitle
        self.fireDate = date
        self.repeatInterval = repeats
        self.soundName = soundName
        self.identifier = identifier
        
        if (repeats == .none) {
            self.repeats = false
        } else {
            self.repeats = true
        }
        
    }
    
    // Region based notification
    // Default notifyOnExit is false and notifyOnEntry is true
    
    public init (identifier: String, alertTitle: String, alertBody: String, region: CLRegion? ) {
        
        self.alertBody = alertBody
        self.alertTitle = alertTitle
        self.identifier = identifier
        region?.notifyOnExit = false
        region?.notifyOnEntry = true
        self.region = region
        
    }

    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let repeatString = try container.decode(String.self, forKey: .repeatInterval)
        self.repeatInterval = RepeatingInterval(rawValue: repeatString)!
        self.alertTitle = try container.decodeIfPresent(String.self, forKey: .alertTitle)
        self.alertBody = try container.decodeIfPresent(String.self, forKey: .alertBody)
        self.soundName =  try container.decode(String.self, forKey: .soundName)
        self.fireDate = try container.decodeIfPresent(Date.self, forKey: .fireDate)
        self.repeats = try container.decode(Bool.self, forKey: .repeats)
        self.scheduled = try container.decode(Bool.self, forKey: .scheduled)
        self.identifier = try container.decodeIfPresent(String.self, forKey: .identifier)
        self.launchImageName = try container.decodeIfPresent(String.self, forKey: .launchImageName)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.hasDataFromBefore = try container.decode(Bool.self, forKey: .hasDataFromBefore)
    }
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        
        try container.encode(repeatInterval.rawValue, forKey: CodingKeys.repeatInterval)
        try container.encode(alertTitle, forKey: .alertTitle)
        try container.encode(alertBody, forKey: .alertBody)
        try container.encode(soundName, forKey: .soundName)
        try container.encode(fireDate, forKey: .fireDate)
        try container.encode(repeats, forKey: .repeats)
        try container.encode(scheduled, forKey: .scheduled)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(launchImageName, forKey: .launchImageName)
        try container.encode(category, forKey: .category)
        try container.encode(hasDataFromBefore, forKey: .hasDataFromBefore)
    }
    
    public var debugDescription : String {
        
        return "<DLNotification Identifier: " + self.identifier!  + " Title: " + self.alertTitle! + ">"
    }
}


