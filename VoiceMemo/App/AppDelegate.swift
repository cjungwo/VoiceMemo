//
//  AppDelegate.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 11/3/2024.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
  var notificationDelegate = NotificationDelegate()
  
  func applicationDidFinishLaunching(_ application: UIApplication) {
    UNUserNotificationCenter.current().delegate = notificationDelegate
  }
}
