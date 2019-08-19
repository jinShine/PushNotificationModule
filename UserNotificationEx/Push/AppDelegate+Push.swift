//
//  AppDelegate+Push.swift
//  UserNotificationEx
//
//  Created by Seungjin on 14/08/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit
import UserNotifications

extension AppDelegate {
  
  func setupForRemoteNotifications(_ application: UIApplication) {
    PushManager.main.setup(application)
    
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }
  }
  
  //APNs에 등록이 완료되었을때 호출됨.
  //등록이 완료되면 Token을 발급 해준다.
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    PushManager.main.didRegisterForRemoteNotificationsWithDeviceToken(deviceToken: deviceToken)
  }
  
  //디바이스 등록이 실패되었을대 호출
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    
  }
  
  
}


//MARK: - UNUserNotificationCenter Delegate

extension AppDelegate: UNUserNotificationCenterDelegate {
  
  @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    
    PushManager.main.userNotificationCenter(center, willPresent: notification)
    completionHandler([.alert, .badge, .sound])
    
  }
  
  @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    
    PushManager.main.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    
  }

}
