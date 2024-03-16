//
//  HomeViewModel.swift
//  VoiceMemo
//
//  Created by JungWoo Choi on 15/3/2024.
//

import Foundation

@Observable class HomeViewModel {
  var selectedTab: Tab
  var todosCount: Int
  var memosCount: Int
  var voiceRecordersCount: Int
  
  init(selectedTab: Tab = .todoList,
       todosCount: Int = 0,
       memosCount: Int = 0,
       voiceRecordersCount: Int = 0
  ) {
    self.selectedTab = selectedTab
    self.todosCount = todosCount
    self.memosCount = memosCount
    self.voiceRecordersCount = voiceRecordersCount
  }
}

extension HomeViewModel {
  func setTodosCount(_ count: Int) {
    todosCount = count
  }
  
  func setMemosCount(_ count: Int) {
    memosCount = count
  }
  
  func setvoiceRecordersCount(_ count: Int) {
    voiceRecordersCount = count
  }
  
  func changeSelectedTab(_ tab: Tab) {
    selectedTab = tab
  }
}
