//
//  PushManager.swift
//  UserNotificationEx
//
//  Created by Seungjin on 14/08/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit
import FirebaseMessaging

class PushManager: NSObject {
  
  //Singleton
  static let main = PushManager()
  
  
  var messaging: Messaging {
    return Messaging.messaging()
  }
  
  func setup(_ application: UIApplication) {
    messaging.delegate = self
    
    registerFromRemoteNotifications(application)
  }
  
  private func registerFromRemoteNotifications(_ application: UIApplication) {
    
    if #available(iOS 10, *) {
      let option: UNAuthorizationOptions = [.alert, .badge, .sound]
      let center = UNUserNotificationCenter.current()
      center.requestAuthorization(options: option) { (granted, error) in
        
        guard granted else {
          //Error
          return
        }
        
        DispatchQueue.main.async {
          //APNs에 디바이스를 등록하고, Delegate를 통해서 결과를 알려준다.
          application.registerForRemoteNotifications()
        }
        
      }
    } else {
      let options: UIUserNotificationType = [.alert, .badge, .sound]
      let pushNotificationSettings = UIUserNotificationSettings(types: options, categories: nil)
      application.registerUserNotificationSettings(pushNotificationSettings)
      //APNs에 디바이스를 등록하고, Delegate를 통해서 결과를 알려준다.
      application.registerForRemoteNotifications()
    }
    
  }
  
  
  @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification) {
    
    remoteNotificationDidReceive(notification.request.content.userInfo)
    
  }
  
  @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    
    remoteNotificationDidReceive(response.notification.request.content.userInfo)
    completionHandler()
  }
  
  func didRegisterForRemoteNotificationsWithDeviceToken(deviceToken: Data) {
    messaging.apnsToken = deviceToken
    let token = deviceToken.map { String(format: "%02.2hhx", arguments: [$0]) }.joined()
    print("device Token", token)
  }
  
  func didFailToRegisterForRemoteNotificationsWithError(error: Error) {
    // error
  }
  
  private func remoteNotificationDidReceive(_ userInfo: [AnyHashable : Any]) {
    
    // userInfo 데이터 처리
    print(userInfo)
    
  }
  
}

//MARK: - Firebase
extension PushManager: MessagingDelegate {
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    print("FCM Token :", fcmToken)
  }
}
