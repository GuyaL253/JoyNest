//
//  NotificationManager.swift
//  JoyNest
//
//  Created by Guy Almog on 31/10/2024.
//
import UIKit
import UserNotifications

class NotificationManager: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
        func checkAuthorization() {
            let notaficationCenter = UNUserNotificationCenter.current()
            notaficationCenter.getNotificationSettings{ settings in
                switch settings.authorizationStatus {
                case .authorized:
                    self.dispatchNotification()
                case .denied:
                    return
                case .notDetermined:
                    notaficationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                        if didAllow{
                            self.dispatchNotification()
                        }
                    }
                default:
                    return
                }
            }
        }
            
            func dispatchNotification() {
                let idemtifaire = "morning"
                let title = "ניר שמן"
                let body = " ניר הכי שמן בארץ"
                let hour = 23
                let minute = 29
                let isDaily = true
                
                let notificationCenter = UNUserNotificationCenter.current()
                
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body
                content.sound = .default
                
                let calender = Calendar.current
                let timeZone = TimeZone.current
                var dateComponents = DateComponents(calendar: calender, timeZone: timeZone)
                dateComponents.hour = hour
                dateComponents.minute = minute
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
                let request = UNNotificationRequest(identifier: idemtifaire, content: content, trigger: trigger)
                
                notificationCenter.removePendingNotificationRequests(withIdentifiers: [idemtifaire])
                notificationCenter.add( request)
            }
        }
        
