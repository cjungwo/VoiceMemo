//
//  TodoViewModel.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 12/3/2024.
//

import Foundation

@Observable class TodoViewModel {
  var title: String
  var time: Date
  var day: Date
  var isDisplayCalender: Bool
  
  init(
    title: String = "",
    time: Date = .init(),
    day: Date = .init(),
    isDisplayCalender: Bool = false
  ) {
    self.title = title
    self.time = time
    self.day = day
    self.isDisplayCalender = isDisplayCalender
  }
}

extension TodoViewModel {
  func setIsDisplayCalender(_ isDisplay: Bool) {
    isDisplayCalender = isDisplay
  }
}
