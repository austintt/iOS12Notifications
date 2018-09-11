//
//  ViewController+NotificationDelegate.swift
//  InteractiveNotifications
//
//  Created by Austin Tooley on 9/10/18.
//  Copyright © 2018 Austin Tooley. All rights reserved.
//

import UIKit
import UserNotifications

extension ViewController: UNUserNotificationCenterDelegate {
    
    // So we can see notifications while the app is open
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case Notification.Action.highFive:
            print("🙌 High Five!")
        case Notification.Action.cookDinner:
            print("🍔 Burger Time.")
        case Notification.Action.buy:
            print("💸💸💸")
        default:
            print("Other Action")
        }
        
        completionHandler()
    }
}
