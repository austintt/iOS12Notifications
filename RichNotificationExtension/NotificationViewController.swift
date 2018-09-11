//
//  NotificationViewController.swift
//  RichNotificationExtension
//
//  Created by Austin Tooley on 9/10/18.
//  Copyright © 2018 Austin Tooley. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import AVFoundation

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    private var videoPlayer: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        
        playVideo("laser.mp4")
    }

    private func playVideo(_ file: String) {
        let file = file.components(separatedBy: ".")
        
        guard let path = Bundle.main.path(forResource: file[0], ofType:file[1]) else {
            debugPrint( "\(file.joined(separator: ".")) not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { (_) in
            player.seek(to: CMTime.zero)
            player.play()
        }
    }
}
