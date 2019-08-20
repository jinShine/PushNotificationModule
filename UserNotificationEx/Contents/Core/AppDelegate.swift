//
//  AppDelegate.swift
//  UserNotificationEx
//
//  Created by Seungjin on 14/08/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    FirebaseApp.configure()
    
    setupForRemoteNotifications(application)
    
    return true
  }

  
}

