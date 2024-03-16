//
//  VoiceMemoApp.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 11/3/2024.
//

import SwiftUI

@main
struct VoiceMemoApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  @State private var path = Path()
  
    var body: some Scene {
        WindowGroup {
            OnboardingView()
            .environment(path)
        }
    }
}
