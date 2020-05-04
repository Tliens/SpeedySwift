//
// Permission.swift
//
// Copyright (c) 2015-2019 Damien (http://delba.io)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
import UserNotifications
open class Permission: NSObject {
    public typealias Callback = (PermissionStatus) -> Void

    /// The permission to access the user's contacts.
    public static let contacts = Permission(type: .contacts)

    /// The permission to access the user's location when the app is in background.
    public static let locationAlways = Permission(type: .locationAlways)

    /// The permission to access the user's location when the app is in use.
    public static let locationWhenInUse = Permission(type: .locationWhenInUse)

    /// The permission to access the microphone.
    public static let microphone = Permission(type: .microphone)

    /// The permission to access the camera.
    public static let camera = Permission(type: .camera)

    /// The permission to access the user's photos.
    public static let photos = Permission(type: .photos)

    /// The permission to access the user's reminders.
    public static let reminders = Permission(type: .reminders)

    /// The permission to access the user's events.
    public static let events = Permission(type: .events)

    /// The permission to access the user's bluetooth.
    public static let bluetooth = Permission(type: .bluetooth)

    /// The permission to access the user's motion.
    public static let motion = Permission(type: .motion)

    /// The permission to access the user's SpeechRecognizer.
    @available(iOS 10.0, *)
    public static let speechRecognizer = Permission(type: .speechRecognizer)

    /// The permission to access the user's MediaLibrary.
    @available(iOS 9.3, *)
    public static let mediaLibrary = Permission(type: .mediaLibrary)

    /// The permission to access the user's Siri.
    @available(iOS 10.0, *)
    public static let siri = Permission(type: .siri)

    /// The permission to send notifications.
    public static let notifications: Permission = {
        let options: UNAuthorizationOptions = [.badge, .sound, .alert]
        return Permission(type: .notifications(options))
    }()

    /// Variable used to retain the notifications permission.
    private static var _notifications: Permission?

    /// The permission to send notifications.
    public static func notifications(options: UNAuthorizationOptions) -> Permission {
        let permission = Permission(type: .notifications(options))
        _notifications = permission
        return permission
    }

    /// The permission domain.
    public let type: PermissionType

    /// The permission status.
    open var status: PermissionStatus {
        switch type {
        case .contacts: return statusContacts

        case .locationAlways: return statusLocationAlways
        case .locationWhenInUse: return statusLocationWhenInUse

        case .notifications: return statusNotifications

        case .microphone: return statusMicrophone

        case .camera: return statusCamera

        case .photos: return statusPhotos

        case .reminders: return statusReminders

        case .events: return statusEvents

        case .bluetooth: return statusBluetooth

        case .motion: return statusMotion

        case .speechRecognizer: return statusSpeechRecognizer

        case .mediaLibrary: return statusMediaLibrary

        case .siri: return statusSiri

        case .never: fatalError()
        }
    }

    /// Determines whether to present the pre-permission alert.
    open var presentPrePermissionAlert = false

    /// The pre-permission alert.
    open lazy var prePermissionAlert: PermissionAlert = {
        return PrePermissionAlert(permission: self)
    }()

    /// Determines whether to present the denied alert.
    open var presentDeniedAlert = true

    /// The alert when the permission was denied.
    open lazy var deniedAlert: PermissionAlert = {
        return DeniedAlert(permission: self)
    }()

    /// Determines whether to present the disabled alert.
    open var presentDisabledAlert = true

    /// The alert when the permission is disabled.
    open lazy var disabledAlert: PermissionAlert = {
        return DisabledAlert(permission: self)
    }()

    var callback: Callback?

    var permissionSets: [PermissionSet] = []

    /**
     Creates and return a new permission for the specified type.
     
     - parameter type: The permission type.
     
     - returns: A newly created permission.
     */
    private init(type: PermissionType) {
        self.type = type
    }

    /**
     Requests the permission.
     
     - parameter callback: The function to be triggered after the user responded to the request.
     */
    open func request(_ callback: @escaping Callback) {
        self.callback = callback

        DispatchQueue.main.async {
            self.permissionSets.forEach { $0.willRequestPermission(self) }
        }

        let status = self.status

        switch status {
        case .authorized:    callbacks(status)
        case .notDetermined: presentPrePermissionAlert ? prePermissionAlert.present() : requestAuthorization(callbacks)
        case .denied:        presentDeniedAlert ? deniedAlert.present() : callbacks(status)
        case .disabled:      presentDisabledAlert ? disabledAlert.present() : callbacks(status)
        }
    }

    func requestAuthorization(_ callback: @escaping Callback) {
        switch type {
        case .contacts: requestContacts(callback)
        case .locationAlways: requestLocationAlways(callback)
        case .locationWhenInUse: requestLocationWhenInUse(callback)
        case .notifications: requestNotifications(callback)
        case .microphone: requestMicrophone(callback)
        case .camera: requestCamera(callback)
        case .photos: requestPhotos(callback)
        case .reminders: requestReminders(callback)
        case .events: requestEvents(callback)
        case .bluetooth: requestBluetooth(self.callback)
        case .motion: requestMotion(self.callback)
        case .speechRecognizer: requestSpeechRecognizer(callback)
        case .mediaLibrary: requestMediaLibrary(callback)
        case .siri: requestSiri(callback)
        case .never: fatalError()
        }
    }

    func callbacks(_ with: PermissionStatus) {
        DispatchQueue.main.async {
            self.callback?(self.status)
            self.permissionSets.forEach { $0.didRequestPermission(self) }
        }
    }
}

extension Permission {
    /// The textual representation of self.
    override open var description: String {
        return type.description
    }

    /// A textual representation of this instance, suitable for debugging.
    override open var debugDescription: String {
        return "\(type): \(status)"
    }

}
