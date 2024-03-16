//
//  Date+Ext.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 11/3/2024.
//

import Foundation

extension Date {
  var formattedTime: String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en-AU")
    formatter.dateFormat = "hh:mm a"
    return formatter.string(from: self)
  }
  
  var formattedDay: String {
    let now = Date()
    let calender = Calendar.current
    
    let nowStartOfDay = calender.startOfDay(for: now)
    let dateStartOfDay = calender.startOfDay(for: self)
    let numOfDaysDifference = calender.dateComponents([.day], from: nowStartOfDay, to: dateStartOfDay).day!
    
    if numOfDaysDifference == 0 {
      return "Today"
    } else {
      let formatter = DateFormatter()
      formatter.locale = Locale(identifier: "en-AU")
      formatter.dateFormat = "E, d/M"
      return formatter.string(from: self)
    }
  }
  
  var formattedVoiceRecorderTime: String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en-AU")
    formatter.dateFormat = "d.M.yyyy"
    return formatter.string(from: self)
  }
  
}
