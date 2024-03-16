//
//  Double+Ext.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 13/3/2024.
//

import Foundation

extension Double {
  // ex) 03:04
  var formattedTimeInterval: String {
    let totalSeconds = Int(self)
    let seconds = totalSeconds % 60
    let minutes = (totalSeconds / 60) % 60
    
    return String(format: "%02d:%02d", minutes, seconds)
  }
}
