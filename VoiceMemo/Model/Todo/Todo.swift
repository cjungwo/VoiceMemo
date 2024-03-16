//
//  Todo.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 12/3/2024.
//

import Foundation

struct Todo: Hashable {
  var title: String
  var time: Date
  var day: Date
  var selected: Bool
  
  var convertedDayAndTime: String {
    String("Alert at \(time.formattedTime) - \(day.formattedDay)")
    
  }
}
