//
//  NotificationManager.swift
//  CoreBluetoothExample
//
//  Created by SaitoYuta on 2017/03/16.
//  Copyright © 2017年 bangohan. All rights reserved.
//

import Foundation
import Cocoa

class NotificationManager {
    static func show(text: String) {
        let notification = NSUserNotification()
        notification.title = "Wii Remote"
        notification.subtitle = text
        NSUserNotificationCenter.default.deliver(notification)
    }
}
