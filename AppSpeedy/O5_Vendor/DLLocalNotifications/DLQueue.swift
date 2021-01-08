//
//  DLQueue.swift
//  DLLocalNotifications
//
//  Created by Devesh Laungani on 6/10/18.
//  Copyright © 2018 Devesh Laungani. All rights reserved.
//


@available(iOS 10.0, *)
public
class DLQueue: NSObject {
    
    internal var notifQueue = [DLNotification]()
    static let queue = DLQueue()
    let ArchiveURL = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("notifications.dlqueue")
    
    override init() {
        super.init()
        if let notificationQueue = self.load() {
            notifQueue = notificationQueue
        }
    }
    
    internal func push(_ notification: DLNotification) {
        notifQueue.insert(notification, at: findInsertionPoint(notification))
    }
    
    /// Finds the position at which the new DLNotification is inserted in the queue.
    /// - seealso: [swift-algorithm-club](https://github.com/hollance/swift-algorithm-club/tree/master/Ordered%20Array)
    internal func findInsertionPoint(_ notification: DLNotification) -> Int {
        let range = 0..<notifQueue.count
        var rangeLowerBound = range.lowerBound
        var rangeUpperBound = range.upperBound
        
        while rangeLowerBound < rangeUpperBound {
            let midIndex = rangeLowerBound + (rangeUpperBound - rangeLowerBound) / 2
            if notifQueue[midIndex] == notification {
                return midIndex
            } else if notifQueue[midIndex] < notification {
                rangeLowerBound = midIndex + 1
            } else {
                rangeUpperBound = midIndex
            }
        }
        return rangeLowerBound
    }
    
    ///Removes and returns the head of the queue.
    
    internal func pop() -> DLNotification {
        return notifQueue.removeFirst()
    }
    
    //Returns the head of the queue.
    
    internal func peek() -> DLNotification? {
        return notifQueue.last
    }
    
    ///Clears the queue.
    
    internal func clear() {
        notifQueue.removeAll()
    }
    
    ///Called when a DLLocalnotification is cancelled.
    
    internal func removeAtIndex(_ index: Int) {
        notifQueue.remove(at: index)
    }
    
    // Returns Count of DLNotifications in the queue.
    internal func count() -> Int {
        return notifQueue.count
    }
    
    // Returns The notifications queue.
    internal func notificationsQueue() -> [DLNotification] {
        let queue = notifQueue
        return queue
    }
    
    // Returns DLLocalnotifcation if found, nil otherwise.
    internal func notificationWithIdentifier(_ identifier: String) -> DLNotification? {
        for note in notifQueue {
            if note.identifier == identifier {
                return note
            }
        }
        return nil
    }
    
    
    ///Save queue on disk.
    
    internal func save() -> Bool {
        return NSKeyedArchiver.archiveRootObject(self.notifQueue, toFile: ArchiveURL.path)
    }
    
    ///Load queue from disk.
    ///Called first when instantiating the DLQueue singleton.
    ///You do not need to manually call this method
    
    internal func load() -> [DLNotification]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ArchiveURL.path) as? [DLNotification]
    }
    
}


// Helper function to compare notification types

@available(iOS 10.0, *)
public func <(lhs: DLNotification, rhs: DLNotification) -> Bool {
    return lhs.fireDate?.compare(rhs.fireDate!) == ComparisonResult.orderedAscending
}
@available(iOS 10.0, *)
public func ==(lhs: DLNotification, rhs: DLNotification) -> Bool {
    return lhs.identifier == rhs.identifier
}
