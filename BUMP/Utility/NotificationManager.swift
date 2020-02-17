//
//  NotificationsVerifier.swift
//  BUMP
//
//  Created by Hunain Ali on 11/8/19.
//  Copyright © 2019 BUMP. All rights reserved.
//

import Foundation
import FirebaseAuth

class NotificationManager {
    
    
    static let shared = NotificationManager()
    
    
    
    func isEnabled(completion: @escaping (Bool) -> ()) {
            
        let center  = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .denied {
                print("notif denied")
                self.presentEnableSettingsNotifications()
                completion(false)
                
            }
            else if settings.authorizationStatus == .notDetermined {
                print("notif not determined")
                self.presentEnableNotificationsView()
                completion(false)
            }
            else {
                print("notif allowed")
                completion(true)
            }
        }
        
        
    }
    
    
    func presentEnableNotificationsView() {
        
        //FIX: Better wording.
        let alert = UIAlertController(title: "Join to get notified when someone wants to connect!", message: "You can silence certain group chats too.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            DispatchQueue.main.async {
                UNUserNotificationCenter.current()
                    .requestAuthorization(options: [.alert, .sound, .badge]) {
                        granted, error in
                        
                        print("Permission granted: \(granted)")
                        guard granted else { return }
                }
            }
        }))
        
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true)
        }
    }
    //FIX:
    func presentEnableSettingsNotifications() {
        
        let alert = UIAlertController(title: "Please enable notifs to get the full experience of Grinnell group chats.", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            DispatchQueue.main.async {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
        }))
        
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true)
        }
        
    }
    
    
    
    
    // MARK:- Actionable Notifications
    
    

}
