//
//  HubCVC+Silence.swift
//  BUMP
//
//  Created by Hunain Ali on 1/5/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import SwiftEntryKit
import SPStorkController

extension HubCVC {
    
    
    func presentIntroInfo() {
        
        let vc = IntroInfoVC()
        vc.title = "Bump: A Run Down"
        let nvc = UINavigationController(rootViewController: vc)
        
        nvc.modalPresentationStyle = .pageSheet
        nvc.presentationController?.delegate = vc
        if #available(iOS 13.0, *) {
            nvc.isModalInPresentation = true
        } else {
            // Fallback on earlier versions
        }
        
        
        UIApplication.topViewController()?.dismiss(animated: false) {}
        UIApplication.topViewController()?.present(nvc, animated: true) {}
        
    }
    
    
    func presentMyProfile() {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
    
        let vc = UserProfileView(userID: myUID, actionButtonEnabled: true)
        let atr = Constant.bottomPopUpAttributes
        DispatchQueue.main.async {
            SwiftEntryKit.display(entry: vc, using: atr)
        }
        
    }
    
    func presentMyCircles() {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        let vc = MyCirclesTVC()
        vc.title = "Tap to Join / Leave"
        
        vc.modalPresentationStyle = .pageSheet
        vc.modalPresentationCapturesStatusBarAppearance = true
        
        let nvc = UINavigationController(rootViewController: vc)
        
        self.present(nvc, animated: true) {}
        
    }
    
    
    
    func presentSilenceMode() {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        let alert = UIAlertController(title: "Silence for:", message: "You will recieve no notifications for time picked.", preferredStyle: .alert)
        
        // Create the actions
        let silence12h = UIAlertAction(title: "12 hours", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            let t = Calendar.current.date(byAdding: .hour, value: 12, to: Date())
            var data : [String : Any] = [:]
            data["silenceUntil"] = t
            self.db.collection("User-Base").document(myUID).setData(data, merge: true) { (err) in
            }
            
        }
        let silence3h = UIAlertAction(title: "3 hours", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            let t = Calendar.current.date(byAdding: .hour, value: 3, to: Date())
            var data : [String : Any] = [:]
            data["silenceUntil"] = t
            self.db.collection("User-Base").document(myUID).setData(data, merge: true) { (err) in
            }
            
        }
        let silence1h = UIAlertAction(title: "1 hour", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            let t = Calendar.current.date(byAdding: .hour, value: 1, to: Date())
            var data : [String : Any] = [:]
            data["silenceUntil"] = t
            self.db.collection("User-Base").document(myUID).setData(data, merge: true) { (err) in
            }
        }
        let unsilence = UIAlertAction(title: "Unsilence", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            var data : [String : Any] = [:]
            data["silenceUntil"] = FieldValue.delete()
            self.db.collection("User-Base").document(myUID).updateData(data) { (err) in
            }
        }
        
        alert.addAction(silence1h)
        alert.addAction(silence3h)
        alert.addAction(silence12h)
        alert.addAction(unsilence)
        
        self.present(alert, animated: true, completion: nil)
    
    }
    
    
    func presentHelpline() {
        
        let email = "alihunai@grinnell.edu"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    
    
}
