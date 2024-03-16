//
//  Time.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 14/3/2024.
//

import Foundation

struct Time {
  var hours: Int
  var minutes: Int
  var seconds: Int
  
  var convertedSeconds: Int {
    return (hours * 3600) + (minutes * 60) + seconds
  }
  
  static func fromeSeconds(_ seconds: Int) -> Time {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let remainingSeconds = (seconds % 3600) % 60
    
    return Time(hours: hours, minutes: minutes, seconds: remainingSeconds)
  }
}
