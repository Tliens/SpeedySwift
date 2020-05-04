//
// PermissionType.swift
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
public enum PermissionType {
    case contacts
    case locationAlways
    case locationWhenInUse
    case notifications(UNAuthorizationOptions)
    case microphone
    case camera
    case photos
    case reminders
    case events
    case bluetooth
    case motion
    @available(iOS 10.0, *) case speechRecognizer
    @available(iOS 9.3, *) case mediaLibrary
    @available(iOS 10.0, *) case siri
    case never
}

extension PermissionType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .contacts: return "Contacts"
        case .locationAlways: return "Location"
        case .locationWhenInUse: return "Location"
        case .notifications: return "Notifications"
        case .microphone: return "Microphone"
        case .camera: return "Camera"
        case .photos: return "Photos"
        case .reminders: return "Reminders"
        case .events: return "Events"
        case .bluetooth: return "Bluetooth"
        case .motion: return "Motion"
        case .speechRecognizer: return "Speech Recognizer"
        case .siri: return "SiriKit"
        case .mediaLibrary: return "Media Library"
        case .never: fatalError()
        }
    }
}
