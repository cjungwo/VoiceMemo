//
//  Int+Ext.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 14/3/2024.
//

import Foundation

extension Int {
  var formattedTimeString: String {
    let time = Time.fromeSeconds(self)
    let hoursString = String(format: "%02d", time.hours)
    let minutesString = String(format: "%02d", time.minutes)
    let secondsString = String(format: "%02d", time.seconds)
    
    return "\(hoursString) : \(minutesString) : \(secondsString)"
  }
  
  var formattedSettingTime: String {
    let currentDate = Date()
    let settingDate = currentDate.addingTimeInterval(TimeInterval(self))
    
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en-AU")
    formatter.timeZone = TimeZone(identifier: "Australia/Sydney")
    formatter.dateFormat = "HH:mm"
    
    let formattedTime = formatter.string(from: settingDate)
    return formattedTime
  }
}
