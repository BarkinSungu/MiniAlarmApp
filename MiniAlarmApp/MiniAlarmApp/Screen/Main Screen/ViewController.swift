//
//  ViewController.swift
//  MiniAlarmApp
//
//  Created by Barkın Süngü on 28.08.2023.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        return picker
    }()
        
    let setAlarmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set Alarm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(setAlarm), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(datePicker)
        view.addSubview(setAlarmButton)
                
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        setAlarmButton.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            setAlarmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setAlarmButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 50),
            setAlarmButton.widthAnchor.constraint(equalToConstant: 150),
            setAlarmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func scheduleNotification(at date: Date) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "Wake up!"
                content.body = "Time to wake up!"
                content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "alarm_sound.wav"))
                
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
    
    @objc func setAlarm() {
        let alarmTime = datePicker.date
        scheduleNotification(at: alarmTime)
    }
    
}
