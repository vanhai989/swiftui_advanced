//
//  LocalNotificationView.swift
//  swiftuiAdvanced
//
//  Created by hai dev on 12/08/2022.
//

import SwiftUI

class LocalNotificationManager {
    static let instance = LocalNotificationManager()
    
    func requestPermision() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func registerSendLocalNotification() {
        let content = UNMutableNotificationContent()
        content.sound = .default
        content.title = "First Notification"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        // calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 8
//        dateComponents.minute = 0
//        dateComponents.weekday = 2
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // location
//        let coordinates = CLLocationCoordinate2D(
//            latitude: 40.00,
//            longitude: 50.00)
//        let region = CLCircularRegion(
//            center: coordinates,
//            radius: 100,
//            identifier: UUID().uuidString)
//        region.notifyOnEntry = true
//        region.notifyOnExit = true
//        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}

struct LocalNotificationView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Button {
                LocalNotificationManager.instance.requestPermision()
            }
        label: {
            Text("Request permision")
                .foregroundColor(.blue)
        }
            
            Button {
                LocalNotificationManager.instance.registerSendLocalNotification()
            }
        label: {
            Text("Register notification")
                .foregroundColor(.blue)
        }
            
            Button {LocalNotificationManager.instance.cancelNotification()}
        label: {
            Text("Cancel pendding notification")
                .foregroundColor(.blue)
        }
            
        }
    }
}

struct LocalNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationView()
    }
}
