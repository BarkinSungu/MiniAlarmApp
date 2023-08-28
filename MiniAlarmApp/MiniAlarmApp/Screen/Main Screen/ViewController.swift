//
//  ViewController.swift
//  MiniAlarmApp
//
//  Created by Barkın Süngü on 28.08.2023.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        scheduleNotification(at: Date().addingTimeInterval(60))
    }
    
    func scheduleNotification(at date: Date) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "Wake up!"
                content.body = "Time to wake up!"
                content.sound = .default
                
                let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
                
                let request = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
