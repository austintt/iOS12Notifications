//
//  NotificationViewController.swift
//  SuperNotificationExtension
//
//  Created by Austin Tooley on 9/9/18.
//  Copyright © 2018 Austin Tooley. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class SuperInteractiveNotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var wizzardButton: UIButton!
    @IBOutlet weak var brideButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial image
        imageView.image = #imageLiteral(resourceName: "pugWizard")
        
        // Style the buttons
        wizzardButton.setFilledInStyle(color: UIColor(rgb: 0x2ed573))
        brideButton.setFilledInStyle(color: UIColor(rgb: 0xff7f50))
        
    }
    
    func didReceive(_ notification: UNNotification) {
        
    }

    @IBAction func didWizard(_ sender: Any) {
        imageView.image = #imageLiteral(resourceName: "pugWizard")
        animateButton(wizzardButton)
    }
    
    @IBAction func didBride(_ sender: Any) {
        imageView.image = #imageLiteral(resourceName: "pugBride")
        animateButton(brideButton)
    }
    
    func animateButton(_ button: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            button.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.2, animations: {
                button.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
    }
}
