//
//  ViewController.swift
//  InteractiveNotifications
//
//  Created by Austin Tooley on 9/9/18.
//  Copyright © 2018 Austin Tooley. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    struct Notification {
        
        struct Category {
            static let normal = "normal"
            static let action = "actionPacked"
            static let interactive = "🥑"
        }
        
        struct Action {
            static let highFive = "highFive"
            static let buy = "buy"
            static let cookDinner = "cookDinner"
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register as delegate
        UNUserNotificationCenter.current().delegate = self
        
        // Request Permission
        requestNotificationPermission()
        
        /* Register a simple notification */
        // Create and register category (and actions)
        let normalCategory = UNNotificationCategory(identifier: Notification.Category.normal,
                                                                 actions: [],
                                                                 intentIdentifiers: [],
                                                                 options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([normalCategory])
        
        /* Register notification with actions */
        // Define actions
        let actionHighFive = UNNotificationAction(identifier: Notification.Action.highFive, title: "High Five!", options: [])
        let actionBuy = UNNotificationAction(identifier: Notification.Action.buy, title: "Buy new iPhone XS", options: [.destructive, .authenticationRequired])
        let actionCookDinner = UNNotificationAction(identifier: Notification.Action.cookDinner, title: "Cook Dinner", options: [.foreground])
        
        // Define notification category
        let actionNotificationCategory = UNNotificationCategory(identifier: Notification.Category.action,
                                                            actions: [actionHighFive, actionCookDinner, actionBuy],
                                                            intentIdentifiers: [],
                                                            options: [])
        
        // Register notification category
        UNUserNotificationCenter.current().setNotificationCategories([actionNotificationCategory])
        
        /* Register an interactive notification */
        let interactiveCategory = UNNotificationCategory(identifier: Notification.Category.interactive,
                                                    actions: [],
                                                    intentIdentifiers: [],
                                                    options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([normalCategory])
        
    }

    
    /*
    * We must ask permission from the user for the ability to send notifications.
    * `requestAuthorization` presents the system alert,  with the request.
    */
    func requestNotificationPermission() {
        // Request user's permission to send notifications.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notifications permission granted.")
            }
            else {
                print("Notifications permission denied because: \(error?.localizedDescription).")
            }
        }
    }
    
    /*
     A basic notification.
     */
    func createStandardNotification() -> UNMutableNotificationContent {
        
        let content = UNMutableNotificationContent()
        
        // Set the ID
        content.categoryIdentifier = Notification.Category.normal
        
        // Set content
        content.title = "A Normal Notification"
        content.subtitle = "It's perfectly normal."
        content.body = "Look at at how normal I am!"
        content.sound = UNNotificationSound.default
        
        return content
    }
    
    /*
     A notification with actions
     */
    func createNotificationWithActions() -> UNMutableNotificationContent {
        
        let content = UNMutableNotificationContent()
        
        // Set the ID
        content.categoryIdentifier = Notification.Category.action
        
        // Set content
        content.title = "An Action Packed Notification"
        content.subtitle = "So much action!"
        content.body = "It's like an 80's movie! Bacon ipsum dolor amet burgdoggen ribeye shoulder pork belly, strip steak short loin turducken buffalo swine frankfurter sirloin pig. Flank swine doner meatball, drumstick pork loin rump alcatra hamburger corned beef."
        content.sound = UNNotificationSound.defaultCritical
        
        return content
    }
    
    /*
     An interactive notification.
     */
    func createInteractiveNotification() -> UNMutableNotificationContent {
        
        let content = UNMutableNotificationContent()
        
        // Set the ID
        content.categoryIdentifier = Notification.Category.interactive
        
        // Set content
        content.title = "✨Interactive✨"
        content.subtitle = "wow"
        content.body = "It's amazing!"
        content.sound = UNNotificationSound.default
        
        return content
    }
    
    
    func sendNotification(delay: Int = 1, content: UNMutableNotificationContent) {
        // Check notification preferences
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            
            // Make sure we're authorized for scheduled notificaitons
            guard settings.authorizationStatus == .authorized else { return }
            
            // Create a trigger contdition based on a delay
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(exactly: delay)!, repeats: false)
            
            // Create notification request
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
            
            // Let UNUserNotificationCenter know about the request
            // Trigger countdown starts now
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
    // MARK: Button Actions
    @IBAction func standardNotification(_ sender: Any) {
        sendNotification(content: createStandardNotification())
    }
    
    @IBAction func actionNotification(_ sender: Any) {
        sendNotification(content: createNotificationWithActions())
    }
    
    @IBAction func interactiveNotification(_ sender: Any) {
        sendNotification(content: createInteractiveNotification())
    }
}
